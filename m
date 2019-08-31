Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35937C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 08:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B4723711
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 08:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfHaIsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 04:48:21 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33772 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfHaIsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 04:48:20 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7V8m8XQ003782, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (msx.realsil.com.cn[172.29.17.3](maybeforged))
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7V8m8XQ003782
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 31 Aug 2019 16:48:08 +0800
Received: from laptop-alex (220.170.50.123) by RS-CAS02.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 31 Aug
 2019 16:47:52 +0800
Date:   Sat, 31 Aug 2019 16:46:11 +0800
From:   Alex Lu <alex_lu@realsil.com.cn>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: [PATCH 2/2] Bluetooth: btrtl: Remove trailing newline from calls to rtl_dev macros
Message-ID: <20190831084611.GA10415@laptop-alex>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [220.170.50.123]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Lu <alex_lu@realsil.com.cn>

These printing macros already add a trailing newline, so drop these
unnecessary additional newlines.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
---
 drivers/bluetooth/btrtl.c | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 20aeed3c1ee7..0354e93e7a7c 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -207,19 +207,19 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 	/* Read RTL ROM version command */
 	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
-		rtl_dev_err(hdev, "Read ROM version failed (%ld)\n",
+		rtl_dev_err(hdev, "Read ROM version failed (%ld)",
 			    PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
 
 	if (skb->len != sizeof(*rom_version)) {
-		rtl_dev_err(hdev, "version event length mismatch\n");
+		rtl_dev_err(hdev, "version event length mismatch");
 		kfree_skb(skb);
 		return -EIO;
 	}
 
 	rom_version = (struct rtl_rom_version_evt *)skb->data;
-	rtl_dev_info(hdev, "rom_version status=%x version=%x\n",
+	rtl_dev_info(hdev, "rom_version status=%x version=%x",
 		     rom_version->status, rom_version->version);
 
 	*version = rom_version->version;
@@ -263,7 +263,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 
 	fwptr = btrtl_dev->fw_data + btrtl_dev->fw_len - sizeof(extension_sig);
 	if (memcmp(fwptr, extension_sig, sizeof(extension_sig)) != 0) {
-		rtl_dev_err(hdev, "extension section signature mismatch\n");
+		rtl_dev_err(hdev, "extension section signature mismatch");
 		return -EINVAL;
 	}
 
@@ -284,7 +284,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 			break;
 
 		if (length == 0) {
-			rtl_dev_err(hdev, "found instruction with length 0\n");
+			rtl_dev_err(hdev, "found instruction with length 0");
 			return -EINVAL;
 		}
 
@@ -297,7 +297,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	}
 
 	if (project_id < 0) {
-		rtl_dev_err(hdev, "failed to find version instruction\n");
+		rtl_dev_err(hdev, "failed to find version instruction");
 		return -EINVAL;
 	}
 
@@ -308,13 +308,13 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	}
 
 	if (i >= ARRAY_SIZE(project_id_to_lmp_subver)) {
-		rtl_dev_err(hdev, "unknown project id %d\n", project_id);
+		rtl_dev_err(hdev, "unknown project id %d", project_id);
 		return -EINVAL;
 	}
 
 	if (btrtl_dev->ic_info->lmp_subver !=
 				project_id_to_lmp_subver[i].lmp_subver) {
-		rtl_dev_err(hdev, "firmware is for %x but this is a %x\n",
+		rtl_dev_err(hdev, "firmware is for %x but this is a %x",
 			    project_id_to_lmp_subver[i].lmp_subver,
 			    btrtl_dev->ic_info->lmp_subver);
 		return -EINVAL;
@@ -322,7 +322,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 
 	epatch_info = (struct rtl_epatch_header *)btrtl_dev->fw_data;
 	if (memcmp(epatch_info->signature, RTL_EPATCH_SIGNATURE, 8) != 0) {
-		rtl_dev_err(hdev, "bad EPATCH signature\n");
+		rtl_dev_err(hdev, "bad EPATCH signature");
 		return -EINVAL;
 	}
 
@@ -412,14 +412,14 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 		skb = __hci_cmd_sync(hdev, 0xfc20, frag_len + 1, dl_cmd,
 				     HCI_INIT_TIMEOUT);
 		if (IS_ERR(skb)) {
-			rtl_dev_err(hdev, "download fw command failed (%ld)\n",
+			rtl_dev_err(hdev, "download fw command failed (%ld)",
 				    PTR_ERR(skb));
 			ret = -PTR_ERR(skb);
 			goto out;
 		}
 
 		if (skb->len != sizeof(struct rtl_download_response)) {
-			rtl_dev_err(hdev, "download fw event length mismatch\n");
+			rtl_dev_err(hdev, "download fw event length mismatch");
 			kfree_skb(skb);
 			ret = -EIO;
 			goto out;
@@ -451,7 +451,7 @@ static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
 	const struct firmware *fw;
 	int ret;
 
-	rtl_dev_info(hdev, "loading %s\n", name);
+	rtl_dev_info(hdev, "loading %s", name);
 	ret = request_firmware(&fw, name, &hdev->dev);
 	if (ret < 0)
 		return ret;
@@ -475,7 +475,7 @@ static int btrtl_setup_rtl8723a(struct hci_dev *hdev,
 	 * (which is only for RTL8723B and newer).
 	 */
 	if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8)) {
-		rtl_dev_err(hdev, "unexpected EPATCH signature!\n");
+		rtl_dev_err(hdev, "unexpected EPATCH signature!");
 		return -EINVAL;
 	}
 
@@ -510,7 +510,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 		fw_data = tbuff;
 	}
 
-	rtl_dev_info(hdev, "cfg_sz %d, total sz %d\n", btrtl_dev->cfg_len, ret);
+	rtl_dev_info(hdev, "cfg_sz %d, total sz %d", btrtl_dev->cfg_len, ret);
 
 	ret = rtl_download_firmware(hdev, fw_data, ret);
 
@@ -551,7 +551,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	}
 
 	resp = (struct hci_rp_read_local_version *)skb->data;
-	rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x\n",
+	rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
 		     resp->hci_ver, resp->hci_rev,
 		     resp->lmp_ver, resp->lmp_subver);
 
@@ -578,7 +578,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
 					  &btrtl_dev->fw_data);
 	if (btrtl_dev->fw_len < 0) {
-		rtl_dev_err(hdev, "firmware file %s not found\n",
+		rtl_dev_err(hdev, "firmware file %s not found",
 			    btrtl_dev->ic_info->fw_name);
 		ret = btrtl_dev->fw_len;
 		goto err_free;
@@ -596,7 +596,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 						   &btrtl_dev->cfg_data);
 		if (btrtl_dev->ic_info->config_needed &&
 		    btrtl_dev->cfg_len <= 0) {
-			rtl_dev_err(hdev, "mandatory config file %s not found\n",
+			rtl_dev_err(hdev, "mandatory config file %s not found",
 				    btrtl_dev->ic_info->cfg_name);
 			ret = btrtl_dev->cfg_len;
 			goto err_free;
@@ -622,7 +622,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	 * to a different value.
 	 */
 	if (!btrtl_dev->ic_info) {
-		rtl_dev_info(hdev, "assuming no firmware upload needed\n");
+		rtl_dev_info(hdev, "assuming no firmware upload needed");
 		return 0;
 	}
 
@@ -636,7 +636,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	case RTL_ROM_LMP_8822B:
 		return btrtl_setup_rtl8723b(hdev, btrtl_dev);
 	default:
-		rtl_dev_info(hdev, "assuming no firmware upload needed\n");
+		rtl_dev_info(hdev, "assuming no firmware upload needed");
 		return 0;
 	}
 }
@@ -733,18 +733,18 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 
 	total_data_len = btrtl_dev->cfg_len - sizeof(*config);
 	if (total_data_len <= 0) {
-		rtl_dev_warn(hdev, "no config loaded\n");
+		rtl_dev_warn(hdev, "no config loaded");
 		return -EINVAL;
 	}
 
 	config = (struct rtl_vendor_config *)btrtl_dev->cfg_data;
 	if (le32_to_cpu(config->signature) != RTL_CONFIG_MAGIC) {
-		rtl_dev_err(hdev, "invalid config magic\n");
+		rtl_dev_err(hdev, "invalid config magic");
 		return -EINVAL;
 	}
 
 	if (total_data_len < le16_to_cpu(config->total_len)) {
-		rtl_dev_err(hdev, "config is too short\n");
+		rtl_dev_err(hdev, "config is too short");
 		return -EINVAL;
 	}
 
@@ -754,7 +754,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 		switch (le16_to_cpu(entry->offset)) {
 		case 0xc:
 			if (entry->len < sizeof(*device_baudrate)) {
-				rtl_dev_err(hdev, "invalid UART config entry\n");
+				rtl_dev_err(hdev, "invalid UART config entry");
 				return -EINVAL;
 			}
 
@@ -771,7 +771,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			break;
 
 		default:
-			rtl_dev_dbg(hdev, "skipping config entry 0x%x (len %u)\n",
+			rtl_dev_dbg(hdev, "skipping config entry 0x%x (len %u)",
 				   le16_to_cpu(entry->offset), entry->len);
 			break;
 		};
@@ -780,13 +780,13 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 	}
 
 	if (!found) {
-		rtl_dev_err(hdev, "no UART config entry found\n");
+		rtl_dev_err(hdev, "no UART config entry found");
 		return -ENOENT;
 	}
 
-	rtl_dev_dbg(hdev, "device baudrate = 0x%08x\n", *device_baudrate);
-	rtl_dev_dbg(hdev, "controller baudrate = %u\n", *controller_baudrate);
-	rtl_dev_dbg(hdev, "flow control %d\n", *flow_control);
+	rtl_dev_dbg(hdev, "device baudrate = 0x%08x", *device_baudrate);
+	rtl_dev_dbg(hdev, "controller baudrate = %u", *controller_baudrate);
+	rtl_dev_dbg(hdev, "flow control %d", *flow_control);
 
 	return 0;
 }
-- 
2.21.0

