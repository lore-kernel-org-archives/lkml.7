Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BDACA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A8020882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cp9Ete2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfJVCj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:39:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59284 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729573AbfJVCj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571711966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKy6W32x2qP1eZ4WJP4J8ASTecONLiBU0JVgq0FS4mI=;
        b=cp9Ete2n4bCs6X9+5kLHX6r8/ht4voYkWffpDdgg9kMnmA2hvA0Bux/+wUpJChJrc6bgBu
        /aBjNd9osoCQVcdiqH08xWrQc2suAwmIDwPG1p12wKegNv6qqqjHRqEQ+a0KA7/8wwCrh/
        h5t07O/H5FktA29q8H5j86Bf57QtV9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-B2tmot1FNk2gcBMnSqETHQ-1; Mon, 21 Oct 2019 22:39:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B4B1476;
        Tue, 22 Oct 2019 02:39:21 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BAE760126;
        Tue, 22 Oct 2019 02:39:19 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/14] drm/dp_mst: Remove PDT teardown in drm_dp_destroy_port() and refactor
Date:   Mon, 21 Oct 2019 22:35:57 -0400
Message-Id: <20191022023641.8026-3-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: B2tmot1FNk2gcBMnSqETHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow us to add some locking for port->* members, in
particular the PDT and ->connector, which can't be done from
drm_dp_destroy_port() since we don't know what locks the caller might be
holding.

Note that we already do this in delayed_destroy_work (renamed from
destroy_connector_work in this patch) for ports, we're just making it so
mstbs are also destroyed in this worker.

Changes since v2:
* Clarify commit message
Changes since v4:
* Clarify commit message more

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 40 +++++++++++----------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index 66ff226d8c86..204d0c832c65 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1510,31 +1510,22 @@ static void drm_dp_destroy_port(struct kref *kref)
 =09=09container_of(kref, struct drm_dp_mst_port, topology_kref);
 =09struct drm_dp_mst_topology_mgr *mgr =3D port->mgr;
=20
-=09if (!port->input) {
-=09=09kfree(port->cached_edid);
+=09/* There's nothing that needs locking to destroy an input port yet */
+=09if (port->input) {
+=09=09drm_dp_mst_put_port_malloc(port);
+=09=09return;
+=09}
=20
-=09=09/*
-=09=09 * The only time we don't have a connector
-=09=09 * on an output port is if the connector init
-=09=09 * fails.
-=09=09 */
-=09=09if (port->connector) {
-=09=09=09/* we can't destroy the connector here, as
-=09=09=09 * we might be holding the mode_config.mutex
-=09=09=09 * from an EDID retrieval */
+=09kfree(port->cached_edid);
=20
-=09=09=09mutex_lock(&mgr->delayed_destroy_lock);
-=09=09=09list_add(&port->next, &mgr->destroy_port_list);
-=09=09=09mutex_unlock(&mgr->delayed_destroy_lock);
-=09=09=09schedule_work(&mgr->delayed_destroy_work);
-=09=09=09return;
-=09=09}
-=09=09/* no need to clean up vcpi
-=09=09 * as if we have no connector we never setup a vcpi */
-=09=09drm_dp_port_teardown_pdt(port, port->pdt);
-=09=09port->pdt =3D DP_PEER_DEVICE_NONE;
-=09}
-=09drm_dp_mst_put_port_malloc(port);
+=09/*
+=09 * we can't destroy the connector here, as we might be holding the
+=09 * mode_config.mutex from an EDID retrieval
+=09 */
+=09mutex_lock(&mgr->delayed_destroy_lock);
+=09list_add(&port->next, &mgr->destroy_port_list);
+=09mutex_unlock(&mgr->delayed_destroy_lock);
+=09schedule_work(&mgr->delayed_destroy_work);
 }
=20
 /**
@@ -3981,7 +3972,8 @@ static void drm_dp_tx_work(struct work_struct *work)
 static inline void
 drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
 {
-=09port->mgr->cbs->destroy_connector(port->mgr, port->connector);
+=09if (port->connector)
+=09=09port->mgr->cbs->destroy_connector(port->mgr, port->connector);
=20
 =09drm_dp_port_teardown_pdt(port, port->pdt);
 =09port->pdt =3D DP_PEER_DEVICE_NONE;
--=20
2.21.0

