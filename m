Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102FEC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0591218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld3tVdgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbfIIPD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:03:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46849 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfIIPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:03:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id v11so16447196qto.13;
        Mon, 09 Sep 2019 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bq6ZVY1ZPYVpOs+33THLtJm92zfjsnOpa2sA1upKVHA=;
        b=Ld3tVdgDbUB9GUhfE+D/OpyRWzgKY+O9kqU7p/dgfgZtxdwNKhn58P9Run1Vd4aBLp
         Bm9cpbbzsYeKWt1uWw+Bx0G3x5VVF9GKBBn2j+zsDKhuR6zadSV2hoDKzQ9v63NWttHN
         kA02qJEmyr742P1e6zWVDFSJthLSlCKuNSF4SLc/OV8hLhXVXnyZEq2JLTW3b2Zyp3In
         YnnbhCm5nmQegRWWHmdbLtRyMhVmkA9ixBjdx5nJanpsBC9pqc4e8iD9RaAiIuAiN3Q9
         kQ9yYPs0sqV29tl9JCC3x882x+RTGOdRc87uvXLtsve3b9+Q0/Psgi9SpKWo/PAXyjE5
         1HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bq6ZVY1ZPYVpOs+33THLtJm92zfjsnOpa2sA1upKVHA=;
        b=Ij2s7noWzHzYqkXr6ZEKTVe1DyompB1EXXHHXSAvwvVwqZlW+XLzwxOK4XFRDfo/dz
         sPeTDrCThtbhAFs3qFOwZd+qLE7dooI3onDcyVYHLRr+crMJgEX3lvue87IhMf91h2BH
         ie8MgkCkSQQoVokQnGdZic9fpNfOv0Lm1oY50m7deQ82kR9aLnKNhdOm2e1mj2PoEUwh
         LrIPZG9FeNC3LBYDT1EcpRWsaRfbieUDdREeG0VJ56uPp+xxjggoRno/rkoZzc1MbBsg
         sjFhzcoKXnAataqtfrqV0oNhJsc6dJSTIdXKxlhzL0ToQc393HD3u7AkcDiNgu7zCn0S
         7qGQ==
X-Gm-Message-State: APjAAAXHrYcIuPnxBGh+HBss7wG/9A4ON7fevzKDOsdp8WYwHR8zj1EN
        V9tTi3oWu1wIwbo/2iSYpw==
X-Google-Smtp-Source: APXvYqywDoaJCXjT7mzrQYj0hvpLB3rQ7e6+vPLp8g7J+9VT8px+iZ8/wo99QEwrC6IbqLZGIbWnsQ==
X-Received: by 2002:ac8:1102:: with SMTP id c2mr24484933qtj.340.1568041434670;
        Mon, 09 Sep 2019 08:03:54 -0700 (PDT)
Received: from presler.lan (a95-94-77-68.cpe.netcabo.pt. [95.94.77.68])
        by smtp.gmail.com with ESMTPSA id u132sm7932278qka.50.2019.09.09.08.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 08:03:54 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] Bluetooth: trivial: tidy up printk message output from btrtl.
Date:   Mon,  9 Sep 2019 16:03:29 +0100
Message-Id: <20190909150329.1779-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtl_dev_* calls in the Realtek USB Bluetooth driver add unnecessary
device prefixes and new lines at the end of most messages, which make the
dmesg output look like this:

[    5.667121] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.736869] Bluetooth: hci0: RTL: rtl: examining hci_ver=06 hci_rev=000a lmp_ver=06 lmp_subver=8821

[    5.737853] Bluetooth: hci0: RTL: rom_version status=0 version=1

[    5.737857] Bluetooth: hci0: RTL: rtl: loading rtl_bt/rtl8821a_fw.bin

[    5.737946] Bluetooth: hci0: RTL: rtl: loading rtl_bt/rtl8821a_config.bin

[    5.737965] bluetooth hci0: Direct firmware load for rtl_bt/rtl8821a_config.bin failed with error -2
[    5.737972] Bluetooth: hci0: RTL: cfg_sz -2, total sz 17428

[    5.997375] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

Clean this up by removing extraneous new lines and redundant device prefixes,
with the following result:

