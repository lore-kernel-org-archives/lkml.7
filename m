Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53622C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 02:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2800D206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 02:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OOpD07/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKOCK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 21:10:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37277 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfKOCKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 21:10:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id bb5so3582704plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 18:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTjBXlkdbN0ybVfSQqWJT1ZGiILhcovvd5SLC1fyQRY=;
        b=OOpD07/WXptBzTedtF2b7yVAkaV7RLlOsvUfY3Tg+40lwr354iXTc/3D1/pBLvQV8q
         7/q4ewes+yJKUJ1HXGCrTuIO8C+88Q/qkjwxJ23eaMx/G+YvIqpBikgHBlPt9yUY5uf7
         PO+nizsBSgBzM1NefdMA/TadO1b5LDsnVtB60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTjBXlkdbN0ybVfSQqWJT1ZGiILhcovvd5SLC1fyQRY=;
        b=pe3HcVvfm7cFHfmtkkQwkX1aRdprW6cEAPfeOed3bbM6BDrHqHANiaNwIXX7XGVtL5
         QUl6DURntj/rQk+NdId89DmISyjD4OuYAica8xCl4DkB8/rMTGzVvKA/CBfsarZYaCru
         m1ba1GG03LuQGiHi7mNzdWvq0vPZTU9BxPRZAbvqCsjrHisi0fszWoQfo6rxKESpDvLq
         s8HmPABJEXT5GVFjn+IJdkXL5Vc85hYJ33sF+glR41fPKigZ40gF/YOEz0KSVvgWb1iw
         FDQVCW6+Y9n7D30uvpY74K2L8KEYoRWPKqQQsQPbx1KF/B38eDOT7xi+qFloz8+lyuH9
         YgKg==
X-Gm-Message-State: APjAAAWYrcBl/3qG4QCNTzqnv27VmqhGGa6d7dkH0GzTu+CCjP+iUlhD
        sAUf6wDpcvvLJwL4l/PgIaOPkg==
X-Google-Smtp-Source: APXvYqwKPS1ktD6P7ZyEkE/hpfROeEH5F2qq//uBKuu537H0Jx7Lr5te+W2nxvgnDy65q5JE3EwpSQ==
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr12373722plp.249.1573783823003;
        Thu, 14 Nov 2019 18:10:23 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id f7sm9695820pfa.150.2019.11.14.18.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 18:10:22 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] Bluetooth: btbcm: Support pcm configuration
Date:   Thu, 14 Nov 2019 18:10:06 -0800
Message-Id: <20191114180959.v5.2.I2a9640407d375f20c7c8f4afd1607db143ff0246@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115021008.32926-1-abhishekpandit@chromium.org>
References: <20191115021008.32926-1-abhishekpandit@chromium.org>
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

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/bluetooth/btbcm.c | 19 +++++++++++++++++++
 drivers/bluetooth/btbcm.h |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..53fd66a96e69 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -105,6 +105,25 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
 
+int btbcm_set_pcm_int_params(struct hci_dev *hdev,
+			     const struct bcm_set_pcm_int_params *int_params)
+{
+	struct sk_buff *skb;
+	int err;
+
+	/* Vendor ocf 0x001c sets the pcm parameters and 0x001d reads it */
+	skb = __hci_cmd_sync(hdev, 0xfc1c, 5, int_params, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: Set PCM int params failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_set_pcm_int_params);
+
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	const struct hci_command_hdr *cmd;
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index d204be8a84bf..bf9d86924787 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -54,6 +54,8 @@ struct bcm_set_pcm_format_params {
 int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw);
+int btbcm_set_pcm_int_params(struct hci_dev *hdev,
+			     const struct bcm_set_pcm_int_params *int_params);
 
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
@@ -74,6 +76,12 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
+int btbcm_set_pcm_int_params(struct hci_dev *hdev,
+			     const struct bcm_set_pcm_int_params *int_params)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	return -EOPNOTSUPP;
-- 
2.24.0.432.g9d3f5f5b63-goog

