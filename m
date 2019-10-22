Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B37CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9323020882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P42gVO4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfJVCjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:39:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29686 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729573AbfJVCjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571711970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldA+AbIFIpkUtA1uahHeNuAYUSYSp7wzYpnTWoOE15w=;
        b=P42gVO4FrLD3ebQ0fYfiTugYaBi+W3n3q5u/BWj3e9lTVP2vsRpPWzCil9qq3KSM1wCtgz
        2SpQRPK2ItcEgvZTTQuSIuB0s4+fwMuVNWbYcRRh+s1iecZ/FVD7lmRiqiSU3r8mEvvL4Z
        88/RFxdwTJEdrzDGN+0fJx7cDePWgTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-qR7bjEg4PsiI7ovS9UyfFw-1; Mon, 21 Oct 2019 22:39:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4D4980183E;
        Tue, 22 Oct 2019 02:39:25 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5024E60126;
        Tue, 22 Oct 2019 02:39:22 +0000 (UTC)
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
Subject: [PATCH v5 03/14] drm/dp_mst: Refactor pdt setup/teardown, add more locking
Date:   Mon, 21 Oct 2019 22:35:58 -0400
Message-Id: <20191022023641.8026-4-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qR7bjEg4PsiI7ovS9UyfFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're going to be implementing suspend/resume reprobing very soon,
we need to make sure we are extra careful to ensure that our locking
actually protects the topology state where we expect it to. Turns out
this isn't the case with drm_dp_port_setup_pdt() and
drm_dp_port_teardown_pdt(), both of which change port->mstb without
grabbing &mgr->lock.

Additionally, since most callers of these functions are just using it to
teardown the port's previous PDT and setup a new one we can simplify
things a bit and combine drm_dp_port_setup_pdt() and
drm_dp_port_teardown_pdt() into a single function:
drm_dp_port_set_pdt(). This function also handles actually ensuring that
we grab the correct locks when we need to modify port->mstb.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 181 +++++++++++++++-----------
 include/drm/drm_dp_mst_helper.h       |   6 +-
 2 files changed, 110 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index 204d0c832c65..3f16c0cb094b 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1486,24 +1486,6 @@ drm_dp_mst_topology_put_mstb(struct drm_dp_mst_branc=
h *mstb)
 =09kref_put(&mstb->topology_kref, drm_dp_destroy_mst_branch_device);
 }
