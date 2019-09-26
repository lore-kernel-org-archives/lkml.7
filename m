Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C19BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221EE207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfIZWwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:52:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfIZWwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:52:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1409A30832C0;
        Thu, 26 Sep 2019 22:52:00 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE1E6600C1;
        Thu, 26 Sep 2019 22:51:58 +0000 (UTC)
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
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Thomas Lim <Thomas.Lim@amd.com>,
        David Francis <David.Francis@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] drm/amdgpu/dm/mst: Remove unnecessary NULL check
Date:   Thu, 26 Sep 2019 18:51:04 -0400
Message-Id: <20190926225122.31455-3-lyude@redhat.com>
In-Reply-To: <20190926225122.31455-1-lyude@redhat.com>
References: <20190926225122.31455-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 26 Sep 2019 22:52:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree() checks this automatically.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 185bf0e2bda2..a398ddd1f306 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -144,10 +144,8 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_encoder *amdgpu_encoder = amdgpu_dm_connector->mst_encoder;
 
-	if (amdgpu_dm_connector->edid) {
-		kfree(amdgpu_dm_connector->edid);
-		amdgpu_dm_connector->edid = NULL;
-	}
+	kfree(amdgpu_dm_connector->edid);
+	amdgpu_dm_connector->edid = NULL;
 
 	drm_encoder_cleanup(&amdgpu_encoder->base);
 	kfree(amdgpu_encoder);
-- 
2.21.0

