Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC40C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D102085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgACBMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:12:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgACBMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:12:07 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A3DD5D5EFD30BBB68550;
        Fri,  3 Jan 2020 09:12:06 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 Jan 2020 09:12:01 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] drm/i915: use true,false for bool variable in intel_crt.c
Date:   Fri, 3 Jan 2020 09:12:39 +0800
Message-ID: <1578013959-31486-4-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1578013959-31486-1-git-send-email-mafeng.ma@huawei.com>
References: <1578013959-31486-1-git-send-email-mafeng.ma@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/i915/display/intel_crt.c:1066:1-28: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/i915/display/intel_crt.c:928:2-29: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/i915/display/intel_crt.c:443:2-29: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/gpu/drm/i915/display/intel_crt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crt.c b/drivers/gpu/drm/i915/display/intel_crt.c
index b2b1336..8596eef 100644
--- a/drivers/gpu/drm/i915/display/intel_crt.c
+++ b/drivers/gpu/drm/i915/display/intel_crt.c
@@ -440,7 +440,7 @@ static bool intel_ironlake_crt_detect_hotplug(struct drm_connector *connector)
 		bool turn_off_dac = HAS_PCH_SPLIT(dev_priv);
 		u32 save_adpa;

-		crt->force_hotplug_required = 0;
+		crt->force_hotplug_required = false;

 		save_adpa = adpa = I915_READ(crt->adpa_reg);
 		DRM_DEBUG_KMS("trigger hotplug detect cycle: adpa=0x%x\n", adpa);
@@ -925,7 +925,7 @@ void intel_crt_reset(struct drm_encoder *encoder)
 		POSTING_READ(crt->adpa_reg);

 		DRM_DEBUG_KMS("crt adpa set to 0x%x\n", adpa);
-		crt->force_hotplug_required = 1;
+		crt->force_hotplug_required = true;
 	}

 }
@@ -1063,7 +1063,7 @@ void intel_crt_init(struct drm_i915_private *dev_priv)
 	/*
 	 * Configure the automatic hotplug detection stuff
 	 */
-	crt->force_hotplug_required = 0;
+	crt->force_hotplug_required = false;

 	/*
 	 * TODO: find a proper way to discover whether we need to set the the
--
2.6.2

