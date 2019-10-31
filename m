Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924C4CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6500920873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcch+4vO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfJaWjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:39:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32839 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaWjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:39:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id u23so5086022pgo.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XA2iuNh9/swDl9Tmfmg7ziCGA3j4b9My46MQqYugItM=;
        b=Qcch+4vOBgJFluWS/CU9Vj23gJQmr2uMO/+Egn1smshXIoQwPnXBKkGcOOQWaLtOZv
         SmxRSyak6prlt73W/NGkeVYk4oZi4IVPBG5aguOjSLF+F0MQgJyIkB4Kwb0ZryTvlEX4
         lecHGdERD0zXwSZSpkxhNwbYmSmuS7j0Kch/GLOiTV7RBmE19xUE7ICmKzA77ZraozvM
         OTcF8WZMpMO1SrDVhBLva8A0LYLXbZWaOkA52mBjobTQXQNIeSwqppG3oW2+xRkWGP53
         Bfen5BhTk8ATttHhLCpXf2KpvLlj1HEj1kwX7jhNxoJxKPh3DPsvPi1HlDnb8cILh/z6
         wlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XA2iuNh9/swDl9Tmfmg7ziCGA3j4b9My46MQqYugItM=;
        b=GzIz6jkvc0FohqcdHFh6RsnNiUc9ANNi09uydt/34EUTWmpZLx8Yi9STqYF/U8zKol
         Thb1Y0ppO/9iPSNW29ByvsltAVWJbnZP2hpXjo0Y1X85pw5kkG7GB8Aw4TTWWWVS+J3k
         l0u8fpaRPHW/9+JEIKDeD9H6qEFXdMX3ndWLdCElHjLNHxbBJc8CDGWkfnUXKHalE8rq
         QoMYdvJNJlZhK+KdKeYg/B24C0T1+C9pcxex1e5fC7ZZXAY/5qarWfXhgQDCmzcoizQC
         5EomSty2pn3zxHvsMzVX1esSb/booyGgC2uq2x2nax4SlmlD5dYJMxfXozJqmwMsYrQn
         ulnA==
X-Gm-Message-State: APjAAAUl83zgPZDdaDrChAgG+etLnFHmrOBBUDq/nIvmDm2c62iRMg1J
        2k/PAHzmxTsTQ/o6t98sZIs=
X-Google-Smtp-Source: APXvYqxZ8YeP2THFsqrTpXurgYpWl6lUc8A7LHr282+Fya3K4vm6cvxvAdgKUc1rOUwIrrJ7Let3yw==
X-Received: by 2002:a63:b24c:: with SMTP id t12mr9885542pgo.340.1572561548114;
        Thu, 31 Oct 2019 15:39:08 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id m123sm4692234pfb.133.2019.10.31.15.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:39:07 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/atomic: swap_state should stall on cleanup_done
Date:   Thu, 31 Oct 2019 15:36:41 -0700
Message-Id: <20191031223641.19208-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Stalling on cleanup_done ensures that any atomic state related to a
nonblock commit no longer has dangling references to per-object state
that can be freed.

Otherwise, if a !nonblock commit completes after a nonblock commit has
swapped state (ie. the synchronous part of the nonblock commit comes
before the !nonblock commit), but before the asynchronous part of the
nonblock commit completes, what was the new per-object state in the
nonblock commit can be freed.

This shows up with the new self-refresh helper, as _update_avg_times()
dereferences the original old and new crtc_state.

Fixes: d4da4e33341c ("drm: Measure Self Refresh Entry/Exit times to avoid thrashing")
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Other possibilities:
1) maybe block later before freeing atomic state?
2) refcount individual per-object state

 drivers/gpu/drm/drm_atomic_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 3ef2ac52ce94..a5d95429f91b 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2711,7 +2711,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
 			if (!commit)
 				continue;
 
-			ret = wait_for_completion_interruptible(&commit->hw_done);
+			ret = wait_for_completion_interruptible(&commit->cleanup_done);
 			if (ret)
 				return ret;
 		}
@@ -2722,7 +2722,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
 			if (!commit)
 				continue;
 
-			ret = wait_for_completion_interruptible(&commit->hw_done);
+			ret = wait_for_completion_interruptible(&commit->cleanup_done);
 			if (ret)
 				return ret;
 		}
@@ -2733,7 +2733,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
 			if (!commit)
 				continue;
 
-			ret = wait_for_completion_interruptible(&commit->hw_done);
+			ret = wait_for_completion_interruptible(&commit->cleanup_done);
 			if (ret)
 				return ret;
 		}
-- 
2.21.0

