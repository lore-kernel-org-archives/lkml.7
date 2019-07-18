Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C90C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83A321873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbfGRBpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:45:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731476AbfGRBpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 060C8A7F8;
        Thu, 18 Jul 2019 01:45:40 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF79C19C67;
        Thu, 18 Jul 2019 01:45:37 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 25/26] drm/dp_mst: Also print unhashed pointers for malloc/topology references
Date:   Wed, 17 Jul 2019 21:42:48 -0400
Message-Id: <20190718014329.8107-26-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 18 Jul 2019 01:45:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we only print mstb/port pointer addresses in our malloc and
topology refcount functions using the hashed-by-default %p, but
unfortunately if you're trying to debug a use-after-free error caused by
a refcounting error then this really isn't terribly useful. On the other
hand though, everything in the rest of the DP MST helpers uses hashed
pointer values as well and probably isn't useful to convert to unhashed.
So, let's just get the best of both worlds and print both the hashed and
unhashed pointer in our malloc/topology refcount debugging output. This
will hopefully make it a lot easier to figure out which port/mstb is
causing KASAN to get upset.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 34 ++++++++++++++++-----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 320158970e25..fcd3f98cbc34 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1325,7 +1325,8 @@ static void
 drm_dp_mst_get_mstb_malloc(struct drm_dp_mst_branch *mstb)
 {
 	kref_get(&mstb->malloc_kref);
-	DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->malloc_kref));
+	DRM_DEBUG("mstb %p/%px (%d)\n",
+		  mstb, mstb, kref_read(&mstb->malloc_kref));
 }
 
 /**
@@ -1342,7 +1343,8 @@ drm_dp_mst_get_mstb_malloc(struct drm_dp_mst_branch *mstb)
 static void
 drm_dp_mst_put_mstb_malloc(struct drm_dp_mst_branch *mstb)
 {
-	DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->malloc_kref) - 1);
+	DRM_DEBUG("mstb %p/%px (%d)\n",
+		  mstb, mstb, kref_read(&mstb->malloc_kref) - 1);
 	kref_put(&mstb->malloc_kref, drm_dp_free_mst_branch_device);
 }
 
@@ -1377,7 +1379,8 @@ void
 drm_dp_mst_get_port_malloc(struct drm_dp_mst_port *port)
 {
 	kref_get(&port->malloc_kref);
-	DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->malloc_kref));
+	DRM_DEBUG("port %p/%px (%d)\n",
+		  port, port, kref_read(&port->malloc_kref));
 }
 EXPORT_SYMBOL(drm_dp_mst_get_port_malloc);
 
@@ -1394,7 +1397,8 @@ EXPORT_SYMBOL(drm_dp_mst_get_port_malloc);
 void
 drm_dp_mst_put_port_malloc(struct drm_dp_mst_port *port)
 {
-	DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->malloc_kref) - 1);
+	DRM_DEBUG("port %p/%px (%d)\n",
+		  port, port, kref_read(&port->malloc_kref) - 1);
 	kref_put(&port->malloc_kref, drm_dp_free_mst_port);
 }
 EXPORT_SYMBOL(drm_dp_mst_put_port_malloc);
@@ -1445,8 +1449,8 @@ drm_dp_mst_topology_try_get_mstb(struct drm_dp_mst_branch *mstb)
 	int ret = kref_get_unless_zero(&mstb->topology_kref);
 
 	if (ret)
-		DRM_DEBUG("mstb %p (%d)\n", mstb,
-			  kref_read(&mstb->topology_kref));
+		DRM_DEBUG("mstb %p/%px (%d)\n",
+			  mstb, mstb, kref_read(&mstb->topology_kref));
 
 	return ret;
 }
@@ -1469,7 +1473,8 @@ static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
 {
 	WARN_ON(kref_read(&mstb->topology_kref) == 0);
 	kref_get(&mstb->topology_kref);
-	DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->topology_kref));
+	DRM_DEBUG("mstb %p/%px (%d)\n",
+		  mstb, mstb, kref_read(&mstb->topology_kref));
 }
 
 /**
@@ -1487,8 +1492,8 @@ static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
 static void
 drm_dp_mst_topology_put_mstb(struct drm_dp_mst_branch *mstb)
 {
-	DRM_DEBUG("mstb %p (%d)\n",
-		  mstb, kref_read(&mstb->topology_kref) - 1);
+	DRM_DEBUG("mstb %p/%px (%d)\n",
+		  mstb, mstb, kref_read(&mstb->topology_kref) - 1);
 	kref_put(&mstb->topology_kref, drm_dp_destroy_mst_branch_device);
 }
 
@@ -1544,8 +1549,8 @@ drm_dp_mst_topology_try_get_port(struct drm_dp_mst_port *port)
 	int ret = kref_get_unless_zero(&port->topology_kref);
 
 	if (ret)
-		DRM_DEBUG("port %p (%d)\n", port,
-			  kref_read(&port->topology_kref));
+		DRM_DEBUG("port %p/%px (%d)\n",
+			  port, port, kref_read(&port->topology_kref));
 
 	return ret;
 }
@@ -1567,7 +1572,8 @@ static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
 {
 	WARN_ON(kref_read(&port->topology_kref) == 0);
 	kref_get(&port->topology_kref);
-	DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->topology_kref));
+	DRM_DEBUG("port %p/%px (%d)\n",
+		  port, port, kref_read(&port->topology_kref));
 }
 
 /**
@@ -1583,8 +1589,8 @@ static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
  */
 static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
 {
-	DRM_DEBUG("port %p (%d)\n",
-		  port, kref_read(&port->topology_kref) - 1);
+	DRM_DEBUG("port %p/%px (%d)\n",
+		  port, port, kref_read(&port->topology_kref) - 1);
 	kref_put(&port->topology_kref, drm_dp_destroy_port);
 }
 
-- 
2.21.0

