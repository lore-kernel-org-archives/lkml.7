Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E454EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA3C20873
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 14:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfEQOHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 10:07:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:16470 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbfEQOHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 10:07:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 07:06:45 -0700
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 07:06:42 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
Subject: [RFC PATCH] drm/i915: Tolerate file owned GEM contexts on hot unbind
Date:   Fri, 17 May 2019 16:06:17 +0200
Message-Id: <20190517140617.31187-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>

During i915_driver_unload(), GEM contexts are verified restrictively
inside i915_gem_fini() if they don't consume shared resources which
should be cleaned up before the driver is released.  If those checks
don't result in kernel panic, one more check is performed at the end of
i915_gem_fini() which issues a WARN_ON() if GEM contexts still exist.

Some GEM contexts are allocated unconditionally on device file open,
one per each file descriptor, and are kept open until those file
descriptors are closed.  Since open file descriptors prevent the driver
module from being unloaded, that protects the driver from being
released while contexts are still open.  However, that's not the case
on driver unbind or device unplug sysfs operations which are executed
regardless of open file descriptors.

To protect kernel resources from being accessed by those open file
decriptors while driver unbind or device unplug operation is in
progress, the driver now calls drm_device_unplug() at the beginning of
that process and relies on the DRM layer to provide such protection.

Taking all above information into account, as soon as shared resources
not associated with specific file descriptors are cleaned up, it should
be safe to postpone completion of driver release until users of those
open file decriptors give up on errors and close them.

When device has been marked unplugged, use WARN_ON() conditionally so
the warning is displayed only if a GEM context not associated with a
file descriptor is still allocated.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
---
 drivers/gpu/drm/i915/i915_gem.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 54f27cabae2a..c00b6dbaf4f5 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -4670,7 +4670,17 @@ void i915_gem_fini(struct drm_i915_private *dev_priv)
 
 	i915_gem_drain_freed_objects(dev_priv);
 
-	WARN_ON(!list_empty(&dev_priv->contexts.list));
+	if (drm_dev_is_unplugged(&dev_priv->drm)) {
+		struct i915_gem_context *ctx, *cn;
+
+		list_for_each_entry_safe(ctx, cn, &dev_priv->contexts.list,
+					 link) {
+			WARN_ON(IS_ERR_OR_NULL(ctx->file_priv));
+			break;
+		}
+	} else {
+		WARN_ON(!list_empty(&dev_priv->contexts.list));
+	}
 }
 
 void i915_gem_init_mmio(struct drm_i915_private *i915)
-- 
2.21.0

