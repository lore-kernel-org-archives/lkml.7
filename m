Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD7CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6407321872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfDENC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:02:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:19432 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDENC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:02:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 06:02:58 -0700
X-IronPort-AV: E=Sophos;i="5.60,312,1549958400"; 
   d="scan'208";a="148330402"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 06:02:55 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        michal.wajdeczko@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH 2/2] drm/i915: Mark GEM wedged right after marking device unplugged
Date:   Fri,  5 Apr 2019 15:02:35 +0200
Message-Id: <20190405130235.7707-3-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405130235.7707-1-janusz.krzysztofik@linux.intel.com>
References: <20190405130235.7707-1-janusz.krzysztofik@linux.intel.com>
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

Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
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

