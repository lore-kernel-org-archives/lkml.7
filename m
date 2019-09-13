Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03322C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BF1206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380438;
	bh=VM9gZTOqYFhqgMLCQXm93qWHgPVp58xi3KhFJpgjjYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yUB/NmXgZfjOX/ANaDY/6zcCHj4em+6PczCpTRFjFmoOGDObn3/TBv7pRUGO/qZMh
	 f3i5CvuYKp1/9STPEsNJOGmfBH4bLGSgMBSU8JdY9X+8Hp88HTQSG3AgNtvpYdd+Lm
	 E1lp2+7EibQWoC76NwlkMZk6hwHbTn1InyBR57to=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbfIMNN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389423AbfIMNNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:13:55 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F974206BB;
        Fri, 13 Sep 2019 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380435;
        bh=VM9gZTOqYFhqgMLCQXm93qWHgPVp58xi3KhFJpgjjYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHOl4zUAYFHe7RbMFz0jA403nK5PNdGsGNQlESXQWGyj9MsQkR9LuV8uSk+PRJZsk
         xoQV8vk2keos5Kf1cE9R39yqeGrwAVeKbus5YC7kMEPlhOoo+WfVPquqJl44ZcTs6Z
         RNrb4yNHaWckVw0q85JpxJWkdmBC+CZCOfh2bM8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/190] drm/i915: Cleanup gt powerstate from gem
Date:   Fri, 13 Sep 2019 14:05:18 +0100
Message-Id: <20190913130604.799129279@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 30b710840e4b9c9699d3d4b33fb19ad8880d4614 ]

Since the gt powerstate is allocated by i915_gem_init, clean it from
i915_gem_fini for symmetry and to correct the imbalance on error.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180812223642.24865-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_gem.c      | 3 +++
 drivers/gpu/drm/i915/intel_display.c | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 5019dfd8bcf16..e81abd468a15d 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -5624,6 +5624,7 @@ err_uc_misc:
 void i915_gem_fini(struct drm_i915_private *dev_priv)
 {
 	i915_gem_suspend_late(dev_priv);
+	intel_disable_gt_powersave(dev_priv);
 
 	/* Flush any outstanding unpin_work. */
 	i915_gem_drain_workqueue(dev_priv);
@@ -5635,6 +5636,8 @@ void i915_gem_fini(struct drm_i915_private *dev_priv)
 	i915_gem_contexts_fini(dev_priv);
 	mutex_unlock(&dev_priv->drm.struct_mutex);
 
+	intel_cleanup_gt_powersave(dev_priv);
+
 	intel_uc_fini_misc(dev_priv);
 	i915_gem_cleanup_userptr(dev_priv);
 
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 2622dfc7d2d9a..6902fd2da19ca 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -15972,8 +15972,6 @@ void intel_modeset_cleanup(struct drm_device *dev)
 	flush_work(&dev_priv->atomic_helper.free_work);
 	WARN_ON(!llist_empty(&dev_priv->atomic_helper.free_list));
 
-	intel_disable_gt_powersave(dev_priv);
-
 	/*
 	 * Interrupts and polling as the first thing to avoid creating havoc.
 	 * Too much stuff here (turning of connectors, ...) would
@@ -16001,8 +15999,6 @@ void intel_modeset_cleanup(struct drm_device *dev)
 
 	intel_cleanup_overlay(dev_priv);
 
-	intel_cleanup_gt_powersave(dev_priv);
-
 	intel_teardown_gmbus(dev_priv);
 
 	destroy_workqueue(dev_priv->modeset_wq);
-- 
2.20.1



