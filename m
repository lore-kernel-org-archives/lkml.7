Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66005C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379222339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528714;
	bh=GThmCo6ekjQevRbJ4RJw3Jp6UbfDong1DpDA0cRpd8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YZPIa/0rkGlPLI2ayiBSn5uTF6ePhcA0CJjjIHaVzr8TH7Nbea9t6VUBg8ye/Yux7
	 GHdvrK97ys1QyAM+J1PVE3pkCii0pjZ9uVuiCrVS/uttaXQ84Ep1DpRKtMRBvS5Z50
	 I1fs+MBKSHjlrfU95r/Rl6feVeO//z+/Yza++KK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbfICQid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbfICQ0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:26:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12DD6238CF;
        Tue,  3 Sep 2019 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567527977;
        bh=GThmCo6ekjQevRbJ4RJw3Jp6UbfDong1DpDA0cRpd8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtAAf3YEay/D6BY+jBcM1HgxMVEKM/Zj0c3biXkXaPJAVTsiLk5zO8R6GRxDnYM9K
         7A9NAsA1v7xfAzgwY9C+lfukwc9uDFZK1rCDzgOnoOsCnTulAJyu5cvyNz7kKTAUSb
         Zivb9i1tq3yjTY7V4dyRd4tmYst/VgW5qDlhfuuA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 033/167] drm/i915: Restore sane defaults for KMS on GEM error load
Date:   Tue,  3 Sep 2019 12:23:05 -0400
Message-Id: <20190903162519.7136-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

[ Upstream commit 7ed43df720c007d60bee6d81da07bcdc7e4a55ae ]

If we fail during GEM initialisation, we scrub the HW state by
performing a device level GPU resuet. However, we want to leave the
system in a usable state (with functioning KMS but no GEM) so after
scrubbing the HW state, we need to restore some sane defaults and
re-enable the low-level common parts of the GPU (such as the GMCH).

v2: Restore GTT entries.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20180726085033.4044-2-chris@chris-wilson.co.uk
Reviewed-by: Michał Winiarski <michal.winiarski@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_gem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 03cda197fb6b8..5019dfd8bcf16 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -5595,6 +5595,8 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
 		i915_gem_cleanup_userptr(dev_priv);
 
 	if (ret == -EIO) {
+		mutex_lock(&dev_priv->drm.struct_mutex);
+
 		/*
 		 * Allow engine initialisation to fail by marking the GPU as
 		 * wedged. But we only want to do this where the GPU is angry,
@@ -5605,7 +5607,14 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
 					"Failed to initialize GPU, declaring it wedged!\n");
 			i915_gem_set_wedged(dev_priv);
 		}
-		ret = 0;
+
+		/* Minimal basic recovery for KMS */
+		ret = i915_ggtt_enable_hw(dev_priv);
+		i915_gem_restore_gtt_mappings(dev_priv);
+		i915_gem_restore_fences(dev_priv);
+		intel_init_clock_gating(dev_priv);
+
+		mutex_unlock(&dev_priv->drm.struct_mutex);
 	}
 
 	i915_gem_drain_freed_objects(dev_priv);
-- 
2.20.1

