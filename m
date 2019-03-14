Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8623BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513B021855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SgaoRlSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfCNNoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:44:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34392 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfCNNox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:44:53 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2EDik1L009838;
        Thu, 14 Mar 2019 08:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552571086;
        bh=mUnbh4cPAtTsD1O1YT5v3Y07KP02RW4u1UVzxYXvt1U=;
        h=From:To:CC:Subject:Date;
        b=SgaoRlSm7pEUkP9iJOFA8EsZW4a33UVoDcz30EenILlzYOKZNizYcmJvxoaF5mQYU
         6sGeygo/e6vPAm1RQ7pK28dUlcRgVPwJA3VI02iWfW4BEaNheabz1b+hwM9XLtaZGK
         pQtXFJ4XgFQ1H6uQ8jDcxXU/PrkN3IXO/Wy2G9zw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2EDikKa054960
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 08:44:46 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 14
 Mar 2019 08:44:46 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Mar 2019 08:44:46 -0500
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2EDikjX014165;
        Thu, 14 Mar 2019 08:44:46 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
        <dri-devel@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch 1/1] drm/atomic: integrate private objects with suspend/resume helpers
Date:   Thu, 14 Mar 2019 08:44:45 -0500
Message-ID: <20190314134445.19260-1-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a suspend cycle the atomic state is saved to be used during the
restore cycle.

However the current state duplication logic does not duplicate private
objects. This leads to state inconsistencies at resume time.

With private objects modeset lock now integrated, we can make sure that
private object state are properly saved and restored.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 540a77a2ade9..b108021cc092 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3189,6 +3189,7 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
 	struct drm_connector_list_iter conn_iter;
 	struct drm_plane *plane;
 	struct drm_crtc *crtc;
+	struct drm_private_obj *privobj;
 	int err = 0;
 
 	state = drm_atomic_state_alloc(dev);
@@ -3218,6 +3219,16 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
 		}
 	}
 
+	drm_for_each_privobj(privobj, dev) {
+		struct drm_private_state *priv_state;
+
+		priv_state = drm_atomic_get_private_obj_state(state, privobj);
+		if (IS_ERR(priv_state)) {
+			err = PTR_ERR(priv_state);
+			goto free;
+		}
+	}
+
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	drm_for_each_connector_iter(conn, &conn_iter) {
 		struct drm_connector_state *conn_state;
@@ -3325,12 +3336,17 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
 	struct drm_connector_state *new_conn_state;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state;
+	struct drm_private_obj *privobj;
+	struct drm_private_state *new_priv_state;
 
 	state->acquire_ctx = ctx;
 
 	for_each_new_plane_in_state(state, plane, new_plane_state, i)
 		state->planes[i].old_state = plane->state;
 
+	for_each_new_private_obj_in_state(state, privobj, new_priv_state, i)
+		state->private_objs[i].old_state = privobj->state;
+
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
 		state->crtcs[i].old_state = crtc->state;
 
-- 
2.17.1