=20
-static void drm_dp_port_teardown_pdt(struct drm_dp_mst_port *port, int old=
_pdt)
-{
-=09struct drm_dp_mst_branch *mstb;
-
-=09switch (old_pdt) {
-=09case DP_PEER_DEVICE_DP_LEGACY_CONV:
-=09case DP_PEER_DEVICE_SST_SINK:
-=09=09/* remove i2c over sideband */
-=09=09drm_dp_mst_unregister_i2c_bus(&port->aux);
-=09=09break;
-=09case DP_PEER_DEVICE_MST_BRANCHING:
-=09=09mstb =3D port->mstb;
-=09=09port->mstb =3D NULL;
-=09=09drm_dp_mst_topology_put_mstb(mstb);
-=09=09break;
-=09}
-}
-
 static void drm_dp_destroy_port(struct kref *kref)
 {
 =09struct drm_dp_mst_port *port =3D
@@ -1713,38 +1695,79 @@ static u8 drm_dp_calculate_rad(struct drm_dp_mst_po=
rt *port,
 =09return parent_lct + 1;
 }
=20
-/*
- * return sends link address for new mstb
- */
-static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port)
+static int drm_dp_port_set_pdt(struct drm_dp_mst_port *port, u8 new_pdt)
 {
-=09int ret;
-=09u8 rad[6], lct;
-=09bool send_link =3D false;
+=09struct drm_dp_mst_topology_mgr *mgr =3D port->mgr;
+=09struct drm_dp_mst_branch *mstb;
+=09u8 rad[8], lct;
+=09int ret =3D 0;
+
+=09if (port->pdt =3D=3D new_pdt)
+=09=09return 0;
+
+=09/* Teardown the old pdt, if there is one */
+=09switch (port->pdt) {
+=09case DP_PEER_DEVICE_DP_LEGACY_CONV:
+=09case DP_PEER_DEVICE_SST_SINK:
+=09=09/*
+=09=09 * If the new PDT would also have an i2c bus, don't bother
+=09=09 * with reregistering it
+=09=09 */
+=09=09if (new_pdt =3D=3D DP_PEER_DEVICE_DP_LEGACY_CONV ||
+=09=09    new_pdt =3D=3D DP_PEER_DEVICE_SST_SINK) {
+=09=09=09port->pdt =3D new_pdt;
+=09=09=09return 0;
+=09=09}
+
+=09=09/* remove i2c over sideband */
+=09=09drm_dp_mst_unregister_i2c_bus(&port->aux);
+=09=09break;
+=09case DP_PEER_DEVICE_MST_BRANCHING:
+=09=09mutex_lock(&mgr->lock);
+=09=09drm_dp_mst_topology_put_mstb(port->mstb);
+=09=09port->mstb =3D NULL;
+=09=09mutex_unlock(&mgr->lock);
+=09=09break;
+=09}
+
+=09port->pdt =3D new_pdt;
 =09switch (port->pdt) {
 =09case DP_PEER_DEVICE_DP_LEGACY_CONV:
 =09case DP_PEER_DEVICE_SST_SINK:
 =09=09/* add i2c over sideband */
 =09=09ret =3D drm_dp_mst_register_i2c_bus(&port->aux);
 =09=09break;
+
 =09case DP_PEER_DEVICE_MST_BRANCHING:
 =09=09lct =3D drm_dp_calculate_rad(port, rad);
+=09=09mstb =3D drm_dp_add_mst_branch_device(lct, rad);
+=09=09if (!mstb) {
+=09=09=09ret =3D -ENOMEM;
+=09=09=09DRM_ERROR("Failed to create MSTB for port %p", port);
+=09=09=09goto out;
+=09=09}
=20
-=09=09port->mstb =3D drm_dp_add_mst_branch_device(lct, rad);
-=09=09if (port->mstb) {
-=09=09=09port->mstb->mgr =3D port->mgr;
-=09=09=09port->mstb->port_parent =3D port;
-=09=09=09/*
-=09=09=09 * Make sure this port's memory allocation stays
-=09=09=09 * around until its child MSTB releases it
-=09=09=09 */
-=09=09=09drm_dp_mst_get_port_malloc(port);
+=09=09mutex_lock(&mgr->lock);
+=09=09port->mstb =3D mstb;
+=09=09mstb->mgr =3D port->mgr;
+=09=09mstb->port_parent =3D port;
=20
-=09=09=09send_link =3D true;
-=09=09}
+=09=09/*
+=09=09 * Make sure this port's memory allocation stays
+=09=09 * around until its child MSTB releases it
+=09=09 */
+=09=09drm_dp_mst_get_port_malloc(port);
+=09=09mutex_unlock(&mgr->lock);
+
+=09=09/* And make sure we send a link address for this */
+=09=09ret =3D 1;
 =09=09break;
 =09}
-=09return send_link;
+
+out:
+=09if (ret < 0)
+=09=09port->pdt =3D DP_PEER_DEVICE_NONE;
+=09return ret;
 }
