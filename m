Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C47DC28D1D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FCA2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0l1t7mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfFFJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:47:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45310 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfFFJrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:47:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so1343817lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQfbJoiQ5WTWGjUJ1PADkmMlX7UTg1NHq4Oh3Ljtrbo=;
        b=v0l1t7motrGGJZjUZw7mZhdXu71rcqkX14qgcfNJsj0pBDkflH+Yc72Rh58UO+K/ma
         NkcmwaO4ZRwUGSEf8FDCBIG9d5FZ14s3/Wu+e7uRpuc3N+NwdVmPkgZ3ASVth/T3MdYP
         zkyIoXbtLNxGxDWBwLZLLWP5BgK4Cj1MAjGGDwMPETEClXrqSkfGB+ui3a6x4JzT1JRI
         G7GVtXsWqf6Jrl0j4cKaP5Z91IJPDBMDrMDcVB3HTk4V95x6QgEjoib0TMkiQWzWtb0X
         Fwk6a3D+h0Vdr8Ji3cBC+l5ZJv9LqytaxcbMrFHRJKAG/dbb4ZLq/iU1m+2Kc78Nhxrd
         PHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQfbJoiQ5WTWGjUJ1PADkmMlX7UTg1NHq4Oh3Ljtrbo=;
        b=PeQHGSd6V73hq6poOE+gII/LaTmomatLhGCtB4q7hQ3QQR2vjXPsBY9p7MIzO9tRar
         lDN8kzs2s8/HeZ/IShW+YaS84pzoYQ+dE8bLa8iNp7zA059aGn6KjUmp0FWVqjWtwK3F
         JNOhoCJaKDQSKJzTG8QNvJwEf0pd28EHH55uggy6ymYdcu5GA/WmGl3AigU7g9KG958M
         ZfRlfzS2Vxdr3PUTXi2SmVm/QmcIjSXW56gmyYWMsQjWwTvm9cR2VgZJ7NIkRuNG6oKF
         QieZjdZN0JQO7LO6YZscVYrCRa2XtxQB5bE/M5JiAtqvPKu6kVnu9k0lTaYi5kdtqr2l
         v2gA==
X-Gm-Message-State: APjAAAVUJjLa2e5YEpIefxfeprGN3mO0q3Xo60xZaU/1NjBQ1YkH0Jct
        i3virsc7ZIMdzcQEqpoz9GU+tw==
X-Google-Smtp-Source: APXvYqynVELsYqcqQ3WkOuXVc21SB/kMXSnXwhm4rJjbGqpBW3X6B+fXTZsFIXnZIxLxYIvULF3Ugg==
X-Received: by 2002:a2e:9cc3:: with SMTP id g3mr9015135ljj.117.1559814437482;
        Thu, 06 Jun 2019 02:47:17 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id s20sm214365lfb.95.2019.06.06.02.47.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 02:47:16 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     marex@denx.de, stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        b.zolnierkie@samsung.com
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        a.hajda@samsung.com, mchehab@kernel.org, p.zabel@pengutronix.de,
        hkallweit1@gmail.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-media@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 3/8] drivers: (video|gpu): fix warning same module names
Date:   Thu,  6 Jun 2019 11:47:12 +0200
Message-Id: <20190606094712.23715-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_DRM_MXSFB and CONFIG_FB_MXS enabled as
loadable modules, we see the following warning:

warning: same module names found:
  drivers/video/fbdev/mxsfb.ko
  drivers/gpu/drm/mxsfb/mxsfb.ko

Rework so the names matches the config fragment.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/mxsfb/Makefile | 4 ++--
 drivers/video/fbdev/Makefile   | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/Makefile b/drivers/gpu/drm/mxsfb/Makefile
index ff6e358088fa..5d49d7548e66 100644
--- a/drivers/gpu/drm/mxsfb/Makefile
+++ b/drivers/gpu/drm/mxsfb/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-mxsfb-y := mxsfb_drv.o mxsfb_crtc.o mxsfb_out.o
-obj-$(CONFIG_DRM_MXSFB)	+= mxsfb.o
+drm-mxsfb-y := mxsfb_drv.o mxsfb_crtc.o mxsfb_out.o
+obj-$(CONFIG_DRM_MXSFB)	+= drm-mxsfb.o
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 655f2537cac1..7ee967525af2 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -131,7 +131,8 @@ obj-$(CONFIG_FB_VGA16)            += vga16fb.o
 obj-$(CONFIG_FB_OF)               += offb.o
 obj-$(CONFIG_FB_MX3)		  += mx3fb.o
 obj-$(CONFIG_FB_DA8XX)		  += da8xx-fb.o
-obj-$(CONFIG_FB_MXS)		  += mxsfb.o
+obj-$(CONFIG_FB_MXS)		  += fb-mxs.o
+fb-mxs-objs			  := mxsfb.o
 obj-$(CONFIG_FB_SSD1307)	  += ssd1307fb.o
 obj-$(CONFIG_FB_SIMPLE)           += simplefb.o
 
-- 
2.20.1

