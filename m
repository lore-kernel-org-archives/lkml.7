Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63650C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3656F2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kT2sRsBR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kT2sRsBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHNHnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:43:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfHNHnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:43:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8066A607DE; Wed, 14 Aug 2019 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565768598;
        bh=SNdKX9aeCldaAT6R793W5ewPrb6x1ertjSoz3YWnHCE=;
        h=From:To:Cc:Subject:Date:From;
        b=kT2sRsBRlbWw9Gpw8yrjU1DnTIddArYInKnmJO1RysRZ37oF2CcIkxxGRbm387AIl
         W35vTvacAIB0i7qeaIfi3OkAssRJO1QkmF/KQywhtH7Cpnm9Jx51cWd/vEPHOr2k0C
         S4nVRsCGJ2ppWP93jlyWweqgoLyGSMeptw+7a2oQ=
Received: from rocky-HP-EliteBook-8460p.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72276602E0;
        Wed, 14 Aug 2019 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565768598;
        bh=SNdKX9aeCldaAT6R793W5ewPrb6x1ertjSoz3YWnHCE=;
        h=From:To:Cc:Subject:Date:From;
        b=kT2sRsBRlbWw9Gpw8yrjU1DnTIddArYInKnmJO1RysRZ37oF2CcIkxxGRbm387AIl
         W35vTvacAIB0i7qeaIfi3OkAssRJO1QkmF/KQywhtH7Cpnm9Jx51cWd/vEPHOr2k0C
         S4nVRsCGJ2ppWP93jlyWweqgoLyGSMeptw+7a2oQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72276602E0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Skip 1 error print in device_want_to_sleep()
Date:   Wed, 14 Aug 2019 15:42:39 +0800
Message-Id: <1565768559-30755-1-git-send-email-rjliao@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't fall through to print error message when receive sleep indication
in HCI_IBS_RX_ASLEEP state, this is allowed behavior.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a054210..2affb4e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -686,7 +686,7 @@ static void device_want_to_sleep(struct hci_uart *hu)
 	unsigned long flags;
 	struct qca_data *qca = hu->priv;
 
-	BT_DBG("hu %p want to sleep", hu);
+	BT_DBG("hu %p want to sleep in %d state", hu, qca->rx_ibs_state);
 
 	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
 
@@ -701,7 +701,7 @@ static void device_want_to_sleep(struct hci_uart *hu)
 		break;
 
 	case HCI_IBS_RX_ASLEEP:
-		/* Fall through */
+		break;
 
 	default:
 		/* Any other state is illegal */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

