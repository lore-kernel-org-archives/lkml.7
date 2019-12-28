Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A070EC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75972208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrC41njW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfL1UgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39490 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfL1UgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id y1so22890319lfb.6;
        Sat, 28 Dec 2019 12:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wfs/bL17FYKf1Oxn2bv75LBzwxXdI6zeR8Zv69vdpMc=;
        b=SrC41njW+OfZbCl8EUK7YyYVJNwT1KMBL0GjFXzAlcn6VJmGvGu8esIOKshRiavsLC
         yQcRgDigSgvfawN+ioSKkIj2hZfJ53lELby30sLY+PJ122o3AR3CjOdiW9+Lvuo7WohI
         YcwHOPCe8iBTL/eqn0s9+8tnzeDsmfpAYhbLqIRp3G/kDEQyp4YaJZ6iSJEGcUPfZHxo
         gkb3/0hWSINueuGNNpl1/9tSJAwmGiqkHL+Gdk+XwG0KapF5GaqLzYpnfviXCChC9kDc
         Nd4Wu5N8nNpNnMG4O23Q5bY1kfTCvoec1xMf0y2RPWgzLuDlX/1EIqZJgcLgAnJvEtdg
         bplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wfs/bL17FYKf1Oxn2bv75LBzwxXdI6zeR8Zv69vdpMc=;
        b=dK7YpVreYZQZ2JuumrcPS6XNVhD3fyAwfilnTys5CN0yv9nQUjYKsGCMknqx+1tItY
         vEVkxHF2ljm8N/3RoCaA8y+hFNDdfdn54TQCKogJ2y42MUAvhrYyTQN7jqHCSQtERw6C
         g94qXDGpoFXUj9GdmEw2l8kC693NPIajxOoGEiKyn/sy2AP+Grv5BblpNdimhEJNuE8F
         XJQlRpVQNSnEtNVKwjrw4WGpc7tg0KhLWmGKy8Gletr5MNRwFaxx5wm9Zp9VK49P2JOx
         P8z6a71lUvqkN9I3RAnXctrwmrCh1marly+2bo3cMCdWduitI9eHGgjXsREnayMHfc3u
         Wn7w==
X-Gm-Message-State: APjAAAU6pXGVfDLf3HPeKZx4aWvEqqjzFllvuFkl3eBjuQgGCa5yAMAt
        Mu17N35HE/jCDpthm78g74U=
X-Google-Smtp-Source: APXvYqzRMDrvnMGcnhfiBKOVjkAe4AQcUyEnZcModpquLsAM52hxsRK3Oy4sFtFXAPauj5JzCWlREQ==
X-Received: by 2002:a05:6512:244:: with SMTP id b4mr32155399lfo.85.1577565364698;
        Sat, 28 Dec 2019 12:36:04 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/16] usb: ulpi: Add resource-managed variant of otg_ulpi_create()
Date:   Sat, 28 Dec 2019 23:33:48 +0300
Message-Id: <20191228203358.23490-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
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

