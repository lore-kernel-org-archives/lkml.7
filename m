Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD8DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5DA20693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHcVB/38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbfDRInh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:43:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42773 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbfDRInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:43:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so1899583wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XaG+VmIuFzFcyeH04Vkt+dOmHujdLld/OhJ1u+Y9zcc=;
        b=kHcVB/38JpLU+vYPNimis8TXXS5FAWmQ8MKBiuQmWS8YQ8Z5jRue/GIBHUEC65BdO0
         fIzHjto/uD8UAY74AVFihjrm8IWVULu4SeXMgFF6hOyY7kTUJYfX9RdecbHcRV6K8t6z
         HOEfIu8piiAv9nCTZaDTU9wkevPk4Yp4R2F2GKqEXIg0KA7qL5CdluL2ZRQ/l/KqOEde
         y14bs9iwXYKeleHVgTs0+opAvRymwlVXi366MvgzxnkaGfEUgYQJgsmLv/Sv9zabEHnu
         7q8k9V+kCo3wmOmtnWAmqup/XApNKMDido8sE2st3UW+eC+dDI7zXr/ikEKe3TpkqIrR
         rGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XaG+VmIuFzFcyeH04Vkt+dOmHujdLld/OhJ1u+Y9zcc=;
        b=ewIEVlFiAkAAIKROCK7wuMO3YxTmqMdc4GA5hO/sYg4C7qP2qUmD3Z1TBDaDpIvANH
         Bral45FRXlYfmVziPIklAZkDF8KI3lYWxP+4HfpIHZ0Sfi4oMZZu9z3ybnI0HoVSZnM1
         xWVdkPIGExXrhN6GSEfvVtVfkzbOEJr1wfNNJ85BU934N8s5RzyhsV5aXWPbJibpZVD3
         MISovJ7qvFHfb4IaNv+8av66uzWV9YForseY9/55NA2EQeZ1J8cQCpBpIRnvECdH79Tm
         eQh0TLFEiYLkzxcLqwXxCNizQbRnMY5zXA5xQyEzeDHA8LHTa03wBl6jhujyYyYKfKm0
         to/A==
X-Gm-Message-State: APjAAAWycaC5EaL1vhYOXmb6sDjZFFenA9jAKmH4CiZltCIh5+qrUpMp
        AHfOpYBxm2AkYFjggHTKrwbiD7QQ
X-Google-Smtp-Source: APXvYqyCZ0rGrpXhrVfkpy+bQqBaL0cJax9xOY+BKtTwwWH+PBy06FTHLi0wDJxfQuL+aFrl+1CVJw==
X-Received: by 2002:a5d:4588:: with SMTP id p8mr1483240wrq.155.1555577015208;
        Thu, 18 Apr 2019 01:43:35 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.122])
        by smtp.gmail.com with ESMTPSA id w14sm1767733wrr.16.2019.04.18.01.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 01:43:34 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panfrost: Prevent concurrent resets
Date:   Thu, 18 Apr 2019 10:41:48 +0200
Message-Id: <20190418084305.45021-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a job times out in slot 0 while a reset is performed because a job
timed out in slot 1, the drm-sched core can get into a deadlock.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 1 +
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 +
 drivers/gpu/drm/panfrost/panfrost_job.c    | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 91e8fb0f2b25..970f669c6d29 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -98,6 +98,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	struct resource *res;
 
 	mutex_init(&pfdev->sched_lock);
+	mutex_init(&pfdev->reset_lock);
 	INIT_LIST_HEAD(&pfdev->scheduled_jobs);
 
 	spin_lock_init(&pfdev->hwaccess_lock);
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 1ba48d105763..56f452dfb490 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -78,6 +78,7 @@ struct panfrost_device {
 	struct list_head scheduled_jobs;
 
 	struct mutex sched_lock;
+	struct mutex reset_lock;
 
 	struct {
 		struct devfreq *devfreq;
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 0a7ed04f7d52..a5716c8fe8b3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -384,6 +384,8 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
 		job_read(pfdev, JS_TAIL_LO(js)),
 		sched_job);
 
+	mutex_lock(&pfdev->reset_lock);
+
 	for (i = 0; i < NUM_JOB_SLOTS; i++)
 		drm_sched_stop(&pfdev->js->queue[i].sched);
 
@@ -406,6 +408,8 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
 	/* restart scheduler after GPU is usable again */
 	for (i = 0; i < NUM_JOB_SLOTS; i++)
 		drm_sched_start(&pfdev->js->queue[i].sched, true);
+
+	mutex_unlock(&pfdev->reset_lock);
 }
 
 static const struct drm_sched_backend_ops panfrost_sched_ops = {
-- 
2.20.1

