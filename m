Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BD4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF67320811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaRl0vtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfDXNOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:14:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38700 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfDXNOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:14:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so5004968wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8qWjC17CdJYRqhzFhIPuaKkf1U3hmYPn8JGqQcjU8M=;
        b=CaRl0vtcX8Mf/mRrkgyrA7GRkjr0zmIm9LhtwWG8n0aoChBVa9TpXaO7On3qoK1CeN
         ismOcNcJqgCrMJBdKN88zcyRVuzmb1hyeaS00DeM0Xgb0Igy+fek7D7IYhiR3LXTzHI7
         KTxHGMPDsxdJnai54FQ3++LDjVr2CDUmhvpDMbjw/hhAa6Yf4AXqmWr2+0TMjfFY1y4K
         /XKJ/I69XI+n2TJdPkxVxwOh5B9VOhjbgtQDJF/pMjJ61m2xEt3IamAOXFItUEd5Bv5A
         ziPYdtv5CYyDRDn/JLdq2pEGw4ju66N0AZypVVns7BxHD6Rg1Bmg72ZpcNWfdfJZEMso
         hHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=J8qWjC17CdJYRqhzFhIPuaKkf1U3hmYPn8JGqQcjU8M=;
        b=TOOm2losc1jh0o9azzc16bvE+q+p3IXFJ4gkCMe3wxxl1iRe/HJaTiIX5AGt1uFvJE
         qwCgvKki2Knqu1YKQBicYcHWp9pZtFTHDNPbixY/seS6WT4fCkizF5sB+6vR85foZubz
         Xvqlg3IalgGFVqTRhe2eQ/RBljawaXE8++L+AYYhnWjbsXE9HkfOywwx15y4f0jhsRwK
         c9jGUuON/KXokLTWy3ghQH8ge/3Srv148Ky+hBlIR+/jz5GV5j8m9ZYFAW9KUwJlzB8X
         hmQYa/VpF8C0LY3r/6ELYp4Vu/eU+IWXQ9ZQf1zNL54crUECThuwyDycgYc9gVXx/RxK
         HBcQ==
X-Gm-Message-State: APjAAAUFKcBO+Zm0XpqPaIqG5yE1tkKromrkim52nxke+zZUxu1VDCeJ
        zZMXrHYo3u8p8S3Hj0a8Hq/KzBtW
X-Google-Smtp-Source: APXvYqw2Z0RbIoNJ2Ur+pO1IOhimFPUfVaa5hdKE8ZWejg92xSfiWkO/pE0ACDVCsCuB0sk2LAIkFg==
X-Received: by 2002:a1c:cb0f:: with SMTP id b15mr6475340wmg.88.1556111650088;
        Wed, 24 Apr 2019 06:14:10 -0700 (PDT)
Received: from cizrna.cbg.collabora.co.uk ([109.72.12.5])
        by smtp.gmail.com with ESMTPSA id r18sm29355218wme.18.2019.04.24.06.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 06:14:09 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panfrost: Add sanity checks to submit IOCTL
Date:   Wed, 24 Apr 2019 15:13:53 +0200
Message-Id: <20190424131355.62817-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So userspace can get feedback on any error conditions, instead of going
ahead and things breaking later.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 35 +++++++++++++++++--------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index c06af78ab833..0f2863cb8077 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -172,13 +172,27 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 {
 	struct panfrost_device *pfdev = dev->dev_private;
 	struct drm_panfrost_submit *args = data;
-	struct drm_syncobj *sync_out;
+	struct drm_syncobj *sync_out = NULL;
 	struct panfrost_job *job;
 	int ret = 0;
 
+	if (!args->jc)
+		return -EINVAL;
+
+	if (args->requirements && args->requirements != PANFROST_JD_REQ_FS)
+		return -EINVAL;
+
+	if (args->out_sync > 0) {
+		sync_out = drm_syncobj_find(file, args->out_sync);
+		if (!sync_out)
+			return -ENODEV;
+	}
+
 	job = kzalloc(sizeof(*job), GFP_KERNEL);
-	if (!job)
-		return -ENOMEM;
+	if (!job) {
+		ret = -ENOMEM;
+		goto fail_out_sync;
+	}
 
 	kref_init(&job->refcount);
 
@@ -190,25 +204,24 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 
 	ret = panfrost_copy_in_sync(dev, file, args, job);
 	if (ret)
-		goto fail;
+		goto fail_job;
 
 	ret = panfrost_lookup_bos(dev, file, args, job);
 	if (ret)
-		goto fail;
+		goto fail_job;
 
 	ret = panfrost_job_push(job);
 	if (ret)
-		goto fail;
+		goto fail_job;
 
 	/* Update the return sync object for the job */
-	sync_out = drm_syncobj_find(file, args->out_sync);
-	if (sync_out) {
+	if (sync_out)
 		drm_syncobj_replace_fence(sync_out, job->render_done_fence);
-		drm_syncobj_put(sync_out);
-	}
 
-fail:
+fail_job:
 	panfrost_job_put(job);
+fail_out_sync:
+	drm_syncobj_put(sync_out);
 
 	return ret;
 }
-- 
2.20.1

