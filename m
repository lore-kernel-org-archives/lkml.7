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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF8EC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846F721473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4wmh8s2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfFNMlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:41:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40309 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbfFNMle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:41:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so2173074wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ikrEbSutjHRTcQQg/Oha1wtsctApdZhOcWN+4xePnrs=;
        b=J4wmh8s2eFE78lNG3SgNS9fKgrTvJi8/54g0IibJPJZZLJSZZroXgvM3cDQBfax8gC
         BI0uYyZq8q5SE+NG2+C8YcNagSzCtbkp1rHtnOpRlGdSUODFpU5nfNb3iC9TX9wPwyew
         43aXDF8/CA9PR86IJm8dsl6uzj4ZyRKba312BUdmjUrVObB2pOxgt4h/veMHB3y3LuvR
         vbWfh1k0LPuH0co5IF4onLQmH0BxKNWm6j/T2nqQUKLYlM1wkSyYqdj2/+K53Kl2RcS9
         dZEpfI1sRPZhEdIDHoHIDrD4gMlw9sWFF9uDD2bdNzXIWFkXcSMnkaggJHataqIUW5+W
         Jycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikrEbSutjHRTcQQg/Oha1wtsctApdZhOcWN+4xePnrs=;
        b=C1ClqH7HvenmQxJa/ZCaSuzbCmx96hqOqDIQ6p4kysaQFYlLBNAf6IxyDSt25YuvH8
         doyamJv2x4kZax2e1kvznGWUGEfkSuUMrwqAhPHsFPH8wDEL+WoYwHG2DqiSsiCSLBhO
         bD1Gc0CVhrZYwWySd/O0FVZ7dcbPW+GN5ptmbuQa4+5MODoaUtekgSsgxTCA8/tlEADp
         T11pUt/cERPSkkBPT/0shrTxIIPk/wLcfFLt2FzksGSp/XkOGa+paUTEw6y7quH45Iae
         acRN1hoyxE11QWghLzUtmPgHYb/DTFFrOEsSauRMg5KWMystCnwgK/Xdy3z0mjb4qkGL
         i/Og==
X-Gm-Message-State: APjAAAVoEZphTUJK8ahDPlpXRDQpyhlhJweNAIZGvve51GDRSn+9c73G
        fVXCU0t/8v3phuGD2oxcySQ=
X-Google-Smtp-Source: APXvYqzBD/dbXM9Coe83f5O64MsEtVJFQksKIgSL9I3SUrQShnBIHgrA7EisTvPuUH3e/3GJB6jZGQ==
X-Received: by 2002:a1c:b68a:: with SMTP id g132mr8217905wmf.66.1560516092658;
        Fri, 14 Jun 2019 05:41:32 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:e0eb:ed4e:b781:3e9f])
        by smtp.gmail.com with ESMTPSA id n1sm2648209wrx.39.2019.06.14.05.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 05:41:32 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, peterz@infradead.org,
        thellstrom@vmware.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        lima@lists.freedesktop.org
Subject: [PATCH 5/6] drm/lima: use new ww_mutex_(un)lock_for_each macros
Date:   Fri, 14 Jun 2019 14:41:24 +0200
Message-Id: <20190614124125.124181-6-christian.koenig@amd.com>
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
 drivers/gpu/drm/lima/lima_gem.c | 41 +++++++++------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 477c0f766663..6a51f100c29e 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -151,43 +151,24 @@ static int lima_gem_sync_bo(struct lima_sched_task *task, struct lima_bo *bo,
 static int lima_gem_lock_bos(struct lima_bo **bos, u32 nr_bos,
 			     struct ww_acquire_ctx *ctx)
 {
-	int i, ret = 0, contended, slow_locked = -1;
+	struct ww_mutex *contended;
+	int i, ret = 0;
 
 	ww_acquire_init(ctx, &reservation_ww_class);
 
-retry:
-	for (i = 0; i < nr_bos; i++) {
-		if (i == slow_locked) {
-			slow_locked = -1;
-			continue;
-		}
-
-		ret = ww_mutex_lock_interruptible(&bos[i]->gem.resv->lock, ctx);
-		if (ret < 0) {
-			contended = i;
-			goto err;
-		}
-	}
+	ww_mutex_lock_for_each(for (i = 0; i < nr_bos; i++),
+			       &bos[i]->gem.resv->lock, contended, ret, true,
+			       ctx)
+		if (ret)
+			goto error;
 
 	ww_acquire_done(ctx);
-	return 0;
 
-err:
-	for (i--; i >= 0; i--)
-		ww_mutex_unlock(&bos[i]->gem.resv->lock);
-
-	if (slow_locked >= 0)
-		ww_mutex_unlock(&bos[slow_locked]->gem.resv->lock);
+	return 0;
 
-	if (ret == -EDEADLK) {
-		/* we lost out in a seqno race, lock and retry.. */
-		ret = ww_mutex_lock_slow_interruptible(
-			&bos[contended]->gem.resv->lock, ctx);
-		if (!ret) {
-			slow_locked = contended;
-			goto retry;
-		}
-	}
+error:
+	ww_mutex_unlock_for_each(for (i = 0; i < nr_bos; i++),
+				 &bos[i]->gem.resv->lock, contended);
 	ww_acquire_fini(ctx);
 
 	return ret;
-- 
2.17.1

