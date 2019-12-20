Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD150C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A475224683
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVkAYwSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfLTB4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:56:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33672 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfLTB4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:56:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so5786956lfl.0;
        Thu, 19 Dec 2019 17:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wfs/bL17FYKf1Oxn2bv75LBzwxXdI6zeR8Zv69vdpMc=;
        b=gVkAYwSUeLMoZUIfwmnbf5CPDleYy7WG1dyoyk18Y26SwKQVtB0dqGKQVQB85sGWKM
         v+tP9K9NUtg0/eNaEPsV0FBF6qcxLhKKHhSre1gEge6cqYWWFG2hm0FEp5bCGKimVMI6
         dnLVBmTc0OQY90DWdGGc57JecSASCcfGwt2a5k8Qy2XZG0Ig08Gt+PoSrs/8r3YXUoXv
         hhWlDZ/vs87qre/vhuNbhd306yizCguGvs38wE02EV4xsPrHf/crE7Uu7u4n3uqQWc48
         VKc7usE37UiqFddLmKsOYkbEjDI4c7B1aScY+IocKrkfDHocnX2ITbfn8wUMbDmvcMDH
         1IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wfs/bL17FYKf1Oxn2bv75LBzwxXdI6zeR8Zv69vdpMc=;
        b=lk+ubzfUBz7GWpTIPu2IqGweLt7gT/i3LXufgj0CIJQ7kSimtbilbNK6AcyH9tEM4u
         IautSmdBiUMYnCIgPE5A7eyAFVW7YSzkNBgOVEevQULll/Z0M9NoQL3RQ0pdZRkB8bcY
         D95HgVdvxjy5iNA/gqtXtSgqt8U0SA9bU0LzkNuftd8H7PZlXBl8kjrHfCDe0b5ajOwm
         rYkQL/RRbM/e6ImlL9frmbdIv3BBO1CCJ5BPbjs9RkLilm/J09IF+y6TKzC9k/PP4+gm
         JZcI1tHR9jQRTsM4IPajhHYHEqOB7li/ykk68eOf8rPDPT9tK/+dfZyevhHIRPYtTKcp
         SvDQ==
X-Gm-Message-State: APjAAAULflneBLRvjpPbbu94aMhv4YflchnP+vSRG3LGbmHoVAbm5lkU
        SaaU+RP3Th5AQcl2Gz/rzLw=
X-Google-Smtp-Source: APXvYqyd57XxObnq9R19oKnH1DoSNkwh8KXdDAJuQ+1mHvJJYgp+mq2rHpzhWkqon2RkWRQpk6PLVA==
X-Received: by 2002:a19:4b55:: with SMTP id y82mr7226840lfa.171.1576806970827;
        Thu, 19 Dec 2019 17:56:10 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3270901lfo.40.2019.12.19.17.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:56:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] usb: ulpi: Add resource-managed variant of otg_ulpi_create()
Date:   Fri, 20 Dec 2019 04:52:34 +0300
Message-Id: <20191220015238.9228-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220015238.9228-1-digetx@gmail.com>
References: <20191220015238.9228-1-digetx@gmail.com>
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

