Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0ECC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3572720661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfCFUGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:06:31 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:50485 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfCFUGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:06:30 -0500
Received: from [167.98.27.226] (helo=ct-lt-1124)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h1cnz-0005BV-W3; Wed, 06 Mar 2019 20:06:20 +0000
Received: from tpreston by ct-lt-1124 with local (Exim 4.89)
        (envelope-from <tpreston@ct-lt-1124>)
        id 1h1cnz-0004XR-98; Wed, 06 Mar 2019 20:06:19 +0000
From:   Thomas Preston <thomas.preston@codethink.co.uk>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Preston <thomas.preston@codethink.co.uk>
Subject: [PATCH] drm/i915/ddi: Fix default eDP detection on port A
Date:   Wed,  6 Mar 2019 20:06:18 +0000
Message-Id: <20190306200618.17405-1-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We rely on VBT DDI port info for eDP detection on GEN9 platforms and
above. This breaks GEN9 platforms which don't have VBT because port A
eDP now defaults to false. Fix this by defaulting to true when VBT is
missing.

Fixes: commit a98d9c1d7e9b ("drm/i915/ddi: Rely on VBT DDI port info for eDP detection")
Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
---
 drivers/gpu/drm/i915/intel_bios.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/intel_bios.c b/drivers/gpu/drm/i915/intel_bios.c
index 1faa494e2bc9..efbbfb64b55f 100644
--- a/drivers/gpu/drm/i915/intel_bios.c
+++ b/drivers/gpu/drm/i915/intel_bios.c
@@ -1629,6 +1629,7 @@ init_vbt_missing_defaults(struct drm_i915_private *dev_priv)
 		info->supports_dvi = (port != PORT_A && port != PORT_E);
 		info->supports_hdmi = info->supports_dvi;
 		info->supports_dp = (port != PORT_E);
+		info->supports_edp = (port == PORT_A);
 	}
 }
 
-- 
2.11.0

