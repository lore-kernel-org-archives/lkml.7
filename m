Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FD6C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69005222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TimzpB2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfKMLBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:01:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50550 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:01:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so1505472wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 03:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0Xlz+ZxLjn4rwJrKXH7Gxgom3syRiCC9us180jsCHc=;
        b=TimzpB2YE+a4cLKKMqjNJvvegAfB47vo+pKINWJGOrjVSfgotVuTxCQWFKXjKlWq8L
         ibJWNKmfh5tIZWriV/a5AG0/MSc/76xcza8emTPXBKgYu1RTVFHS1PzJpIaP5O+8mP3E
         67yTYyXOhNstzpWyxO6FUK88IpO/avRoEGtG6U9tZ/VyeWpVXC5cL8HjtiSjeOUATRgd
         X1/H01u25tiNxHqdmYpTQB1PVwX5yltdEuZkxEK/tiiWotoKGnmAbAM27IvGlVlx0Nhu
         VGvIWgtiJSOjSHLO704YwF/8Rx5EL3NNDmeH2qq/Uy69mV0lYSCcxuyc7ZY4ZUSUo12H
         BDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0Xlz+ZxLjn4rwJrKXH7Gxgom3syRiCC9us180jsCHc=;
        b=L/ul0nzzhybDq/6znD6nHlxULsRYwkHXpT8olL8Ni5rBEuDYLOFQ1JCFmlpx45N/vr
         AqH+nFqhWJboW+JWyvky8efZ1Tp+UY7iDy3yxnO0l2zcVAqqXNUbNteaTUobdq2/5dLW
         Wu4YNqzhlke6CAtfUGt7P9Ui2hJOc22L9T2Hat8WLcSs2u5DDkYUEuS+/7kWwpF1pjH2
         UxgpqzRl5oClv+XYN2MkzvqMP4S5Bx80rHVGPkt60V0EteeL8jFrLmY/LzrcE9UfAfXF
         Wwfb3Oy2cNeosjax5ovW9PnQn1/6ceySX6qyQuxTzK/bJaR3EURi8a7ia/DMtVBuww+D
         btoA==
X-Gm-Message-State: APjAAAWd3VlRo+aif13TpXFzKR+NIMObpIVXF35mEiVTOQiFyWzjL5II
        x/8StpURaiAtgdJ9aOe9Dg==
X-Google-Smtp-Source: APXvYqwf5WCDLBqCxnZ57OkXfqRpxdRHeSvwxG0nXYQCzRh0ZxomwXY2xFVitIU1dP8LocnbWTrRNw==
X-Received: by 2002:a7b:c001:: with SMTP id c1mr2257443wmb.96.1573642864586;
        Wed, 13 Nov 2019 03:01:04 -0800 (PST)
Received: from ninjahub.lan (host-2-102-15-84.as13285.net. [2.102.15.84])
        by smtp.googlemail.com with ESMTPSA id c4sm2331492wrp.86.2019.11.13.03.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 03:01:03 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jerome.pouiller@silabs.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: align to fix warnings of line over 80 characters
Date:   Wed, 13 Nov 2019 11:00:52 +0000
Message-Id: <20191113110052.14855-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align to fix multiple warnings of line over 80 characters.
Issue detected by checkpatch tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/wfx/bus_sdio.c   |   4 +-
 drivers/staging/wfx/data_rx.h    |   3 +-
 drivers/staging/wfx/debug.c      |  15 ++--
 drivers/staging/wfx/fwio.c       |  65 ++++++++++-----
 drivers/staging/wfx/hif_rx.c     |  78 ++++++++++++------
 drivers/staging/wfx/hif_tx.c     |  66 ++++++++++-----
 drivers/staging/wfx/hif_tx_mib.h |  11 ++-
 drivers/staging/wfx/hwio.c       |  42 ++++++----
 drivers/staging/wfx/hwio.h       |   9 ++-
 drivers/staging/wfx/key.c        |  24 ++++--
 drivers/staging/wfx/main.c       |  61 +++++++++-----
 drivers/staging/wfx/queue.c      |  31 ++++---
 drivers/staging/wfx/queue.h      |   6 +-
 drivers/staging/wfx/scan.c       |  15 ++--
 drivers/staging/wfx/sta.c        | 133 +++++++++++++++++++++----------
 drivers/staging/wfx/sta.h        |   6 +-
 drivers/staging/wfx/traces.h     |  27 ++++---
 drivers/staging/wfx/wfx.h        |   6 +-
 18 files changed, 407 insertions(+), 195 deletions(-)

diff --git a/drivers/staging/wfx/bus_sdio.c b/drivers/staging/wfx/bus_sdio.c
index 375e07d6d9ae..f8901164c206 100644
--- a/drivers/staging/wfx/bus_sdio.c
+++ b/drivers/staging/wfx/bus_sdio.c
@@ -188,7 +188,9 @@ static int wfx_sdio_probe(struct sdio_func *func,
 
 	bus->func = func;
 	sdio_set_drvdata(func, bus);
-	func->card->quirks |= MMC_QUIRK_LENIENT_FN0 | MMC_QUIRK_BLKSZ_FOR_BYTE_MODE | MMC_QUIRK_BROKEN_BYTE_MODE_512;
+	func->card->quirks |= MMC_QUIRK_LENIENT_FN0 |
+			      MMC_QUIRK_BLKSZ_FOR_BYTE_MODE |
+			      MMC_QUIRK_BROKEN_BYTE_MODE_512;
 
 	sdio_claim_host(func);
 	ret = sdio_enable_func(func);
diff --git a/drivers/staging/wfx/data_rx.h b/drivers/staging/wfx/data_rx.h
index b44d15268f83..a50ce352bc5e 100644
--- a/drivers/staging/wfx/data_rx.h
+++ b/drivers/staging/wfx/data_rx.h
@@ -13,6 +13,7 @@
 struct wfx_vif;
 struct sk_buff;
 
-void wfx_rx_cb(struct wfx_vif *wvif, struct hif_ind_rx *arg, struct sk_buff *skb);
+void wfx_rx_cb(struct wfx_vif *wvif, struct hif_ind_rx *arg,
+	       struct sk_buff *skb);
 
 #endif /* WFX_DATA_RX_H */
diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
index 0a9ca109039c..d17a75242365 100644
--- a/drivers/staging/wfx/debug.c
+++ b/drivers/staging/wfx/debug.c
@@ -72,7 +72,8 @@ static int wfx_counters_show(struct seq_file *seq, void *v)
 		return -EIO;
 
 #define PUT_COUNTER(name) \
-	seq_printf(seq, "%24s %d\n", #name ":", le32_to_cpu(counters.count_##name))
+	seq_printf(seq, "%24s %d\n", #name ":",\
+		   le32_to_cpu(counters.count_##name))
 
 	PUT_COUNTER(tx_packets);
 	PUT_COUNTER(tx_multicast_frames);
@@ -211,7 +212,8 @@ struct dbgfs_hif_msg {
 	int ret;
 };
 
-static ssize_t wfx_send_hif_msg_write(struct file *file, const char __user *user_buf,
+static ssize_t wfx_send_hif_msg_write(struct file *file,
+				      const char __user *user_buf,
 				      size_t count, loff_t *ppos)
 {
 	struct dbgfs_hif_msg *context = file->private_data;
@@ -236,7 +238,8 @@ static ssize_t wfx_send_hif_msg_write(struct file *file, const char __user *user
 		kfree(request);
 		return -EINVAL;
 	}
-	context->ret = wfx_cmd_send(wdev, request, context->reply, sizeof(context->reply), false);
+	context->ret = wfx_cmd_send(wdev, request, context->reply,
+				    sizeof(context->reply), false);
 
 	kfree(request);
 	complete(&context->complete);
@@ -299,8 +302,10 @@ int wfx_debug_init(struct wfx_dev *wdev)
 	debugfs_create_file("counters", 0444, d, wdev, &wfx_counters_fops);
 	debugfs_create_file("rx_stats", 0444, d, wdev, &wfx_rx_stats_fops);
 	debugfs_create_file("send_pds", 0200, d, wdev, &wfx_send_pds_fops);
-	debugfs_create_file("burn_slk_key", 0200, d, wdev, &wfx_burn_slk_key_fops);
-	debugfs_create_file("send_hif_msg", 0600, d, wdev, &wfx_send_hif_msg_fops);
+	debugfs_create_file("burn_slk_key", 0200, d, wdev,
+			    &wfx_burn_slk_key_fops);
+	debugfs_create_file("send_hif_msg", 0600, d, wdev,
+			    &wfx_send_hif_msg_fops);
 
 	return 0;
 }
diff --git a/drivers/staging/wfx/fwio.c b/drivers/staging/wfx/fwio.c
index 6d82c6244c7f..dbf8bda71ff7 100644
--- a/drivers/staging/wfx/fwio.c
+++ b/drivers/staging/wfx/fwio.c
@@ -107,11 +107,14 @@ int get_firmware(struct wfx_dev *wdev, u32 keyset_chip,
 	const char *data;
 	int ret;
 
-	snprintf(filename, sizeof(filename), "%s_%02X.sec", wdev->pdata.file_fw, keyset_chip);
+	snprintf(filename, sizeof(filename), "%s_%02X.sec", wdev->pdata.file_fw,
+		 keyset_chip);
 	ret = firmware_request_nowarn(fw, filename, wdev->dev);
 	if (ret) {
-		dev_info(wdev->dev, "can't load %s, falling back to %s.sec\n", filename, wdev->pdata.file_fw);
-		snprintf(filename, sizeof(filename), "%s.sec", wdev->pdata.file_fw);
+		dev_info(wdev->dev, "can't load %s, falling back to %s.sec\n",
+			 filename, wdev->pdata.file_fw);
+		snprintf(filename, sizeof(filename), "%s.sec",
+			 wdev->pdata.file_fw);
 		ret = request_firmware(fw, filename, wdev->dev);
 		if (ret) {
 			dev_err(wdev->dev, "can't load %s\n", filename);
@@ -164,7 +167,8 @@ static int wait_ncp_status(struct wfx_dev *wdev, u32 status)
 			return -ETIMEDOUT;
 	}
 	if (ktime_compare(now, start))
-		dev_dbg(wdev->dev, "chip answer after %lldus\n", ktime_us_delta(now, start));
+		dev_dbg(wdev->dev, "chip answer after %lldus\n",
+			ktime_us_delta(now, start));
 	else
 		dev_dbg(wdev->dev, "chip answer immediately\n");
 	return 0;
@@ -188,15 +192,18 @@ static int upload_firmware(struct wfx_dev *wdev, const u8 *data, size_t len)
 			if (ret < 0)
 				return ret;
 			now = ktime_get();
-			if (offs + DNLD_BLOCK_SIZE - bytes_done < DNLD_FIFO_SIZE)
+			if (offs +
+			    DNLD_BLOCK_SIZE - bytes_done < DNLD_FIFO_SIZE)
 				break;
 			if (ktime_after(now, ktime_add_ms(start, DCA_TIMEOUT)))
 				return -ETIMEDOUT;
 		}
 		if (ktime_compare(now, start))
-			dev_dbg(wdev->dev, "answer after %lldus\n", ktime_us_delta(now, start));
+			dev_dbg(wdev->dev, "answer after %lldus\n",
+				ktime_us_delta(now, start));
 
-		ret = sram_write_dma_safe(wdev, WFX_DNLD_FIFO + (offs % DNLD_FIFO_SIZE),
+		ret = sram_write_dma_safe(wdev, WFX_DNLD_FIFO +
+					  (offs % DNLD_FIFO_SIZE),
 					  data + offs, DNLD_BLOCK_SIZE);
 		if (ret < 0)
 			return ret;
@@ -220,10 +227,14 @@ static void print_boot_status(struct wfx_dev *wdev)
 		dev_info(wdev->dev, "no error reported by secure boot\n");
 	} else {
 		sram_reg_read(wdev, WFX_ERR_INFO, &val32);
-		if (val32 < ARRAY_SIZE(fwio_error_strings) && fwio_error_strings[val32])
-			dev_info(wdev->dev, "secure boot error: %s\n", fwio_error_strings[val32]);
+		if (val32 < ARRAY_SIZE(fwio_error_strings) &&
+		    fwio_error_strings[val32])
+			dev_info(wdev->dev, "secure boot error: %s\n",
+				 fwio_error_strings[val32]);
 		else
-			dev_info(wdev->dev, "secure boot error: Unknown (0x%02x)\n", val32);
+			dev_info(wdev->dev,
+				 "secure boot error: Unknown (0x%02x)\n",
+				 val32);
 	}
 }
 
@@ -262,9 +273,13 @@ static int load_firmware_secure(struct wfx_dev *wdev)
 		goto error;
 
 	sram_reg_write(wdev, WFX_DNLD_FIFO, 0xFFFFFFFF); // Fifo init
-	sram_write_dma_safe(wdev, WFX_DCA_FW_VERSION, "\x01\x00\x00\x00", FW_VERSION_SIZE);
-	sram_write_dma_safe(wdev, WFX_DCA_FW_SIGNATURE, fw->data + fw_offset, FW_SIGNATURE_SIZE);
-	sram_write_dma_safe(wdev, WFX_DCA_FW_HASH, fw->data + fw_offset + FW_SIGNATURE_SIZE, FW_HASH_SIZE);
+	sram_write_dma_safe(wdev, WFX_DCA_FW_VERSION, "\x01\x00\x00\x00",
+			    FW_VERSION_SIZE);
+	sram_write_dma_safe(wdev, WFX_DCA_FW_SIGNATURE, fw->data + fw_offset,
+			    FW_SIGNATURE_SIZE);
+	sram_write_dma_safe(wdev, WFX_DCA_FW_HASH,
+			    fw->data + fw_offset + FW_SIGNATURE_SIZE,
+			    FW_HASH_SIZE);
 	sram_reg_write(wdev, WFX_DCA_IMAGE_SIZE, fw->size - header_size);
 	sram_reg_write(wdev, WFX_DCA_HOST_STATUS, HOST_UPLOAD_PENDING);
 	ret = wait_ncp_status(wdev, NCP_DOWNLOAD_PENDING);
@@ -272,10 +287,12 @@ static int load_firmware_secure(struct wfx_dev *wdev)
 		goto error;
 
 	start = ktime_get();
-	ret = upload_firmware(wdev, fw->data + header_size, fw->size - header_size);
+	ret = upload_firmware(wdev, fw->data + header_size,
+			      fw->size - header_size);
 	if (ret)
 		goto error;
-	dev_dbg(wdev->dev, "firmware load after %lldus\n", ktime_us_delta(ktime_get(), start));
+	dev_dbg(wdev->dev, "firmware load after %lldus\n",
+		ktime_us_delta(ktime_get(), start));
 
 	sram_reg_write(wdev, WFX_DCA_HOST_STATUS, HOST_UPLOAD_COMPLETE);
 	ret = wait_ncp_status(wdev, NCP_AUTH_OK);
@@ -310,10 +327,12 @@ static int init_gpr(struct wfx_dev *wdev)
 	};
 
 	for (i = 0; i < ARRAY_SIZE(gpr_init); i++) {
-		ret = igpr_reg_write(wdev, gpr_init[i].index, gpr_init[i].value);
+		ret = igpr_reg_write(wdev, gpr_init[i].index,
+				     gpr_init[i].value);
 		if (ret < 0)
 			return ret;
-		dev_dbg(wdev->dev, "  index %02x: %08x\n", gpr_init[i].index, gpr_init[i].value);
+		dev_dbg(wdev->dev, "  index %02x: %08x\n", gpr_init[i].index,
+			gpr_init[i].value);
 	}
 	return 0;
 }
@@ -348,7 +367,8 @@ int wfx_init_device(struct wfx_dev *wdev)
 
 	hw_revision = FIELD_GET(CFG_DEVICE_ID_MAJOR, reg);
 	if (hw_revision == 0 || hw_revision > 2) {
-		dev_err(wdev->dev, "bad hardware revision number: %d\n", hw_revision);
+		dev_err(wdev->dev, "bad hardware revision number: %d\n",
+			hw_revision);
 		return -ENODEV;
 	}
 	hw_type = FIELD_GET(CFG_DEVICE_ID_TYPE, reg);
@@ -375,7 +395,8 @@ int wfx_init_device(struct wfx_dev *wdev)
 			return -ETIMEDOUT;
 		}
 	}
-	dev_dbg(wdev->dev, "chip wake up after %lldus\n", ktime_us_delta(now, start));
+	dev_dbg(wdev->dev, "chip wake up after %lldus\n",
+		ktime_us_delta(now, start));
 
 	ret = config_reg_write_bits(wdev, CFG_CPU_RESET, 0);
 	if (ret < 0)
@@ -383,6 +404,10 @@ int wfx_init_device(struct wfx_dev *wdev)
 	ret = load_firmware_secure(wdev);
 	if (ret < 0)
 		return ret;
-	ret = config_reg_write_bits(wdev, CFG_DIRECT_ACCESS_MODE | CFG_IRQ_ENABLE_DATA | CFG_IRQ_ENABLE_WRDY, CFG_IRQ_ENABLE_DATA);
+	ret = config_reg_write_bits(wdev,
+				    CFG_DIRECT_ACCESS_MODE |
+				    CFG_IRQ_ENABLE_DATA |
+				    CFG_IRQ_ENABLE_WRDY,
+				    CFG_IRQ_ENABLE_DATA);
 	return ret;
 }
