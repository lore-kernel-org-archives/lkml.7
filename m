Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD25C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105762133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdP8kCT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfFNMle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:41:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34443 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbfFNMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:41:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so8833505wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5qK3v8M0/COPEJ7SsWz/6CEIKUUGZmlWZtaz7Lhp+Ls=;
        b=PdP8kCT5pZ4KuRLTSoxZDOpMV9pdkl9OgGbCB5RREx+hw6lGRrZeeEjtwwZX2q7vN3
         QHlwzO/9Feq+CAo1OidLVlETLzyZ3/F1BoGXW/ESOq77VmJoQbfgTow6jbZpg0ncFkCN
         3E4OMqjqtCGnXGW0fPe139Q5uvVm1LtbwPEEzy3SWD4JEXg5rHZbMl1+8DSwpDaye8ob
         xJ/yxsr0KAGGq16zjraeEe0RRQBNEf7YO/xyoBgg4ZtptfRKqW1mpgPBbgwbtXHYQUjq
         fZ4xVaTOHSsjfkOm3zOCoRTeFZPiiM5hZ0EXVdSc/gv1/EorkEtXNZBOqinC2C9icEFl
         saQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5qK3v8M0/COPEJ7SsWz/6CEIKUUGZmlWZtaz7Lhp+Ls=;
        b=MDFVqaxZr1LRWl3GWxFyuU++e5Q/hG29wDtjVtWlEsMH9BMKy/q6IcjleUWgczxb2k
         nxsMDBSojFiW+EPAoB3vX4+vEJAvCwMB5ymzBcajW93Km6N0WwvxRjwNKOmVWwB6Wpga
         5IOJ1BOvfWkuzEHEproB2zar8zuz/KFYgOBBdYRZiipytsqfgrUMLGKErS9r2M882uD1
         w9k02AzKdhqYdhOpl2WzKuDBdD7kHc5bgH1f2vZTnV633z+lYZBOvDyXw1Ny0DzVJpUK
         TKqmPBXNw8xFh0S1O6U2tlwHtKOheLaXMo9otOtTIbJOLg8EO5gWYx3D4T8VrZPlhaOB
         uHvw==
X-Gm-Message-State: APjAAAWwMQoL7urwDUjLZcwJWLtjsvakogdA5idHLeGglpqtLGczdQ0P
        8RQOFtNlZRsx7c52nXgFxyc=
X-Google-Smtp-Source: APXvYqx3TdkTr2PERaWPaBgxNyn5HROu2JC1tdlF95OhuMaMEztonewEfp/JX5KXsP6wDZyP4C46VA==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr7935115wmc.169.1560516090704;
        Fri, 14 Jun 2019 05:41:30 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:e0eb:ed4e:b781:3e9f])
        by smtp.gmail.com with ESMTPSA id n1sm2648209wrx.39.2019.06.14.05.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 05:41:30 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, peterz@infradead.org,
        thellstrom@vmware.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        lima@lists.freedesktop.org
Subject: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
Date:   Fri, 14 Jun 2019 14:41:22 +0200
Message-Id: <20190614124125.124181-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614124125.124181-1-christian.koenig@amd.com>
References: <20190614124125.124181-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the provided macros instead of implementing deadlock handling on our own.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_gem.c | 49 ++++++++++-----------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 50de138c89e0..6e4623d3bee2 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1307,51 +1307,26 @@ int
 drm_gem_lock_reservations(struct drm_gem_object **objs, int count,
 			  struct ww_acquire_ctx *acquire_ctx)
 {
-	int contended = -1;
+	struct ww_mutex *contended;
 	int i, ret;
 
 	ww_acquire_init(acquire_ctx, &reservation_ww_class);
 
-retry:
-	if (contended != -1) {
-		struct drm_gem_object *obj = objs[contended];
-
-		ret = ww_mutex_lock_slow_interruptible(&obj->resv->lock,
-						       acquire_ctx);
-		if (ret) {
-			ww_acquire_done(acquire_ctx);
-			return ret;
-		}
-	}
-
-	for (i = 0; i < count; i++) {
-		if (i == contended)
-			continue;
-
-		ret = ww_mutex_lock_interruptible(&objs[i]->resv->lock,
-						  acquire_ctx);
-		if (ret) {
-			int j;
-
-			for (j = 0; j < i; j++)
-				ww_mutex_unlock(&objs[j]->resv->lock);
-
-			if (contended != -1 && contended >= i)
-				ww_mutex_unlock(&objs[contended]->resv->lock);
-
-			if (ret == -EDEADLK) {
-				contended = i;
-				goto retry;
-			}
-
-			ww_acquire_done(acquire_ctx);
-			return ret;
-		}
-	}
+	ww_mutex_lock_for_each(for (i = 0; i < count; i++),
+			       &objs[i]->resv->lock, contended, ret, true,
+			       acquire_ctx)
+		if (ret)
+			goto error;
 
 	ww_acquire_done(acquire_ctx);
 
 	return 0;
+
+error:
+	ww_mutex_unlock_for_each(for (i = 0; i < count; i++),
+				 &objs[i]->resv->lock, contended);
+	ww_acquire_done(acquire_ctx);
+	return ret;
 }
 EXPORT_SYMBOL(drm_gem_lock_reservations);
 
-- 
2.17.1

