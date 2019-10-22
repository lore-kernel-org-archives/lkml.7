Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BCC20882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsBHCu9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbfJVCkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:40:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54547 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730084AbfJVCkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571712020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjLVdEfmhVRsO8dIKQ/T0VmakBgrtkjHw3CdbfENGsI=;
        b=bsBHCu9heVqjVe0MX2sh/iHDh1oy7d5fJf7SHqVqpK/HuMzHhd20IYb7Fh6TG6Xi4nEJNW
        1IZfrTAanPgTqkbi8m8QgEhrvban+liv2tcx223YlptnncqxuKBbpUB3WLO8WdIZYJ3mBt
        8KplV1Hr/37F7YH4hAIuiMa0u75COLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-TfzmRSTcNUew1IxySKIV_Q-1; Mon, 21 Oct 2019 22:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A3DC1005500;
        Tue, 22 Oct 2019 02:40:13 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61E766012D;
        Tue, 22 Oct 2019 02:39:38 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        =?UTF-8?q?Mathias=20Fr=C3=B6hlich?= <Mathias.Froehlich@web.de>,
        Thomas Lim <Thomas.Lim@amd.com>,
        David Francis <David.Francis@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/14] drm/dp_mst: Protect drm_dp_mst_port members with locking
Date:   Mon, 21 Oct 2019 22:36:01 -0400
Message-Id: <20191022023641.8026-7-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TfzmRSTcNUew1IxySKIV_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a complicated one. Essentially, there's currently a problem in the =
MST
core that hasn't really caused any issues that we're aware of (emphasis on =
"that
we're aware of"): locking.

When we go through and probe the link addresses and path resources in a
topology, we hold no locks when updating ports with said information. The
members I'm referring to in particular are:

- ldps
- ddps
- mcs
- pdt
- dpcd_rev
- num_sdp_streams
- num_sdp_stream_sinks
- available_pbn
- input
- connector

Now that we're handling UP requests asynchronously and will be using some o=
f
the struct members mentioned above in atomic modesetting in the future for
features such as PBN validation, this is going to become a lot more importa=
nt.
As well, the next few commits that prepare us for and introduce suspend/res=
ume
reprobing will also need clear locking in order to prevent from additional
racing hilarities that we never could have hit in the past.

So, let's solve this issue by using &mgr->base.lock, the modesetting
lock which currently only protects &mgr->base.state. This works
perfectly because it allows us to avoid blocking connection_mutex
unnecessarily, and we can grab this in connector detection paths since
it's a ww mutex. We start by having drm_dp_mst_handle_up_req() hold this
when updating ports. For drm_dp_mst_handle_link_address_port() things
are a bit more complicated. As I've learned the hard way, we can grab
&mgr->lock.base for everything except for port->connector. See, our
normal driver probing paths end up generating this rather obvious
lockdep chain:

&drm->mode_config.mutex
  -> crtc_ww_class_mutex/crtc_ww_class_acquire
    -> &connector->mutex

However, sysfs grabs &drm->mode_config.mutex in order to protect itself
from connector state changing under it. Because this entails grabbing
kn->count, e.g. the lock that the kernel provides for protecting sysfs
contexts, we end up grabbing kn->count followed by
&drm->mode_config.mutex. This ends up creating an extremely rude chain:

&kn->count
  -> &drm->mode_config.mutex
    -> crtc_ww_class_mutex/crtc_ww_class_acquire
      -> &connector->mutex

I mean, look at that thing! It's just evil!!! This gross thing ends up
making any calls to drm_connector_register()/drm_connector_unregister()
impossible when holding any kind of modesetting lock. This is annoying
because ideally, we always want to ensure that
drm_dp_mst_port->connector never changes when doing an atomic commit or
check that would affect the atomic topology state so that it can
reliably and easily be used from future DRM DP MST helpers to assist
with tasks such as scanning through the current VCPI allocations and
adding connectors which need to have their allocations updated in
response to a bandwidth change or the like.

Being able to hold &mgr->base.lock throughout the entire link probe
process would have been _great_, since we could prevent userspace from
ever seeing any states in-between individual port changes and as a
result likely end up with a much faster probe and more consistent
results from said probes. But without some rework of how we handle
connector probing in sysfs it's not at all currently possible. In the
future, maybe we can try using the sysfs locks to protect updates to
connector probing state and fix this mess.

So for now, to protect everything other than port->connector under
&mgr->base.lock and ensure that we still have the guarantee that atomic
check/commit contexts will never see port->connector change we use a
silly trick. See: port->connector only needs to change in order to
ensure that input ports (see the MST spec) never have a ghost connector
associated with them. But, there's nothing stopping us from simply
throwing the entire port out and creating a new one in order to maintain
that requirement while still keeping port->connector consistent across
the lifetime of the port in atomic check/commit contexts. For all
intended purposes this works fine, as we validate ports in any contexts
we care about before using them and as such will end up reporting the
connector as disconnected until it's port's destruction finalizes. So,
we just do that in cases where we detect port->input has transitioned
from true->false. We don't need to worry about the other direction,
since a port without a connector isn't visible to userspace and as such
doesn't need to be protected by &mgr->base.lock until we finish
registering a connector for it.

For updating members of drm_dp_mst_port other than port->connector, we
simply grab &mgr->base.lock in drm_dp_mst_link_probe_work() for already
registered ports, update said members and drop the lock before
potentially registering a connector and probing the link address of it's
children.

Finally, we modify drm_dp_mst_detect_port() to take a modesetting lock
acquisition context in order to acquire &mgr->base.lock under
&connection_mutex and convert all it's users over to using the
.detect_ctx probe hooks.

With that, we finally have well defined locking.

Changes since v4:
* Get rid of port->mutex, stop using connection_mutex and just use our own
  modesetting lock - mgr->base.lock. Also, add a probe_lock that comes
  before this patch.
* Just throw out ports that get changed from an output to an input, and
  replace them with new ports. This lets us ensure that modesetting
  contexts never see port->connector go from having a connector to being
  NULL.
* Write an extremely detailed explanation of what problems this is
  trying to fix, since there's a _lot_ of context here and I honestly
  forgot some of it myself a couple times.
* Don't grab mgr->lock when reading port->mstb in
  drm_dp_mst_handle_link_address_port(). It's not needed.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  28 +--
 drivers/gpu/drm/drm_dp_mst_topology.c         | 230 ++++++++++++------
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  28 ++-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |  32 +--
 drivers/gpu/drm/radeon/radeon_dp_mst.c        |  24 +-
 include/drm/drm_dp_mst_helper.h               |  38 ++-
 6 files changed, 240 insertions(+), 140 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5ec14efd4d8c..f8214acf70b3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -123,21 +123,6 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *a=
ux,
 =09return result;
 }