=20
 /**
@@ -1881,10 +1904,9 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_ms=
t_branch *mstb,
 =09=09=09=09    struct drm_device *dev,
 =09=09=09=09    struct drm_dp_link_addr_reply_port *port_msg)
 {
+=09struct drm_dp_mst_topology_mgr *mgr =3D mstb->mgr;
 =09struct drm_dp_mst_port *port;
-=09bool ret;
 =09bool created =3D false;
-=09int old_pdt =3D 0;
 =09int old_ddps =3D 0;
=20
 =09port =3D drm_dp_get_port(mstb, port_msg->port_number);
@@ -1896,7 +1918,7 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst=
_branch *mstb,
 =09=09kref_init(&port->malloc_kref);
 =09=09port->parent =3D mstb;
 =09=09port->port_num =3D port_msg->port_number;
-=09=09port->mgr =3D mstb->mgr;
+=09=09port->mgr =3D mgr;
 =09=09port->aux.name =3D "DPMST";
 =09=09port->aux.dev =3D dev->dev;
 =09=09port->aux.is_remote =3D true;
@@ -1909,11 +1931,9 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_ms=
t_branch *mstb,
=20
 =09=09created =3D true;
 =09} else {
-=09=09old_pdt =3D port->pdt;
 =09=09old_ddps =3D port->ddps;
 =09}
=20
-=09port->pdt =3D port_msg->peer_device_type;
 =09port->input =3D port_msg->input_port;
 =09port->mcs =3D port_msg->mcs;
 =09port->ddps =3D port_msg->ddps;
@@ -1925,29 +1945,33 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_m=
st_branch *mstb,
 =09/* manage mstb port lists with mgr lock - take a reference
 =09   for this list */
 =09if (created) {
-=09=09mutex_lock(&mstb->mgr->lock);
+=09=09mutex_lock(&mgr->lock);
 =09=09drm_dp_mst_topology_get_port(port);
 =09=09list_add(&port->next, &mstb->ports);
-=09=09mutex_unlock(&mstb->mgr->lock);
+=09=09mutex_unlock(&mgr->lock);
 =09}
=20
 =09if (old_ddps !=3D port->ddps) {
 =09=09if (port->ddps) {
 =09=09=09if (!port->input) {
-=09=09=09=09drm_dp_send_enum_path_resources(mstb->mgr,
-=09=09=09=09=09=09=09=09mstb, port);
+=09=09=09=09drm_dp_send_enum_path_resources(mgr, mstb,
+=09=09=09=09=09=09=09=09port);
 =09=09=09}
 =09=09} else {
 =09=09=09port->available_pbn =3D 0;
 =09=09}
 =09}
=20
-=09if (old_pdt !=3D port->pdt && !port->input) {
-=09=09drm_dp_port_teardown_pdt(port, old_pdt);
-
-=09=09ret =3D drm_dp_port_setup_pdt(port);
-=09=09if (ret =3D=3D true)
-=09=09=09drm_dp_send_link_address(mstb->mgr, port->mstb);
+=09if (!port->input) {
+=09=09int ret =3D drm_dp_port_set_pdt(port,
+=09=09=09=09=09      port_msg->peer_device_type);
+=09=09if (ret =3D=3D 1) {
+=09=09=09drm_dp_send_link_address(mgr, port->mstb);
+=09=09} else if (ret < 0) {
+=09=09=09DRM_ERROR("Failed to change PDT on port %p: %d\n",
+=09=09=09=09  port, ret);
+=09=09=09goto fail;
+=09=09}
 =09}
=20
 =09if (created && !port->input) {
@@ -1955,18 +1979,11 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_m=
st_branch *mstb,
=20
 =09=09build_mst_prop_path(mstb, port->port_num, proppath,
 =09=09=09=09    sizeof(proppath));
-=09=09port->connector =3D (*mstb->mgr->cbs->add_connector)(mstb->mgr,
-=09=09=09=09=09=09=09=09   port,
-=09=09=09=09=09=09=09=09   proppath);
-=09=09if (!port->connector) {
-=09=09=09/* remove it from the port list */
-=09=09=09mutex_lock(&mstb->mgr->lock);
-=09=09=09list_del(&port->next);
-=09=09=09mutex_unlock(&mstb->mgr->lock);
-=09=09=09/* drop port list reference */
-=09=09=09drm_dp_mst_topology_put_port(port);
-=09=09=09goto out;
-=09=09}
+=09=09port->connector =3D (*mgr->cbs->add_connector)(mgr, port,
+=09=09=09=09=09=09=09     proppath);
+=09=09if (!port->connector)
+=09=09=09goto fail;
+
 =09=09if ((port->pdt =3D=3D DP_PEER_DEVICE_DP_LEGACY_CONV ||
 =09=09     port->pdt =3D=3D DP_PEER_DEVICE_SST_SINK) &&
 =09=09    port->port_num >=3D DP_MST_LOGICAL_PORT_0) {
@@ -1974,12 +1991,24 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_m=
st_branch *mstb,
 =09=09=09=09=09=09=09 &port->aux.ddc);
 =09=09=09drm_connector_set_tile_property(port->connector);
 =09=09}
-=09=09(*mstb->mgr->cbs->register_connector)(port->connector);
+
+=09=09(*mgr->cbs->register_connector)(port->connector);
 =09}
