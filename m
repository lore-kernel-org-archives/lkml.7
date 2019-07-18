Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DCEC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A007D2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbfGRBtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:49:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbfGRBtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:49:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DE8F8E225;
        Thu, 18 Jul 2019 01:49:14 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DDFB5D71A;
        Thu, 18 Jul 2019 01:49:10 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/dm: Remove unneeded hotplug event in s3_handle_mst()
Date:   Wed, 17 Jul 2019 21:48:56 -0400
Message-Id: <20190718014858.9257-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 18 Jul 2019 01:49:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM DP MST topology manager will send it's own hotplug events when
connectors are destroyed, so there's no reason to send an additional
hotplug event here.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0242d693f4f6..156eeacee2ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -812,7 +812,6 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 	struct drm_connector *connector;
 	struct drm_dp_mst_topology_mgr *mgr;
 	int ret;
-	bool need_hotplug = false;
 
 	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
 
@@ -831,15 +830,15 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 			ret = drm_dp_mst_topology_mgr_resume(mgr);
 			if (ret < 0) {
 				drm_dp_mst_topology_mgr_set_mst(mgr, false);
-				need_hotplug = true;
+				mutex_lock(&aconnector->hpd_lock);
+				aconnector->dc_link->type =
+					dc_connection_single;
+				mutex_unlock(&aconnector->hpd_lock);
 			}
 		}
 	}
 
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-
-	if (need_hotplug)
-		drm_kms_helper_hotplug_event(dev);
 }
 
 /**
-- 
2.21.0

