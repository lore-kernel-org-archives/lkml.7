Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34485C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0987821901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VORIvKvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfGVSZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:25:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34936 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbfGVSZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:25:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so11747562pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phxXam+NzCk41fkXQIfIPhu7NO3JuGp0Zqj7GYLvO5g=;
        b=VORIvKvZyl9su9iT0PV3CqryHSefcsep6woCoAACriNyyj1wpAq19jNBW1BYF5IpQo
         US79nuEXwDfYRquImLevsgou9blTecCzbQdIRW8MvRGuCKdw8QN2iYCtNEWGFwhJ26xY
         CNEJ+PxvFxXS8ph5Wzk31pOD2MWnCapWoZQok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phxXam+NzCk41fkXQIfIPhu7NO3JuGp0Zqj7GYLvO5g=;
        b=I6jHiNyQtkf0gXsp+nvsD478IZdg5qbqSG+tHCKt7FFFLIE84/KOJR1RcHUQeITwKn
         wOwNc+faN+i+eFNjULVjAdsXO6ATnix6IxtL905ZUPkaSMaKJn4zBH9nxReQfIaXfE01
         8FHDw/RsfiCyezIKu4ruwJ3h1laXjAsQTdnlHlhUdxQFYdrFdlbTj4cC1IELnB5XeCez
         RGxE0cHf4EPNl2lSuSf7yRbAVY1CDfUNbjFuICeGzbq8QJ7y2Lhx8Su9uIJs0uit6CvK
         4quFF0J6hbMM03xzSuMP0Fr5VC6+UFtvnuLW77HapOJ/WYBzFHPYbwrXddlzOTQl4hSH
         0NNA==
X-Gm-Message-State: APjAAAWrzAADyeBBf5YhpUV6vmfMBSrgKMdKAAw72pcTZKNQYCebqQuU
        xrq+vXjK8cOK5zwCMfVb500Q7A==
X-Google-Smtp-Source: APXvYqxIok6j9SpyTOOUPPOSMw74gGma9eXYYBqZ20kYDDJq6S+wqATyE6oe5vdgxNJaBlFiNXuY1g==
X-Received: by 2002:a62:1883:: with SMTP id 125mr1535738pfy.178.1563819905974;
        Mon, 22 Jul 2019 11:25:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id a3sm36117683pfl.145.2019.07.22.11.25.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:25:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] video: of: display_timing: Don't yell if no timing node is present
Date:   Mon, 22 Jul 2019 11:24:37 -0700
Message-Id: <20190722182439.44844-3-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722182439.44844-1-dianders@chromium.org>
References: <20190722182439.44844-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be cases (like in panel-simple.c) where we have a sane
fallback if no timings are specified in the device tree.  Let's get
rid of the unconditional pr_err().  We can add error messages in
individual drivers if it makes sense.

NOTE: we'll still print errors if the node is present but there are
problems parsing the timings.

Fixes: b8a2948fa2b3 ("drm/panel: simple: Add ability to override typical timing")
Reported-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/video/of_display_timing.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 5eedae0799f0..abc9ada798ee 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -125,10 +125,8 @@ int of_get_display_timing(const struct device_node *np, const char *name,
 		return -EINVAL;
 
 	timing_np = of_get_child_by_name(np, name);
-	if (!timing_np) {
-		pr_err("%pOF: could not find node '%s'\n", np, name);
+	if (!timing_np)
 		return -ENOENT;
-	}
 
 	ret = of_parse_display_timing(timing_np, dt);
 
-- 
2.22.0.657.g960e92d24f-goog

