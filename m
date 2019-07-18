Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C229EC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D042189F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbfGRBpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:45:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389259AbfGRBo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 954743082A9C;
        Thu, 18 Jul 2019 01:44:55 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7236E19C67;
        Thu, 18 Jul 2019 01:44:54 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/26] drm/nouveau: Don't grab runtime PM refs for HPD IRQs
Date:   Wed, 17 Jul 2019 21:42:44 -0400
Message-Id: <20190718014329.8107-22-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 18 Jul 2019 01:44:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for suspend/resume reprobing to work, we need to be able to
perform sideband communications during suspend/resume, along with
runtime PM suspend/resume. In order to do so, we also need to make sure
that nouveau doesn't bother grabbing a runtime PM reference to do so,
since otherwise we'll start deadlocking runtime PM again.

Note that we weren't able to do this before, because of the DP MST
helpers processing UP requests from topologies in the same context as
drm_dp_mst_hpd_irq() which would have caused us to open ourselves up to
receiving hotplug events and deadlocking with runtime suspend/resume.
Now that those requests are handled asynchronously, this change should
be completely safe.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 33 +++++++++++----------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 4116ee62adaf..e9e78696a728 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1129,6 +1129,16 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
 	const char *name = connector->name;
 	struct nouveau_encoder *nv_encoder;
 	int ret;
+	bool plugged = (rep->mask != NVIF_NOTIFY_CONN_V0_UNPLUG);
+
+	if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
+		NV_DEBUG(drm, "service %s\n", name);
+		drm_dp_cec_irq(&nv_connector->aux);
+		if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP)))
+			nv50_mstm_service(nv_encoder->dp.mstm);
+
+		return NVIF_NOTIFY_KEEP;
+	}
 
 	ret = pm_runtime_get(drm->dev->dev);
 	if (ret == 0) {
@@ -1149,25 +1159,16 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
 		return NVIF_NOTIFY_DROP;
 	}
 
-	if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
-		NV_DEBUG(drm, "service %s\n", name);
-		drm_dp_cec_irq(&nv_connector->aux);
-		if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP)))
-			nv50_mstm_service(nv_encoder->dp.mstm);
-	} else {
-		bool plugged = (rep->mask != NVIF_NOTIFY_CONN_V0_UNPLUG);
-
+	if (!plugged)
+		drm_dp_cec_unset_edid(&nv_connector->aux);
+	NV_DEBUG(drm, "%splugged %s\n", plugged ? "" : "un", name);
+	if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP))) {
 		if (!plugged)
-			drm_dp_cec_unset_edid(&nv_connector->aux);
-		NV_DEBUG(drm, "%splugged %s\n", plugged ? "" : "un", name);
-		if ((nv_encoder = find_encoder(connector, DCB_OUTPUT_DP))) {
-			if (!plugged)
-				nv50_mstm_remove(nv_encoder->dp.mstm);
-		}
-
-		drm_helper_hpd_irq_event(connector->dev);
+			nv50_mstm_remove(nv_encoder->dp.mstm);
 	}
 
+	drm_helper_hpd_irq_event(connector->dev);
+
 	pm_runtime_mark_last_busy(drm->dev->dev);
 	pm_runtime_put_autosuspend(drm->dev->dev);
 	return NVIF_NOTIFY_KEEP;
-- 
2.21.0

