Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BD5C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4C222BD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WmOTWn5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKLAUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:20:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34902 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfKLAUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:20:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id d13so11994829pfq.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jt5HxsYB+y6SKJjlhS6tgd94AO19rGDPcNF7QLhPD9o=;
        b=WmOTWn5nmp1Ys/wRm37i1r8ycX6LayMydZpr6xJylQUtLHcpc+FXGI/MsDW9pUv3Ab
         ahPeM0zYQ1RRhqA26ak9RLiYJ/gx7XXPMKfFnvQbOFMMLbuTpchIKtP3SaUQkT3NVfDQ
         4OZwg/GbBFNeYKG2r7wR70vpwcuZJuco8dhD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jt5HxsYB+y6SKJjlhS6tgd94AO19rGDPcNF7QLhPD9o=;
        b=tDSH5kxuX+GQtk2kp2n4Wj9b21VrSbAtFQ3mYzhQ8hcmJ49BRZj233/pLvi63FL4DW
         rCK7q41t6fVqeFfY7pRfPpI3ljulhzPlRedzdLTi5B0nnWZQG7ozmV0uYWCIdsv5G8LK
         qkWM1cuGA0nOtjs7t9ybl0mbDBGlh9EesD6sD4YkkMw+etRYc25QmBuUYh/CUxEzuL3u
         JxFa9RZIfWdc+VZoZa3lN6jMjB1VLXxuBYnPXsacE4gAxQG8kRKc4mxE6wetFXiqupPB
         iNPRubUUV2zlbu1d9lqfIg6OUAKIdTUAslY+iJfHeVPypWujJKrOV/Gy2a4i6sX3/UvF
         5a7A==
X-Gm-Message-State: APjAAAXfCHs7zicZYu6dYFZYbWgiTpDWLg4nfpOS4kgg+NTxi+foA1Bl
        uITuePhTHscEXVyMFtn4e5kbZQ==
X-Google-Smtp-Source: APXvYqzAAUequbHbR5sI0noZIlXO9yAcKZe2kO30a3AYToSawn/NS5LMyqZPkWhI9pgHFiDZat3Jvg==
X-Received: by 2002:a62:7911:: with SMTP id u17mr32710101pfc.115.1573518004426;
        Mon, 11 Nov 2019 16:20:04 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id h23sm8430898pgg.58.2019.11.11.16.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:20:04 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] Bluetooth: hci_bcm: Support pcm params in dts
Date:   Mon, 11 Nov 2019 16:19:48 -0800
Message-Id: <20191112001949.136377-4-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112001949.136377-1-abhishekpandit@chromium.org>
References: <20191112001949.136377-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM chips may require configuration of PCM to operate correctly and
there is a vendor specific HCI command to do this. Add support in the
hci_bcm driver to parse this from devicetree and configure the chip.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v3: None
Changes in v2: None

 drivers/bluetooth/hci_bcm.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6134bff58748..b7f47d9edb7d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -88,6 +88,8 @@ struct bcm_device_data {
  *	used to disable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently disabled
  * @disallow_set_baudrate: don't allow set_baudrate
+ * @has_pcm_params: whether PCM parameters need to be configured
+ * @pcm_params: PCM and routing parameters
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -122,6 +124,9 @@ struct bcm_device {
 	bool			is_suspended;
 #endif
 	bool			disallow_set_baudrate;
+
+	bool				has_pcm_params;
+	struct bcm_set_pcm_int_params	pcm_params;
 };
 
 /* generic bcm uart resources */
@@ -596,6 +601,17 @@ static int bcm_setup(struct hci_uart *hu)
 			host_set_baudrate(hu, speed);
 	}
 
+	/* PCM parameters if any*/
+	if (bcm->dev && bcm->dev->has_pcm_params) {
+		err = btbcm_set_pcm_params(hu->hdev, &bcm->dev->pcm_params,
+					   NULL);
+
+		if (err) {
+			bt_dev_info(hu->hdev, "BCM: Set pcm params failed (%d)",
+				    err);
+		}
+	}
+
 finalize:
 	release_firmware(fw);
 
@@ -1132,7 +1148,24 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 static int bcm_of_probe(struct bcm_device *bdev)
 {
+	int err;
+
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
+
+	err = device_property_read_u8(bdev->dev, "brcm,bt-sco-routing",
+				      &bdev->pcm_params.routing);
+	if (!err)
+		bdev->has_pcm_params = true;
+
+	device_property_read_u8(bdev->dev, "brcm,pcm-interface-rate",
+				&bdev->pcm_params.rate);
+	device_property_read_u8(bdev->dev, "brcm,pcm-frame-type",
+				&bdev->pcm_params.frame_sync);
+	device_property_read_u8(bdev->dev, "brcm,pcm-sync-mode",
+				&bdev->pcm_params.sync_mode);
+	device_property_read_u8(bdev->dev, "brcm,pcm-clock-mode",
+				&bdev->pcm_params.clock_mode);
+
 	return 0;
 }
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

