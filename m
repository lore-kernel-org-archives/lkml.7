Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D75BC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73CF2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 09:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxifOtZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDMJfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:35:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51158 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfDMJfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 05:35:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so14183317wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iMU3oA46JmheKXc/xuZAihLwg8hvxE+GXODzPKTYCF0=;
        b=bxifOtZd/QTaZUOhDlJFdjg90fV8hIiUoiLTFvjycVMx00EisuuUC6yKMZD0A7uCyA
         rityMS+8lw/gJYexjI+x+wgotHmjF0NnnmMCfURKbN+q+d/a0NBglkvaNWXD7hSkngsP
         0uNELMA3EtROQ0OmN5ZiXfZUs/80A3ceao85tINXx2K73F0nnh7103atAwICod80JoD9
         ECC+DvTdv+KS8HFg6DKO6meodB+kTnHCepajJsXO6h2BlnEOmlTGnUxpl8aVRWpTqQpy
         5Uif+Y+0UqZBkldBbOJKWM+V6QoeArC5NBVB4xJrulS7lBMeokXEHtI2lSKUQ3lqx8xN
         D8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iMU3oA46JmheKXc/xuZAihLwg8hvxE+GXODzPKTYCF0=;
        b=bSc4NBH9U5LRbBZwUuztI5Fhg0tTUM7DYatz5QUq3bpUCYJEgq7HRACNNN2Pyx1A+u
         buF6x97Zkz3XGGMPr0wyCOVi2HWYkuUg9+8DVYxX4kr/yaRlbSfCPg6M1icRN5zHOtDN
         JUV3ttnZfLoU1c1rsZk/TcGPeW7jIULhTlF5NFVrNs2iwZ6S0Myt3C7KQvQ3BuPx1ljp
         ju+XPYtajjF2oQy3NDWzbqVRo6EPZv/s45qYazW/AHeynYlMUMPUUxNd7h8jzMSydy43
         IEjLExmf3epHlVjAbc6OF4eF/urUnXV8FXjYjOmWXIPCNTjhCDKhs67E2hBAUgnN2yOh
         +fUw==
X-Gm-Message-State: APjAAAXzYIZG+VeC8U4vHOIBZ2xZQsKnJEzxWy59mMyp4fc37xTpPvIj
        TYcdXR7SVc4IarCLy7RjS14=
X-Google-Smtp-Source: APXvYqyUMk37Cm8wmhtxLSxL3q5rklyIAg2lQv4qtQ2usZLIGIAv2nNheyYlYi5GmIYMcP1iHiSF9g==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr15468353wme.24.1555148134177;
        Sat, 13 Apr 2019 02:35:34 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2def:500:2ca3:f513:3ec4:694])
        by smtp.gmail.com with ESMTPSA id o15sm39615602wrj.59.2019.04.13.02.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 02:35:33 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: normalize Laurent Pinchart's email address
Date:   Sat, 13 Apr 2019 11:35:22 +0200
Message-Id: <20190413093522.14738-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS contains lower-case and upper-case variants of
Laurent Pinchart's email address.

Only keep the lower-case variant in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b486b9e5d73c..dc329b6524d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1097,7 +1097,7 @@ F:	Documentation/perf/xgene-pmu.txt
 F:	Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 
 APTINA CAMERA SENSOR PLL
-M:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/aptina-pll.*
@@ -5126,7 +5126,7 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DRM DRIVERS FOR BRIDGE CHIPS
 M:	Andrzej Hajda <a.hajda@samsung.com>
-R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
+R:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/bridge/
-- 
2.17.1

