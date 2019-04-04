Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F71C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B88720882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfDDKYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:24:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:14871 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfDDKYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:24:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 03:24:53 -0700
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="131386438"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 03:24:50 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        michal.wajdeczko@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
Subject: [PATCH] drm/i915: Fix context IDs not released on driver hot unbind
Date:   Thu,  4 Apr 2019 12:24:45 +0200
Message-Id: <20190404102445.12303-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>

In case the driver gets unbound while a device is open, kernel panic
may be forced if a list of allocated context IDs is not empty.

When a device is open, the list may happen to be not empty because a
context ID, once allocated by a context ID allocator to a context
assosiated with that open file descriptor, is released as late as
on device close.

On the other hand, there is a need to release all allocated context IDs
and destroy the context ID allocator on driver unbind, even if a device
is open, in order to free memory resources consumed and prevent from
memory leaks.  The purpose of the forced kernel panic was to protect
the context ID allocator from being silently destroyed if not all
allocated IDs had been released.

Before forcing the kernel panic on non-empty list of allocated context
IDs, do that unlikely on non-empty list of contexts that should be
freed by preceding drain of work queue (there must be another bug if
that list happens to be not empty).  If empty, we may assume that
remaining contexts are idle (not pinned) and their IDs can be safely
released.

Once done, release context IDs of each of those remaining contexts
unless it happens a context is unlikely pinned.  Force kernel panic in
that case, there must be still another bug in the driver code.

Now the kernel panic protecting the allocator should not pop up as the
list it checks should be empty.  If it unlikely happens to be not
empty, there must be still another bug.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
---
 drivers/gpu/drm/i915/i915_gem_context.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_gem_context.c b/drivers/gpu/drm/i915/i915_gem_context.c
index 280813a4bf82..18d004d94e43 100644
--- a/drivers/gpu/drm/i915/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/i915_gem_context.c
@@ -611,6 +611,8 @@ void i915_gem_contexts_lost(struct drm_i915_private *dev_priv)
 
 void i915_gem_contexts_fini(struct drm_i915_private *i915)
 {
+	struct i915_gem_context *ctx, *cn;
+
 	lockdep_assert_held(&i915->drm.struct_mutex);
 
 	if (i915->preempt_context)
@@ -618,6 +620,14 @@ void i915_gem_contexts_fini(struct drm_i915_private *i915)
 	destroy_kernel_context(&i915->kernel_context);
 
 	/* Must free all deferred contexts (via flush_workqueue) first */
+	GEM_BUG_ON(!llist_empty(&i915->contexts.free_list));
+
+	/* Release all remaining HW IDs before ID allocator is destroyed */
+	list_for_each_entry_safe(ctx, cn, &i915->contexts.hw_id_list,
+				 hw_id_link) {
+		GEM_BUG_ON(atomic_read(&ctx->hw_id_pin_count));
+		release_hw_id(ctx);
+	}
 	GEM_BUG_ON(!list_empty(&i915->contexts.hw_id_list));
 	ida_destroy(&i915->contexts.hw_ida);
 }
-- 
2.20.1

