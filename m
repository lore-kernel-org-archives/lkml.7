Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484CE21871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbfDELkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:40:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:50237 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfDELkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:40:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 04:40:51 -0700
X-IronPort-AV: E=Sophos;i="5.60,312,1549958400"; 
   d="scan'208";a="133226859"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 04:40:48 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        michal.wajdeczko@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH] drm/i915: Mark GEM wedged right after marking device unplugged
Date:   Fri,  5 Apr 2019 13:40:32 +0200
Message-Id: <20190405114032.5725-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As soon as a device is considered unplugged, not only prevent pending
users from accessing the device structures but also cancel all their
pending requests so all consumed resources can be cleaned up as soon
as possible.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
---
 drivers/gpu/drm/i915/i915_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 66163378c481..03a563ce7e6b 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -1598,6 +1598,13 @@ static void i915_driver_unregister(struct drm_i915_private *dev_priv)
 	i915_teardown_sysfs(dev_priv);
 	drm_dev_unplug(&dev_priv->drm);
 
+	/*
+	 * After unregistering the device to prevent any new users, cancel
+	 * all in-flight requests so that we can quickly unbind the active
+	 * resources.
+	 */
+	i915_gem_set_wedged(dev_priv);
+
 	i915_gem_shrinker_unregister(dev_priv);
 }
 
-- 
2.20.1