diff --git a/drivers/staging/wfx/hif_rx.c b/drivers/staging/wfx/hif_rx.c
index 36e171b27ae2..820de216be0c 100644
--- a/drivers/staging/wfx/hif_rx.c
+++ b/drivers/staging/wfx/hif_rx.c
@@ -18,7 +18,8 @@
 #include "secure_link.h"
 #include "hif_api_cmd.h"
 
-static int hif_generic_confirm(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_generic_confirm(struct wfx_dev *wdev, struct hif_msg *hif,
+			       void *buf)
 {
 	// All confirm messages start with status
 	int status = le32_to_cpu(*((__le32 *) buf));
@@ -33,7 +34,8 @@ static int hif_generic_confirm(struct wfx_dev *wdev, struct hif_msg *hif, void *
 	}
 
 	if (cmd != wdev->hif_cmd.buf_send->id) {
-		dev_warn(wdev->dev, "chip response mismatch request: 0x%.2x vs 0x%.2x\n",
+		dev_warn(wdev->dev,
+			 "chip response mismatch request: 0x%.2x vs 0x%.2x\n",
 			 cmd, wdev->hif_cmd.buf_send->id);
 		return -EINVAL;
 	}
@@ -70,7 +72,8 @@ static int hif_tx_confirm(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
 	return 0;
 }
 
-static int hif_multi_tx_confirm(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_multi_tx_confirm(struct wfx_dev *wdev, struct hif_msg *hif,
+				void *buf)
 {
 	struct hif_cnf_multi_transmit *body = buf;
 	struct hif_cnf_tx *buf_loc = (struct hif_cnf_tx *) &body->tx_conf_payload;
@@ -90,7 +93,8 @@ static int hif_multi_tx_confirm(struct wfx_dev *wdev, struct hif_msg *hif, void
 	return 0;
 }
 
-static int hif_startup_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_startup_indication(struct wfx_dev *wdev, struct hif_msg *hif,
+				  void *buf)
 {
 	struct hif_ind_startup *body = buf;
 
@@ -108,7 +112,8 @@ static int hif_startup_indication(struct wfx_dev *wdev, struct hif_msg *hif, voi
 	return 0;
 }
 
-static int hif_wakeup_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_wakeup_indication(struct wfx_dev *wdev, struct hif_msg *hif,
+				 void *buf)
 {
 	if (!wdev->pdata.gpio_wakeup
 	    || !gpiod_get_value(wdev->pdata.gpio_wakeup)) {
@@ -118,7 +123,8 @@ static int hif_wakeup_indication(struct wfx_dev *wdev, struct hif_msg *hif, void
 	return 0;
 }
 
-static int hif_keys_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_keys_indication(struct wfx_dev *wdev, struct hif_msg *hif,
+			       void *buf)
 {
 	struct hif_ind_sl_exchange_pub_keys *body = buf;
 
@@ -131,13 +137,15 @@ static int hif_keys_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *
 	return 0;
 }
 
-static int hif_receive_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf, struct sk_buff *skb)
+static int hif_receive_indication(struct wfx_dev *wdev, struct hif_msg *hif,
+				  void *buf, struct sk_buff *skb)
 {
 	struct wfx_vif *wvif = wdev_to_wvif(wdev, hif->interface);
 	struct hif_ind_rx *body = buf;
 
 	if (!wvif) {
-		dev_warn(wdev->dev, "ignore rx data for non-existent vif %d\n", hif->interface);
+		dev_warn(wdev->dev, "ignore rx data for non-existent vif %d\n",
+			 hif->interface);
 		return 0;
 	}
 	skb_pull(skb, sizeof(struct hif_msg) + sizeof(struct hif_ind_rx));
@@ -146,7 +154,8 @@ static int hif_receive_indication(struct wfx_dev *wdev, struct hif_msg *hif, voi
 	return 0;
 }
 
-static int hif_event_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_event_indication(struct wfx_dev *wdev, struct hif_msg *hif,
+				void *buf)
 {
 	struct wfx_vif *wvif = wdev_to_wvif(wdev, hif->interface);
 	struct hif_ind_event *body = buf;
@@ -173,7 +182,8 @@ static int hif_event_indication(struct wfx_dev *wdev, struct hif_msg *hif, void
 	return 0;
 }
 
-static int hif_pm_mode_complete_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_pm_mode_complete_indication(struct wfx_dev *wdev,
+					   struct hif_msg *hif, void *buf)
 {
 	struct wfx_vif *wvif = wdev_to_wvif(wdev, hif->interface);
 
@@ -183,7 +193,8 @@ static int hif_pm_mode_complete_indication(struct wfx_dev *wdev, struct hif_msg
 	return 0;
 }
 
-static int hif_scan_complete_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_scan_complete_indication(struct wfx_dev *wdev,
+					struct hif_msg *hif, void *buf)
 {
 	struct wfx_vif *wvif = wdev_to_wvif(wdev, hif->interface);
 	struct hif_ind_scan_cmpl *body = buf;
@@ -194,7 +205,8 @@ static int hif_scan_complete_indication(struct wfx_dev *wdev, struct hif_msg *hi
 	return 0;
 }
 
-static int hif_join_complete_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_join_complete_indication(struct wfx_dev *wdev,
+					struct hif_msg *hif, void *buf)
 {
 	struct wfx_vif *wvif = wdev_to_wvif(wdev, hif->interface);
 
@@ -204,7 +216,8 @@ static int hif_join_complete_indication(struct wfx_dev *wdev, struct hif_msg *hi
 	return 0;
 }
 
-static int hif_suspend_resume_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_suspend_resume_indication(struct wfx_dev *wdev,
+					 struct hif_msg *hif, void *buf)
 {
 	struct wfx_vif *wvif = wdev_to_wvif(wdev, hif->interface);
 	struct hif_ind_suspend_resume_tx *body = buf;
@@ -215,7 +228,8 @@ static int hif_suspend_resume_indication(struct wfx_dev *wdev, struct hif_msg *h
 	return 0;
 }
 
-static int hif_error_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_error_indication(struct wfx_dev *wdev, struct hif_msg *hif,
+				void *buf)
 {
 	struct hif_ind_error *body = buf;
 	u8 *pRollback = (u8 *) body->data;
@@ -223,31 +237,39 @@ static int hif_error_indication(struct wfx_dev *wdev, struct hif_msg *hif, void
 
 	switch (body->type) {
 	case HIF_ERROR_FIRMWARE_ROLLBACK:
-		dev_err(wdev->dev, "asynchronous error: firmware rollback error %d\n", *pRollback);
+		dev_err(wdev->dev,
+			"asynchronous error: firmware rollback error %d\n",
+			*pRollback);
 		break;
 	case HIF_ERROR_FIRMWARE_DEBUG_ENABLED:
 		dev_err(wdev->dev, "asynchronous error: firmware debug feature enabled\n");
 		break;
 	case HIF_ERROR_OUTDATED_SESSION_KEY:
-		dev_err(wdev->dev, "asynchronous error: secure link outdated key: %#.8x\n", *pStatus);
+		dev_err(wdev->dev, "asynchronous error: secure link outdated key: %#.8x\n",
+			*pStatus);
 		break;
 	case HIF_ERROR_INVALID_SESSION_KEY:
 		dev_err(wdev->dev, "asynchronous error: invalid session key\n");
 		break;
 	case HIF_ERROR_OOR_VOLTAGE:
-		dev_err(wdev->dev, "asynchronous error: out-of-range overvoltage: %#.8x\n", *pStatus);
+		dev_err(wdev->dev, "asynchronous error: out-of-range overvoltage: %#.8x\n",
+			*pStatus);
 		break;
 	case HIF_ERROR_PDS_VERSION:
-		dev_err(wdev->dev, "asynchronous error: wrong PDS payload or version: %#.8x\n", *pStatus);
+		dev_err(wdev->dev,
+			"asynchronous error: wrong PDS payload or version: %#.8x\n",
+			*pStatus);
 		break;
 	default:
-		dev_err(wdev->dev, "asynchronous error: unknown (%d)\n", body->type);
+		dev_err(wdev->dev, "asynchronous error: unknown (%d)\n",
+			body->type);
 		break;
 	}
 	return 0;
 }
 
-static int hif_generic_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_generic_indication(struct wfx_dev *wdev, struct hif_msg *hif,
+				  void *buf)
 {
 	struct hif_ind_generic *body = buf;
 
@@ -255,23 +277,29 @@ static int hif_generic_indication(struct wfx_dev *wdev, struct hif_msg *hif, voi
 	case HIF_GENERIC_INDICATION_TYPE_RAW:
 		return 0;
 	case HIF_GENERIC_INDICATION_TYPE_STRING:
-		dev_info(wdev->dev, "firmware says: %s\n", (char *) body->indication_data.raw_data);
+		dev_info(wdev->dev, "firmware says: %s\n",
+			 (char *) body->indication_data.raw_data);
 		return 0;
 	case HIF_GENERIC_INDICATION_TYPE_RX_STATS:
 		mutex_lock(&wdev->rx_stats_lock);
 		// Older firmware send a generic indication beside RxStats
 		if (!wfx_api_older_than(wdev, 1, 4))
-			dev_info(wdev->dev, "Rx test ongoing. Temperature: %d°C\n", body->indication_data.rx_stats.current_temp);
-		memcpy(&wdev->rx_stats, &body->indication_data.rx_stats, sizeof(wdev->rx_stats));
+			dev_info(wdev->dev, "Rx test ongoing. Temperature: %d°C\n",
+				 body->indication_data.rx_stats.current_temp);
+		memcpy(&wdev->rx_stats, &body->indication_data.rx_stats,
+		       sizeof(wdev->rx_stats));
 		mutex_unlock(&wdev->rx_stats_lock);
 		return 0;
 	default:
-		dev_err(wdev->dev, "generic_indication: unknown indication type: %#.8x\n", body->indication_type);
+		dev_err(wdev->dev,
+			"generic_indication: unknown indication type: %#.8x\n",
+			body->indication_type);
 		return -EIO;
 	}
 }
 
-static int hif_exception_indication(struct wfx_dev *wdev, struct hif_msg *hif, void *buf)
+static int hif_exception_indication(struct wfx_dev *wdev,
+				    struct hif_msg *hif, void *buf)
 {
 	size_t len = hif->len - 4; // drop header
 	dev_err(wdev->dev, "firmware exception\n");
diff --git a/drivers/staging/wfx/hif_tx.c b/drivers/staging/wfx/hif_tx.c
index 2f5dadff0660..cb7cddcb9815 100644
--- a/drivers/staging/wfx/hif_tx.c
+++ b/drivers/staging/wfx/hif_tx.c
@@ -24,7 +24,8 @@ void wfx_init_hif_cmd(struct wfx_hif_cmd *hif_cmd)
 	mutex_init(&hif_cmd->key_renew_lock);
 }
 
-static void wfx_fill_header(struct hif_msg *hif, int if_id, unsigned int cmd, size_t size)
+static void wfx_fill_header(struct hif_msg *hif, int if_id, unsigned int cmd,
+			    size_t size)
 {
 	if (if_id == -1)
 		if_id = 2;
@@ -47,7 +48,8 @@ static void *wfx_alloc_hif(size_t body_len, struct hif_msg **hif)
 		return NULL;
 }
 
-int wfx_cmd_send(struct wfx_dev *wdev, struct hif_msg *request, void *reply, size_t reply_len, bool async)
+int wfx_cmd_send(struct wfx_dev *wdev, struct hif_msg *request, void *reply,
+		 size_t reply_len, bool async)
 {
 	const char *mib_name = "";
 	const char *mib_sep = "";
@@ -100,7 +102,8 @@ int wfx_cmd_send(struct wfx_dev *wdev, struct hif_msg *request, void *reply, siz
 	wdev->hif_cmd.buf_send = NULL;
 	mutex_unlock(&wdev->hif_cmd.lock);
 
-	if (ret && (cmd == HIF_REQ_ID_READ_MIB || cmd == HIF_REQ_ID_WRITE_MIB)) {
+	if (ret &&
+	    (cmd == HIF_REQ_ID_READ_MIB || cmd == HIF_REQ_ID_WRITE_MIB)) {
 		mib_name = get_mib_name(((u16 *) request)[2]);
 		mib_sep = "/";
 	}
@@ -170,7 +173,8 @@ int hif_reset(struct wfx_vif *wvif, bool reset_stat)
 	return ret;
 }
 
-int hif_read_mib(struct wfx_dev *wdev, int vif_id, u16 mib_id, void *val, size_t val_len)
+int hif_read_mib(struct wfx_dev *wdev, int vif_id, u16 mib_id, void *val,
+		 size_t val_len)
 {
 	int ret;
 	struct hif_msg *hif;
@@ -183,11 +187,13 @@ int hif_read_mib(struct wfx_dev *wdev, int vif_id, u16 mib_id, void *val, size_t
 	ret = wfx_cmd_send(wdev, hif, reply, buf_len, false);
 
 	if (!ret && mib_id != reply->mib_id) {
-		dev_warn(wdev->dev, "%s: confirmation mismatch request\n", __func__);
+		dev_warn(wdev->dev,
+			 "%s: confirmation mismatch request\n", __func__);
 		ret = -EIO;
 	}
 	if (ret == -ENOMEM)
-		dev_err(wdev->dev, "buffer is too small to receive %s (%zu < %d)\n",
+		dev_err(wdev->dev,
+			"buffer is too small to receive %s (%zu < %d)\n",
 			get_mib_name(mib_id), val_len, reply->length);
 	if (!ret)
 		memcpy(val, &reply->mib_data, reply->length);
@@ -198,7 +204,8 @@ int hif_read_mib(struct wfx_dev *wdev, int vif_id, u16 mib_id, void *val, size_t
 	return ret;
 }
 
-int hif_write_mib(struct wfx_dev *wdev, int vif_id, u16 mib_id, void *val, size_t val_len)
+int hif_write_mib(struct wfx_dev *wdev, int vif_id, u16 mib_id, void *val,
+		  size_t val_len)
 {
 	int ret;
 	struct hif_msg *hif;
@@ -236,7 +243,8 @@ int hif_scan(struct wfx_vif *wvif, const struct wfx_scan_params *arg)
 	cpu_to_le32s(&body->min_channel_time);
 	cpu_to_le32s(&body->max_channel_time);
 	cpu_to_le32s(&body->tx_power_level);
-	memcpy(ptr, arg->ssids, arg->scan_req.num_of_ssi_ds * sizeof(struct hif_ssid_def));
+	memcpy(ptr, arg->ssids,
+	       arg->scan_req.num_of_ssi_ds * sizeof(struct hif_ssid_def));
 	ssids = (struct hif_ssid_def *) ptr;
 	for (i = 0; i < body->num_of_ssi_ds; ++i)
 		cpu_to_le32s(&ssids[i].ssid_length);
@@ -281,16 +289,19 @@ int hif_join(struct wfx_vif *wvif, const struct hif_req_join *arg)
 	return ret;
 }
 
-int hif_set_bss_params(struct wfx_vif *wvif, const struct hif_req_set_bss_params *arg)
+int hif_set_bss_params(struct wfx_vif *wvif,
+		       const struct hif_req_set_bss_params *arg)
 {
 	int ret;
 	struct hif_msg *hif;
-	struct hif_req_set_bss_params *body = wfx_alloc_hif(sizeof(*body), &hif);
+	struct hif_req_set_bss_params *body = wfx_alloc_hif(sizeof(*body),
+							    &hif);
 
 	memcpy(body, arg, sizeof(*body));
 	cpu_to_le16s(&body->aid);
 	cpu_to_le32s(&body->operational_rate_set);
-	wfx_fill_header(hif, wvif->id, HIF_REQ_ID_SET_BSS_PARAMS, sizeof(*body));
+	wfx_fill_header(hif, wvif->id, HIF_REQ_ID_SET_BSS_PARAMS,
+			sizeof(*body));
 	ret = wfx_cmd_send(wvif->wdev, hif, NULL, 0, false);
 	kfree(hif);
 	return ret;
@@ -308,7 +319,8 @@ int hif_add_key(struct wfx_dev *wdev, const struct hif_req_add_key *arg)
 	if (wfx_api_older_than(wdev, 1, 5))
 		// Legacy firmwares expect that add_key to be sent on right
 		// interface.
-		wfx_fill_header(hif, arg->int_id, HIF_REQ_ID_ADD_KEY, sizeof(*body));
+		wfx_fill_header(hif, arg->int_id, HIF_REQ_ID_ADD_KEY,
+				sizeof(*body));
 	else
 		wfx_fill_header(hif, -1, HIF_REQ_ID_ADD_KEY, sizeof(*body));
 	ret = wfx_cmd_send(wdev, hif, NULL, 0, false);
@@ -329,18 +341,21 @@ int hif_remove_key(struct wfx_dev *wdev, int idx)
 	return ret;
 }
 
-int hif_set_edca_queue_params(struct wfx_vif *wvif, const struct hif_req_edca_queue_params *arg)
+int hif_set_edca_queue_params(struct wfx_vif *wvif,
+			      const struct hif_req_edca_queue_params *arg)
 {
 	int ret;
 	struct hif_msg *hif;
-	struct hif_req_edca_queue_params *body = wfx_alloc_hif(sizeof(*body), &hif);
+	struct hif_req_edca_queue_params *body = wfx_alloc_hif(sizeof(*body),
+							       &hif);
 
 	// NOTE: queues numerotation are not the same between WFx and Linux
 	memcpy(body, arg, sizeof(*body));
 	cpu_to_le16s(&body->cw_min);
 	cpu_to_le16s(&body->cw_max);
 	cpu_to_le16s(&body->tx_op_limit);
-	wfx_fill_header(hif, wvif->id, HIF_REQ_ID_EDCA_QUEUE_PARAMS, sizeof(*body));
+	wfx_fill_header(hif, wvif->id, HIF_REQ_ID_EDCA_QUEUE_PARAMS,
+			sizeof(*body));
 	ret = wfx_cmd_send(wvif->wdev, hif, NULL, 0, false);
 	kfree(hif);
 	return ret;
@@ -379,10 +394,12 @@ int hif_beacon_transmit(struct wfx_vif *wvif, bool enable_beaconing)
 {
 	int ret;
 	struct hif_msg *hif;
-	struct hif_req_beacon_transmit *body = wfx_alloc_hif(sizeof(*body), &hif);
+	struct hif_req_beacon_transmit *body = wfx_alloc_hif(sizeof(*body),
+							     &hif);
 
 	body->enable_beaconing = enable_beaconing ? 1 : 0;
-	wfx_fill_header(hif, wvif->id, HIF_REQ_ID_BEACON_TRANSMIT, sizeof(*body));
+	wfx_fill_header(hif, wvif->id, HIF_REQ_ID_BEACON_TRANSMIT,
+			sizeof(*body));
 	ret = wfx_cmd_send(wvif->wdev, hif, NULL, 0, false);
 	kfree(hif);
 	return ret;
@@ -421,16 +438,20 @@ int hif_update_ie(struct wfx_vif *wvif, const struct hif_ie_flags *target_frame,
 	return ret;
 }
 
-int hif_sl_send_pub_keys(struct wfx_dev *wdev, const uint8_t *pubkey, const uint8_t *pubkey_hmac)
+int hif_sl_send_pub_keys(struct wfx_dev *wdev, const uint8_t *pubkey,
+			 const uint8_t *pubkey_hmac)
 {
 	int ret;
 	struct hif_msg *hif;
-	struct hif_req_sl_exchange_pub_keys *body = wfx_alloc_hif(sizeof(*body), &hif);
+	struct hif_req_sl_exchange_pub_keys *body = wfx_alloc_hif(sizeof(*body),
+								  &hif);
 
 	body->algorithm = HIF_SL_CURVE25519;
 	memcpy(body->host_pub_key, pubkey, sizeof(body->host_pub_key));
-	memcpy(body->host_pub_key_mac, pubkey_hmac, sizeof(body->host_pub_key_mac));
-	wfx_fill_header(hif, -1, HIF_REQ_ID_SL_EXCHANGE_PUB_KEYS, sizeof(*body));
+	memcpy(body->host_pub_key_mac, pubkey_hmac,
+	       sizeof(body->host_pub_key_mac));
+	wfx_fill_header(hif, -1, HIF_REQ_ID_SL_EXCHANGE_PUB_KEYS,
+			sizeof(*body));
 	ret = wfx_cmd_send(wdev, hif, NULL, 0, false);
 	kfree(hif);
 	// Compatibility with legacy secure link
@@ -457,7 +478,8 @@ int hif_sl_set_mac_key(struct wfx_dev *wdev, const u8 *slk_key,
 {
 	int ret;
 	struct hif_msg *hif;
-	struct hif_req_set_sl_mac_key *body = wfx_alloc_hif(sizeof(*body), &hif);
+	struct hif_req_set_sl_mac_key *body = wfx_alloc_hif(sizeof(*body),
+							    &hif);
 
 	memcpy(body->key_value, slk_key, sizeof(body->key_value));
 	body->otp_or_ram = destination;
diff --git a/drivers/staging/wfx/hif_tx_mib.h b/drivers/staging/wfx/hif_tx_mib.h
index d1cabd697205..bb091e395ff5 100644
--- a/drivers/staging/wfx/hif_tx_mib.h
+++ b/drivers/staging/wfx/hif_tx_mib.h
@@ -57,8 +57,9 @@ static inline int hif_get_counters_table(struct wfx_dev *wdev,
 		return hif_read_mib(wdev, 0, HIF_MIB_ID_COUNTERS_TABLE,
 				    arg, sizeof(struct hif_mib_count_table));
 	} else {
-		return hif_read_mib(wdev, 0, HIF_MIB_ID_EXTENDED_COUNTERS_TABLE,
-				    arg, sizeof(struct hif_mib_extended_count_table));
+		return hif_read_mib(wdev, 0,
+				    HIF_MIB_ID_EXTENDED_COUNTERS_TABLE, arg,
+				sizeof(struct hif_mib_extended_count_table));
 	}
 }
 
@@ -112,7 +113,8 @@ static inline int hif_beacon_filter_control(struct wfx_vif *wvif,
 		.bcn_count = cpu_to_le32(beacon_count),
 	};
 	return hif_write_mib(wvif->wdev, wvif->id,
-			     HIF_MIB_ID_BEACON_FILTER_ENABLE, &arg, sizeof(arg));
+			     HIF_MIB_ID_BEACON_FILTER_ENABLE,
+			     &arg, sizeof(arg));
 }
 
 static inline int hif_set_operational_mode(struct wfx_dev *wdev,
@@ -173,7 +175,8 @@ static inline int hif_set_association_mode(struct wfx_vif *wvif,
 static inline int hif_set_tx_rate_retry_policy(struct wfx_vif *wvif,
 					       struct hif_mib_set_tx_rate_retry_policy *arg)
 {
-	size_t size = struct_size(arg, tx_rate_retry_policy, arg->num_tx_rate_policies);
+	size_t size = struct_size(arg, tx_rate_retry_policy,
+				  arg->num_tx_rate_policies);
 
 	return hif_write_mib(wvif->wdev, wvif->id,
 			     HIF_MIB_ID_SET_TX_RATE_RETRY_POLICY, arg, size);
diff --git a/drivers/staging/wfx/hwio.c b/drivers/staging/wfx/hwio.c
index 0cf52aee10e7..47e04c59ed93 100644
--- a/drivers/staging/wfx/hwio.c
+++ b/drivers/staging/wfx/hwio.c
@@ -34,12 +34,14 @@ static int read32(struct wfx_dev *wdev, int reg, u32 *val)
 	*val = ~0; // Never return undefined value
 	if (!tmp)
 		return -ENOMEM;
-	ret = wdev->hwbus_ops->copy_from_io(wdev->hwbus_priv, reg, tmp, sizeof(u32));
+	ret = wdev->hwbus_ops->copy_from_io(wdev->hwbus_priv, reg, tmp,
+					    sizeof(u32));
 	if (ret >= 0)
 		*val = le32_to_cpu(*tmp);
 	kfree(tmp);
 	if (ret)
-		dev_err(wdev->dev, "%s: bus communication error: %d\n", __func__, ret);
+		dev_err(wdev->dev, "%s: bus communication error: %d\n",
+			__func__, ret);
 	return ret;
 }
 
@@ -51,10 +53,12 @@ static int write32(struct wfx_dev *wdev, int reg, u32 val)
 	if (!tmp)
 		return -ENOMEM;
 	*tmp = cpu_to_le32(val);
-	ret = wdev->hwbus_ops->copy_to_io(wdev->hwbus_priv, reg, tmp, sizeof(u32));
+	ret = wdev->hwbus_ops->copy_to_io(wdev->hwbus_priv, reg, tmp,
+					  sizeof(u32));
 	kfree(tmp);
 	if (ret)
-		dev_err(wdev->dev, "%s: bus communication error: %d\n", __func__, ret);
+		dev_err(wdev->dev, "%s: bus communication error: %d\n",
+			__func__, ret);
 	return ret;
 }
 
@@ -102,7 +106,8 @@ static int write32_bits_locked(struct wfx_dev *wdev, int reg, u32 mask, u32 val)
 	return ret;
 }
 
-static int indirect_read(struct wfx_dev *wdev, int reg, u32 addr, void *buf, size_t len)
+static int indirect_read(struct wfx_dev *wdev, int reg, u32 addr, void *buf,
+			 size_t len)
 {
 	int ret;
 	int i;
@@ -152,7 +157,8 @@ static int indirect_read(struct wfx_dev *wdev, int reg, u32 addr, void *buf, siz
 	return ret;
 }
 
-static int indirect_write(struct wfx_dev *wdev, int reg, u32 addr, const void *buf, size_t len)
+static int indirect_write(struct wfx_dev *wdev, int reg, u32 addr,
+			  const void *buf, size_t len)
 {
 	int ret;
 
@@ -165,7 +171,8 @@ static int indirect_write(struct wfx_dev *wdev, int reg, u32 addr, const void *b
 	return wdev->hwbus_ops->copy_to_io(wdev->hwbus_priv, reg, buf, len);
 }
 
-static int indirect_read_locked(struct wfx_dev *wdev, int reg, u32 addr, void *buf, size_t len)
+static int indirect_read_locked(struct wfx_dev *wdev, int reg, u32 addr,
+				void *buf, size_t len)
 {
 	int ret;
 
@@ -176,7 +183,8 @@ static int indirect_read_locked(struct wfx_dev *wdev, int reg, u32 addr, void *b
 	return ret;
 }
 
-static int indirect_write_locked(struct wfx_dev *wdev, int reg, u32 addr, const void *buf, size_t len)
+static int indirect_write_locked(struct wfx_dev *wdev, int reg, u32 addr,
+				 const void *buf, size_t len)
 {
 	int ret;
 
@@ -187,7 +195,8 @@ static int indirect_write_locked(struct wfx_dev *wdev, int reg, u32 addr, const
 	return ret;
 }
 
-static int indirect_read32_locked(struct wfx_dev *wdev, int reg, u32 addr, u32 *val)
+static int indirect_read32_locked(struct wfx_dev *wdev, int reg, u32 addr,
+				  u32 *val)
 {
 	int ret;
 	__le32 *tmp = kmalloc(sizeof(u32), GFP_KERNEL);
@@ -203,7 +212,8 @@ static int indirect_read32_locked(struct wfx_dev *wdev, int reg, u32 addr, u32 *
 	return ret;
 }
 
-static int indirect_write32_locked(struct wfx_dev *wdev, int reg, u32 addr, u32 val)
+static int indirect_write32_locked(struct wfx_dev *wdev, int reg, u32 addr,
+				   u32 val)
 {
 	int ret;
 	__le32 *tmp = kmalloc(sizeof(u32), GFP_KERNEL);
@@ -225,11 +235,13 @@ int wfx_data_read(struct wfx_dev *wdev, void *buf, size_t len)
 
 	WARN((long) buf & 3, "%s: unaligned buffer", __func__);
 	wdev->hwbus_ops->lock(wdev->hwbus_priv);
-	ret = wdev->hwbus_ops->copy_from_io(wdev->hwbus_priv, WFX_REG_IN_OUT_QUEUE, buf, len);
+	ret = wdev->hwbus_ops->copy_from_io(wdev->hwbus_priv,
+					    WFX_REG_IN_OUT_QUEUE, buf, len);
 	_trace_io_read(WFX_REG_IN_OUT_QUEUE, buf, len);
 	wdev->hwbus_ops->unlock(wdev->hwbus_priv);
 	if (ret)
-		dev_err(wdev->dev, "%s: bus communication error: %d\n", __func__, ret);
+		dev_err(wdev->dev, "%s: bus communication error: %d\n",
+			__func__, ret);
 	return ret;
 }
 
@@ -239,11 +251,13 @@ int wfx_data_write(struct wfx_dev *wdev, const void *buf, size_t len)
 
 	WARN((long) buf & 3, "%s: unaligned buffer", __func__);
 	wdev->hwbus_ops->lock(wdev->hwbus_priv);
-	ret = wdev->hwbus_ops->copy_to_io(wdev->hwbus_priv, WFX_REG_IN_OUT_QUEUE, buf, len);
+	ret = wdev->hwbus_ops->copy_to_io(wdev->hwbus_priv,
+					  WFX_REG_IN_OUT_QUEUE, buf, len);
 	_trace_io_write(WFX_REG_IN_OUT_QUEUE, buf, len);
 	wdev->hwbus_ops->unlock(wdev->hwbus_priv);
 	if (ret)
-		dev_err(wdev->dev, "%s: bus communication error: %d\n", __func__, ret);
+		dev_err(wdev->dev, "%s: bus communication error: %d\n",
+			__func__, ret);
 	return ret;
 }
 
diff --git a/drivers/staging/wfx/hwio.h b/drivers/staging/wfx/hwio.h
index 906524f71fd1..b2c1a66de963 100644
--- a/drivers/staging/wfx/hwio.h
+++ b/drivers/staging/wfx/hwio.h
@@ -37,8 +37,13 @@ int ahb_reg_write(struct wfx_dev *wdev, u32 addr, u32 val);
 #define CFG_ERR_HOST_NO_IN_QUEUE   0x00000040
 #define CFG_ERR_HOST_CRC_MISS      0x00000080 // only with SDIO
 #define CFG_SPI_IGNORE_CS          0x00000080 // only with SPI
-#define CFG_WORD_MODE_MASK         0x00000300 // Bytes ordering (only writable in SPI):
-#define     CFG_WORD_MODE0         0x00000000 //   B1,B0,B3,B2 (In SPI, register address and CONFIG data always use this mode)
+/* Bytes ordering (only writable in SPI): */
+#define CFG_WORD_MODE_MASK         0x00000300
+/*
+ * B1,B0,B3,B2 (In SPI, register address and
+ * CONFIG data always use this mode)
+ */
+#define     CFG_WORD_MODE0         0x00000000
 #define     CFG_WORD_MODE1         0x00000100 //   B3,B2,B1,B0
 #define     CFG_WORD_MODE2         0x00000200 //   B0,B1,B2,B3 (SDIO)
 #define CFG_DIRECT_ACCESS_MODE     0x00000400 // Direct or queue access mode
diff --git a/drivers/staging/wfx/key.c b/drivers/staging/wfx/key.c
index caea6d959b0e..96adfa330604 100644
--- a/drivers/staging/wfx/key.c
+++ b/drivers/staging/wfx/key.c
@@ -171,28 +171,36 @@ static int wfx_add_key(struct wfx_vif *wvif, struct ieee80211_sta *sta,
 		return -EINVAL;
 	k = &wdev->keys[idx];
 	k->int_id = wvif->id;
-	if (key->cipher == WLAN_CIPHER_SUITE_WEP40 || key->cipher ==  WLAN_CIPHER_SUITE_WEP104) {
+	if (key->cipher == WLAN_CIPHER_SUITE_WEP40 ||
+	    key->cipher ==  WLAN_CIPHER_SUITE_WEP104) {
 		if (pairwise)
-			k->type = fill_wep_pair(&k->key.wep_pairwise_key, key, sta->addr);
+			k->type = fill_wep_pair(&k->key.wep_pairwise_key, key,
+						sta->addr);
 		else
 			k->type = fill_wep_group(&k->key.wep_group_key, key);
 	} else if (key->cipher == WLAN_CIPHER_SUITE_TKIP) {
 		if (pairwise)
-			k->type = fill_tkip_pair(&k->key.tkip_pairwise_key, key, sta->addr);
+			k->type = fill_tkip_pair(&k->key.tkip_pairwise_key, key,
+						 sta->addr);
 		else
-			k->type = fill_tkip_group(&k->key.tkip_group_key, key, &seq, wvif->vif->type);
+			k->type = fill_tkip_group(&k->key.tkip_group_key, key,
+						  &seq, wvif->vif->type);
 	} else if (key->cipher == WLAN_CIPHER_SUITE_CCMP) {
 		if (pairwise)
-			k->type = fill_ccmp_pair(&k->key.aes_pairwise_key, key, sta->addr);
+			k->type = fill_ccmp_pair(&k->key.aes_pairwise_key, key,
+						 sta->addr);
 		else
-			k->type = fill_ccmp_group(&k->key.aes_group_key, key, &seq);
+			k->type = fill_ccmp_group(&k->key.aes_group_key, key,
+						  &seq);
 	} else if (key->cipher ==  WLAN_CIPHER_SUITE_SMS4) {
 		if (pairwise)
-			k->type = fill_sms4_pair(&k->key.wapi_pairwise_key, key, sta->addr);
+			k->type = fill_sms4_pair(&k->key.wapi_pairwise_key, key,
+						 sta->addr);
 		else
 			k->type = fill_sms4_group(&k->key.wapi_group_key, key);
 	} else if (key->cipher ==  WLAN_CIPHER_SUITE_AES_CMAC) {
-		k->type = fill_aes_cmac_group(&k->key.igtk_group_key, key, &seq);
+		k->type = fill_aes_cmac_group(&k->key.igtk_group_key, key,
+					      &seq);
 	} else {
 		dev_warn(wdev->dev, "unsupported key type %d\n", key->cipher);
 		wfx_free_key(wdev, idx);
diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 18f07f7ad347..986a2ef678b9 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -99,7 +99,8 @@ static const struct ieee80211_supported_band wfx_band_2ghz = {
 	.ht_cap = {
 		// Receive caps
 		.cap = IEEE80211_HT_CAP_GRN_FLD | IEEE80211_HT_CAP_SGI_20 |
-		       IEEE80211_HT_CAP_MAX_AMSDU | (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT),
+		       IEEE80211_HT_CAP_MAX_AMSDU |
+		       (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT),
 		.ht_supported = 1,
 		.ampdu_factor = IEEE80211_HT_MAX_AMPDU_16K,
 		.ampdu_density = IEEE80211_HT_MPDU_DENSITY_NONE,
@@ -163,14 +164,17 @@ bool wfx_api_older_than(struct wfx_dev *wdev, int major, int minor)
 	return false;
 }
 
-struct gpio_desc *wfx_get_gpio(struct device *dev, int override, const char *label)
+struct gpio_desc *wfx_get_gpio(struct device *dev, int override,
+			       const char *label)
 {
 	struct gpio_desc *ret;
 	char label_buf[256];
 
 	if (override >= 0) {
 		snprintf(label_buf, sizeof(label_buf), "wfx_%s", label);
-		ret = ERR_PTR(devm_gpio_request_one(dev, override, GPIOF_OUT_INIT_LOW, label_buf));
+		ret = ERR_PTR(devm_gpio_request_one(dev, override,
+						    GPIOF_OUT_INIT_LOW,
+						    label_buf));
 		if (!ret)
 			ret = gpio_to_desc(override);
 	} else if (override == -1) {
@@ -182,10 +186,12 @@ struct gpio_desc *wfx_get_gpio(struct device *dev, int override, const char *lab
 		if (!ret || PTR_ERR(ret) == -ENOENT)
 			dev_warn(dev, "gpio %s is not defined\n", label);
 		else
-			dev_warn(dev, "error while requesting gpio %s\n", label);
+			dev_warn(dev,
+				 "error while requesting gpio %s\n", label);
 		ret = NULL;
 	} else {
-		dev_dbg(dev, "using gpio %d for %s\n", desc_to_gpio(ret), label);
+		dev_dbg(dev,
+			"using gpio %d for %s\n", desc_to_gpio(ret), label);
 	}
 	return ret;
 }
@@ -215,7 +221,8 @@ int wfx_send_pds(struct wfx_dev *wdev, unsigned char *buf, size_t len)
 			buf[i] = 0;
 			dev_dbg(wdev->dev, "send PDS '%s}'\n", buf + start);
 			buf[i] = '}';
-			ret = hif_configuration(wdev, buf + start, i - start + 1);
+			ret = hif_configuration(wdev, buf + start,
+						i - start + 1);
 			if (ret == HIF_STATUS_FAILURE) {
 				dev_err(wdev->dev, "PDS bytes %d to %d: invalid data (unsupported options?)\n", start, i);
 				return -EINVAL;
@@ -243,7 +250,8 @@ static int wfx_send_pdata_pds(struct wfx_dev *wdev)
 
 	ret = request_firmware(&pds, wdev->pdata.file_pds, wdev->dev);
 	if (ret) {
-		dev_err(wdev->dev, "can't load PDS file %s\n", wdev->pdata.file_pds);
+		dev_err(wdev->dev, "can't load PDS file %s\n",
+			wdev->pdata.file_pds);
 		return ret;
 	}
 	tmp_buf = kmemdup(pds->data, pds->size, GFP_KERNEL);
@@ -282,7 +290,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	hw->queues = 4;
 	hw->max_rates = 8;
 	hw->max_rate_tries = 15;
-	hw->extra_tx_headroom = sizeof(struct hif_sl_msg_hdr) + sizeof(struct hif_msg)
+	hw->extra_tx_headroom = sizeof(struct hif_sl_msg_hdr) +
+				sizeof(struct hif_msg)
 				+ sizeof(struct hif_req_tx)
 				+ 4 /* alignment */ + 8 /* TKIP IV */;
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
@@ -297,7 +306,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	hw->wiphy->iface_combinations = wfx_iface_combinations;
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmalloc(dev, sizeof(wfx_band_2ghz), GFP_KERNEL);
 	// FIXME: also copy wfx_rates and wfx_2ghz_chantable
-	memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz, sizeof(wfx_band_2ghz));
+	memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz,
+	       sizeof(wfx_band_2ghz));
 
 	wdev = hw->priv;
 	wdev->hw = hw;
@@ -305,7 +315,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	wdev->hwbus_ops = hwbus_ops;
 	wdev->hwbus_priv = hwbus_priv;
 	memcpy(&wdev->pdata, pdata, sizeof(*pdata));
-	of_property_read_string(dev->of_node, "config-file", &wdev->pdata.file_pds);
+	of_property_read_string(dev->of_node, "config-file",
+				&wdev->pdata.file_pds);
 	wdev->pdata.gpio_wakeup = wfx_get_gpio(dev, gpio_wakeup, "wakeup");
 	wfx_sl_fill_pdata(dev, &wdev->pdata);
 
@@ -344,7 +355,8 @@ int wfx_probe(struct wfx_dev *wdev)
 	if (err)
 		goto err1;
 
-	err = wait_for_completion_interruptible_timeout(&wdev->firmware_ready, 10 * HZ);
+	err = wait_for_completion_interruptible_timeout(&wdev->firmware_ready,
+							10 * HZ);
 	if (err <= 0) {
 		if (err == 0) {
 			dev_err(wdev->dev, "timeout while waiting for startup indication. IRQ configuration error?\n");
@@ -359,16 +371,19 @@ int wfx_probe(struct wfx_dev *wdev)
 	dev_info(wdev->dev, "started firmware %d.%d.%d \"%s\" (API: %d.%d, keyset: %02X, caps: 0x%.8X)\n",
 		 wdev->hw_caps.firmware_major, wdev->hw_caps.firmware_minor,
 		 wdev->hw_caps.firmware_build, wdev->hw_caps.firmware_label,
-		 wdev->hw_caps.api_version_major, wdev->hw_caps.api_version_minor,
+		 wdev->hw_caps.api_version_major,
+		 wdev->hw_caps.api_version_minor,
 		 wdev->keyset, *((u32 *) &wdev->hw_caps.capabilities));
-	snprintf(wdev->hw->wiphy->fw_version, sizeof(wdev->hw->wiphy->fw_version),
+	snprintf(wdev->hw->wiphy->fw_version,
+		 sizeof(wdev->hw->wiphy->fw_version),
 		 "%d.%d.%d",
 		 wdev->hw_caps.firmware_major,
 		 wdev->hw_caps.firmware_minor,
 		 wdev->hw_caps.firmware_build);
 
 	if (wfx_api_older_than(wdev, 1, 0)) {
-		dev_err(wdev->dev, "unsupported firmware API version (expect 1 while firmware returns %d)\n",
+		dev_err(wdev->dev,
+			"unsupported firmware API version (expect 1 while firmware returns %d)\n",
 			wdev->hw_caps.api_version_major);
 		err = -ENOTSUPP;
 		goto err1;
@@ -376,7 +391,8 @@ int wfx_probe(struct wfx_dev *wdev)
 
 	err = wfx_sl_init(wdev);
 	if (err && wdev->hw_caps.capabilities.link_mode == SEC_LINK_ENFORCED) {
-		dev_err(wdev->dev, "chip require secure_link, but can't negociate it\n");
+		dev_err(wdev->dev,
+			"chip require secure_link, but can't negociate it\n");
 		goto err1;
 	}
 
@@ -386,15 +402,18 @@ int wfx_probe(struct wfx_dev *wdev)
 		wdev->hw->wiphy->bands[NL80211_BAND_2GHZ]->channels[13].flags |= IEEE80211_CHAN_DISABLED;
 	}
 
-	dev_dbg(wdev->dev, "sending configuration file %s\n", wdev->pdata.file_pds);
+	dev_dbg(wdev->dev, "sending configuration file %s\n",
+		wdev->pdata.file_pds);
 	err = wfx_send_pdata_pds(wdev);
 	if (err < 0)
 		goto err1;
 
 	wdev->pdata.gpio_wakeup = gpio_saved;
 	if (wdev->pdata.gpio_wakeup) {
-		dev_dbg(wdev->dev, "enable 'quiescent' power mode with gpio %d and PDS file %s\n",
-			desc_to_gpio(wdev->pdata.gpio_wakeup), wdev->pdata.file_pds);
+		dev_dbg(wdev->dev,
+			"enable 'quiescent' power mode with gpio %d and PDS file %s\n",
+			desc_to_gpio(wdev->pdata.gpio_wakeup),
+			wdev->pdata.file_pds);
 		gpiod_set_value(wdev->pdata.gpio_wakeup, 1);
 		control_reg_write(wdev, 0);
 		hif_set_operational_mode(wdev, HIF_OP_POWER_MODE_QUIESCENT);
@@ -411,13 +430,15 @@ int wfx_probe(struct wfx_dev *wdev)
 			ether_addr_copy(wdev->addresses[i].addr, macaddr);
 			wdev->addresses[i].addr[ETH_ALEN - 1] += i;
 		} else {
-			ether_addr_copy(wdev->addresses[i].addr, wdev->hw_caps.mac_addr[i]);
+			ether_addr_copy(wdev->addresses[i].addr,
+					wdev->hw_caps.mac_addr[i]);
 		}
 		if (!is_valid_ether_addr(wdev->addresses[i].addr)) {
 			dev_warn(wdev->dev, "using random MAC address\n");
 			eth_random_addr(wdev->addresses[i].addr);
 		}
-		dev_info(wdev->dev, "MAC address %d: %pM\n", i, wdev->addresses[i].addr);
+		dev_info(wdev->dev, "MAC address %d: %pM\n", i,
+			 wdev->addresses[i].addr);
 	}
 	wdev->hw->wiphy->n_addresses = ARRAY_SIZE(wdev->addresses);
 	wdev->hw->wiphy->addresses = wdev->addresses;
diff --git a/drivers/staging/wfx/queue.c b/drivers/staging/wfx/queue.c
index ef3ee55cf621..800beb1ecdda 100644
--- a/drivers/staging/wfx/queue.c
+++ b/drivers/staging/wfx/queue.c
@@ -42,7 +42,8 @@ void wfx_tx_flush(struct wfx_dev *wdev)
 				 !wdev->hif.tx_buffers_used,
 				 msecs_to_jiffies(3000));
 	if (!ret) {
-		dev_warn(wdev->dev, "cannot flush tx buffers (%d still busy)\n", wdev->hif.tx_buffers_used);
+		dev_warn(wdev->dev, "cannot flush tx buffers (%d still busy)\n",
+			 wdev->hif.tx_buffers_used);
 		wfx_pending_dump_old_frames(wdev, 3000);
 		// FIXME: drop pending frames here
 		wdev->chip_frozen = 1;
@@ -121,7 +122,8 @@ void wfx_tx_queues_wait_empty_vif(struct wfx_vif *wvif)
 	} while (!done);
 }
 
-static void wfx_tx_queue_clear(struct wfx_dev *wdev, struct wfx_queue *queue, struct sk_buff_head *gc_list)
+static void wfx_tx_queue_clear(struct wfx_dev *wdev, struct wfx_queue *queue,
+			       struct sk_buff_head *gc_list)
 {
 	int i;
 	struct sk_buff *item;
@@ -189,7 +191,8 @@ size_t wfx_tx_queue_get_num_queued(struct wfx_queue *queue,
 		ret = skb_queue_len(&queue->queue);
 	} else {
 		ret = 0;
-		for (i = 0, bit = 1; i < ARRAY_SIZE(queue->link_map_cache); ++i, bit <<= 1) {
+		for (i = 0, bit = 1; i < ARRAY_SIZE(queue->link_map_cache);
+		     ++i, bit <<= 1) {
 			if (link_id_map & bit)
 				ret += queue->link_map_cache[i];
 		}
@@ -198,7 +201,8 @@ size_t wfx_tx_queue_get_num_queued(struct wfx_queue *queue,
 	return ret;
 }
 
-void wfx_tx_queue_put(struct wfx_dev *wdev, struct wfx_queue *queue, struct sk_buff *skb)
+void wfx_tx_queue_put(struct wfx_dev *wdev, struct wfx_queue *queue,
+		      struct sk_buff *skb)
 {
 	struct wfx_queue_stats *stats = &wdev->tx_queue_stats;
 	struct wfx_tx_priv *tx_priv = wfx_skb_tx_priv(skb);
@@ -315,7 +319,8 @@ void wfx_pending_dump_old_frames(struct wfx_dev *wdev, unsigned int limit_ms)
 	skb_queue_walk(&stats->pending, skb) {
 		tx_priv = wfx_skb_tx_priv(skb);
 		req = wfx_skb_txreq(skb);
-		if (ktime_after(now, ktime_add_ms(tx_priv->xmit_timestamp, limit_ms))) {
+		if (ktime_after(now, ktime_add_ms(tx_priv->xmit_timestamp,
+						  limit_ms))) {
 			if (first) {
 				dev_info(wdev->dev, "frames stuck in firmware since %dms or more:\n",
 					 limit_ms);
@@ -329,7 +334,8 @@ void wfx_pending_dump_old_frames(struct wfx_dev *wdev, unsigned int limit_ms)
 	spin_unlock_bh(&stats->pending.lock);
 }
 
-unsigned int wfx_pending_get_pkt_us_delay(struct wfx_dev *wdev, struct sk_buff *skb)
+unsigned int wfx_pending_get_pkt_us_delay(struct wfx_dev *wdev,
+					  struct sk_buff *skb)
 {
 	ktime_t now = ktime_get();
 	struct wfx_tx_priv *tx_priv = wfx_skb_tx_priv(skb);
@@ -376,7 +382,8 @@ static bool hif_handle_tx_data(struct wfx_vif *wvif, struct sk_buff *skb,
 	case NL80211_IFTYPE_AP:
 		if (!wvif->state) {
 			action = do_drop;
-		} else if (!(BIT(tx_priv->raw_link_id) & (BIT(0) | wvif->link_id_map))) {
+		} else if (!(BIT(tx_priv->raw_link_id) &
+			     (BIT(0) | wvif->link_id_map))) {
 			dev_warn(wvif->wdev->dev, "a frame with expired link-id is dropped\n");
 			action = do_drop;
 		}
@@ -462,7 +469,8 @@ static int wfx_get_prio_queue(struct wfx_vif *wvif,
 	/* override winner if bursting */
 	if (winner >= 0 && wvif->wdev->tx_burst_idx >= 0 &&
 	    winner != wvif->wdev->tx_burst_idx &&
-	    !wfx_tx_queue_get_num_queued(&wvif->wdev->tx_queue[winner], tx_allowed_mask & urgent) &&
+	    !wfx_tx_queue_get_num_queued(&wvif->wdev->tx_queue[winner],
+					 tx_allowed_mask & urgent) &&
 	    wfx_tx_queue_get_num_queued(&wvif->wdev->tx_queue[wvif->wdev->tx_burst_idx], tx_allowed_mask))
 		winner = wvif->wdev->tx_burst_idx;
 
@@ -536,10 +544,13 @@ struct hif_msg *wfx_tx_queues_get(struct wfx_dev *wdev)
 		while ((wvif = wvif_iterate(wdev, wvif)) != NULL) {
 			spin_lock_bh(&wvif->ps_state_lock);
 
-			not_found = wfx_tx_queue_mask_get(wvif, &vif_queue, &vif_tx_allowed_mask, &vif_more);
+			not_found = wfx_tx_queue_mask_get(wvif, &vif_queue,
+							  &vif_tx_allowed_mask,
+							  &vif_more);
 
 			if (wvif->mcast_buffered && (not_found || !vif_more) &&
-					(wvif->mcast_tx || !wvif->sta_asleep_mask)) {
+					(wvif->mcast_tx ||
+					 !wvif->sta_asleep_mask)) {
 				wvif->mcast_buffered = false;
 				if (wvif->mcast_tx) {
 					wvif->mcast_tx = false;
diff --git a/drivers/staging/wfx/queue.h b/drivers/staging/wfx/queue.h
index 938dbf3469e7..21566e48b2c2 100644
--- a/drivers/staging/wfx/queue.h
+++ b/drivers/staging/wfx/queue.h
@@ -47,13 +47,15 @@ bool wfx_tx_queues_is_empty(struct wfx_dev *wdev);
 void wfx_tx_queues_wait_empty_vif(struct wfx_vif *wvif);
 struct hif_msg *wfx_tx_queues_get(struct wfx_dev *wdev);
 
-void wfx_tx_queue_put(struct wfx_dev *wdev, struct wfx_queue *queue, struct sk_buff *skb);
+void wfx_tx_queue_put(struct wfx_dev *wdev, struct wfx_queue *queue,
+		      struct sk_buff *skb);
 size_t wfx_tx_queue_get_num_queued(struct wfx_queue *queue, u32 link_id_map);
 
 struct sk_buff *wfx_pending_get(struct wfx_dev *wdev, u32 packet_id);
 int wfx_pending_remove(struct wfx_dev *wdev, struct sk_buff *skb);
 int wfx_pending_requeue(struct wfx_dev *wdev, struct sk_buff *skb);
-unsigned int wfx_pending_get_pkt_us_delay(struct wfx_dev *wdev, struct sk_buff *skb);
+unsigned int wfx_pending_get_pkt_us_delay(struct wfx_dev *wdev,
+					  struct sk_buff *skb);
 void wfx_pending_dump_old_frames(struct wfx_dev *wdev, unsigned int limit_ms);
 
 #endif /* WFX_QUEUE_H */
diff --git a/drivers/staging/wfx/scan.c b/drivers/staging/wfx/scan.c
index cba735c1e73c..35fcf9119f96 100644
--- a/drivers/staging/wfx/scan.c
+++ b/drivers/staging/wfx/scan.c
@@ -12,7 +12,8 @@
 #include "sta.h"
 #include "hif_tx_mib.h"
 
-static void __ieee80211_scan_completed_compat(struct ieee80211_hw *hw, bool aborted)
+static void __ieee80211_scan_completed_compat(struct ieee80211_hw *hw,
+					      bool aborted)
 {
 	struct cfg80211_scan_info info = {
 		.aborted = aborted ? 1 : 0,
@@ -159,7 +160,8 @@ void wfx_scan_work(struct work_struct *work)
 
 	if (!wvif->scan.req || wvif->scan.curr == wvif->scan.end) {
 		if (wvif->scan.output_power != wvif->wdev->output_power)
-			hif_set_output_power(wvif, wvif->wdev->output_power * 10);
+			hif_set_output_power(wvif,
+					     wvif->wdev->output_power * 10);
 
 		if (wvif->scan.status < 0)
 			dev_warn(wvif->wdev->dev, "scan failed\n");
@@ -172,7 +174,8 @@ void wfx_scan_work(struct work_struct *work)
 		wfx_scan_restart_delayed(wvif);
 		wfx_tx_unlock(wvif->wdev);
 		mutex_unlock(&wvif->wdev->conf_mutex);
-		__ieee80211_scan_completed_compat(wvif->wdev->hw, wvif->scan.status ? 1 : 0);
+		__ieee80211_scan_completed_compat(wvif->wdev->hw,
+						  wvif->scan.status ? 1 : 0);
 		up(&wvif->scan.lock);
 		if (wvif->state == WFX_STATE_STA &&
 		    !(wvif->powersave_mode.pm_mode.enter_psm))
@@ -211,7 +214,8 @@ void wfx_scan_work(struct work_struct *work)
 		scan.scan_req.scan_flags.fbg = 1;
 	}
 
-	scan.ch = kcalloc(scan.scan_req.num_of_channels, sizeof(u8), GFP_KERNEL);
+	scan.ch = kcalloc(scan.scan_req.num_of_channels,
+			  sizeof(u8), GFP_KERNEL);
 
 	if (!scan.ch) {
 		wvif->scan.status = -ENOMEM;
@@ -273,7 +277,8 @@ void wfx_scan_complete_cb(struct wfx_vif *wvif, struct hif_ind_scan_cmpl *arg)
 
 void wfx_scan_timeout(struct work_struct *work)
 {
-	struct wfx_vif *wvif = container_of(work, struct wfx_vif, scan.timeout.work);
+	struct wfx_vif *wvif = container_of(work, struct wfx_vif,
+					    scan.timeout.work);
 
 	if (atomic_xchg(&wvif->scan.in_progress, 0)) {
 		if (wvif->scan.status > 0) {
diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index 43137657209c..01a2bef62a5d 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -100,7 +100,8 @@ void wfx_cqm_bssloss_sm(struct wfx_vif *wvif, int init, int good, int bad)
 		skb = ieee80211_nullfunc_get(wvif->wdev->hw, wvif->vif, false);
 		if (!skb)
 			goto end;
-		memset(IEEE80211_SKB_CB(skb), 0, sizeof(*IEEE80211_SKB_CB(skb)));
+		memset(IEEE80211_SKB_CB(skb), 0,
+		       sizeof(*IEEE80211_SKB_CB(skb)));
 		IEEE80211_SKB_CB(skb)->control.vif = wvif->vif;
 		IEEE80211_SKB_CB(skb)->driver_rates[0].idx = 0;
 		IEEE80211_SKB_CB(skb)->driver_rates[0].count = 1;
@@ -180,8 +181,10 @@ static int wfx_set_mcast_filter(struct wfx_vif *wvif,
 	for (i = 0; i < fp->num_addresses; i++) {
 		filter_addr_val.condition_idx = i;
 		filter_addr_val.address_type = HIF_MAC_ADDR_A1;
-		ether_addr_copy(filter_addr_val.mac_address, fp->address_list[i]);
-		ret = hif_set_mac_addr_condition(wvif, &filter_addr_val);
+		ether_addr_copy(filter_addr_val.mac_address,
+				fp->address_list[i]);
+		ret = hif_set_mac_addr_condition(wvif,
+						 &filter_addr_val);
 		if (ret)
 			return ret;
 		config.mac_cond |= 1 << i;
@@ -246,7 +249,8 @@ void wfx_update_filtering(struct wfx_vif *wvif)
 		bf_ctrl.bcn_count = 1;
 		n_filter_ies = 0;
 	} else if (!is_sta) {
-		bf_ctrl.enable = HIF_BEACON_FILTER_ENABLE | HIF_BEACON_FILTER_AUTO_ERP;
+		bf_ctrl.enable = HIF_BEACON_FILTER_ENABLE |
+				 HIF_BEACON_FILTER_AUTO_ERP;
 		bf_ctrl.bcn_count = 0;
 		n_filter_ies = 2;
 	} else {
@@ -257,9 +261,11 @@ void wfx_update_filtering(struct wfx_vif *wvif)
 
 	ret = hif_set_rx_filter(wvif, filter_bssid, fwd_probe_req);
 	if (!ret)
-		ret = hif_set_beacon_filter_table(wvif, n_filter_ies, filter_ies);
+		ret = hif_set_beacon_filter_table(wvif, n_filter_ies,
+						  filter_ies);
 	if (!ret)
-		ret = hif_beacon_filter_control(wvif, bf_ctrl.enable, bf_ctrl.bcn_count);
+		ret = hif_beacon_filter_control(wvif, bf_ctrl.enable,
+						bf_ctrl.bcn_count);
 	if (!ret)
 		ret = wfx_set_mcast_filter(wvif, &wvif->mcast_filter);
 	if (ret)
@@ -268,12 +274,14 @@ void wfx_update_filtering(struct wfx_vif *wvif)
 
 static void wfx_update_filtering_work(struct work_struct *work)
 {
-	struct wfx_vif *wvif = container_of(work, struct wfx_vif, update_filtering_work);
+	struct wfx_vif *wvif = container_of(work, struct wfx_vif,
+					    update_filtering_work);
 
 	wfx_update_filtering(wvif);
 }
 
-u64 wfx_prepare_multicast(struct ieee80211_hw *hw, struct netdev_hw_addr_list *mc_list)
+u64 wfx_prepare_multicast(struct ieee80211_hw *hw,
+			  struct netdev_hw_addr_list *mc_list)
 {
 	int i;
 	struct netdev_hw_addr *ha;
@@ -283,12 +291,14 @@ u64 wfx_prepare_multicast(struct ieee80211_hw *hw, struct netdev_hw_addr_list *m
 
 	while ((wvif = wvif_iterate(wdev, wvif)) != NULL) {
 		memset(&wvif->mcast_filter, 0x00, sizeof(wvif->mcast_filter));
-		if (!count || count > ARRAY_SIZE(wvif->mcast_filter.address_list))
+		if (!count ||
+		    count > ARRAY_SIZE(wvif->mcast_filter.address_list))
 			continue;
 
 		i = 0;
 		netdev_hw_addr_list_for_each(ha, mc_list) {
-			ether_addr_copy(wvif->mcast_filter.address_list[i], ha->addr);
+			ether_addr_copy(wvif->mcast_filter.address_list[i],
+					ha->addr);
 			i++;
 		}
 		wvif->mcast_filter.enable = 1;
@@ -310,7 +320,8 @@ void wfx_configure_filter(struct ieee80211_hw *hw,
 
 	while ((wvif = wvif_iterate(wdev, wvif)) != NULL) {
 		down(&wvif->scan.lock);
-		wvif->filter_bssid = (*total_flags & (FIF_OTHER_BSS | FIF_PROBE_REQ)) ? 0 : 1;
+		wvif->filter_bssid = (*total_flags &
+				      (FIF_OTHER_BSS | FIF_PROBE_REQ)) ? 0 : 1;
 		wvif->disable_beacon_filter = !(*total_flags & FIF_PROBE_REQ);
 		wfx_fwd_probe_req(wvif, true);
 		wfx_update_filtering(wvif);
@@ -384,8 +395,10 @@ int wfx_set_pm(struct wfx_vif *wvif, const struct hif_req_set_pm_mode *arg)
 		pm.pm_mode.fast_psm = 0;
 	}
 
-	if (!wait_for_completion_timeout(&wvif->set_pm_mode_complete, msecs_to_jiffies(300)))
-		dev_warn(wvif->wdev->dev, "timeout while waiting of set_pm_mode_complete\n");
+	if (!wait_for_completion_timeout(&wvif->set_pm_mode_complete,
+					 msecs_to_jiffies(300)))
+		dev_warn(wvif->wdev->dev,
+			 "timeout while waiting of set_pm_mode_complete\n");
 	ret = hif_set_pm(wvif, &pm);
 	// FIXME: why ?
 	if (-ETIMEDOUT == wvif->scan.status)
@@ -445,7 +458,8 @@ void wfx_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		wvif = (struct wfx_vif *) vif->drv_priv;
 		if (wvif->vif->type == NL80211_IFTYPE_MONITOR)
 			drop = true;
-		if (wvif->vif->type == NL80211_IFTYPE_AP && !wvif->enable_beacon)
+		if (wvif->vif->type == NL80211_IFTYPE_AP &&
+		    !wvif->enable_beacon)
 			drop = true;
 	}
 
@@ -497,7 +511,8 @@ static void wfx_event_handler_work(struct work_struct *work)
 				 */
 				wvif->delayed_link_loss = 1;
 				/* Also start a watchdog. */
-				schedule_delayed_work(&wvif->bss_loss_work, 5 * HZ);
+				schedule_delayed_work(&wvif->bss_loss_work,
+						      5 * HZ);
 			}
 			break;
 		case HIF_EVENT_IND_BSSREGAINED:
@@ -505,13 +520,17 @@ static void wfx_event_handler_work(struct work_struct *work)
 			cancel_work_sync(&wvif->unjoin_work);
 			break;
 		case HIF_EVENT_IND_RCPI_RSSI:
-			wfx_event_report_rssi(wvif, event->evt.event_data.rcpi_rssi);
+			wfx_event_report_rssi(wvif,
+					      event->evt.event_data.rcpi_rssi);
 			break;
 		case HIF_EVENT_IND_PS_MODE_ERROR:
-			dev_warn(wvif->wdev->dev, "error while processing power save request\n");
+			dev_warn(wvif->wdev->dev,
+				 "error while processing power save request\n");
 			break;
 		default:
-			dev_warn(wvif->wdev->dev, "unhandled event indication: %.2x\n", event->evt.event_id);
+			dev_warn(wvif->wdev->dev,
+				 "unhandled event indication: %.2x\n",
+				 event->evt.event_id);
 			break;
 		}
 	}
@@ -520,14 +539,16 @@ static void wfx_event_handler_work(struct work_struct *work)
 
 static void wfx_bss_loss_work(struct work_struct *work)
 {
-	struct wfx_vif *wvif = container_of(work, struct wfx_vif, bss_loss_work.work);
+	struct wfx_vif *wvif = container_of(work, struct wfx_vif,
+					    bss_loss_work.work);
 
 	ieee80211_connection_loss(wvif->vif);
 }
 
 static void wfx_bss_params_work(struct work_struct *work)
 {
-	struct wfx_vif *wvif = container_of(work, struct wfx_vif, bss_params_work);
+	struct wfx_vif *wvif = container_of(work, struct wfx_vif,
+					    bss_params_work);
 
 	mutex_lock(&wvif->wdev->conf_mutex);
 	wvif->bss_params.bss_flags.lost_count_only = 1;
@@ -538,9 +559,11 @@ static void wfx_bss_params_work(struct work_struct *work)
 
 static void wfx_set_beacon_wakeup_period_work(struct work_struct *work)
 {
-	struct wfx_vif *wvif = container_of(work, struct wfx_vif, set_beacon_wakeup_period_work);
+	struct wfx_vif *wvif = container_of(work, struct wfx_vif,
+					    set_beacon_wakeup_period_work);
 
-	hif_set_beacon_wakeup_period(wvif, wvif->dtim_period, wvif->dtim_period);
+	hif_set_beacon_wakeup_period(wvif, wvif->dtim_period,
+				     wvif->dtim_period);
 }
 
 static void wfx_do_unjoin(struct wfx_vif *wvif)
@@ -549,7 +572,8 @@ static void wfx_do_unjoin(struct wfx_vif *wvif)
 
 	if (atomic_read(&wvif->scan.in_progress)) {
 		if (wvif->delayed_unjoin)
-			dev_dbg(wvif->wdev->dev, "delayed unjoin is already scheduled\n");
+			dev_dbg(wvif->wdev->dev,
+				"delayed unjoin is already scheduled\n");
 		else
 			wvif->delayed_unjoin = true;
 		goto done;
@@ -591,7 +615,8 @@ static void wfx_do_unjoin(struct wfx_vif *wvif)
 	mutex_unlock(&wvif->wdev->conf_mutex);
 }
 
-static void wfx_set_mfp(struct wfx_vif *wvif, struct cfg80211_bss *bss)
+static void wfx_set_mfp(struct wfx_vif *wvif,
+			struct cfg80211_bss *bss)
 {
 	const int pairwise_cipher_suite_count_offset = 8 / sizeof(u16);
 	const int pairwise_cipher_suite_size = 4 / sizeof(u16);
@@ -632,7 +657,8 @@ static void wfx_do_join(struct wfx_vif *wvif)
 		.preamble_type = conf->use_short_preamble ? HIF_PREAMBLE_SHORT : HIF_PREAMBLE_LONG,
 		.probe_for_join = 1,
 		.atim_window = 0,
-		.basic_rate_set = wfx_rate_mask_to_hw(wvif->wdev, conf->basic_rates),
+		.basic_rate_set = wfx_rate_mask_to_hw(wvif->wdev,
+						      conf->basic_rates),
 	};
 
 	if (wvif->channel->flags & IEEE80211_CHAN_NO_IR)
@@ -643,7 +669,8 @@ static void wfx_do_join(struct wfx_vif *wvif)
 
 	bssid = wvif->vif->bss_conf.bssid;
 
-	bss = cfg80211_get_bss(wvif->wdev->hw->wiphy, wvif->channel, bssid, NULL, 0,
+	bss = cfg80211_get_bss(wvif->wdev->hw->wiphy, wvif->channel,
+			       bssid, NULL, 0,
 			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
 
 	if (!bss && !conf->ibss_joined) {
@@ -819,7 +846,8 @@ static int wfx_start_ap(struct wfx_vif *wvif)
 		.beacon_interval = conf->beacon_int,
 		.dtim_period = conf->dtim_period,
 		.preamble_type = conf->use_short_preamble ? HIF_PREAMBLE_SHORT : HIF_PREAMBLE_LONG,
-		.basic_rate_set = wfx_rate_mask_to_hw(wvif->wdev, conf->basic_rates),
+		.basic_rate_set = wfx_rate_mask_to_hw(wvif->wdev,
+						      conf->basic_rates),
 	};
 
 	memset(start.ssid, 0, sizeof(start.ssid));
@@ -931,7 +959,8 @@ static int wfx_ht_ampdu_density(const struct wfx_ht_info *ht_info)
 	return ht_info->ht_cap.ampdu_density;
 }
 
-static void wfx_join_finalize(struct wfx_vif *wvif, struct ieee80211_bss_conf *info)
+static void wfx_join_finalize(struct wfx_vif *wvif,
+			      struct ieee80211_bss_conf *info)
 {
 	struct ieee80211_sta *sta = NULL;
 	struct hif_mib_set_association_mode association_mode = { };
@@ -955,7 +984,8 @@ static void wfx_join_finalize(struct wfx_vif *wvif, struct ieee80211_bss_conf *i
 	rcu_read_unlock();
 
 	/* Non Greenfield stations present */
-	if (wvif->ht_info.operation_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT)
+	if (wvif->ht_info.operation_mode &
+	    IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT)
 		hif_dual_cts_protection(wvif, true);
 	else
 		hif_dual_cts_protection(wvif, false);
@@ -1014,7 +1044,9 @@ void wfx_bss_info_changed(struct ieee80211_hw *hw,
 			filter.condition_idx = i;
 			if (i < nb_arp_addr) {
 				// Caution: type of arp_addr_list[i] is __be32
-				memcpy(filter.ipv4_address, &info->arp_addr_list[i], sizeof(filter.ipv4_address));
+				memcpy(filter.ipv4_address,
+				       &info->arp_addr_list[i],
+				       sizeof(filter.ipv4_address));
 				filter.arp_enable = HIF_ARP_NS_FILTERING_ENABLE;
 			} else {
 				filter.arp_enable = HIF_ARP_NS_FILTERING_DISABLE;
@@ -1031,7 +1063,8 @@ void wfx_bss_info_changed(struct ieee80211_hw *hw,
 		wfx_upload_beacon(wvif);
 	}
 
-	if (changed & BSS_CHANGED_BEACON_ENABLED && wvif->state != WFX_STATE_IBSS) {
+	if (changed & BSS_CHANGED_BEACON_ENABLED &&
+	    wvif->state != WFX_STATE_IBSS) {
 		if (wvif->enable_beacon != info->enable_beacon) {
 			hif_beacon_transmit(wvif, info->enable_beacon);
 			wvif->enable_beacon = info->enable_beacon;
@@ -1064,7 +1097,8 @@ void wfx_bss_info_changed(struct ieee80211_hw *hw,
 
 		if (changed &
 		    (BSS_CHANGED_ASSOC | BSS_CHANGED_BSSID |
-		     BSS_CHANGED_IBSS | BSS_CHANGED_BASIC_RATES | BSS_CHANGED_HT)) {
+		     BSS_CHANGED_IBSS | BSS_CHANGED_BASIC_RATES |
+		     BSS_CHANGED_HT)) {
 			if (info->assoc) {
 				if (wvif->state < WFX_STATE_PRE_STA) {
 					ieee80211_connection_loss(vif);
@@ -1080,7 +1114,8 @@ void wfx_bss_info_changed(struct ieee80211_hw *hw,
 			if (info->assoc || info->ibss_joined)
 				wfx_join_finalize(wvif, info);
 			else
-				memset(&wvif->bss_params, 0, sizeof(wvif->bss_params));
+				memset(&wvif->bss_params, 0,
+				       sizeof(wvif->bss_params));
 		}
 	}
 
@@ -1135,7 +1170,8 @@ void wfx_bss_info_changed(struct ieee80211_hw *hw,
 		hif_set_rcpi_rssi_threshold(wvif, &th);
 	}
 
-	if (changed & BSS_CHANGED_TXPOWER && info->txpower != wdev->output_power) {
+	if (changed & BSS_CHANGED_TXPOWER &&
+	    info->txpower != wdev->output_power) {
 		wdev->output_power = info->txpower;
 		hif_set_output_power(wvif, wdev->output_power * 10);
 	}
@@ -1250,7 +1286,8 @@ int wfx_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, bool set)
 
 static void wfx_mcast_start_work(struct work_struct *work)
 {
-	struct wfx_vif *wvif = container_of(work, struct wfx_vif, mcast_start_work);
+	struct wfx_vif *wvif = container_of(work, struct wfx_vif,
+					    mcast_start_work);
 	long tmo = wvif->dtim_period * TU_TO_JIFFIES(wvif->beacon_int + 20);
 
 	cancel_work_sync(&wvif->mcast_stop_work);
@@ -1265,7 +1302,8 @@ static void wfx_mcast_start_work(struct work_struct *work)
 
 static void wfx_mcast_stop_work(struct work_struct *work)
 {
-	struct wfx_vif *wvif = container_of(work, struct wfx_vif, mcast_stop_work);
+	struct wfx_vif *wvif = container_of(work, struct wfx_vif,
+					    mcast_stop_work);
 
 	if (wvif->aid0_bit_set) {
 		del_timer_sync(&wvif->mcast_timeout);
@@ -1313,7 +1351,8 @@ void wfx_suspend_resume(struct wfx_vif *wvif,
 		if (!arg->suspend_resume_flags.resume)
 			wvif->mcast_tx = false;
 		else
-			wvif->mcast_tx = wvif->aid0_bit_set && wvif->mcast_buffered;
+			wvif->mcast_tx = wvif->aid0_bit_set &&
+					 wvif->mcast_buffered;
 		if (wvif->mcast_tx) {
 			cancel_tmo = true;
 			wfx_bh_request_tx(wvif->wdev);
@@ -1361,7 +1400,8 @@ int wfx_assign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
-void wfx_unassign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+void wfx_unassign_vif_chanctx(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
 			      struct ieee80211_chanctx_conf *conf)
 {
 	struct wfx_vif *wvif = (struct wfx_vif *) vif->drv_priv;
@@ -1395,14 +1435,19 @@ int wfx_config(struct ieee80211_hw *hw, u32 changed)
 	if (changed & IEEE80211_CONF_CHANGE_PS) {
 		wvif = NULL;
 		while ((wvif = wvif_iterate(wdev, wvif)) != NULL) {
-			memset(&wvif->powersave_mode, 0, sizeof(wvif->powersave_mode));
+			memset(&wvif->powersave_mode, 0,
+			       sizeof(wvif->powersave_mode));
 			if (conf->flags & IEEE80211_CONF_PS) {
 				wvif->powersave_mode.pm_mode.enter_psm = 1;
 				if (conf->dynamic_ps_timeout > 0) {
 					wvif->powersave_mode.pm_mode.fast_psm = 1;
-					// Firmware does not support more than 128ms
+					/*
+					 * Firmware does not support more than
+					 * 128ms
+					 */
 					wvif->powersave_mode.fast_psm_idle_period =
-						min(conf->dynamic_ps_timeout * 2, 255);
+						min(conf->dynamic_ps_timeout *
+						    2, 255);
 				}
 			}
 			if (wvif->state == WFX_STATE_STA && wvif->bss_params.aid)
@@ -1518,7 +1563,8 @@ int wfx_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	init_completion(&wvif->set_pm_mode_complete);
 	complete(&wvif->set_pm_mode_complete);
-	INIT_WORK(&wvif->set_beacon_wakeup_period_work, wfx_set_beacon_wakeup_period_work);
+	INIT_WORK(&wvif->set_beacon_wakeup_period_work,
+		  wfx_set_beacon_wakeup_period_work);
 	INIT_WORK(&wvif->update_filtering_work, wfx_update_filtering_work);
 	INIT_WORK(&wvif->bss_params_work, wfx_bss_params_work);
 	INIT_WORK(&wvif->set_cts_work, wfx_set_cts_work);
@@ -1528,7 +1574,8 @@ int wfx_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	hif_set_macaddr(wvif, vif->addr);
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		memcpy(&wvif->edca.params[i], &default_edca_params[i], sizeof(default_edca_params[i]));
+		memcpy(&wvif->edca.params[i], &default_edca_params[i],
+		       sizeof(default_edca_params[i]));
 		wvif->edca.uapsd_enable[i] = false;
 		hif_set_edca_queue_params(wvif, &wvif->edca.params[i]);
 	}
diff --git a/drivers/staging/wfx/sta.h b/drivers/staging/wfx/sta.h
index 57c46bd4e650..4ccf1b17632b 100644
--- a/drivers/staging/wfx/sta.h
+++ b/drivers/staging/wfx/sta.h
@@ -86,11 +86,13 @@ void wfx_change_chanctx(struct ieee80211_hw *hw,
 			struct ieee80211_chanctx_conf *conf, u32 changed);
 int wfx_assign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct ieee80211_chanctx_conf *conf);
-void wfx_unassign_vif_chanctx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+void wfx_unassign_vif_chanctx(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
 			      struct ieee80211_chanctx_conf *conf);
 
 // WSM Callbacks
-void wfx_suspend_resume(struct wfx_vif *wvif, struct hif_ind_suspend_resume_tx *arg);
+void wfx_suspend_resume(struct wfx_vif *wvif,
+			struct hif_ind_suspend_resume_tx *arg);
 
 // Other Helpers
 void wfx_cqm_bssloss_sm(struct wfx_vif *wvif, int init, int good, int bad);
diff --git a/drivers/staging/wfx/traces.h b/drivers/staging/wfx/traces.h
index 67457cda133b..3f6198ab2235 100644
--- a/drivers/staging/wfx/traces.h
+++ b/drivers/staging/wfx/traces.h
@@ -177,14 +177,16 @@ DECLARE_EVENT_CLASS(hif_data,
 		else
 			__entry->msg_type = "REQ";
 		if (!is_recv &&
-		    (__entry->msg_id == HIF_REQ_ID_READ_MIB || __entry->msg_id == HIF_REQ_ID_WRITE_MIB)) {
+		    (__entry->msg_id == HIF_REQ_ID_READ_MIB ||
+		     __entry->msg_id == HIF_REQ_ID_WRITE_MIB)) {
 			__entry->mib = le16_to_cpup((u16 *) hif->body);
 			header_len = 4;
 		} else {
 			__entry->mib = -1;
 			header_len = 0;
 		}
-		__entry->buf_len = min_t(int, __entry->msg_len, sizeof(__entry->buf))
+		__entry->buf_len = min_t(int, __entry->msg_len,
+					 sizeof(__entry->buf))
 				   - sizeof(struct hif_msg) - header_len;
 		memcpy(__entry->buf, hif->body + header_len, __entry->buf_len);
 	),
@@ -203,11 +205,13 @@ DECLARE_EVENT_CLASS(hif_data,
 DEFINE_EVENT(hif_data, hif_send,
 	TP_PROTO(struct hif_msg *hif, int tx_fill_level, bool is_recv),
 	TP_ARGS(hif, tx_fill_level, is_recv));
-#define _trace_hif_send(hif, tx_fill_level) trace_hif_send(hif, tx_fill_level, false)
+#define _trace_hif_send(hif, tx_fill_level)\
+	trace_hif_send(hif, tx_fill_level, false)
 DEFINE_EVENT(hif_data, hif_recv,
 	TP_PROTO(struct hif_msg *hif, int tx_fill_level, bool is_recv),
 	TP_ARGS(hif, tx_fill_level, is_recv));
-#define _trace_hif_recv(hif, tx_fill_level) trace_hif_recv(hif, tx_fill_level, true)
+#define _trace_hif_recv(hif, tx_fill_level)\
+	trace_hif_recv(hif, tx_fill_level, true)
 
 #define wfx_reg_list_enum                                 \
 	wfx_reg_name(WFX_REG_CONFIG,       "CONFIG")      \
@@ -241,7 +245,8 @@ DECLARE_EVENT_CLASS(io_data,
 		__entry->reg = reg;
 		__entry->addr = addr;
 		__entry->msg_len = len;
-		__entry->buf_len = min_t(int, sizeof(__entry->buf), __entry->msg_len);
+		__entry->buf_len = min_t(int, sizeof(__entry->buf),
+					 __entry->msg_len);
 		memcpy(__entry->buf, io_buf, __entry->buf_len);
 		if (addr >= 0)
 			snprintf(__entry->addr_str, 10, "/%08x", addr);
@@ -259,12 +264,14 @@ DECLARE_EVENT_CLASS(io_data,
 DEFINE_EVENT(io_data, io_write,
 	TP_PROTO(int reg, int addr, const void *io_buf, size_t len),
 	TP_ARGS(reg, addr, io_buf, len));
-#define _trace_io_ind_write(reg, addr, io_buf, len) trace_io_write(reg, addr, io_buf, len)
+#define _trace_io_ind_write(reg, addr, io_buf, len)\
+	trace_io_write(reg, addr, io_buf, len)
 #define _trace_io_write(reg, io_buf, len) trace_io_write(reg, -1, io_buf, len)
 DEFINE_EVENT(io_data, io_read,
 	TP_PROTO(int reg, int addr, const void *io_buf, size_t len),
 	TP_ARGS(reg, addr, io_buf, len));
-#define _trace_io_ind_read(reg, addr, io_buf, len) trace_io_read(reg, addr, io_buf, len)
+#define _trace_io_ind_read(reg, addr, io_buf, len)\
+	trace_io_read(reg, addr, io_buf, len)
 #define _trace_io_read(reg, io_buf, len) trace_io_read(reg, -1, io_buf, len)
 
 DECLARE_EVENT_CLASS(io_data32,
@@ -348,7 +355,8 @@ TRACE_EVENT(bh_stats,
 		__entry->release ? "release" : "keep"
 	)
 );
-#define _trace_bh_stats(ind, req, cnf, busy, release) trace_bh_stats(ind, req, cnf, busy, release)
+#define _trace_bh_stats(ind, req, cnf, busy, release)\
+	trace_bh_stats(ind, req, cnf, busy, release)
 
 TRACE_EVENT(tx_stats,
 	TP_PROTO(struct hif_cnf_tx *tx_cnf, struct sk_buff *skb, int delay),
@@ -365,7 +373,8 @@ TRACE_EVENT(tx_stats,
 	),
 	TP_fast_assign(
 		// Keep sync with wfx_rates definition in main.c
-		static const int hw_rate[] = { 0, 1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13 };
+		static const int hw_rate[] = { 0, 1, 2, 3, 6, 7, 8, 9,
+					       10, 11, 12, 13 };
 		struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 		struct ieee80211_tx_rate *rates = tx_info->driver_rates;
 		int i;
diff --git a/drivers/staging/wfx/wfx.h b/drivers/staging/wfx/wfx.h
index 44e580a07c91..781a8c8ba982 100644
--- a/drivers/staging/wfx/wfx.h
+++ b/drivers/staging/wfx/wfx.h
@@ -141,13 +141,15 @@ static inline struct wfx_vif *wdev_to_wvif(struct wfx_dev *wdev, int vif_id)
 	}
 	vif_id = array_index_nospec(vif_id, ARRAY_SIZE(wdev->vif));
 	if (!wdev->vif[vif_id]) {
-		dev_dbg(wdev->dev, "requesting non-allocated vif: %d\n", vif_id);
+		dev_dbg(wdev->dev, "requesting non-allocated vif: %d\n",
+			vif_id);
 		return NULL;
 	}
 	return (struct wfx_vif *) wdev->vif[vif_id]->drv_priv;
 }
 
-static inline struct wfx_vif *wvif_iterate(struct wfx_dev *wdev, struct wfx_vif *cur)
+static inline struct wfx_vif *wvif_iterate(struct wfx_dev *wdev,
+					   struct wfx_vif *cur)
 {
 	int i;
 	int mark = 0;
-- 
2.23.0

