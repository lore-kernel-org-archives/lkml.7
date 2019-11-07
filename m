Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657C2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314452178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lKgysL54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfKGX2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:28:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45417 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfKGX1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:27:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id y24so2667443plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 15:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09lhMrDrNWC/JXB2teKaEq/BNqZ941erzzvQPS9vkhg=;
        b=lKgysL54GQ/ebY9znGF3RcGaKYH97LcM5oHg4tyOioOzTJmRHwlAaNP0CwCkzNPfLF
         H+uELDeS6WFsiUJeuL7zxEIUC4OoVhdTf+PMSQ1MPao3P6ZbXEqPi3h50iRXfaJR9n1n
         m0jIBM68sCVYLhANSezxEz9Fjz2xkEye4ezX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09lhMrDrNWC/JXB2teKaEq/BNqZ941erzzvQPS9vkhg=;
        b=DYASDOB24O8SwXHfucvBBvFOLBDoSKtbWhUDZa5gLCtE10ta7gtOAow6JTVDSA2zUb
         nSLQ4PZA/GzB1wD/iRAo/FlnWlpfEo6y3TROUDuIJG5qbsB84ffiYmTl4cufZ0VEU9ao
         cusM2g27SJ6yOoLyrPVody/hugmpNhsAd8GNBvcAGUT9YxWH5vgN6jyo8ZM5PM+wBtqO
         fFWqPT1Abuik1SAA/smd34QTLa9EoGjunfnmDpHihatLNhrNPxdrt2jpkLCuWvIQFtlZ
         4FkyGEL77/YRPV11z9w48cALjvDj7pDM7z7YQUU5vhFRnHmTzPv4vD/1DmuyqF83Hk04
         V6+w==
X-Gm-Message-State: APjAAAXikum8T2lXdDmlL6qM4c/ePGfafeGn+C/McbBVTSVCNV8AtQoO
        agzFPrjRW1U8dgQHbnAO3bS6AQ==
X-Google-Smtp-Source: APXvYqw5hh0nbO5l+XghY35SmNAXLAuRVXRyYe1ZDkm6kgt5E/Hg8AewlGIVto1FNkGn5EY3LQfB+Q==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr4205712pjt.104.1573169270701;
        Thu, 07 Nov 2019 15:27:50 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id h3sm2857579pji.16.2019.11.07.15.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 15:27:50 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] Bluetooth: hci_bcm: Support pcm params in dts
Date:   Thu,  7 Nov 2019 15:27:11 -0800
Message-Id: <20191107232713.48577-4-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191107232713.48577-1-abhishekpandit@chromium.org>
References: <20191107232713.48577-1-abhishekpandit@chromium.org>
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

Changes in v2: None

 drivers/bluetooth/hci_bcm.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 2114df607cb3..46e4793fc234 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -79,6 +79,8 @@
  * @hu: pointer to HCI UART controller struct,
  *	used to disable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently disabled
+ * @has_pcm_params: whether PCM parameters need to be configured
+ * @pcm_params: PCM and routing parameters
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -112,6 +114,9 @@ struct bcm_device {
 	struct hci_uart		*hu;
 	bool			is_suspended;
 #endif
+
+	bool				has_pcm_params;
+	struct bcm_set_pcm_int_params	pcm_params;
 };
 
 /* generic bcm uart resources */
@@ -576,6 +581,17 @@ static int bcm_setup(struct hci_uart *hu)
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
 
@@ -1112,7 +1128,24 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 static int bcm_of_probe(struct bcm_device *bdev)
 {
+	int err;
+
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
+
+	err = device_property_read_u8(bdev->dev, "brcm,sco-routing",
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

