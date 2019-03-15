Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF65C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BBE218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SfKmsVVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfCON5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:57:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35415 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfCON5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:57:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id y15so6231557wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZcsemXvfglAUC0jGESedl+RTzmszV5G64pnxTWiH4g=;
        b=SfKmsVVC+drcRsqXUXJ6gvPIfn1f0k9kq04SPXA216aWmztGBUrCjafC40QyYDQpNb
         a26++I1pS+z5aAE6dkcL9WhceFW6xEYvu5w7Wl8KbhOIqGo5K0q9eKFgm6yzWK/uKqxD
         4P5LjRKEEBbIWhBcqdnSxsvbnJQy2ANUpDbNNBez6K5LvN/8fMMTXcKn1ojzGQpWmN3W
         mGW5eF0CPP9U+/wOYjSOd2We8PtL6tEk3QJIpLsHvh5RLfEeSdm4qCENFrynm41sK8tJ
         ze/NUB1P5/y8vZbcacgq0Scwb9XxpUw1yVZaYzEm0wqZ00DOfjZJOibVEnrGuXL5ViX7
         /Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZcsemXvfglAUC0jGESedl+RTzmszV5G64pnxTWiH4g=;
        b=I3uxjEeGnbxzQfwovE5AiGpDs9pPlN5vRDX1jcGEnMEvNQ6VeM9bvQYJI0IeMi8ye+
         bSIuA9ZTepO0c3A/VFt/45qlwShJpzFd8spB/SWU6yufPgyHNhHeUmiFuUP1NRx0sLtk
         x0HhFdgrnaFBMV3+RGOaItKnCPbSkhBW7Obht+2Jr1sPw3HJFBs9yXjGqrpGJZfu0LLS
         wXF8p9rW1Z0dRi4regtpSGPJ/W5IFTp73rRUXmf/sD4foF9BWpC88G2olccFQ77rjbSs
         fiSZHOUErhtVP95PH2EoM3Ptn57jAcmiVa3Xfw8V0U1un4YGvb62bjudr1aBfpVKggno
         BGsA==
X-Gm-Message-State: APjAAAWbyNSJMETvR5TmSgu0XWReAUjhRoup9PBmpC2QJgz4qT3mlNMK
        sBOghsioFI8VdkvYK4xOOtFMoQ==
X-Google-Smtp-Source: APXvYqzLHSWXamSAChoX0YiQ6Kh+aI9iXLHASSTbYijTh2oD7ThGAS7omC/Urgn2DNOCC/Wkh3cGWA==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr2232123wmg.80.1552658220083;
        Fri, 15 Mar 2019 06:57:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a14sm2131900wrx.96.2019.03.15.06.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 06:56:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     devicetree@vger.kernel.org, khilman@baylibre.com, icenowy@aosc.io
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: gpu: mali-midgard: Add resets property
Date:   Fri, 15 Mar 2019 14:56:54 +0100
Message-Id: <20190315135655.28359-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315135655.28359-1-narmstrong@baylibre.com>
References: <20190315135655.28359-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic ARM Mali Midgard requires reset controls to power on and
software reset the GPU, adds these as optional in the bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
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
2.20.1

