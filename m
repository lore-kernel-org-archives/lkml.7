Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F38CA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27A321783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMEU3XpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbfJVCk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:40:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37164 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387442AbfJVCkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571712024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmwWa3TWD3uShU2mHZzpR5scuhFQ16OxsUlTglKtdsA=;
        b=eMEU3XpIDIKcy/S3bpSO9kqj3MFhFyRCnfzHe//a3EoI5UMPq5P4qMuc3lm27b8kgE5Y1/
        m6o5Zu8H7C+pc9/IWcQTW3q45G6SYRIa/ZlSzyJMN+Pcx92xCtVLhR/qfjn5ilfIdrQUrj
        7FxWdKZO/fyZGV31ubpuhMaKMM/BWgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-B9jwI_PLNlqixRHimYRCog-1; Mon, 21 Oct 2019 22:40:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 199371800DC7;
        Tue, 22 Oct 2019 02:40:16 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C580360126;
        Tue, 22 Oct 2019 02:40:13 +0000 (UTC)
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
Subject: [PATCH v5 07/14] drm/dp_mst: Don't forget to update port->input in drm_dp_mst_handle_conn_stat()
Date:   Mon, 21 Oct 2019 22:36:02 -0400
Message-Id: <20191022023641.8026-8-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: B9jwI_PLNlqixRHimYRCog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This probably hasn't caused any problems up until now since it's
probably nearly impossible to encounter this in the wild, however if we
were to receive a connection status notification from the MST hub after
resume while we're in the middle of reprobing the link addresses for a
topology then there's a much larger chance that a port could have
changed from being an output port to input port (or vice versa). If we
forget to update this bit of information, we'll potentially ignore a
valid PDT change on a downstream port because we think it's an input
port.

So, make sure we read the input_port field in connection status
notifications in drm_dp_mst_handle_conn_stat() to prevent this from
happening once we've implemented suspend/resume reprobing.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 52 +++++++++++++++++++--------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index 7bf4db91ff90..c8e218b902ae 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2079,18 +2079,40 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branc=
h *mstb,
 {
 =09struct drm_dp_mst_topology_mgr *mgr =3D mstb->mgr;
 =09struct drm_dp_mst_port *port;
-=09int old_ddps;
-=09bool dowork =3D false;
+=09int old_ddps, ret;
+=09u8 new_pdt;
+=09bool dowork =3D false, create_connector =3D false;
=20
 =09port =3D drm_dp_get_port(mstb, conn_stat->port_number);
 =09if (!port)
 =09=09return;
=20
-=09/* Locking is only needed if the port's exposed to userspace */
-=09if (port->connector)
+=09if (port->connector) {
+=09=09if (!port->input && conn_stat->input_port) {
+=09=09=09/*
+=09=09=09 * We can't remove a connector from an already exposed
+=09=09=09 * port, so just throw the port out and make sure we
+=09=09=09 * reprobe the link address of it's parent MSTB
+=09=09=09 */
+=09=09=09drm_dp_mst_topology_unlink_port(mgr, port);
+=09=09=09mstb->link_address_sent =3D false;
+=09=09=09dowork =3D true;
+=09=09=09goto out;
+=09=09}
+
+=09=09/*
+=09=09 * Locking is only needed if the port's exposed to userspace
+=09=09 */
 =09=09drm_modeset_lock(&mgr->base.lock, NULL);
+=09} else if (port->input && !conn_stat->input_port) {
+=09=09create_connector =3D true;
+=09=09/* Reprobe link address so we get num_sdp_streams */
+=09=09mstb->link_address_sent =3D false;
+=09=09dowork =3D true;
+=09}
=20
 =09old_ddps =3D port->ddps;
+=09port->input =3D conn_stat->input_port;
 =09port->mcs =3D conn_stat->message_capability_status;
 =09port->ldps =3D conn_stat->legacy_device_plug_status;
 =09port->ddps =3D conn_stat->displayport_device_plug_status;
@@ -2103,21 +2125,23 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branc=
h *mstb,
 =09=09}
 =09}
=20
-=09if (!port->input) {
-=09=09int ret =3D drm_dp_port_set_pdt(port,
-=09=09=09=09=09      conn_stat->peer_device_type);
-=09=09if (ret =3D=3D 1) {
-=09=09=09dowork =3D true;
-=09=09} else if (ret < 0) {
-=09=09=09DRM_ERROR("Failed to change PDT for port %p: %d\n",
-=09=09=09=09  port, ret);
-=09=09=09dowork =3D false;
-=09=09}
+=09new_pdt =3D port->input ? DP_PEER_DEVICE_NONE : conn_stat->peer_device_=
type;
+
+=09ret =3D drm_dp_port_set_pdt(port, new_pdt);
+=09if (ret =3D=3D 1) {
+=09=09dowork =3D true;
+=09} else if (ret < 0) {
+=09=09DRM_ERROR("Failed to change PDT for port %p: %d\n",
+=09=09=09  port, ret);
+=09=09dowork =3D false;
 =09}
=20
 =09if (port->connector)
 =09=09drm_modeset_unlock(&mgr->base.lock);
+=09else if (create_connector)
+=09=09drm_dp_mst_port_add_connector(mstb, port);
=20
+out:
 =09drm_dp_mst_topology_put_port(port);
 =09if (dowork)
 =09=09queue_work(system_long_wq, &mstb->mgr->work);
--=20
2.21.0