[    5.667008] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.716945] Bluetooth: hci0: rtl: examining hci_ver=06 hci_rev=000a lmp_ver=06 lmp_subver=8821
[    5.718745] Bluetooth: hci0: rtl: rom_version status=0 version=1
[    5.718749] Bluetooth: hci0: rtl: loading rtl_bt/rtl8821a_fw.bin
[    5.718830] Bluetooth: hci0: rtl: loading rtl_bt/rtl8821a_config.bin
[    5.718849] bluetooth hci0: Direct firmware load for rtl_bt/rtl8821a_config.bin failed with error -2
[    5.718858] Bluetooth: hci0: rtl: cfg_sz -2, total sz 17428
[    5.997400] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 drivers/bluetooth/btrtl.c | 62 +++++++++++++++++++--------------------
 drivers/bluetooth/btrtl.h |  8 ++---
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 4f75a9b61d09..0c9c16444ce5 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -186,19 +186,19 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 	/* Read RTL ROM version command */
 	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
-		rtl_dev_err(hdev, "Read ROM version failed (%ld)\n",
+		rtl_dev_err(hdev, "Read ROM version failed (%ld)",
 			    PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
 
 	if (skb->len != sizeof(*rom_version)) {
-		rtl_dev_err(hdev, "RTL version event length mismatch\n");
+		rtl_dev_err(hdev, "RTL version event length mismatch");
 		kfree_skb(skb);
 		return -EIO;
 	}
 
 	rom_version = (struct rtl_rom_version_evt *)skb->data;
-	rtl_dev_info(hdev, "rom_version status=%x version=%x\n",
+	rtl_dev_info(hdev, "rom_version status=%x version=%x",
 		     rom_version->status, rom_version->version);
 
 	*version = rom_version->version;
@@ -242,7 +242,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 
 	fwptr = btrtl_dev->fw_data + btrtl_dev->fw_len - sizeof(extension_sig);
 	if (memcmp(fwptr, extension_sig, sizeof(extension_sig)) != 0) {
-		rtl_dev_err(hdev, "extension section signature mismatch\n");
+		rtl_dev_err(hdev, "extension section signature mismatch");
 		return -EINVAL;
 	}
 
@@ -263,7 +263,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 			break;
 
 		if (length == 0) {
-			rtl_dev_err(hdev, "found instruction with length 0\n");
+			rtl_dev_err(hdev, "found instruction with length 0");
 			return -EINVAL;
 		}
 
@@ -276,7 +276,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	}
 
 	if (project_id < 0) {
-		rtl_dev_err(hdev, "failed to find version instruction\n");
+		rtl_dev_err(hdev, "failed to find version instruction");
 		return -EINVAL;
 	}
 
@@ -287,13 +287,13 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
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
@@ -301,7 +301,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 
 	epatch_info = (struct rtl_epatch_header *)btrtl_dev->fw_data;
 	if (memcmp(epatch_info->signature, RTL_EPATCH_SIGNATURE, 8) != 0) {
-		rtl_dev_err(hdev, "bad EPATCH signature\n");
+		rtl_dev_err(hdev, "bad EPATCH signature");
 		return -EINVAL;
 	}
 
@@ -389,14 +389,14 @@ static int rtl_download_firmware(struct hci_dev *hdev,
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
@@ -416,7 +416,7 @@ static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
 	const struct firmware *fw;
 	int ret;
 
-	rtl_dev_info(hdev, "rtl: loading %s\n", name);
+	rtl_dev_info(hdev, "loading %s", name);
 	ret = request_firmware(&fw, name, &hdev->dev);
 	if (ret < 0)
 		return ret;
@@ -440,7 +440,7 @@ static int btrtl_setup_rtl8723a(struct hci_dev *hdev,
 	 * (which is only for RTL8723B and newer).
 	 */
 	if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8)) {
-		rtl_dev_err(hdev, "unexpected EPATCH signature!\n");
+		rtl_dev_err(hdev, "unexpected EPATCH signature!");
 		return -EINVAL;
 	}
 
@@ -475,7 +475,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 		fw_data = tbuff;
 	}
 
-	rtl_dev_info(hdev, "cfg_sz %d, total sz %d\n", btrtl_dev->cfg_len, ret);
+	rtl_dev_info(hdev, "cfg_sz %d, total sz %d", btrtl_dev->cfg_len, ret);
 
 	ret = rtl_download_firmware(hdev, fw_data, ret);
 
@@ -491,13 +491,13 @@ static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
 	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
-		rtl_dev_err(hdev, "HCI_OP_READ_LOCAL_VERSION failed (%ld)\n",
+		rtl_dev_err(hdev, "HCI_OP_READ_LOCAL_VERSION failed (%ld)",
 			    PTR_ERR(skb));
 		return skb;
 	}
 
 	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
-		rtl_dev_err(hdev, "HCI_OP_READ_LOCAL_VERSION event length mismatch\n");
+		rtl_dev_err(hdev, "HCI_OP_READ_LOCAL_VERSION event length mismatch");
 		kfree_skb(skb);
 		return ERR_PTR(-EIO);
 	}