=20
-static enum drm_connector_status
-dm_dp_mst_detect(struct drm_connector *connector, bool force)
-{
-=09struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(conne=
ctor);
-=09struct amdgpu_dm_connector *master =3D aconnector->mst_port;
-
-=09enum drm_connector_status status =3D
-=09=09drm_dp_mst_detect_port(
-=09=09=09connector,
-=09=09=09&master->mst_mgr,
-=09=09=09aconnector->port);
-
-=09return status;
-}
-
 static void
 dm_dp_mst_connector_destroy(struct drm_connector *connector)
 {
@@ -177,7 +162,6 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_con=
nector *connector)
 }
=20
 static const struct drm_connector_funcs dm_dp_mst_connector_funcs =3D {
-=09.detect =3D dm_dp_mst_detect,
 =09.fill_modes =3D drm_helper_probe_single_connector_modes,
 =09.destroy =3D dm_dp_mst_connector_destroy,
 =09.reset =3D amdgpu_dm_connector_funcs_reset,
@@ -252,10 +236,22 @@ static struct drm_encoder *dm_mst_best_encoder(struct=
 drm_connector *connector)
 =09return &amdgpu_dm_connector->mst_encoder->base;
 }
=20
+static int
+dm_dp_mst_detect(struct drm_connector *connector,
+=09=09 struct drm_modeset_acquire_ctx *ctx, bool force)
+{
+=09struct amdgpu_dm_connector *aconnector =3D to_amdgpu_dm_connector(conne=
ctor);
+=09struct amdgpu_dm_connector *master =3D aconnector->mst_port;
+
+=09return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
+=09=09=09=09      aconnector->port);
+}
+
 static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_=
funcs =3D {
 =09.get_modes =3D dm_dp_mst_get_modes,
 =09.mode_valid =3D amdgpu_dm_connector_mode_valid,
 =09.best_encoder =3D dm_mst_best_encoder,
+=09.detect_ctx =3D dm_dp_mst_detect,
 };
