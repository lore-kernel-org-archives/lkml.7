Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B896BC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D2220705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="L1LThsAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgAHJIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:08:24 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:63501 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727516AbgAHJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:08:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578474502; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=6CDsFIM/kWKxfBbG2h1PLawytrueo+E0DdiEb5Ryxt8=; b=L1LThsAvt54nUeOe5Sho/4hW23nM1SOJgnavou5iKw2iDlOjgMNpJI3EGP2ie3UkvA/PFy7m
 OzrJRtLXjjyYmQ0oxPI9Cm0wXepDS45rawMvUD6lwusMFhQY/PsyK8tQkVWhl9h4YHvNN/8y
 1DaWipUwc3YrALUxTSc+zS1y8YE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e159c02.7f9ba3b37d18-smtp-out-n03;
 Wed, 08 Jan 2020 09:08:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A65EDC4479C; Wed,  8 Jan 2020 09:08:18 +0000 (UTC)
Received: from rocky-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBC54C4479F;
        Wed,  8 Jan 2020 09:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBC54C4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v2 3/3] Bluetooth: hci_qca: Use unified API qca_power_on() to power up wcn399x
Date:   Wed,  8 Jan 2020 17:08:04 +0800
Message-Id: <20200108090804.22889-3-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108090804.22889-1-rjliao@codeaurora.org>
References: <20200107052601.32216-1-rjliao@codeaurora.org>
 <20200108090804.22889-1-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces wcn399x power on with unified API qca_power_on(),
which supports both wcn399x and Rome.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---

Changes in v2: Added this patch

 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 8fc8c9bce9ee..7cc82d048558 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1579,7 +1579,7 @@ static int qca_setup(struct hci_uart *hu)
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hu->hdev->shutdown = qca_power_off;
-		ret = qca_wcn3990_init(hu);
+		ret = qca_power_on(hdev);
 		if (ret)
 			return ret;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
