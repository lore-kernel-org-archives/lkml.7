Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F2EC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE0E2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ESsau/uU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfIKRf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:35:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43070 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbfIKRf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:35:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id l22so26220654qtp.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mJD6iQtvN/UCjy4Ek8D93A8B4R/KlP3wDuq4/HX54Nk=;
        b=ESsau/uU7KkgWzaER4y2/52TBwwEMzglevQZgPhz8mpsh/psDnnwjhgCfMZx2xn7RO
         pTQMc4weP+eRGMm7La/QZypjUcjwfXOSY31sJWbO9DllIrfBVvcSDUt15jbMJJ5IQnkr
         fNnSmRkOk62gX4p8GqROfsCMVJkvswWy3bjYmTudOEQNz3hvX2e1t+Df2R313l4H0CQ7
         xDhRgrN7QroVOiWA7CvNIccCpQ6PsgEbUr3mVULnSlr7MoIuZxR5jpA5CMZYoQMPR7xY
         CTfHGHAhQCmh+Th+AdcgeGVctHvcOXk7cadtaOtxfl2XVnRMAexGlG1idU8BFky60sgz
         u38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mJD6iQtvN/UCjy4Ek8D93A8B4R/KlP3wDuq4/HX54Nk=;
        b=h8uS75hoXYuoKs+MH5Tk/nic5gHzuUtcDuWmvDOBzi9BokkahSV6khseuURcjRhzZu
         Ere6JWVjy/yyw0fp5ntgVZ7ISC4pt0fUIgrvJy5Ly0h3V31f9LKDjjAgcj27CzhGAtnT
         GpDzEQT2m8sP/f8VO5+HttHnJiVHaluPJ37PdIXg2mowAYo+hGtnLpCIYWdjCvu1YYSl
         pSJtBaEJtTapOms7R41bSAhNKbKwnCRHh53y6DvpNBnjSSNvhHoqyN0UWqyolreEpDKn
         IFuLf1WiaW58vDm+qw+4sjIQil24Pg+keBklJB4XwEhPcIgt+balPvqZ1mvtz7xYBami
         aYEA==
X-Gm-Message-State: APjAAAVA3jQocs06QdDc+bV3w0z3hHblWCyY3wnSfFBn32XU6Scu1jM6
        HdTTjXtDviymqSVqEE1xy8AlIA==
X-Google-Smtp-Source: APXvYqwcOywenx8LVLVD6JO3ednMqGYhwk73RQ5i92GZvWMV25FAZF2IFj/VjnedRzlUY75Dl91o7g==
X-Received: by 2002:aed:22cc:: with SMTP id q12mr37648607qtc.232.1568223320208;
        Wed, 11 Sep 2019 10:35:20 -0700 (PDT)
Received: from ovpn-125-217.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c204sm850853qkb.90.2019.09.11.10.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 10:35:19 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, emil.l.velikov@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RFC PATCH] gpu: no need to compile drm/ if CONFIG_DRM=n
Date:   Wed, 11 Sep 2019 13:34:53 -0400
Message-Id: <20190911173453.958-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c0e09200dc08 ("drm: reorganise drm tree to be more future
proof.") changed the behavior from only compiling drm/ if CONFIG_DRM=y
to always compiling drm/. This restores the behavior, so people don't
need to waste time compiling stuff they don't need.

Fixes: c0e09200dc08 ("drm: reorganise drm tree to be more future proof.")
---
 drivers/gpu/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index f17d01f076c7..a793b9ace34b 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -3,5 +3,6 @@
 # taken to initialize them in the correct order. Link order is the only way
 # to ensure this currently.
 obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
-obj-y			+= drm/ vga/
+obj-$(CONFIG_DRM)		+= drm/
+obj-y				+= vga/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
-- 
2.20.1 (Apple Git-117)

