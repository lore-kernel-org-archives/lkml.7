Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE2BC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311D5215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skoNYfQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgAFBe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:34:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46003 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgAFBew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so49278930ljc.12;
        Sun, 05 Jan 2020 17:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wfs/bL17FYKf1Oxn2bv75LBzwxXdI6zeR8Zv69vdpMc=;
        b=skoNYfQB9aw6uIo1m5pO29jw3TLOkx6/PFEz6X3LaooSQyx8CvTPElnSOWs9bIlKxY
         j3ebU1lfte2Ql8DiEd/KEurFjSKIQ9MbSKZ45xT0uInJNRWhjV9Kf3wTxYqyCDLODR4T
         rmy13XroRwNAWBEeRFhocXg8RZ1byVCNI0t8VkqQAhrZF2XWdQydZbAB6igKxVk8bYS/
         Ce8nje6tDWhvzD48yrUTBhRzbhlVFUQQ6RTxFNcjyPpxTQVQ6IPQrboZlQrS+3sCsY9a
         psPN8ak/OBc6YrI/Ra4nYg8+0ZhvSY1lezMQJZtLlJFLqK/XcdW9Zjj2F0Sw4PXMwLJ6
         jvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wfs/bL17FYKf1Oxn2bv75LBzwxXdI6zeR8Zv69vdpMc=;
        b=k0xNaHeyCuFVfuvDEl1RcgnGD4/XVXjC+JNBDPq3ycrOU/F+XoAqQw2/6QYN4R0vBZ
         Y2DdEsDfpYBrQDAEqNJyi3YgK9jlYcZhKhAGbdn1pD3MHSQ8nuHFesQhxmlY8W8agL63
         pTmHg8n3rngn0Tkikph5rIMOYLGHmpvocEajV/8aUDjABFJXF1OnWl1vzjyK+/JJqO7G
         kpeFyJIppNfLT1+iMr4zxOMIy7zabVWW39pm9GexVfky7gt3ybiBC80qMQmsw349UPCh
         BXRtZ9MEhHPpgmAHrhmBKvqeJRIp2zZT/1TCDlET4SbX3raBSqK1ERrpPGvdwztKyikY
         nX1w==
X-Gm-Message-State: APjAAAX51/YPLWNS0o2Ax25iodmdhs9I2RCKVmoR8NHJEPuO+QMRVrZL
        xDGwAZ3ZUfnDUIcttikOUX8=
X-Google-Smtp-Source: APXvYqycE1ZQ18Rrg6fxV6Lw0fluWixV4+zNhF8W14Sl2geJhfHce4vVNsKe1zaOTGsA7dHG1TU93A==
X-Received: by 2002:a2e:556:: with SMTP id 83mr60625433ljf.127.1578274489977;
        Sun, 05 Jan 2020 17:34:49 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/20] usb: ulpi: Add resource-managed variant of otg_ulpi_create()
Date:   Mon,  6 Jan 2020 04:34:06 +0300
Message-Id: <20200106013416.9604-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now drivers (like NVIDIA Tegra USB PHY for example) will be able to
benefit from the resource-managed variant, making driver's code a bit
cleaner.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-ulpi.c | 48 +++++++++++++++++++++++++++++++-------
 include/linux/usb/ulpi.h   | 11 +++++++++
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/phy/phy-ulpi.c b/drivers/usb/phy/phy-ulpi.c
index a43c49369a60..e683a37e3a7a 100644
--- a/drivers/usb/phy/phy-ulpi.c
+++ b/drivers/usb/phy/phy-ulpi.c
@@ -240,6 +240,21 @@ static int ulpi_set_vbus(struct usb_otg *otg, bool on)
 	return usb_phy_io_write(phy, flags, ULPI_OTG_CTRL);
 }
 
+static void otg_ulpi_init(struct usb_phy *phy, struct usb_otg *otg,
+			  struct usb_phy_io_ops *ops,
+			  unsigned int flags)
+{
+	phy->label	= "ULPI";
+	phy->flags	= flags;
+	phy->io_ops	= ops;
+	phy->otg	= otg;
+	phy->init	= ulpi_init;
+
+	otg->usb_phy	= phy;
+	otg->set_host	= ulpi_set_host;
+	otg->set_vbus	= ulpi_set_vbus;
+}
+
 struct usb_phy *
 otg_ulpi_create(struct usb_phy_io_ops *ops,
 		unsigned int flags)
@@ -257,17 +272,32 @@ otg_ulpi_create(struct usb_phy_io_ops *ops,
 		return NULL;
 	}
 
-	phy->label	= "ULPI";
-	phy->flags	= flags;
-	phy->io_ops	= ops;
-	phy->otg	= otg;
-	phy->init	= ulpi_init;
-
-	otg->usb_phy	= phy;
-	otg->set_host	= ulpi_set_host;
-	otg->set_vbus	= ulpi_set_vbus;
+	otg_ulpi_init(phy, otg, ops, flags);
 
 	return phy;
 }
 EXPORT_SYMBOL_GPL(otg_ulpi_create);
 
+struct usb_phy *
+devm_otg_ulpi_create(struct device *dev,
+		     struct usb_phy_io_ops *ops,
+		     unsigned int flags)
+{
+	struct usb_phy *phy;
+	struct usb_otg *otg;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return NULL;
+
+	otg = devm_kzalloc(dev, sizeof(*otg), GFP_KERNEL);
+	if (!otg) {
+		devm_kfree(dev, phy);
+		return NULL;
+	}
+
+	otg_ulpi_init(phy, otg, ops, flags);
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(devm_otg_ulpi_create);
diff --git a/include/linux/usb/ulpi.h b/include/linux/usb/ulpi.h
index c515765adab7..36c2982780ad 100644
--- a/include/linux/usb/ulpi.h
+++ b/include/linux/usb/ulpi.h
@@ -55,12 +55,23 @@
 #if IS_ENABLED(CONFIG_USB_ULPI)
 struct usb_phy *otg_ulpi_create(struct usb_phy_io_ops *ops,
 					unsigned int flags);
+
+struct usb_phy *devm_otg_ulpi_create(struct device *dev,
+				     struct usb_phy_io_ops *ops,
+				     unsigned int flags);
 #else
 static inline struct usb_phy *otg_ulpi_create(struct usb_phy_io_ops *ops,
 					      unsigned int flags)
 {
 	return NULL;
 }
+
+static inline struct usb_phy *devm_otg_ulpi_create(struct device *dev,
+						   struct usb_phy_io_ops *ops,
+						   unsigned int flags)
+{
+	return NULL;
+}
 #endif
 
 #ifdef CONFIG_USB_ULPI_VIEWPORT
-- 
2.24.0