=20
 static void amdgpu_dm_encoder_destroy(struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index 11d842f0bff5..7bf4db91ff90 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1905,6 +1905,78 @@ void drm_dp_mst_connector_early_unregister(struct dr=
m_connector *connector,
 }
 EXPORT_SYMBOL(drm_dp_mst_connector_early_unregister);
=20
+static void
+drm_dp_mst_port_add_connector(struct drm_dp_mst_branch *mstb,
+=09=09=09      struct drm_dp_mst_port *port)
+{
+=09struct drm_dp_mst_topology_mgr *mgr =3D port->mgr;
+=09char proppath[255];
+=09int ret;
+
+=09build_mst_prop_path(mstb, port->port_num, proppath, sizeof(proppath));
+=09port->connector =3D mgr->cbs->add_connector(mgr, port, proppath);
+=09if (!port->connector) {
+=09=09ret =3D -ENOMEM;
+=09=09goto error;
+=09}
+
+=09if ((port->pdt =3D=3D DP_PEER_DEVICE_DP_LEGACY_CONV ||
+=09     port->pdt =3D=3D DP_PEER_DEVICE_SST_SINK) &&
+=09    port->port_num >=3D DP_MST_LOGICAL_PORT_0) {
+=09=09port->cached_edid =3D drm_get_edid(port->connector,
+=09=09=09=09=09=09 &port->aux.ddc);
+=09=09drm_connector_set_tile_property(port->connector);
+=09}
+
+=09mgr->cbs->register_connector(port->connector);
+=09return;
+
+error:
+=09DRM_ERROR("Failed to create connector for port %p: %d\n", port, ret);
+}
+
+/*
+ * Drop a topology reference, and unlink the port from the in-memory topol=
ogy
+ * layout
+ */
+static void
+drm_dp_mst_topology_unlink_port(struct drm_dp_mst_topology_mgr *mgr,
+=09=09=09=09struct drm_dp_mst_port *port)
+{
+=09mutex_lock(&mgr->lock);
+=09list_del(&port->next);
+=09mutex_unlock(&mgr->lock);
+=09drm_dp_mst_topology_put_port(port);
+}
+
+static struct drm_dp_mst_port *
+drm_dp_mst_add_port(struct drm_device *dev,
+=09=09    struct drm_dp_mst_topology_mgr *mgr,
+=09=09    struct drm_dp_mst_branch *mstb, u8 port_number)
+{
+=09struct drm_dp_mst_port *port =3D kzalloc(sizeof(*port), GFP_KERNEL);
+
+=09if (!port)
+=09=09return NULL;
+
+=09kref_init(&port->topology_kref);
+=09kref_init(&port->malloc_kref);
+=09port->parent =3D mstb;
+=09port->port_num =3D port_number;
+=09port->mgr =3D mgr;
+=09port->aux.name =3D "DPMST";
+=09port->aux.dev =3D dev->dev;
+=09port->aux.is_remote =3D true;
+
+=09/*
+=09 * Make sure the memory allocation for our parent branch stays
+=09 * around until our own memory allocation is released
+=09 */
+=09drm_dp_mst_get_mstb_malloc(mstb);
+
+=09return port;
+}
+
 static void
 drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
 =09=09=09=09    struct drm_device *dev,
@@ -1912,35 +1984,40 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_m=
st_branch *mstb,
 {
 =09struct drm_dp_mst_topology_mgr *mgr =3D mstb->mgr;
 =09struct drm_dp_mst_port *port;
-=09bool created =3D false;
-=09int old_ddps =3D 0;
+=09int old_ddps =3D 0, ret;
+=09u8 new_pdt =3D DP_PEER_DEVICE_NONE;
+=09bool created =3D false, send_link_addr =3D false;
=20
 =09port =3D drm_dp_get_port(mstb, port_msg->port_number);
 =09if (!port) {
-=09=09port =3D kzalloc(sizeof(*port), GFP_KERNEL);
+=09=09port =3D drm_dp_mst_add_port(dev, mgr, mstb,
+=09=09=09=09=09   port_msg->port_number);
 =09=09if (!port)
 =09=09=09return;
-=09=09kref_init(&port->topology_kref);
-=09=09kref_init(&port->malloc_kref);
-=09=09port->parent =3D mstb;
-=09=09port->port_num =3D port_msg->port_number;
-=09=09port->mgr =3D mgr;
-=09=09port->aux.name =3D "DPMST";
-=09=09port->aux.dev =3D dev->dev;
-=09=09port->aux.is_remote =3D true;
-
-=09=09/*
-=09=09 * Make sure the memory allocation for our parent branch stays
-=09=09 * around until our own memory allocation is released
+=09=09created =3D true;
+=09} else if (port_msg->input_port && !port->input && port->connector) {
+=09=09/* Destroying the connector is impossible in this context, so
+=09=09 * replace the port with a new one
 =09=09 */
-=09=09drm_dp_mst_get_mstb_malloc(mstb);
+=09=09drm_dp_mst_topology_unlink_port(mgr, port);
+=09=09drm_dp_mst_topology_put_port(port);
=20
+=09=09port =3D drm_dp_mst_add_port(dev, mgr, mstb,
+=09=09=09=09=09   port_msg->port_number);
+=09=09if (!port)
+=09=09=09return;
 =09=09created =3D true;
 =09} else {
+=09=09/* Locking is only needed when the port has a connector
+=09=09 * exposed to userspace
+=09=09 */
+=09=09drm_modeset_lock(&mgr->base.lock, NULL);
 =09=09old_ddps =3D port->ddps;
 =09}
=20
 =09port->input =3D port_msg->input_port;
+=09if (!port->input)
+=09=09new_pdt =3D port_msg->peer_device_type;
 =09port->mcs =3D port_msg->mcs;
 =09port->ddps =3D port_msg->ddps;
 =09port->ldps =3D port_msg->legacy_device_plug_status;
@@ -1968,59 +2045,39 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_m=
st_branch *mstb,
 =09=09}
 =09}
