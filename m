Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84D4C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840BF21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kODRaWBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfGVSZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:25:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36350 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731813AbfGVSZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:25:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so19548280plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkGn8pX+SnGbncQZILWgKTNC3yYNo8zAMY1G6oxP7Bk=;
        b=kODRaWBKJXyuIRTX369dvcz8KsHsvOXWSPRckcRa6ktNtHmxUsikmQlXEMgVRiPoeq
         x7NoYUYH8Oo67zCDzUZ7wEDv9Hzk/Sk5FxtB3AcougBOrP4zw/IuxrqGJXNSUKywLpqf
         SqCtChZV6KHIRQ+rM0myXRa1+dwp1B6eBHx64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkGn8pX+SnGbncQZILWgKTNC3yYNo8zAMY1G6oxP7Bk=;
        b=IesWTfyVwKGCS+8qcOAJaUlk5Ttw5Hy/1rXvoaHVWDbNDYlxqNRICK5kkkR2H3LJ59
         yKdc0OItSPG5+ORCjp4FzcFoHIupoD4GewHzQsLxz+B+Ztt/THG+Jp3hSY9sxmVFiMor
         LISJ/BLhNAClYnHVUyy8lor7Gs1U/HxyQ0MvxJXV6jPc+bnN1R84LQOBWHWprkSjr3ZI
         V6E6KS7KG+dk0bpklxAN2BSKxPBjmDE8OT+/I77ItfaVqWbmjU8vnl5aAa3YpVDDQvBz
         r5tH6LVXxZ5B26ynKwMcwqk14Cn9k9xo02shoHrMVbRcdBmAmetE1PPza+QL7PEwwzOX
         lLow==
X-Gm-Message-State: APjAAAVWclfJgidxYkkzjyoy0WL0/jgDC43hlSpunayFS5FB3IfN0Uau
        bvZC1ccp5/IipWcNB7Kd2wla4w==
X-Google-Smtp-Source: APXvYqwt8O0L83AANnlACuiSZO0y3AW9dmuUUC7ooEfiwSxSjS1wz+BGd5M4s1GjUn44c68TKPzdkg==
X-Received: by 2002:a17:902:9688:: with SMTP id n8mr75084152plp.227.1563819904526;
        Mon, 22 Jul 2019 11:25:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id a3sm36117683pfl.145.2019.07.22.11.25.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:25:04 -0700 (PDT)
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
Subject: [PATCH 1/4] video: of: display_timing: Add of_node_put() in of_get_display_timing()
Date:   Mon, 22 Jul 2019 11:24:36 -0700
Message-Id: <20190722182439.44844-2-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722182439.44844-1-dianders@chromium.org>
References: <20190722182439.44844-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From code inspection it can be seen that of_get_display_timing() is
lacking an of_node_put().  Add it.

Fixes: ffa3fd21de8a ("videomode: implement public of_get_display_timing()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/video/of_display_timing.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index f5c1c469c0af..5eedae0799f0 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -119,6 +119,7 @@ int of_get_display_timing(const struct device_node *np, const char *name,
 		struct display_timing *dt)
 {
 	struct device_node *timing_np;
+	int ret;
 
 	if (!np)
 		return -EINVAL;
@@ -129,7 +130,11 @@ int of_get_display_timing(const struct device_node *np, const char *name,
 		return -ENOENT;
 	}
 
-	return of_parse_display_timing(timing_np, dt);
+	ret = of_parse_display_timing(timing_np, dt);
+
+	of_node_put(timing_np);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_get_display_timing);
 
-- 
2.22.0.657.g960e92d24f-goog

