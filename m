Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9571C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DEE2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfHEDHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:07:25 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57653 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfHEDHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 23:07:25 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7537CRU004066, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (msx.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7537CRU004066
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 5 Aug 2019 11:07:12 +0800
Received: from toshiba (172.29.36.108) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 5 Aug 2019
 11:07:12 +0800
Date:   Mon, 5 Aug 2019 11:07:33 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH v2] Bluetooth: btrtl: Save firmware and config
Message-ID: <20190805030733.GA11069@toshiba>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [172.29.36.108]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Lu <alex_lu@realsil.com.cn>

usb reset resume will cause downloading firmware again and
requesting firmware may be failed while host is resuming

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
---
 drivers/bluetooth/btrtl.c | 101 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 208feef63de4..416a5cb676e3 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -56,6 +56,8 @@ struct btrtl_device_info {
 	int cfg_len;
 };
 
+static struct btrtl_device_info dev_info;
+
 static const struct id_table ic_id_table[] = {
 	{ IC_MATCH_FL_LMPSUBV, RTL_ROM_LMP_8723A, 0x0,
 	  .config_needed = false,
@@ -553,8 +555,23 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			goto err_free;
 	}
 
-	btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
-					  &btrtl_dev->fw_data);
+	if (dev_info.ic_info == NULL ||
+	    dev_info.ic_info != btrtl_dev->ic_info) {
+		btrtl_dev->fw_len = rtl_load_file(hdev,
+						  btrtl_dev->ic_info->fw_name,
+						  &btrtl_dev->fw_data);
+		/* Make sure that fw is stored later */
+		dev_info.ic_info = NULL;
+	} else {
+		if (dev_info.fw_len > 0)
+			btrtl_dev->fw_data = kmemdup(dev_info.fw_data,
+						     dev_info.fw_len,
+						     GFP_KERNEL);
+		if (btrtl_dev->fw_data)
+			btrtl_dev->fw_len = dev_info.fw_len;
+		else
+			btrtl_dev->fw_len = -ENOMEM;
+	}
 	if (btrtl_dev->fw_len < 0) {
 		rtl_dev_err(hdev, "firmware file %s not found\n",
 			    btrtl_dev->ic_info->fw_name);
@@ -570,8 +587,21 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			snprintf(cfg_name, sizeof(cfg_name), "%s.bin",
 				 btrtl_dev->ic_info->cfg_name);
 		}
-		btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
-						   &btrtl_dev->cfg_data);
+
+		if (dev_info.ic_info == NULL ||
+		    dev_info.ic_info != btrtl_dev->ic_info) {
+			btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
+							&btrtl_dev->cfg_data);
+		} else {
+			if (dev_info.cfg_len > 0)
+				btrtl_dev->cfg_data = kmemdup(dev_info.cfg_data,
+							      dev_info.cfg_len,
+							      GFP_KERNEL);
+			if (btrtl_dev->cfg_data)
+				btrtl_dev->cfg_len = dev_info.cfg_len;
+			else
+				btrtl_dev->cfg_len = -ENOMEM;
+		}
 		if (btrtl_dev->ic_info->config_needed &&
 		    btrtl_dev->cfg_len <= 0) {
 			rtl_dev_err(hdev, "mandatory config file %s not found\n",
@@ -620,6 +650,49 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btrtl_download_firmware);
 
+static void dev_fw_free(void)
+{
+	kfree(dev_info.fw_data);
+	kfree(dev_info.cfg_data);
+	memset(&dev_info, 0, sizeof(dev_info));
+}
+
+static void dev_fw_dup(struct btrtl_device_info *btrtl_dev)
+{
+	dev_fw_free();
+
+	dev_info.ic_info = btrtl_dev->ic_info;
+	dev_info.rom_version = btrtl_dev->rom_version;
+
+	dev_info.fw_len = btrtl_dev->fw_len;
+	if (dev_info.fw_len > 0)
+		dev_info.fw_data = kmemdup(btrtl_dev->fw_data,
+					   btrtl_dev->fw_len, GFP_KERNEL);
+	if (!dev_info.fw_data) {
+		BT_ERR("Failed to save rtl firmware");
+		goto err_memdup;
+	}
+
+	dev_info.cfg_len = btrtl_dev->cfg_len;
+	if (dev_info.cfg_len > 0)
+		dev_info.cfg_data = kmemdup(btrtl_dev->cfg_data,
+					    btrtl_dev->cfg_len, GFP_KERNEL);
+	if (!dev_info.cfg_data) {
+		if (dev_info.ic_info->config_needed) {
+			BT_ERR("Failed to save mandatory rtl config file");
+			goto err_memdup;
+		} else {
+			dev_info.cfg_len = 0;
+		}
+		BT_WARN("Failed to save rtl config file");
+	}
+
+	return;
+
+err_memdup:
+	dev_fw_free();
+}
+
 int btrtl_setup_realtek(struct hci_dev *hdev)
 {
 	struct btrtl_device_info *btrtl_dev;
@@ -629,6 +702,9 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 	if (IS_ERR(btrtl_dev))
 		return PTR_ERR(btrtl_dev);
 
+	if (btrtl_dev->ic_info && dev_info.ic_info != btrtl_dev->ic_info)
+		dev_fw_dup(btrtl_dev);
+
 	ret = btrtl_download_firmware(hdev, btrtl_dev);
 
 	btrtl_free(btrtl_dev);
@@ -745,6 +821,23 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
 
+static int btrtl_module_init(void)
+{
+	BT_INFO("btrtl: init");
+
+	return 0;
+}
+
+static void btrtl_module_exit(void)
+{
+	BT_INFO("btrtl: exit");
+
+	dev_fw_free();
+}
+
+module_init(btrtl_module_init);
+module_exit(btrtl_module_exit)
+
 MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
2.19.2

