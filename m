Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73235C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDDA20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go1yH8C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfJUSJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:09:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40265 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:09:55 -0400
Received: by mail-io1-f66.google.com with SMTP id p6so8865788iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PwDqUExav+cvbganG+erWbWCIApPv5iXkwoEhIS0cuM=;
        b=Go1yH8C47c3vJg+g89NxR1MiSoBSlsfDJXv7TaDG1nV08X69HQyCZGO5W6faTh+D+1
         +eaXtDaKwqfoCPn93hax7poha82vC5pB8+YNc0Ghqngkh4zj+p5YFy1dBw2blL5gQHgz
         5HtFWOLUiEzmexkVWuywVSuLOD57Y6muqgH1esvAeBf+UnYuBC2Xk8MN8+tVbSflfHjI
         UmFuz54+gdjwVohH8FfSFDItW/BM5qlHmMZj8ozrwK+Cco0eJZK/UPL7K9ImlGWao4Yb
         OJaOvIksdMP2SAFj0KV1nfmZxQdDL8PnueY9UhCNF8jaU9/AJgMTXHzV3lQlwP5YpXOq
         Ou3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PwDqUExav+cvbganG+erWbWCIApPv5iXkwoEhIS0cuM=;
        b=TZ+NYmDQGieHb/NwZv7eOT7qBwOF39iO5KMJzIueXI8QSUS4v6DjJdaltmVx5aHz8v
         MHWwChUUE0i8e8FFEARUaJbeXBbOQhSBUraRnuWzzMeDWSADoBFZ1ojRA92h9Nv7q0U9
         rh/Vs4nnobwdFePuVgW/v9xYmV5D/Uyebvq+6WTQ05xzlV+lvbbqIz189w8PsuFLvt7I
         mGQnIa0XQN5oLyo1YzKp6JMSsCq/ibODoXRPq3U3L8clsJrCReQiMOihQpLa8iqV7jPy
         yqKvfgkeZf/y5JHc7he1zteQOuBqeLCfKMzkBUpjpG4iI+AfJck1cpxDU7X8EM7fczox
         3pGQ==
X-Gm-Message-State: APjAAAVR5LvXVtc7rtuaRqrtAsFxZPVEJ0Vpj0vZpAL9dRCrSSsq8KfK
        feDEqZBpcZ4xhiKJwq418N4=
X-Google-Smtp-Source: APXvYqznSmzhy0wTWi5lvuUY2S8YwDjtVPi2bLQB0Nx5j3prHKAAifbyhvoswa2OOS7Mz3aEo4AjgQ==
X-Received: by 2002:a6b:7942:: with SMTP id j2mr23507522iop.161.1571681393819;
        Mon, 21 Oct 2019 11:09:53 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id g13sm3715386ion.23.2019.10.21.11.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 11:09:53 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>, Jack Xiao <Jack.Xiao@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_fence_emit
Date:   Mon, 21 Oct 2019 13:09:40 -0500
Message-Id: <20191021180944.22183-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the impelementation of amdgpu_fence_emit() if dma_fence_wait() fails
and returns an errno, before returning the allocated memory for fence
should be released.

Fixes: 3d2aca8c8620 ("drm/amdgpu: fix old fence check in amdgpu_fence_emit")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 23085b352cf2..2f59c9270a7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -166,8 +166,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 		if (old) {
 			r = dma_fence_wait(old, false);
 			dma_fence_put(old);
-			if (r)
+			if (r) {
+				dma_fence_put(fence);
 				return r;
+			}
 		}
 	}
 
-- 
2.17.1