=20
-=09if (!port->input) {
-=09=09int ret =3D drm_dp_port_set_pdt(port,
-=09=09=09=09=09      port_msg->peer_device_type);
-=09=09if (ret =3D=3D 1) {
-=09=09=09drm_dp_send_link_address(mgr, port->mstb);
-=09=09} else if (ret < 0) {
-=09=09=09DRM_ERROR("Failed to change PDT on port %p: %d\n",
-=09=09=09=09  port, ret);
-=09=09=09goto fail;
-=09=09}
+=09ret =3D drm_dp_port_set_pdt(port, new_pdt);
+=09if (ret =3D=3D 1) {
+=09=09send_link_addr =3D true;
+=09} else if (ret < 0) {
+=09=09DRM_ERROR("Failed to change PDT on port %p: %d\n",
+=09=09=09  port, ret);
+=09=09goto fail;
 =09}
=20
-=09if (created && !port->input) {
-=09=09char proppath[255];
-
-=09=09build_mst_prop_path(mstb, port->port_num, proppath,
-=09=09=09=09    sizeof(proppath));
-=09=09port->connector =3D (*mgr->cbs->add_connector)(mgr, port,
-=09=09=09=09=09=09=09     proppath);
-=09=09if (!port->connector)
-=09=09=09goto fail;
-
-=09=09if ((port->pdt =3D=3D DP_PEER_DEVICE_DP_LEGACY_CONV ||
-=09=09     port->pdt =3D=3D DP_PEER_DEVICE_SST_SINK) &&
-=09=09    port->port_num >=3D DP_MST_LOGICAL_PORT_0) {
-=09=09=09port->cached_edid =3D drm_get_edid(port->connector,
-=09=09=09=09=09=09=09 &port->aux.ddc);
-=09=09=09drm_connector_set_tile_property(port->connector);
-=09=09}
+=09if (!created)
+=09=09drm_modeset_unlock(&mgr->base.lock);
+=09else if (!port->connector && !port->input)
+=09=09drm_dp_mst_port_add_connector(mstb, port);
=20
-=09=09(*mgr->cbs->register_connector)(port->connector);
-=09}
+=09if (send_link_addr && port->mstb)
+=09=09drm_dp_send_link_address(mgr, port->mstb);
=20
 =09/* put reference to this port */
 =09drm_dp_mst_topology_put_port(port);
 =09return;
=20
 fail:
-=09/* Remove it from the port list */
-=09mutex_lock(&mgr->lock);
-=09list_del(&port->next);
-=09mutex_unlock(&mgr->lock);
-
-=09/* Drop the port list reference */
-=09drm_dp_mst_topology_put_port(port);
-=09/* And now drop our reference */
+=09drm_dp_mst_topology_unlink_port(mgr, port);
 =09drm_dp_mst_topology_put_port(port);
+=09if (!created)
+=09=09drm_modeset_unlock(&mgr->base.lock);
 }
=20
 static void
 drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
 =09=09=09    struct drm_dp_connection_status_notify *conn_stat)
 {
+=09struct drm_dp_mst_topology_mgr *mgr =3D mstb->mgr;
 =09struct drm_dp_mst_port *port;
 =09int old_ddps;
 =09bool dowork =3D false;
@@ -2029,6 +2086,10 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch=
 *mstb,
 =09if (!port)
 =09=09return;
=20
+=09/* Locking is only needed if the port's exposed to userspace */
+=09if (port->connector)
+=09=09drm_modeset_lock(&mgr->base.lock, NULL);
+
 =09old_ddps =3D port->ddps;
 =09port->mcs =3D conn_stat->message_capability_status;
 =09port->ldps =3D conn_stat->legacy_device_plug_status;
@@ -2054,10 +2115,12 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branc=
h *mstb,
 =09=09}
 =09}
