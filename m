Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4C0C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A3F21897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfIRI47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:56:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52084 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfIRI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:56:59 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8I8ukxU018315, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8I8ukxU018315
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 18 Sep 2019 16:56:47 +0800
Received: from localhost.localdomain (172.21.83.238) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 18 Sep 2019 16:56:46 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alex_lu@realsil.com.cn>, <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btrtl: Fix an issue for the incorrect error return code.
Date:   Wed, 18 Sep 2019 16:56:41 +0800
Message-ID: <20190918085641.5374-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.83.238]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

It does not need the '-' for PTR_ERR(skb) because PTR_ERR(skb) will
return the negative value during errors.

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btrtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index bf3c02be6930..ae9a2047f242 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -418,7 +418,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 		if (IS_ERR(skb)) {
 			rtl_dev_err(hdev, "download fw command failed (%ld)",
 				    PTR_ERR(skb));
-			ret = -PTR_ERR(skb);
+			ret = PTR_ERR(skb);
 			goto out;
 		}
 
-- 
2.17.1