@@ -537,7 +537,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	}
 
 	resp = (struct hci_rp_read_local_version *)skb->data;
-	rtl_dev_info(hdev, "rtl: examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x\n",
+	rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
 		     resp->hci_ver, resp->hci_rev,
 		     resp->lmp_ver, resp->lmp_subver);
 
@@ -550,7 +550,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 					    hdev->bus);
 
 	if (!btrtl_dev->ic_info) {
-		rtl_dev_info(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
+		rtl_dev_info(hdev, "unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
 			    lmp_subver, hci_rev, hci_ver);
 		return btrtl_dev;
 	}
@@ -564,7 +564,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
 					  &btrtl_dev->fw_data);
 	if (btrtl_dev->fw_len < 0) {
-		rtl_dev_err(hdev, "firmware file %s not found\n",
+		rtl_dev_err(hdev, "firmware file %s not found",
 			    btrtl_dev->ic_info->fw_name);
 		ret = btrtl_dev->fw_len;
 		goto err_free;
@@ -582,7 +582,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 						   &btrtl_dev->cfg_data);
 		if (btrtl_dev->ic_info->config_needed &&
 		    btrtl_dev->cfg_len <= 0) {
-			rtl_dev_err(hdev, "mandatory config file %s not found\n",
+			rtl_dev_err(hdev, "mandatory config file %s not found",
 				    btrtl_dev->ic_info->cfg_name);
 			ret = btrtl_dev->cfg_len;
 			goto err_free;
@@ -608,7 +608,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	 * to a different value.
 	 */
 	if (!btrtl_dev->ic_info) {
-		rtl_dev_info(hdev, "rtl: assuming no firmware upload needed\n");
+		rtl_dev_info(hdev, "assuming no firmware upload needed");
 		return 0;
 	}
 
@@ -622,7 +622,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	case RTL_ROM_LMP_8822B:
 		return btrtl_setup_rtl8723b(hdev, btrtl_dev);
 	default:
-		rtl_dev_info(hdev, "rtl: assuming no firmware upload needed\n");
+		rtl_dev_info(hdev, "assuming no firmware upload needed");
 		return 0;
 	}
 }
@@ -714,18 +714,18 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 
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
 
@@ -735,7 +735,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 		switch (le16_to_cpu(entry->offset)) {
 		case 0xc:
 			if (entry->len < sizeof(*device_baudrate)) {
-				rtl_dev_err(hdev, "invalid UART config entry\n");
+				rtl_dev_err(hdev, "invalid UART config entry");
 				return -EINVAL;
 			}
 
@@ -752,7 +752,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			break;
 
 		default:
-			rtl_dev_dbg(hdev, "skipping config entry 0x%x (len %u)\n",
+			rtl_dev_dbg(hdev, "skipping config entry 0x%x (len %u)",
 				   le16_to_cpu(entry->offset), entry->len);
 			break;
 		};
@@ -761,13 +761,13 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
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
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 10ad40c3e42c..2e734495d5d6 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -7,10 +7,10 @@
 
 #define RTL_FRAG_LEN 252
 
-#define rtl_dev_err(dev, fmt, ...) bt_dev_err(dev, "RTL: " fmt, ##__VA_ARGS__)
-#define rtl_dev_warn(dev, fmt, ...) bt_dev_warn(dev, "RTL: " fmt, ##__VA_ARGS__)
-#define rtl_dev_info(dev, fmt, ...) bt_dev_info(dev, "RTL: " fmt, ##__VA_ARGS__)
-#define rtl_dev_dbg(dev, fmt, ...) bt_dev_dbg(dev, "RTL: " fmt, ##__VA_ARGS__)
+#define rtl_dev_err(dev, fmt, ...) bt_dev_err(dev, "rtl: " fmt, ##__VA_ARGS__)
+#define rtl_dev_warn(dev, fmt, ...) bt_dev_warn(dev, "rtl: " fmt, ##__VA_ARGS__)
+#define rtl_dev_info(dev, fmt, ...) bt_dev_info(dev, "rtl: " fmt, ##__VA_ARGS__)
+#define rtl_dev_dbg(dev, fmt, ...) bt_dev_dbg(dev, "rtl: " fmt, ##__VA_ARGS__)
 
 struct btrtl_device_info;
 
-- 
2.23.0