=20
-out:
 =09/* put reference to this port */
 =09drm_dp_mst_topology_put_port(port);
+=09return;
+
+fail:
+=09/* Remove it from the port list */
+=09mutex_lock(&mgr->lock);
+=09list_del(&port->next);
+=09mutex_unlock(&mgr->lock);
+
+=09/* Drop the port list reference */
+=09drm_dp_mst_topology_put_port(port);
+=09/* And now drop our reference */
+=09drm_dp_mst_topology_put_port(port);
 }
=20
 static void
@@ -1987,16 +2016,14 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branc=
h *mstb,
 =09=09=09    struct drm_dp_connection_status_notify *conn_stat)
 {
 =09struct drm_dp_mst_port *port;
-=09int old_pdt;
 =09int old_ddps;
 =09bool dowork =3D false;
+
 =09port =3D drm_dp_get_port(mstb, conn_stat->port_number);
 =09if (!port)
 =09=09return;
=20
 =09old_ddps =3D port->ddps;
-=09old_pdt =3D port->pdt;
-=09port->pdt =3D conn_stat->peer_device_type;
 =09port->mcs =3D conn_stat->message_capability_status;
 =09port->ldps =3D conn_stat->legacy_device_plug_status;
 =09port->ddps =3D conn_stat->displayport_device_plug_status;
@@ -2008,11 +2035,17 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branc=
h *mstb,
 =09=09=09port->available_pbn =3D 0;
 =09=09}
 =09}
-=09if (old_pdt !=3D port->pdt && !port->input) {
-=09=09drm_dp_port_teardown_pdt(port, old_pdt);
=20
-=09=09if (drm_dp_port_setup_pdt(port))
+=09if (!port->input) {
+=09=09int ret =3D drm_dp_port_set_pdt(port,
+=09=09=09=09=09      conn_stat->peer_device_type);
+=09=09if (ret =3D=3D 1) {
 =09=09=09dowork =3D true;
+=09=09} else if (ret < 0) {
+=09=09=09DRM_ERROR("Failed to change PDT for port %p: %d\n",
+=09=09=09=09  port, ret);
+=09=09=09dowork =3D false;
+=09=09}
 =09}
=20
 =09drm_dp_mst_topology_put_port(port);
@@ -3975,9 +4008,7 @@ drm_dp_delayed_destroy_port(struct drm_dp_mst_port *p=
ort)
 =09if (port->connector)
 =09=09port->mgr->cbs->destroy_connector(port->mgr, port->connector);
=20
-=09drm_dp_port_teardown_pdt(port, port->pdt);
-=09port->pdt =3D DP_PEER_DEVICE_NONE;
-
+=09drm_dp_port_set_pdt(port, DP_PEER_DEVICE_NONE);
 =09drm_dp_mst_put_port_malloc(port);
 }
=20
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helpe=
r.h
index b2160c366fb7..8ba2a01324bb 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -55,8 +55,10 @@ struct drm_dp_vcpi {
  * @num_sdp_stream_sinks: Number of stream sinks
  * @available_pbn: Available bandwidth for this port.
  * @next: link to next port on this branch device
- * @mstb: branch device attach below this port
- * @aux: i2c aux transport to talk to device connected to this port.
+ * @mstb: branch device on this port, protected by
+ * &drm_dp_mst_topology_mgr.lock
+ * @aux: i2c aux transport to talk to device connected to this port, prote=
cted
+ * by &drm_dp_mst_topology_mgr.lock
  * @parent: branch device parent of this port
  * @vcpi: Virtual Channel Payload info for this port.
  * @connector: DRM connector this port is connected to.
--=20
2.21.0

