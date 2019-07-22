Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF723C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFB021901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YEW6P3hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfGVTPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:15:10 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33205 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfGVTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:15:10 -0400
Received: by mail-vs1-f68.google.com with SMTP id m8so27110580vsj.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4BuuPSvhQT5H67c4iK7jqEFJDfyC/RcpCWzQsK/Bagw=;
        b=YEW6P3hOXzy+0zgf6FOEyZJgqFbPIbY+8dVXkWPS/LmqA3Ulr6DM8mLczZleAqHxPt
         wI19rxN1CrY8o4DLllYJitWKTki8rbqyOJKYgGlVKlF3faV0WYzoNIXw4/pCgfh1WY0m
         /9WGxd8Q7RpFCAgMQHd6hCBy7gT4tfVf4v97vc5+s+BPu84M/E4VfLjON4Nnq6TgYwdS
         VozpLWc4YxcSstY2DUFEcf3FCSIvIj61UQSvLSvP/UfvmWljL/M8j6a2H3F+6hyiHckq
         sPtt+oEoU/xgniNh+9bAROKrnl1wf+Lz3pHdT0vO2xDuLoHOXKqH9XLFBjribJFs/ws3
         9Kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4BuuPSvhQT5H67c4iK7jqEFJDfyC/RcpCWzQsK/Bagw=;
        b=I8VSvPzbEtv+8KKO8zM+tICZ7PccHnu7mwYBZ+AHd6mHJMCqyLsUpf5Oe8ogXzXbcd
         5xLuL+qPJ991+0aSVV3BOY64SznBtWXcfE0CqekEGVGGJ3lozXXcPtmOqjrBdk+ofUNM
         CqGqgrCNPOZJ5RboJFCMoE7QXlfVY2OceZSnfXA4J2nXO2FZ5YhH5Eot1nalP+Nv+0QI
         gHqgFIwgIxAYXWpuqWO88hjbjqLMkNQWIHEBz8ikpuo2zzyBUIRXZmv77Ejdzfk/zE+Y
         zaFRZnJwZmsi3WjF0l1AYr5vyYSnGgudv6Kh1+0+ffJzayQegoA0MiO1xEAbMJSYcn0b
         e08Q==
X-Gm-Message-State: APjAAAWrBmGn6bObVVf0LUUtKt0vBU+msxqEN0e7HBbS6QMq5msMjLX2
        L4ktEGHyQV3I/JGp05Mvh2h3WOjW8j+j/Q==
X-Google-Smtp-Source: APXvYqxZlIpTi88Fqz4ibqiGDTpWCCB7h63uPWTKFXZaJF1FeJSDC0tq9HX1ZRxP8buTUrL2OdsQrA==
X-Received: by 2002:a67:d46:: with SMTP id 67mr44695015vsn.181.1563822909007;
        Mon, 22 Jul 2019 12:15:09 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 4sm7433056vsx.11.2019.07.22.12.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 12:15:08 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     daniel@ffwll.ch
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] drm: silence variable 'conn' set but not used
Date:   Mon, 22 Jul 2019 15:14:46 -0400
Message-Id: <1563822886-13570-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "struct drm_connector" iteration cursor from
"for_each_new_connector_in_state" is never used in atomic_remove_fb()
which generates a compilation warning,

drivers/gpu/drm/drm_framebuffer.c: In function 'atomic_remove_fb':
drivers/gpu/drm/drm_framebuffer.c:838:24: warning: variable 'conn' set
but not used [-Wunused-but-set-variable]

Silence it by marking "conn" __maybe_unused.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/gpu/drm/drm_framebuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 0b72468e8131..57564318ceea 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -835,7 +835,7 @@ static int atomic_remove_fb(struct drm_framebuffer *fb)
 	struct drm_device *dev = fb->dev;
 	struct drm_atomic_state *state;
 	struct drm_plane *plane;
-	struct drm_connector *conn;
+	struct drm_connector *conn __maybe_unused;
 	struct drm_connector_state *conn_state;
 	int i, ret;
 	unsigned plane_mask;
-- 
1.8.3.1

