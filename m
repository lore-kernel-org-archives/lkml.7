Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA07EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90A4207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfIZWwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbfIZWwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:52:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE359300603C;
        Thu, 26 Sep 2019 22:52:02 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97851600C1;
        Thu, 26 Sep 2019 22:52:01 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Thomas Lim <Thomas.Lim@amd.com>,
        David Francis <David.Francis@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] drm/amdgpu/dm/mst: Use ->atomic_best_encoder
Date:   Thu, 26 Sep 2019 18:51:05 -0400
Message-Id: <20190926225122.31455-4-lyude@redhat.com>
In-Reply-To: <20190926225122.31455-1-lyude@redhat.com>
References: <20190926225122.31455-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 26 Sep 2019 22:52:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are supposed to be atomic after all. We'll need this in a moment for
the next commit.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a398ddd1f306..d9113ce0be09 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -243,17 +243,17 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static struct drm_encoder *dm_mst_best_encoder(struct drm_connector *connector)
+static struct drm_encoder *
+dm_mst_atomic_best_encoder(struct drm_connector *connector,
+			   struct drm_connector_state *connector_state)
 {
-	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
-
-	return &amdgpu_dm_connector->mst_encoder->base;
+	return &to_amdgpu_dm_connector(connector)->mst_encoder->base;
 }
 
 static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_funcs = {
 	.get_modes = dm_dp_mst_get_modes,
 	.mode_valid = amdgpu_dm_connector_mode_valid,
-	.best_encoder = dm_mst_best_encoder,
+	.atomic_best_encoder = dm_mst_atomic_best_encoder,
 };
 
 static void amdgpu_dm_encoder_destroy(struct drm_encoder *encoder)
-- 
2.21.0

