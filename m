Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E16CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737D420885
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLz+rZ9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKRTVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:21:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46068 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfKRTVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:21:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1so8775230pgg.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 11:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ippZaeBAeylwJGFVZbvZ9jDwjVRO01IDa3/hsxkLxo4=;
        b=BLz+rZ9CCPPROaCh2zpB3kcCfbH+0iw0zr/ybgsf1DSUeJt2Z39udEH+TyIs+wml0V
         NU3KrvgUG5r6rZLkYJHIbNMhdQaJlZyrRcxDxXbCWM/DwiERYfUYtxOxwlja3MB6SUfE
         imOnNhaPPlur5taEteE4dlZI+o0Zh7v9gc0+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ippZaeBAeylwJGFVZbvZ9jDwjVRO01IDa3/hsxkLxo4=;
        b=AsnDRiEZjTHzmwlhTeshmSkP0AeBvJtiwl1vm3Mfy/si5cIHnBD1CNkZj1OByzm/yM
         HYbS0ZRaBgGQPLy3z8FeY84yBcVtoKs0OmxBL0QP0Kt4EHf2oguwUj3SnHs+8zdnJTE4
         RREoUloxl6uSeIojgjOQ5ePJFhwTUbJMgqzgw1h0BNC6aaxDzIGPeg78yH5Y0Kr3CQ1L
         ES2WXs2z2XSVLPd2EC0uV6Bgq3MPX6SmT6cYADjBa6+w7JiuDF1sVmO+/PpD7TY9CQ0x
         x64OEkczQ6PDugdg5xFPEW+Xn4qIpsje0GTXIoNKIjMFM9BROSyvvQLygdMwAIo0GEes
         YxKg==
X-Gm-Message-State: APjAAAWsoXKffFoFOPTx8uWvtVsjiDd4BuoWv6eEukm4gvd/3P6UZcIS
        T0fQaHbQnmNLBtgbngOVZsrOcg==
X-Google-Smtp-Source: APXvYqxZKBOL6saXSRgcYwufVh+i/EZRD8QhuHp1NACZ4Hk5sPqMHqA6Dl/brYEI+Cwhex19cU+vkA==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr970756pgh.372.1574104897430;
        Mon, 18 Nov 2019 11:21:37 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id p123sm22772633pfg.30.2019.11.18.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 11:21:36 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] Bluetooth: btbcm: Support pcm configuration
Date:   Mon, 18 Nov 2019 11:21:21 -0800
Message-Id: <20191118110335.v6.2.I2a9640407d375f20c7c8f4afd1607db143ff0246@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191118192123.82430-1-abhishekpandit@chromium.org>
References: <20191118192123.82430-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM vendor specific command to configure PCM parameters. The new
vendor opcode allows us to set the sco routing, the pcm interface rate,
and a few other pcm specific options (frame sync, sync mode, and clock
mode). See broadcom-bluetooth.txt in Documentation for more information
about valid values for those settings.

Here is an example trace where this opcode was used to configure
a BCM4354:

        < HCI Command: Vendor (0x3f|0x001c) plen 5
                01 02 00 01 01
        > HCI Event: Command Complete (0x0e) plen 4
        Vendor (0x3f|0x001c) ncmd 1
                Status: Success (0x00)

We can read back the values as well with ocf 0x001d to confirm the
values that were set:
        $ hcitool cmd 0x3f 0x001d
        < HCI Command: ogf 0x3f, ocf 0x001d, plen 0
        > HCI Event: 0x0e plen 9
        01 1D FC 00 01 02 00 01 01

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/bluetooth/btbcm.c | 47 +++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm.h | 16 +++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..df90841d29c5 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -105,6 +105,53 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
 
+int btbcm_read_pcm_int_params(struct hci_dev *hdev,
+			      struct bcm_set_pcm_int_params *int_params)
+{
+	struct sk_buff *skb;
+	int err = 0;
+
+	skb = __hci_cmd_sync(hdev, 0xfc1d, 5, int_params, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: Read PCM int params failed (%d)", err);
+		return err;
+	}
+
+	if (!skb->data[0] && skb->len == sizeof(*int_params) + 1) {
+		memcpy(int_params, &skb->data[1], sizeof(*int_params));
+	} else {
+		bt_dev_err(hdev,
+			   "BCM: Read PCM int params failed (%d), Length (%d)",
+			   skb->data[0], skb->len);
+		err = -EINVAL;
+	}
+
+	kfree_skb(skb);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btbcm_read_pcm_int_params);
+
+int btbcm_write_pcm_int_params(struct hci_dev *hdev,
+			       const struct bcm_set_pcm_int_params *int_params)
+{
+	struct sk_buff *skb;
+	int err;
+
+	/* Vendor ocf 0x001c sets the pcm parameters and 0x001d reads it */
+	skb = __hci_cmd_sync(hdev, 0xfc1c, 5, int_params, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: Write PCM int params failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_write_pcm_int_params);
+
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	const struct hci_command_hdr *cmd;
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index d204be8a84bf..29ca3956ea1c 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -54,6 +54,10 @@ struct bcm_set_pcm_format_params {
 int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw);
+int btbcm_read_pcm_int_params(struct hci_dev *hdev,
+			      struct bcm_set_pcm_int_params *int_params);
+int btbcm_write_pcm_int_params(struct hci_dev *hdev,
+			       const struct bcm_set_pcm_int_params *int_params);
 
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
@@ -74,6 +78,18 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
+int btbcm_read_pcm_int_params(struct hci_dev *hdev,
+			      struct bcm_set_pcm_int_params *int_params)
+{
+	return -EOPNOTSUPP;
+}
+
+int btbcm_write_pcm_int_params(struct hci_dev *hdev,
+			       const struct bcm_set_pcm_int_params *int_params)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	return -EOPNOTSUPP;
-- 
2.24.0.432.g9d3f5f5b63-goog

