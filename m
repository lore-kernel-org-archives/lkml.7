Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A93C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000C720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e7Z80az3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ao8LyDPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfCFQV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:21:27 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50126 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfCFQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:21:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 397D76118D; Wed,  6 Mar 2019 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551889286;
        bh=Ep3Q5zPZhCzIJLT4Gg/hqPo6crzurFgXTohdFArXVV4=;
        h=From:To:Cc:Subject:Date:From;
        b=e7Z80az3JxwO58ikGDQIvcUjO5pGTXMF0dFIYl2a0Yz8ftLvQ/l2ZVZZq3CyYqf86
         d9BnPsnLMg5+ONj/2hcc83FRADkKJxi384EAvd+06kIX5F3F+6vWHePWoD3iqsHrF8
         Lc2+uuLo79qKrXG7qju1ipa5gM84Niiu8hchrG8s=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 724636115B;
        Wed,  6 Mar 2019 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551889283;
        bh=Ep3Q5zPZhCzIJLT4Gg/hqPo6crzurFgXTohdFArXVV4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ao8LyDPTEC/e5a5zdc+4sWuv+m9WXLMrXofjFIFNbMJ0ZNEYHFB21ox1tz2V9zEia
         ITxYZ0FhmxdfvOvsm/jhNx/srpfLTdtWGaJVDvU1zeZ7e80hcLrK3tOtOHnFT/GA0p
         dcpB2trU8YlJO8I/V42ijHNfKak/o7imWY0FWIiA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 724636115B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, rjliao@codeaurora.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Give enough time to ROME controller to bootup.
Date:   Wed,  6 Mar 2019 21:51:13 +0530
Message-Id: <20190306162113.8585-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables enough time to ROME controller to bootup
after we bring the enable ping out of reset.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 237aea34b69f..1953b13511e7 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -508,6 +508,8 @@ static int qca_open(struct hci_uart *hu)
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->btsoc_type != QCA_WCN3990) {
 			gpiod_set_value_cansleep(qcadev->bt_en, 1);
+			/* Controller needs time to bootup. */
+			msleep(150);
 		} else {
 			hu->init_speed = qcadev->init_speed;
 			hu->oper_speed = qcadev->oper_speed;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

