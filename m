Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D12EC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341CC2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfDEN2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:28:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:27646 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDEN2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:28:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 06:28:15 -0700
X-IronPort-AV: E=Sophos;i="5.60,312,1549958400"; 
   d="scan'208";a="220877453"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 06:28:12 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        michal.wajdeczko@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
Subject: [PATCH v2] drm/i915: Don't panic on non-empty list of free cachelines
Date:   Fri,  5 Apr 2019 15:28:06 +0200
Message-Id: <20190405132806.8508-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>

If there are active users of a device during driver unbind, the driver
now panics on non-empty list of free cachelines.

By design, cachelines which are not in use are kept on a list of free
cachelines associated with a timeline and removed from that list either
when in use or when the timeline is destroyed.  Timelines in turn are
assigned to open file descriptors.

As long as a device file is open, its associated timeline with its list
of free cachelines will be hopefully destroyed on device close, either
while outstanding execlists are destroyed or on i915_timeline_put()
called directly, so as long as device file descriptors are protected
from unwanted user activities by the device being marked unplugged,
there should be no reason to panic.

Moreover, timeline mutex which is destroyed right after the check for
emptyness of a free cacheline list succeeds is never used to protect
that list, only a list of active cachelines, so it can be freely
destroyed even if the former is not empty.

Since the desired behavior is to clean up active contexts first,
unpinning the contexts and resources, and so letting the timeline be
freed, the panic is there to say that i915_timelines_fini() is
called to early.  Don't remove the check completely then but convert it
from the BUG() to a WARN() so the indication a long term fix is needed
is still given.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
---
 drivers/gpu/drm/i915/i915_timeline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_timeline.c b/drivers/gpu/drm/i915/i915_timeline.c
index b2202d2e58a2..965fd3052b25 100644
--- a/drivers/gpu/drm/i915/i915_timeline.c
+++ b/drivers/gpu/drm/i915/i915_timeline.c
@@ -325,7 +325,7 @@ void i915_timelines_fini(struct drm_i915_private *i915)
 	struct i915_gt_timelines *gt = &i915->gt.timelines;
 
 	GEM_BUG_ON(!list_empty(&gt->active_list));
-	GEM_BUG_ON(!list_empty(&gt->hwsp_free_list));
+	GEM_WARN_ON(!list_empty(&gt->hwsp_free_list));
 
 	mutex_destroy(&gt->mutex);
 }
-- 
2.20.1

