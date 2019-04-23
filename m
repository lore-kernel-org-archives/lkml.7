Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DF5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104CC20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="twa/FD3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfDWJ3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:29:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46721 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDWJ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:29:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id v2so4886877pge.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4fZiACkBLsuw5BLuZySw+S4JDknvGfC5Ei1Wz8auhg=;
        b=twa/FD3WmOktH9MVUXb/BldyzAa94cTWq+B+S4ebxbShNY2tz68WlGR8/5ZjyL48Gh
         is1gLQKuXAdlVwuuYBQowMOWGgnIU4cLlahPNfTri8ya/Vkqg2xYHyMvm6kCa1JKUHHL
         DB0JMTZ3PHHGcuL1YReWXA8XA0zLfL56ZxME9SxJbU/ULv5oya+8sBH8pu35OH6ORWJe
         pC6g0alS54g3O2Ac9cY73AnwM9VJlHJmNtPofCIbswJQsGaT989Es/9OfoLnGhbBqSlj
         hgPxb/oKA/z6b0ax9JfOa6HYKAsuLpqd1NLUUS5jdBMs2GMG/HGXQQ4kumsm8D3hc1QN
         SA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4fZiACkBLsuw5BLuZySw+S4JDknvGfC5Ei1Wz8auhg=;
        b=V8U1GrfMoqsz7ytmFLJonP5QKYkoe45WFiCc8hyvJ2SuGpv+OZM9pcNHO22tbSBEK6
         gcZwdum1fu5qWpg+DuLwO9MGEU2eV1POybLifPjxlpKExABGWFHmkXSN2cq9rrt/F3Ei
         3isSjDjkKUUrCJsNlY6O8dMogMkQY3JOiZCJfY5J2OrqolxR5FjLF3vaMbzB/Hpsumz2
         Vafr+7NUdW8YJMLW+htSNBaDb3qSv2aiK013bLO5KqBx7w1bwkwkwWEBYnT5f4U++ZTK
         xBPP7eK4sMclvaBsGmrTjBqJYpe80akjjggJu+hkIvgFzAnM8piC/1OWCCul+I9gl/fi
         DIwg==
X-Gm-Message-State: APjAAAX3N9IHYDzBpPB1IUcOWWqF+jvLg9BQ3ISFwyFCYErW6cozNANH
        H+BSFCblTF8dCnhh0JRDFtVe7A==
X-Google-Smtp-Source: APXvYqzyeawPu0YMyAZZFm6KX9YpYBW5MaleqW0+qkdNuOr2h7cbOgN3OqOXryQp3ByD92IOpbNilQ==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr22898103pgd.357.1556011744623;
        Tue, 23 Apr 2019 02:29:04 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id q10sm18905809pgh.93.2019.04.23.02.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 02:29:04 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] i915: disable framebuffer compression on GeminiLake
Date:   Tue, 23 Apr 2019 17:28:10 +0800
Message-Id: <20190423092810.28359-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <drake@endlessm.com>

On many (all?) the Gemini Lake systems we work with, there is frequent
momentary graphical corruption at the top of the screen, and it seems
that disabling framebuffer compression can avoid this.

The ticket was reported 6 months ago and has already affected a
multitude of users, without any real progress being made. So, lets
disable framebuffer compression on GeminiLake until a solution is found.

Buglink: https://bugs.freedesktop.org/show_bug.cgi?id=108085
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/gpu/drm/i915/intel_fbc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_fbc.c b/drivers/gpu/drm/i915/intel_fbc.c
index 656e684e7c9a..fc018f3f53a1 100644
--- a/drivers/gpu/drm/i915/intel_fbc.c
+++ b/drivers/gpu/drm/i915/intel_fbc.c
@@ -1278,6 +1278,10 @@ static int intel_sanitize_fbc_option(struct drm_i915_private *dev_priv)
 	if (!HAS_FBC(dev_priv))
 		return 0;
 
+	/* https://bugs.freedesktop.org/show_bug.cgi?id=108085 */
+	if (IS_GEMINILAKE(dev_priv))
+		return 0;
+
 	if (IS_BROADWELL(dev_priv) || INTEL_GEN(dev_priv) >= 9)
 		return 1;
 
-- 
2.21.0