=20
+=09if (port->connector)
+=09=09drm_modeset_unlock(&mgr->base.lock);
+
 =09drm_dp_mst_topology_put_port(port);
 =09if (dowork)
 =09=09queue_work(system_long_wq, &mstb->mgr->work);
-
 }
=20
 static struct drm_dp_mst_branch *drm_dp_get_mst_branch_device(struct drm_d=
p_mst_topology_mgr *mgr,
@@ -2157,8 +2220,11 @@ static void drm_dp_check_and_send_link_address(struc=
t drm_dp_mst_topology_mgr *m
 =09=09if (port->input || !port->ddps)
 =09=09=09continue;
=20
-=09=09if (!port->available_pbn)
+=09=09if (!port->available_pbn) {
+=09=09=09drm_modeset_lock(&mgr->base.lock, NULL);
 =09=09=09drm_dp_send_enum_path_resources(mgr, mstb, port);
+=09=09=09drm_modeset_unlock(&mgr->base.lock);
+=09=09}
=20
 =09=09if (port->mstb)
 =09=09=09mstb_child =3D drm_dp_mst_topology_get_mstb_validated(
@@ -2189,11 +2255,16 @@ static void drm_dp_mst_link_probe_work(struct work_=
struct *work)
 =09=09=09mstb =3D NULL;
 =09}
 =09mutex_unlock(&mgr->lock);
-=09if (mstb) {
-=09=09drm_dp_check_and_send_link_address(mgr, mstb);
-=09=09drm_dp_mst_topology_put_mstb(mstb);
+=09if (!mstb) {
+=09=09mutex_unlock(&mgr->probe_lock);
+=09=09return;
 =09}
+
+=09drm_dp_check_and_send_link_address(mgr, mstb);
+=09drm_dp_mst_topology_put_mstb(mstb);
+
 =09mutex_unlock(&mgr->probe_lock);
+=09drm_kms_helper_hotplug_event(dev);
 }
=20
 static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
@@ -2478,8 +2549,6 @@ static void drm_dp_send_link_address(struct drm_dp_ms=
t_topology_mgr *mgr,
 =09=09drm_dp_mst_handle_link_address_port(mstb, mgr->dev,
 =09=09=09=09=09=09    &reply->ports[i]);
=20
-=09drm_kms_helper_hotplug_event(mgr->dev);
-
 out:
 =09if (ret <=3D 0)
 =09=09mstb->link_address_sent =3D false;
@@ -3274,13 +3343,14 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp=
_mst_topology_mgr *mgr)
 =09return 0;
 }
=20
-static inline void
+static inline bool
 drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 =09=09=09  struct drm_dp_pending_up_req *up_req)
 {
 =09struct drm_dp_mst_branch *mstb =3D NULL;
 =09struct drm_dp_sideband_msg_req_body *msg =3D &up_req->msg;
 =09struct drm_dp_sideband_msg_hdr *hdr =3D &up_req->hdr;
+=09bool hotplug =3D false;
=20
 =09if (hdr->broadcast) {
 =09=09const u8 *guid =3D NULL;
@@ -3298,16 +3368,17 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topolog=
y_mgr *mgr,
 =09if (!mstb) {
 =09=09DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
 =09=09=09      hdr->lct);
-=09=09return;
+=09=09return false;
 =09}
=20
 =09/* TODO: Add missing handler for DP_RESOURCE_STATUS_NOTIFY events */
 =09if (msg->req_type =3D=3D DP_CONNECTION_STATUS_NOTIFY) {
 =09=09drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
-=09=09drm_kms_helper_hotplug_event(mgr->dev);
+=09=09hotplug =3D true;
 =09}
=20
 =09drm_dp_mst_topology_put_mstb(mstb);
+=09return hotplug;
 }
=20
 static void drm_dp_mst_up_req_work(struct work_struct *work)
@@ -3316,6 +3387,7 @@ static void drm_dp_mst_up_req_work(struct work_struct=
 *work)
 =09=09container_of(work, struct drm_dp_mst_topology_mgr,
 =09=09=09     up_req_work);
 =09struct drm_dp_pending_up_req *up_req;
+=09bool send_hotplug =3D false;
=20
 =09mutex_lock(&mgr->probe_lock);
 =09while (true) {
@@ -3330,10 +3402,13 @@ static void drm_dp_mst_up_req_work(struct work_stru=
ct *work)
 =09=09if (!up_req)
 =09=09=09break;
=20
-=09=09drm_dp_mst_process_up_req(mgr, up_req);
+=09=09send_hotplug |=3D drm_dp_mst_process_up_req(mgr, up_req);
 =09=09kfree(up_req);
 =09}
 =09mutex_unlock(&mgr->probe_lock);
