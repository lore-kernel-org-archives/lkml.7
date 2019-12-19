Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F48CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7A12465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wLKFnwlG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLSHTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 02:19:09 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:17823 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfLSHTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 02:19:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576739948; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=L4r+YjN1VXlRiEvuNhW/AVL5onraaJkU5uADpyCsxLw=; b=wLKFnwlGc9NEfGrA0VhB7oZq0ICJZ6f5YCisSPHzy3s/9//SZJPILrzxmitOWrgV9ERd4YAo
 Edi74G/Nvg8UGkdL7ig6jkgm02LCPyGoz2gKUEaukcOy1FGK1PQExpuouFKQrwoonAkiqS/5
 e7VvqGSmvgvBw0hoRRMYWwXO1RQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb2468.7f8b23c72c00-smtp-out-n02;
 Thu, 19 Dec 2019 07:19:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4A4E1C63C50; Thu, 19 Dec 2019 07:19:04 +0000 (UTC)
Received: from rocky-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A146C494B4;
        Thu, 19 Dec 2019 07:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A146C494B4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v1] Bluetooth: btusb: Add support for 04ca:3021 QCA_ROME device
Date:   Thu, 19 Dec 2019 15:18:57 +0800
Message-Id: <20191219071857.18532-1-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB "VendorID:04ca ProductID:3021" is a new QCA ROME USB
Bluetooth device, let's support firmware downloading for it.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0eaeca0a64fb..f5924f3e8b8d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -266,6 +266,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x301a), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x04ca, 0x3021), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x13d3, 0x3491), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x13d3, 0x3496), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME },
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
