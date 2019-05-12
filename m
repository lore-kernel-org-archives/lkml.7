Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99AC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE5E217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNPLCR8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfELRqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:46:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34520 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfELRqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:46:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id m20so9712326wmg.1;
        Sun, 12 May 2019 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1WIGTjZh4mIwUZpoXVfzkYofixlglZX9sKei53EYiYk=;
        b=FNPLCR8Sd13vMzZbJg8ptcgHXtjdN1eS0ZvAd0uRFvifNg+n8JpiAcG8DD3rDOsdu3
         xiheRxeCsEA5ATtOgkuuqVXHPzZJGNRMRUdPHZ1jIQu/yLNphwgNpLNI3gBGMVHQDVZv
         P2ULCWwuKNIltsEqQWfvKPwwloxjdzfVnyekrJRLrh2wmTakO94vwauG5Os4o1iPEvHj
         Q3cMxNcOEmPQWVeqM8CxPFspXuvki4g0PULvuebwMYm8rmtBFRCGGjHrEzuHtLdGv2Fb
         5rhSafvgxQVouj4xJmdbx7IWn9lKFcY132hkVU6fW8iQcEfdAcTkpYXh5GP01eC4SQtu
         Uzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1WIGTjZh4mIwUZpoXVfzkYofixlglZX9sKei53EYiYk=;
        b=cr7WarBE0XUQn45eK53mG/FbgQ0XKLYs8ofz8p9493+mKah3RL3dleGQdggWzoIIlb
         NyOSlPx41QvhXdgepHr2ThlsXPCAwpoEquyIJJ1hETad5TGy4M76JvGT5FeFDeCXcFUZ
         w8it2FX/iV+bVrZ/pXYkfZmrezYQqCvVNnqtaI5EyfFAmLrm+pdWYM69DoWvxkJBq/Fp
         E8AqlgOGB0juszUJ6i8NvTIMswSTNQp5zHxID1pNX3O58TzaQcRV/yIwjbz0FNRfZHXe
         1rmd75ieMo2EfgpZ4qK6wPnuP36ic+IA0dmFW9vb+J+/PMCn4Kvf72Qc0YoBmMHAGlpe
         6XDg==
X-Gm-Message-State: APjAAAXecRZm9BDTJRXEaSLF66s6rVrapUjbwGBfIxy3nJ/Pxyy6Dbnr
        xAVKigN8llQESwP10QETaKA=
X-Google-Smtp-Source: APXvYqx2EWKBm+GH/a0JjB7RxHj0gE/6taBHkxJHevcGOh44GOKAT3CUGk1nxZQ0yStWTZtn7JbA/w==
X-Received: by 2002:a1c:a684:: with SMTP id p126mr8448133wme.101.1557683176596;
        Sun, 12 May 2019 10:46:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id d14sm9090558wre.78.2019.05.12.10.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:46:15 -0700 (PDT)
From:   peron.clem@gmail.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v4 1/8] dt-bindings: gpu: mali-midgard: Add resets property
Date:   Sun, 12 May 2019 19:46:01 +0200
Message-Id: <20190512174608.10083-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512174608.10083-1-peron.clem@gmail.com>
References: <20190512174608.10083-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

The Amlogic ARM Mali Midgard requires reset controls to power on and
software reset the GPU, adds these as optional in the bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 18a2cde2e5f3..1b1a74129141 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -37,6 +37,20 @@ Optional properties:
 - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
   for details.
 
+- resets : Phandle of the GPU reset line.
+
+Vendor-specific bindings
+------------------------
+
+The Mali GPU is integrated very differently from one SoC to
+another. In order to accomodate those differences, you have the option
+to specify one more vendor-specific compatible, among:
+
+- "amlogic,meson-gxm-mali"
+  Required properties:
+  - resets : Should contain phandles of :
+    + GPU reset line
+    + GPU APB glue reset line
 
 Example for a Mali-T760:
 
-- 
2.17.1

