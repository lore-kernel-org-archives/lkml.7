Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05273C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C838123711
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 08:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfHaIlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 04:41:47 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33668 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfHaIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 04:41:47 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7V8fXSa003174, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (doc.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7V8fXSa003174
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 31 Aug 2019 16:41:34 +0800
Received: from laptop-alex (116.136.21.149) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 31 Aug
 2019 16:41:33 +0800
Date:   Sat, 31 Aug 2019 16:41:13 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH 1/2] Bluetooth: btrtl: Remove redundant prefix from calls to rtl_dev macros
Message-ID: <20190831084030.GA10145@laptop-alex>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [116.136.21.149]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Lu <alex_lu@realsil.com.cn>

the rtl: or RTL: prefix in the string is pointless. The rtl_dev_* macros
already does that.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
---
 drivers/bluetooth/btrtl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index adb8ba0fcd59..20aeed3c1ee7 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -213,7 +213,7 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 	}
 
 	if (skb->len != sizeof(*rom_version)) {
-		rtl_dev_err(hdev, "RTL version event length mismatch\n");
+		rtl_dev_err(hdev, "version event length mismatch\n");
 		kfree_skb(skb);
 		return -EIO;
 	}
@@ -451,7 +451,7 @@ static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
 	const struct firmware *fw;
 	int ret;
 
-	rtl_dev_info(hdev, "rtl: loading %s\n", name);
+	rtl_dev_info(hdev, "loading %s\n", name);
 	ret = request_firmware(&fw, name, &hdev->dev);
 	if (ret < 0)
 		return ret;
@@ -551,7 +551,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	}
 
 	resp = (struct hci_rp_read_local_version *)skb->data;
-	rtl_dev_info(hdev, "rtl: examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x\n",
+	rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x\n",
 		     resp->hci_ver, resp->hci_rev,
 		     resp->lmp_ver, resp->lmp_subver);
 
@@ -564,7 +564,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 					    hdev->bus);
 
 	if (!btrtl_dev->ic_info) {
-		rtl_dev_info(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
+		rtl_dev_info(hdev, "unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
 			    lmp_subver, hci_rev, hci_ver);
 		return btrtl_dev;
 	}
@@ -622,7 +622,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	 * to a different value.
 	 */
 	if (!btrtl_dev->ic_info) {
-		rtl_dev_info(hdev, "rtl: assuming no firmware upload needed\n");
+		rtl_dev_info(hdev, "assuming no firmware upload needed\n");
 		return 0;
 	}
 
@@ -636,7 +636,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	case RTL_ROM_LMP_8822B:
 		return btrtl_setup_rtl8723b(hdev, btrtl_dev);
 	default:
-		rtl_dev_info(hdev, "rtl: assuming no firmware upload needed\n");
+		rtl_dev_info(hdev, "assuming no firmware upload needed\n");
 		return 0;
 	}
 }
-- 
2.21.0

