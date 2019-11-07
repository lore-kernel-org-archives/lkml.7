Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3272178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oREwbBfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfKGX1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:27:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37338 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfKGX1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:27:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id p13so2701638pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 15:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eeEdv0QtJ307WBwSmqMekG71Dor1PodSsMGowPt5cRw=;
        b=oREwbBfw1sF3vS3Z4ORZRzCXMYwd4LYZu+DoSgbnY5ZMo3Jne4gq5K42JlLgLlQRWj
         kqGjhNLlbrIZvbix66kBf5o5Va11QRf3LDZx3X/CKcxnPSGB+ZdGkNONb4JpnQUFCNd4
         Gg22dFJKACOumz/rQRzTM9z4qwi1cWCeHM9iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eeEdv0QtJ307WBwSmqMekG71Dor1PodSsMGowPt5cRw=;
        b=RmnbLde6OdMaTtQHTfNd4ahWZicApLWUU50JGrSoE4EJgFRe3FHKVcvU/YBrMf0+Dh
         hc3GTWSZCccav0ykLr1QmY3kX/8//DEifHwxkq7eDe3j7FvLSGjrI2/my4jbvp6Rhdo7
         +1aVE/HyNh1pCtiaIOBLduESDZKm6D9I9ZU2wPn7ZLVk9DWMdFNG72hc3U6I3DYOmTUx
         Gi5ukBS4wqGM+AIUFgnSwEQdSeZtN1/PrPaMPLiG5pOYFUsLECR/VR9cbxsxZzH7wPKj
         kuTcf/jy3rJcbReFmIBNPOw7dGAtgZeCb6uTomJnsxcxNDYcSra4qYCjZogaihJeXI1B
         tXgg==
X-Gm-Message-State: APjAAAX2SOMUqBdmN0cLvGxAumXpeS6FF7fSvPZUFFmKNdz3YzqXCPpJ
        W9TsG055CjNp83YlMlQT7Z6AJQ==
X-Google-Smtp-Source: APXvYqwb78gexO6X0YuTqe9ef4hJFzS5zfn6M9GHHuLGwDlwk3gdR9z806gv+mUefNGuhRjMYkr/qA==
X-Received: by 2002:a17:90a:326b:: with SMTP id k98mr8926333pjb.50.1573169269037;
        Thu, 07 Nov 2019 15:27:49 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id h3sm2857579pji.16.2019.11.07.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 15:27:48 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: btbcm: Support pcm configuration
Date:   Thu,  7 Nov 2019 15:27:10 -0800
Message-Id: <20191107232713.48577-3-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191107232713.48577-1-abhishekpandit@chromium.org>
References: <20191107232713.48577-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM vendor specific commands to configure PCM.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2: None

 drivers/bluetooth/btbcm.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm.h | 10 ++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..f052518f7b0c 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -105,6 +105,41 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
 
+int btbcm_set_pcm_params(struct hci_dev *hdev,
+			 const struct bcm_set_pcm_int_params *int_params,
+			 const struct bcm_set_pcm_format_params *format_params)
+{
+	struct sk_buff *skb;
+	int err;
+
+	if (int_params) {
+		skb = __hci_cmd_sync(hdev, 0xfc1c, 5, int_params,
+				     HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			bt_dev_err(hdev, "BCM: Set PCM int params failed (%d)",
+				   err);
+			return err;
+		}
+		kfree_skb(skb);
+	}
+
+	if (format_params) {
+		skb = __hci_cmd_sync(hdev, 0xfc1e, 5, format_params,
+				     HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			bt_dev_err(hdev, "BCM: Set PCM data params failed (%d)",
+				   err);
+			return err;
+		}
+		kfree_skb(skb);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_set_pcm_params);
+
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	const struct hci_command_hdr *cmd;
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index d204be8a84bf..f0a63c65544e 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -54,6 +54,9 @@ struct bcm_set_pcm_format_params {
 int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw);
+int btbcm_set_pcm_params(struct hci_dev *hdev,
+			 const struct bcm_set_pcm_int_params *int_params,
+			 const struct bcm_set_pcm_format_params *format_params);
 
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
@@ -74,6 +77,13 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
+int btbcm_set_pcm_params(struct hci_dev *hdev,
+			 const struct bcm_set_pcm_int_params *int_params,
+			 const struct bcm_set_pcm_format_params *format_params)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	return -EOPNOTSUPP;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

