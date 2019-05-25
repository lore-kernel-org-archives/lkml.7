Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7561AC04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 07:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272B9217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 07:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC7rjIYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfEYHad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 03:30:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36546 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEYHac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 03:30:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id v80so6638562pfa.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CBmogAJUB339Ep3aXj31B9OMK/rErdF2S8y1zyAwxG8=;
        b=gC7rjIYRif8KrFeSxZoE9bJlUrDLPnpp7ZpN+7izHNxWjxDoQuzz+UUUnL8ZzbKXlV
         +B+vMKfrWfIeZyu50/RqmmDvaZvvcomBBnbCxByHK6MTJdZcLSf7b3kOD/TPwmc1G/HV
         T7FpRL9zA9x8q8pUhh2pIBE5QzA0M1V2F1PiMju/i8P2djnihcmj4OPTnLX6LL6Qs6qw
         9HjzQeghf/VQlKZikMYyWp2YZ+oeTA3Z1/1YOqRybLOeU91UzmgyCrbGB1qoRZ6CaWdP
         kiBY5F2yRud1Ug9od78Uhw+qnYJVCXz71BY5XFLIVtfzLQlxIpVAur1T79R9plOEgy93
         uHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CBmogAJUB339Ep3aXj31B9OMK/rErdF2S8y1zyAwxG8=;
        b=Iz2HI3TpUmiS3105KhGI+jHMZ+jPgJ7flyI3VZJ/lKZx6WB3+VpfleTYxE6m0xdrRO
         +5apKCO8UO6xumJ9sQoGpzEyFRUJdAQbAucQ7LyTWmeTEbOVL9DUfUu7exzcgE4m5nAf
         vIbEfb2kS+KA9dST3CoH3qxGYnpP4sujkQoR52TK1BP3988aQI6sBKftx6XALt7hICLb
         ZYV/OdhcQ3CaX2LJ7cLWURaa3bi9bYpiGou9QwtSdPmoGxyJxeOjNCuf4T/bRxCI15ue
         0+SYb8XuWV/LKcGMgj4Ef5uOCfP+aaezUs2qi0xE8pW2daMy4TXX/rFdKuFzKTZtqd2f
         WbGQ==
X-Gm-Message-State: APjAAAXVAB7C0+zYoNCCBO83lYwzIKeHWzbNukcyp7AIiKwd7VL0lEaq
        FvOstwv+sO4iifMXnUEhmuA=
X-Google-Smtp-Source: APXvYqw7Nq85Uzgu9ty/HtMjyUAeqWceKF3Gt7yedRT3adN5M/+iBJ1YlHGs4JhsHdTqos3PGcqKCA==
X-Received: by 2002:a17:90a:9bc4:: with SMTP id b4mr14672395pjw.100.1558769432212;
        Sat, 25 May 2019 00:30:32 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id o1sm11126605pfa.66.2019.05.25.00.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 00:30:31 -0700 (PDT)
Date:   Sat, 25 May 2019 13:00:26 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Matteo Croce <mcroce@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/omapdrm: fix warning PTR_ERR_OR_ZERO can be used
Message-ID: <20190525073026.GA7114@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warnings reported by coccicheck

./drivers/gpu/drm/omapdrm/dss/hdmi_phy.c:197:1-3: WARNING:
PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/omapdrm/dss/hdmi4_core.c:937:1-3: WARNING:
PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/omapdrm/dss/hdmi5_core.c:913:1-3: WARNING:
PTR_ERR_OR_ZERO can be used
./drivers/gpu/drm/omapdrm/dss/hdmi4.c:601:1-3: WARNING: PTR_ERR_OR_ZERO
can be used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/omapdrm/dss/hdmi4.c      | 5 +----
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c | 6 ++----
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c | 4 +---
 drivers/gpu/drm/omapdrm/dss/hdmi_phy.c   | 4 +---
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index 6339e27..cce53f3 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -598,10 +598,7 @@ static int hdmi_audio_register(struct omap_hdmi *hdmi)
 		&hdmi->pdev->dev, "omap-hdmi-audio", PLATFORM_DEVID_AUTO,
 		&pdata, sizeof(pdata));
 
-	if (IS_ERR(hdmi->audio_pdev))
-		return PTR_ERR(hdmi->audio_pdev);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(hdmi->audio_pdev);
 }
 
 /* -----------------------------------------------------------------------------
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
index e384b95..1bcdb54 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
@@ -934,8 +934,6 @@ int hdmi4_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
 	core->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(core->base))
-		return PTR_ERR(core->base);
-
-	return 0;
+	
+	return PTR_ERR_OR_ZERO(core->base);
 }
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
index 02efabc..022c2ce 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
@@ -910,8 +910,6 @@ int hdmi5_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
 	core->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(core->base))
-		return PTR_ERR(core->base);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(core->base);
 }
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
index 9915923..a7d7040 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
@@ -194,8 +194,6 @@ int hdmi_phy_init(struct platform_device *pdev, struct hdmi_phy_data *phy,
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
 	phy->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(phy->base))
-		return PTR_ERR(phy->base);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(phy->base);
 }
-- 
2.7.4