+
+=09if (send_hotplug)
+=09=09drm_kms_helper_hotplug_event(mgr->dev);
 }
=20
 static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
@@ -3441,22 +3516,31 @@ EXPORT_SYMBOL(drm_dp_mst_hpd_irq);
 /**
  * drm_dp_mst_detect_port() - get connection status for an MST port
  * @connector: DRM connector for this port
+ * @ctx: The acquisition context to use for grabbing locks
  * @mgr: manager for this port
- * @port: unverified pointer to a port
+ * @port: pointer to a port
  *
- * This returns the current connection state for a port. It validates the
- * port pointer still exists so the caller doesn't require a reference
+ * This returns the current connection state for a port.
  */
-enum drm_connector_status drm_dp_mst_detect_port(struct drm_connector *con=
nector,
-=09=09=09=09=09=09 struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_=
port *port)
+int
+drm_dp_mst_detect_port(struct drm_connector *connector,
+=09=09       struct drm_modeset_acquire_ctx *ctx,
+=09=09       struct drm_dp_mst_topology_mgr *mgr,
+=09=09       struct drm_dp_mst_port *port)
 {
-=09enum drm_connector_status status =3D connector_status_disconnected;
+=09int ret;
=20
 =09/* we need to search for the port in the mgr in case it's gone */
 =09port =3D drm_dp_mst_topology_get_port_validated(mgr, port);
 =09if (!port)
 =09=09return connector_status_disconnected;
=20
+=09ret =3D drm_modeset_lock(&mgr->base.lock, ctx);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D connector_status_disconnected;
+
 =09if (!port->ddps)
 =09=09goto out;
=20
@@ -3466,7 +3550,7 @@ enum drm_connector_status drm_dp_mst_detect_port(stru=
ct drm_connector *connector
 =09=09break;
=20
 =09case DP_PEER_DEVICE_SST_SINK:
-=09=09status =3D connector_status_connected;
+=09=09ret =3D connector_status_connected;
 =09=09/* for logical ports - cache the EDID */
 =09=09if (port->port_num >=3D 8 && !port->cached_edid) {
 =09=09=09port->cached_edid =3D drm_get_edid(connector, &port->aux.ddc);
@@ -3474,12 +3558,12 @@ enum drm_connector_status drm_dp_mst_detect_port(st=
ruct drm_connector *connector
 =09=09break;
 =09case DP_PEER_DEVICE_DP_LEGACY_CONV:
 =09=09if (port->ldps)
-=09=09=09status =3D connector_status_connected;
+=09=09=09ret =3D connector_status_connected;
 =09=09break;
 =09}
 out:
 =09drm_dp_mst_topology_put_port(port);
-=09return status;
+=09return ret;
 }
 EXPORT_SYMBOL(drm_dp_mst_detect_port);
=20
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/=
i915/display/intel_dp_mst.c
index bbcab27644dc..a9962846a503 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -391,20 +391,7 @@ static int intel_dp_mst_get_ddc_modes(struct drm_conne=
ctor *connector)
 =09return ret;
 }
=20
-static enum drm_connector_status
-intel_dp_mst_detect(struct drm_connector *connector, bool force)
-{
-=09struct intel_connector *intel_connector =3D to_intel_connector(connecto=
r);
-=09struct intel_dp *intel_dp =3D intel_connector->mst_port;
-
-=09if (drm_connector_is_unregistered(connector))
-=09=09return connector_status_disconnected;
-=09return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
-=09=09=09=09      intel_connector->port);
-}
-
 static const struct drm_connector_funcs intel_dp_mst_connector_funcs =3D {
-=09.detect =3D intel_dp_mst_detect,
 =09.fill_modes =3D drm_helper_probe_single_connector_modes,
 =09.atomic_get_property =3D intel_digital_connector_atomic_get_property,
 =09.atomic_set_property =3D intel_digital_connector_atomic_set_property,
@@ -465,11 +452,26 @@ static struct drm_encoder *intel_mst_atomic_best_enco=
der(struct drm_connector *c
 =09return &intel_dp->mst_encoders[crtc->pipe]->base.base;
 }
=20
+static int
+intel_dp_mst_detect(struct drm_connector *connector,
+=09=09    struct drm_modeset_acquire_ctx *ctx, bool force)
+{
+=09struct intel_connector *intel_connector =3D to_intel_connector(connecto=
r);
+=09struct intel_dp *intel_dp =3D intel_connector->mst_port;
+
+=09if (drm_connector_is_unregistered(connector))
+=09=09return connector_status_disconnected;
+
+=09return drm_dp_mst_detect_port(connector, ctx, &intel_dp->mst_mgr,
+=09=09=09=09      intel_connector->port);
+}
+
 static const struct drm_connector_helper_funcs intel_dp_mst_connector_help=
er_funcs =3D {
 =09.get_modes =3D intel_dp_mst_get_modes,
 =09.mode_valid =3D intel_dp_mst_mode_valid,
 =09.atomic_best_encoder =3D intel_mst_atomic_best_encoder,
 =09.atomic_check =3D intel_dp_mst_atomic_check,
+=09.detect_ctx =3D intel_dp_mst_detect,
 };
=20
 static void intel_dp_mst_encoder_destroy(struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouv=
eau/dispnv50/disp.c
index a13924ae1992..a9d6aa110cfd 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -986,20 +986,11 @@ nv50_mstc_atomic_check(struct drm_connector *connecto=
r,
 =09return drm_dp_atomic_release_vcpi_slots(state, mgr, mstc->port);
 }
=20
-static const struct drm_connector_helper_funcs
-nv50_mstc_help =3D {
-=09.get_modes =3D nv50_mstc_get_modes,
-=09.mode_valid =3D nv50_mstc_mode_valid,
-=09.best_encoder =3D nv50_mstc_best_encoder,
-=09.atomic_best_encoder =3D nv50_mstc_atomic_best_encoder,
-=09.atomic_check =3D nv50_mstc_atomic_check,
-};
-
-static enum drm_connector_status
-nv50_mstc_detect(struct drm_connector *connector, bool force)
+static int
+nv50_mstc_detect(struct drm_connector *connector,
+=09=09 struct drm_modeset_acquire_ctx *ctx, bool force)
 {
 =09struct nv50_mstc *mstc =3D nv50_mstc(connector);
-=09enum drm_connector_status conn_status;
 =09int ret;
=20
 =09if (drm_connector_is_unregistered(connector))
@@ -1009,14 +1000,24 @@ nv50_mstc_detect(struct drm_connector *connector, b=
ool force)
 =09if (ret < 0 && ret !=3D -EACCES)
 =09=09return connector_status_disconnected;
=20
-=09conn_status =3D drm_dp_mst_detect_port(connector, mstc->port->mgr,
-=09=09=09=09=09     mstc->port);
+=09ret =3D drm_dp_mst_detect_port(connector, ctx, mstc->port->mgr,
+=09=09=09=09     mstc->port);
=20
 =09pm_runtime_mark_last_busy(connector->dev->dev);
 =09pm_runtime_put_autosuspend(connector->dev->dev);
-=09return conn_status;
+=09return ret;
 }
=20
+static const struct drm_connector_helper_funcs
+nv50_mstc_help =3D {
+=09.get_modes =3D nv50_mstc_get_modes,
+=09.mode_valid =3D nv50_mstc_mode_valid,
+=09.best_encoder =3D nv50_mstc_best_encoder,
+=09.atomic_best_encoder =3D nv50_mstc_atomic_best_encoder,
+=09.atomic_check =3D nv50_mstc_atomic_check,
+=09.detect_ctx =3D nv50_mstc_detect,
+};
+
 static void
 nv50_mstc_destroy(struct drm_connector *connector)
 {
@@ -1031,7 +1032,6 @@ nv50_mstc_destroy(struct drm_connector *connector)
 static const struct drm_connector_funcs
 nv50_mstc =3D {
 =09.reset =3D nouveau_conn_reset,
-=09.detect =3D nv50_mstc_detect,
 =09.fill_modes =3D drm_helper_probe_single_connector_modes,
 =09.destroy =3D nv50_mstc_destroy,
 =09.atomic_duplicate_state =3D nouveau_conn_atomic_duplicate_state,
diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c b/drivers/gpu/drm/radeo=
n/radeon_dp_mst.c
index 2994f07fbad9..ee28f5b3785e 100644
--- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
+++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
@@ -233,21 +233,26 @@ drm_encoder *radeon_mst_best_encoder(struct drm_conne=
ctor *connector)
 =09return &radeon_connector->mst_encoder->base;
 }
=20
+static int
+radeon_dp_mst_detect(struct drm_connector *connector,
+=09=09     struct drm_modeset_acquire_ctx *ctx,
+=09=09     bool force)
+{
+=09struct radeon_connector *radeon_connector =3D
+=09=09to_radeon_connector(connector);
+=09struct radeon_connector *master =3D radeon_connector->mst_port;
+
+=09return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
+=09=09=09=09      radeon_connector->port);
+}
+
 static const struct drm_connector_helper_funcs radeon_dp_mst_connector_hel=
per_funcs =3D {
 =09.get_modes =3D radeon_dp_mst_get_modes,
 =09.mode_valid =3D radeon_dp_mst_mode_valid,
 =09.best_encoder =3D radeon_mst_best_encoder,
+=09.detect_ctx =3D radeon_dp_mst_detect,
 };
=20
-static enum drm_connector_status
-radeon_dp_mst_detect(struct drm_connector *connector, bool force)
-{
-=09struct radeon_connector *radeon_connector =3D to_radeon_connector(conne=
ctor);
-=09struct radeon_connector *master =3D radeon_connector->mst_port;
-
-=09return drm_dp_mst_detect_port(connector, &master->mst_mgr, radeon_conne=
ctor->port);
-}
-
 static void
 radeon_dp_mst_connector_destroy(struct drm_connector *connector)
 {
@@ -262,7 +267,6 @@ radeon_dp_mst_connector_destroy(struct drm_connector *c=
onnector)
=20
 static const struct drm_connector_funcs radeon_dp_mst_connector_funcs =3D =
{
 =09.dpms =3D drm_helper_connector_dpms,
-=09.detect =3D radeon_dp_mst_detect,
 =09.fill_modes =3D drm_helper_probe_single_connector_modes,
 =09.destroy =3D radeon_dp_mst_connector_destroy,
 };
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helpe=
r.h
index bccb5514e0ef..fd142db42cb0 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -45,21 +45,31 @@ struct drm_dp_vcpi {
 /**
  * struct drm_dp_mst_port - MST port
  * @port_num: port number
- * @input: if this port is an input port.
- * @mcs: message capability status - DP 1.2 spec.
- * @ddps: DisplayPort Device Plug Status - DP 1.2
- * @pdt: Peer Device Type
- * @ldps: Legacy Device Plug Status
- * @dpcd_rev: DPCD revision of device on this port
- * @num_sdp_streams: Number of simultaneous streams
- * @num_sdp_stream_sinks: Number of stream sinks
- * @available_pbn: Available bandwidth for this port.
+ * @input: if this port is an input port. Protected by
+ * &drm_dp_mst_topology_mgr.base.lock.
+ * @mcs: message capability status - DP 1.2 spec. Protected by
+ * &drm_dp_mst_topology_mgr.base.lock.
+ * @ddps: DisplayPort Device Plug Status - DP 1.2. Protected by
+ * &drm_dp_mst_topology_mgr.base.lock.
+ * @pdt: Peer Device Type. Protected by
+ * &drm_dp_mst_topology_mgr.base.lock.
+ * @ldps: Legacy Device Plug Status. Protected by
+ * &drm_dp_mst_topology_mgr.base.lock.
+ * @dpcd_rev: DPCD revision of device on this port. Protected by
+ * &drm_dp_mst_topology_mgr.base.lock.
+ * @num_sdp_streams: Number of simultaneous streams. Protected by
+ * &drm_dp_mst_topology_mgr.base.lock.
+ * @num_sdp_stream_sinks: Number of stream sinks. Protected by
+ * &drm_dp_mst_topology_mgr.base.lock.
+ * @available_pbn: Available bandwidth for this port. Protected by
+ * &drm_dp_mst_topology_mgr.base.lock.
  * @next: link to next port on this branch device
  * @aux: i2c aux transport to talk to device connected to this port, prote=
cted
- * by &drm_dp_mst_topology_mgr.lock
+ * by &drm_dp_mst_topology_mgr.base.lock.
  * @parent: branch device parent of this port
  * @vcpi: Virtual Channel Payload info for this port.
- * @connector: DRM connector this port is connected to.
+ * @connector: DRM connector this port is connected to. Protected by
+ * &drm_dp_mst_topology_mgr.base.lock.
  * @mgr: topology manager this port lives under.
  *
  * This structure represents an MST port endpoint on a device somewhere
@@ -653,7 +663,11 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_=
topology_mgr *mgr, bool ms
 int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool =
*handled);
=20
=20
-enum drm_connector_status drm_dp_mst_detect_port(struct drm_connector *con=
nector, struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
+int
+drm_dp_mst_detect_port(struct drm_connector *connector,
+=09=09       struct drm_modeset_acquire_ctx *ctx,
+=09=09       struct drm_dp_mst_topology_mgr *mgr,
+=09=09       struct drm_dp_mst_port *port);
=20
 bool drm_dp_mst_port_has_audio(struct drm_dp_mst_topology_mgr *mgr,
 =09=09=09=09=09struct drm_dp_mst_port *port);
--=20
2.21.0

