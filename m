Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B8CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F0F2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pO8ssjEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfCONIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:08:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35405 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCONIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:08:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id e17so6458079pgd.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iy5X5nQ4JgXGLF8UMM2hZ+8DxyqREPSMFw8EUbSF9/Y=;
        b=pO8ssjEaKNDM2gxwo2eZOJi3BFaU6Z7wYIQ4I1OHhb5JrmiQNN0ar47vhmtlIHkIIS
         RWpk/5+cRl/iPVEgCzavRKeDJR9Reyhu/r0oLuNT3v4gMsylvwqauvz+kHlcHWDVmVAi
         l7EbSBu8e14tkwTzn5igylZZLTf6sv4LmqOw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iy5X5nQ4JgXGLF8UMM2hZ+8DxyqREPSMFw8EUbSF9/Y=;
        b=ruZR4irCTccSe0jwwdnYHWID18baiO2GIFgzB++yLwWtVgzUVq7sSq0+yU0iyz/kmR
         I6aLHGAko0BZuOpxImmh4fcv7VCTwr8T5G4RKKFbzd67JeuIywWka+Elk+QJkVbq2ky+
         dn6//s4u6xl5PSSZmNR0eUSZFymJWK454vumwVXSEDPLqE5j9P4ZbidsoSWOhiOdMfeK
         06IB/lLI4x+gxQvC+QeO/jmMsc0FmYsmDcALf+M0IQynnKzTF+LIer6CBquVicDtrkaw
         iUPgMO+UTMi1oBZUH3GRvhVLj8TgsZwhm91xPnvDZY44NO/qBnXtqWVY2xlH7XpbG+T2
         hxPA==
X-Gm-Message-State: APjAAAXghUXJWjL4YhQFLmv96Ag2D5gb4ye5xDG4h07ifix6/xMO0oQB
        govjv1PlleKDY2W475vAmOGaNQ==
X-Google-Smtp-Source: APXvYqydZg7PQXvS2Bgd7RPRfKpHQih5xMbZt34Kjaiwt0O75Jd/UYNWjPeusZb2G04Eq0ACxQjnWA==
X-Received: by 2002:a62:48c1:: with SMTP id q62mr3983492pfi.113.1552655327466;
        Fri, 15 Mar 2019 06:08:47 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.185])
        by smtp.gmail.com with ESMTPSA id e2sm854008pfa.64.2019.03.15.06.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 06:08:46 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 2/6] drm/exynos: dsi: Use drm_bridge_detach
Date:   Fri, 15 Mar 2019 18:38:21 +0530
Message-Id: <20190315130825.9005-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190315130825.9005-1-jagan@amarulasolutions.com>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_bridge_detach now available to use while detaching
bridge, use this core wrapper instead of explicitly
pointing the bridge funcs.

Cc: Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index a4253dd55f86..5daf43d02768 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1583,8 +1583,7 @@ static int exynos_dsi_host_detach(struct mipi_dsi_host *host,
 		dsi->connector.status = connector_status_disconnected;
 		mutex_unlock(&drm->mode_config.mutex);
 	} else {
-		if (dsi->out_bridge->funcs->detach)
-			dsi->out_bridge->funcs->detach(dsi->out_bridge);
+		drm_bridge_detach(dsi->out_bridge);
 		dsi->out_bridge = NULL;
 	}
 
-- 
2.18.0.321.gffc6fa0e3

