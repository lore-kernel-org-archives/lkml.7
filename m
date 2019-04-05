Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E43A21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfDEH1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:27:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:29088 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfDEH1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:27:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 00:27:06 -0700
X-IronPort-AV: E=Sophos;i="5.60,310,1549958400"; 
   d="scan'208";a="131667186"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 00:27:03 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        michal.wajdeczko@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@intel.com>
Subject: [PATCH] drm/i915: Use drm_dev_unplug()
Date:   Fri,  5 Apr 2019 09:26:57 +0200
Message-Id: <20190405072657.9997-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janusz Krzysztofik <janusz.krzysztofik@intel.com>

The driver does not currently support unbinding from a device which is
in use.  Since open file descriptors may still be pointing into kernel
memory where the device structures used to be, entirely correct kernel
panics protect the driver from being unbound as we should not be
unbinding it before those dangling pointers have been made safe.

According to the documentation found inside drivers/gpu/drm/drm_drv.c,
drm_dev_unplug() should be used instead of drm_dev_unregister() in
order to make a device inaccessible to users as soon as it is unpluged.
Follow that advice to make those possibly dangling pointers safe,
protected by DRM layer from a user who is otherwise left pointing into
possibly reused kernel memory after the driver has been unbound from
the device.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 9df65d386d11..66163378c481 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -1596,7 +1596,7 @@ static void i915_driver_unregister(struct drm_i915_private *dev_priv)
 	i915_pmu_unregister(dev_priv);
 
 	i915_teardown_sysfs(dev_priv);
-	drm_dev_unregister(&dev_priv->drm);
+	drm_dev_unplug(&dev_priv->drm);
 
 	i915_gem_shrinker_unregister(dev_priv);
 }
-- 
2.20.1

