Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E524C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C3921D81
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JraT+YvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390801AbfIYVBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 17:01:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35517 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726375AbfIYVBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569445295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9RxYj5teBPpN/KUxlPhe/HE5yk/eAzeYmA1gJdETtY=;
        b=JraT+YvPvU6JsJMvYeLISCAwSkvi67nQmFxBNGmNuRnYQpT8VsFiD/vxDuRY6HNKjQXQeL
        0C0VPWzy0YeDPXwXjW4KCYtuPcWFI4Yq5IKkO4Z9U0dn14u4S+Ilk91vDSrjmwOkzF5anD
        +7BWcO7Cww0GAPfmHD3338G+x0KBH7Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-c4cie_0CMya_sbTKAtmbvQ-1; Wed, 25 Sep 2019 17:01:34 -0400
Received: by mail-qk1-f198.google.com with SMTP id x77so152541qka.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ScM/Ac5MkUH2MY1W8OIWpCK2OOSYqls1/6d6mwr56ho=;
        b=iyQwxK9EMPDWcS0GEMeS4OAIW+n44DD0NS3mClk0MEQJSQDWvuHe3ZDPA8MxDDiGsF
         lFUaW6NxLLtYh8dQ4xh7Pg+fXGvEI8h3Z1wP7UsRUri8MeZXdqg+IdNRvJYNWrrTDxbW
         7ih5TOpbS9YbhYtnSgSXiBuTQsV+XBwRJRngYidRMPGaF8H9k1GtIvQf6xumV8An4bcb
         u9Dfp1lcj7rH1+PXOXerqbAdL39OIxstQrqc6sh7jA+gNPNAaHcj260vQ9fv589l9g2w
         5Uvc7bjewWM8WiEwQFJ3N7BDjRwvUMZHHelXLuS2TGpS3m+ou55ii3HOBc+Yx1wQFwA9
         Khbw==
X-Gm-Message-State: APjAAAV3VioKdkuIwngSNkXHxTV26iGekPzqW0NB895QCGOGaR76j88E
        s+cMKzDrjqb789aOisIzQGK2lzsaFxwLLkJ7qgOo4SBWNvi7B0fKradtIlrrUOrTafKngoLrl7J
        Aopk+hRtruzVfPsdLH0A61l5B
X-Received: by 2002:ac8:33c3:: with SMTP id d3mr430416qtb.41.1569445293639;
        Wed, 25 Sep 2019 14:01:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJWpsoaokz/sb+P6S9S6IEQ4mDsjjRc6FBnqXoOAz30B/2lC8tj+A6OW07efkc/FKN5dGP2w==
X-Received: by 2002:ac8:33c3:: with SMTP id d3mr430385qtb.41.1569445293357;
        Wed, 25 Sep 2019 14:01:33 -0700 (PDT)
Received: from dhcp-10-20-1-34.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id b50sm29597qte.48.2019.09.25.14.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:01:32 -0700 (PDT)
Message-ID: <4134513c8cae44270f3ae76e82c579dfe32993ec.camel@redhat.com>
Subject: Re: [PATCH v2 20/27] drm/dp_mst: Protect drm_dp_mst_port members
 with connection_mutex
From:   Lyude Paul <lyude@redhat.com>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Date:   Wed, 25 Sep 2019 17:01:31 -0400
In-Reply-To: <20190925200020.GL218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
         <20190903204645.25487-21-lyude@redhat.com>
         <20190925200020.GL218215@art_vandelay>
Organization: Red Hat
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-MC-Unique: c4cie_0CMya_sbTKAtmbvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-25 at 16:00 -0400, Sean Paul wrote:
> On Tue, Sep 03, 2019 at 04:45:58PM -0400, Lyude Paul wrote:
> > Yes-you read that right. Currently there is literally no locking in
> > place for any of the drm_dp_mst_port struct members that can be modifie=
d
> > in response to a link address response, or a connection status response=
.
> > Which literally means if we're unlucky enough to have any sort of
> > hotplugging event happen before we're finished with reprobing link
> > addresses, we'll race and the contents of said struct members becomes
> > undefined. Fun!
> >=20
> > So, finally add some simple locking protections to our MST helpers by
> > protecting any drm_dp_mst_port members which can be changed by link
> > address responses or connection status notifications under
> > drm_device->mode_config.connection_mutex.
> >=20
> > Cc: Juston Li <juston.li@intel.com>
> > Cc: Imre Deak <imre.deak@intel.com>
> > Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 144 +++++++++++++++++++-------
> >  include/drm/drm_dp_mst_helper.h       |  39 +++++--
> >  2 files changed, 133 insertions(+), 50 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 5101eeab4485..259634c5d6dc 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -1354,6 +1354,7 @@ static void drm_dp_free_mst_port(struct kref *kre=
f)
> >  =09=09container_of(kref, struct drm_dp_mst_port, malloc_kref);
> > =20
> >  =09drm_dp_mst_put_mstb_malloc(port->parent);
> > +=09mutex_destroy(&port->lock);
> >  =09kfree(port);
> >  }
> > =20
> > @@ -1906,6 +1907,36 @@ void drm_dp_mst_connector_early_unregister(struc=
t
> > drm_connector *connector,
> >  }
> >  EXPORT_SYMBOL(drm_dp_mst_connector_early_unregister);
> > =20
> > +static void
> > +drm_dp_mst_port_add_connector(struct drm_dp_mst_branch *mstb,
> > +=09=09=09      struct drm_dp_mst_port *port)
> > +{
> > +=09struct drm_dp_mst_topology_mgr *mgr =3D port->mgr;
> > +=09char proppath[255];
> > +=09int ret;
> > +
> > +=09build_mst_prop_path(mstb, port->port_num, proppath, sizeof(proppath=
));
> > +=09port->connector =3D mgr->cbs->add_connector(mgr, port, proppath);
> > +=09if (!port->connector) {
> > +=09=09ret =3D -ENOMEM;
> > +=09=09goto error;
> > +=09}
> > +
> > +=09if ((port->pdt =3D=3D DP_PEER_DEVICE_DP_LEGACY_CONV ||
> > +=09     port->pdt =3D=3D DP_PEER_DEVICE_SST_SINK) &&
> > +=09    port->port_num >=3D DP_MST_LOGICAL_PORT_0) {
> > +=09=09port->cached_edid =3D drm_get_edid(port->connector,
> > +=09=09=09=09=09=09 &port->aux.ddc);
> > +=09=09drm_connector_set_tile_property(port->connector);
> > +=09}
> > +
> > +=09mgr->cbs->register_connector(port->connector);
> > +=09return;
> > +
> > +error:
> > +=09DRM_ERROR("Failed to create connector for port %p: %d\n", port, ret=
);
> > +}
> > +
> >  static void
> >  drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
> >  =09=09=09=09    struct drm_device *dev,
> > @@ -1913,8 +1944,12 @@ drm_dp_mst_handle_link_address_port(struct
> > drm_dp_mst_branch *mstb,
> >  {
> >  =09struct drm_dp_mst_topology_mgr *mgr =3D mstb->mgr;
> >  =09struct drm_dp_mst_port *port;
> > -=09bool created =3D false;
> > -=09int old_ddps =3D 0;
> > +=09struct drm_dp_mst_branch *child_mstb =3D NULL;
> > +=09struct drm_connector *connector_to_destroy =3D NULL;
> > +=09int old_ddps =3D 0, ret;
> > +=09u8 new_pdt =3D DP_PEER_DEVICE_NONE;
> > +=09bool created =3D false, send_link_addr =3D false,
> > +=09     create_connector =3D false;
> > =20
> >  =09port =3D drm_dp_get_port(mstb, port_msg->port_number);
> >  =09if (!port) {
> > @@ -1923,6 +1958,7 @@ drm_dp_mst_handle_link_address_port(struct
> > drm_dp_mst_branch *mstb,
> >  =09=09=09return;
> >  =09=09kref_init(&port->topology_kref);
> >  =09=09kref_init(&port->malloc_kref);
> > +=09=09mutex_init(&port->lock);
> >  =09=09port->parent =3D mstb;
> >  =09=09port->port_num =3D port_msg->port_number;
> >  =09=09port->mgr =3D mgr;
> > @@ -1937,11 +1973,17 @@ drm_dp_mst_handle_link_address_port(struct
> > drm_dp_mst_branch *mstb,
> >  =09=09drm_dp_mst_get_mstb_malloc(mstb);
> > =20
> >  =09=09created =3D true;
> > -=09} else {
> > -=09=09old_ddps =3D port->ddps;
> >  =09}
> > =20
> > +=09mutex_lock(&port->lock);
> > +=09drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> > +
> > +=09if (!created)
> > +=09=09old_ddps =3D port->ddps;
> > +
> >  =09port->input =3D port_msg->input_port;
> > +=09if (!port->input)
> > +=09=09new_pdt =3D port_msg->peer_device_type;
> >  =09port->mcs =3D port_msg->mcs;
> >  =09port->ddps =3D port_msg->ddps;
> >  =09port->ldps =3D port_msg->legacy_device_plug_status;
> > @@ -1969,44 +2011,58 @@ drm_dp_mst_handle_link_address_port(struct
> > drm_dp_mst_branch *mstb,
> >  =09=09}
> >  =09}
> > =20
> > -=09if (!port->input) {
> > -=09=09int ret =3D drm_dp_port_set_pdt(port,
> > -=09=09=09=09=09      port_msg->peer_device_type);
> > -=09=09if (ret =3D=3D 1) {
> > -=09=09=09drm_dp_send_link_address(mgr, port->mstb);
> > -=09=09} else if (ret < 0) {
> > -=09=09=09DRM_ERROR("Failed to change PDT on port %p: %d\n",
> > -=09=09=09=09  port, ret);
> > -=09=09=09goto fail;
> > +=09ret =3D drm_dp_port_set_pdt(port, new_pdt);
> > +=09if (ret =3D=3D 1) {
> > +=09=09send_link_addr =3D true;
> > +=09} else if (ret < 0) {
> > +=09=09DRM_ERROR("Failed to change PDT on port %p: %d\n",
> > +=09=09=09  port, ret);
> > +=09=09goto fail_unlock;
> > +=09}
> > +
> > +=09if (send_link_addr) {
> > +=09=09mutex_lock(&mgr->lock);
> > +=09=09if (port->mstb) {
> > +=09=09=09child_mstb =3D port->mstb;
> > +=09=09=09drm_dp_mst_get_mstb_malloc(child_mstb);
> >  =09=09}
> > +=09=09mutex_unlock(&mgr->lock);
> >  =09}
> > =20
> > -=09if (created && !port->input) {
> > -=09=09char proppath[255];
> > +=09/*
> > +=09 * We unset port->connector before dropping connection_mutex so tha=
t
> > +=09 * there's no chance any of the atomic MST helpers can accidentally
> > +=09 * associate a to-be-destroyed connector with a port.
> > +=09 */
> > +=09if (port->connector && port->input) {
> > +=09=09connector_to_destroy =3D port->connector;
> > +=09=09port->connector =3D NULL;
> > +=09} else if (!port->connector && !port->input) {
> > +=09=09create_connector =3D true;
> > +=09}
> > =20
> > -=09=09build_mst_prop_path(mstb, port->port_num, proppath,
> > -=09=09=09=09    sizeof(proppath));
> > -=09=09port->connector =3D (*mgr->cbs->add_connector)(mgr, port,
> > -=09=09=09=09=09=09=09     proppath);
> > -=09=09if (!port->connector)
> > -=09=09=09goto fail;
> > +=09drm_modeset_unlock(&dev->mode_config.connection_mutex);
>=20
> Do you drop this early b/c it deadlocks with something upstack? If so, I
> wonder if you could plumb an acquire context through the appropriate
> functions to avoid needing the port->lock at all?

I'll give this a shot, as it would definitely be nicer then having port->lo=
ck
>=20
> Sean
>=20
> > =20
> > -=09=09if ((port->pdt =3D=3D DP_PEER_DEVICE_DP_LEGACY_CONV ||
> > -=09=09     port->pdt =3D=3D DP_PEER_DEVICE_SST_SINK) &&
> > -=09=09    port->port_num >=3D DP_MST_LOGICAL_PORT_0) {
> > -=09=09=09port->cached_edid =3D drm_get_edid(port->connector,
> > -=09=09=09=09=09=09=09 &port->aux.ddc);
> > -=09=09=09drm_connector_set_tile_property(port->connector);
> > -=09=09}
> > +=09if (connector_to_destroy)
> > +=09=09mgr->cbs->destroy_connector(mgr, connector_to_destroy);
> > +=09else if (create_connector)
> > +=09=09drm_dp_mst_port_add_connector(mstb, port);
> > +
> > +=09mutex_unlock(&port->lock);
> > =20
> > -=09=09(*mgr->cbs->register_connector)(port->connector);
> > +=09if (send_link_addr && child_mstb) {
> > +=09=09drm_dp_send_link_address(mgr, child_mstb);
> > +=09=09drm_dp_mst_put_mstb_malloc(child_mstb);
> >  =09}
> > =20
> >  =09/* put reference to this port */
> >  =09drm_dp_mst_topology_put_port(port);
> >  =09return;
> > =20
> > -fail:
> > +fail_unlock:
> > +=09drm_modeset_unlock(&dev->mode_config.connection_mutex);
> > +=09mutex_unlock(&port->lock);
> > +
> >  =09/* Remove it from the port list */
> >  =09mutex_lock(&mgr->lock);
> >  =09list_del(&port->next);
> > @@ -2022,6 +2078,7 @@ static void
> >  drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
> >  =09=09=09    struct drm_dp_connection_status_notify *conn_stat)
> >  {
> > +=09struct drm_device *dev =3D mstb->mgr->dev;
> >  =09struct drm_dp_mst_port *port;
> >  =09int old_ddps;
> >  =09bool dowork =3D false;
> > @@ -2030,6 +2087,8 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_bra=
nch
> > *mstb,
> >  =09if (!port)
> >  =09=09return;
> > =20
> > +=09drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> > +
> >  =09old_ddps =3D port->ddps;
> >  =09port->mcs =3D conn_stat->message_capability_status;
> >  =09port->ldps =3D conn_stat->legacy_device_plug_status;
> > @@ -2055,6 +2114,7 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_bra=
nch
> > *mstb,
> >  =09=09}
> >  =09}
> > =20
> > +=09drm_modeset_unlock(&dev->mode_config.connection_mutex);
> >  =09drm_dp_mst_topology_put_port(port);
> >  =09if (dowork)
> >  =09=09queue_work(system_long_wq, &mstb->mgr->work);
> > @@ -2147,28 +2207,34 @@ drm_dp_get_mst_branch_device_by_guid(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  static void drm_dp_check_and_send_link_address(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  =09=09=09=09=09       struct drm_dp_mst_branch *mstb)
> >  {
> > +=09struct drm_device *dev =3D mgr->dev;
> >  =09struct drm_dp_mst_port *port;
> > -=09struct drm_dp_mst_branch *mstb_child;
> > +
> >  =09if (!mstb->link_address_sent)
> >  =09=09drm_dp_send_link_address(mgr, mstb);
> > =20
> >  =09list_for_each_entry(port, &mstb->ports, next) {
> > -=09=09if (port->input)
> > -=09=09=09continue;
> > +=09=09struct drm_dp_mst_branch *mstb_child =3D NULL;
> > +
> > +=09=09drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> > =20
> > -=09=09if (!port->ddps)
> > +=09=09if (port->input || !port->ddps) {
> > +=09=09=09drm_modeset_unlock(&dev-
> > >mode_config.connection_mutex);
> >  =09=09=09continue;
> > +=09=09}
> > =20
> >  =09=09if (!port->available_pbn)
> >  =09=09=09drm_dp_send_enum_path_resources(mgr, mstb, port);
> > =20
> > -=09=09if (port->mstb) {
> > +=09=09if (port->mstb)
> >  =09=09=09mstb_child =3D drm_dp_mst_topology_get_mstb_validated(
> >  =09=09=09    mgr, port->mstb);
> > -=09=09=09if (mstb_child) {
> > -=09=09=09=09drm_dp_check_and_send_link_address(mgr,
> > mstb_child);
> > -=09=09=09=09drm_dp_mst_topology_put_mstb(mstb_child);
> > -=09=09=09}
> > +
> > +=09=09drm_modeset_unlock(&dev->mode_config.connection_mutex);
> > +
> > +=09=09if (mstb_child) {
> > +=09=09=09drm_dp_check_and_send_link_address(mgr, mstb_child);
> > +=09=09=09drm_dp_mst_topology_put_mstb(mstb_child);
> >  =09=09}
> >  =09}
> >  }
> > diff --git a/include/drm/drm_dp_mst_helper.h
> > b/include/drm/drm_dp_mst_helper.h
> > index 7d80c38ee00e..1efbb086f7ac 100644
> > --- a/include/drm/drm_dp_mst_helper.h
> > +++ b/include/drm/drm_dp_mst_helper.h
> > @@ -45,23 +45,34 @@ struct drm_dp_vcpi {
> >  /**
> >   * struct drm_dp_mst_port - MST port
> >   * @port_num: port number
> > - * @input: if this port is an input port.
> > - * @mcs: message capability status - DP 1.2 spec.
> > - * @ddps: DisplayPort Device Plug Status - DP 1.2
> > - * @pdt: Peer Device Type
> > - * @ldps: Legacy Device Plug Status
> > - * @dpcd_rev: DPCD revision of device on this port
> > - * @num_sdp_streams: Number of simultaneous streams
> > - * @num_sdp_stream_sinks: Number of stream sinks
> > - * @available_pbn: Available bandwidth for this port.
> > + * @input: if this port is an input port. Protected by
> > + * &drm_device.mode_config.connection_mutex.
> > + * @mcs: message capability status - DP 1.2 spec. Protected by
> > + * &drm_device.mode_config.connection_mutex.
> > + * @ddps: DisplayPort Device Plug Status - DP 1.2. Protected by
> > + * &drm_device.mode_config.connection_mutex.
> > + * @pdt: Peer Device Type. Protected by
> > + * &drm_device.mode_config.connection_mutex.
> > + * @ldps: Legacy Device Plug Status. Protected by
> > + * &drm_device.mode_config.connection_mutex.
> > + * @dpcd_rev: DPCD revision of device on this port. Protected by
> > + * &drm_device.mode_config.connection_mutex.
> > + * @num_sdp_streams: Number of simultaneous streams. Protected by
> > + * &drm_device.mode_config.connection_mutex.
> > + * @num_sdp_stream_sinks: Number of stream sinks. Protected by
> > + * &drm_device.mode_config.connection_mutex.
> > + * @available_pbn: Available bandwidth for this port. Protected by
> > + * &drm_device.mode_config.connection_mutex.
> >   * @next: link to next port on this branch device
> >   * @mstb: branch device on this port, protected by
> >   * &drm_dp_mst_topology_mgr.lock
> >   * @aux: i2c aux transport to talk to device connected to this port,
> > protected
> > - * by &drm_dp_mst_topology_mgr.lock
> > + * by &drm_device.mode_config.connection_mutex.
> >   * @parent: branch device parent of this port
> >   * @vcpi: Virtual Channel Payload info for this port.
> > - * @connector: DRM connector this port is connected to.
> > + * @connector: DRM connector this port is connected to. Protected by
> > @lock.
> > + * When there is already a connector registered for this port, this is
> > also
> > + * protected by &drm_device.mode_config.connection_mutex.
> >   * @mgr: topology manager this port lives under.
> >   *
> >   * This structure represents an MST port endpoint on a device somewher=
e
> > @@ -100,6 +111,12 @@ struct drm_dp_mst_port {
> >  =09struct drm_connector *connector;
> >  =09struct drm_dp_mst_topology_mgr *mgr;
> > =20
> > +=09/**
> > +=09 * @lock: Protects @connector. If needed, this lock should be grabb=
ed
> > +=09 * before &drm_device.mode_config.connection_mutex.
> > +=09 */
> > +=09struct mutex lock;
> > +
> >  =09/**
> >  =09 * @cached_edid: for DP logical ports - make tiling work by ensurin=
g
> >  =09 * that the EDID for all connectors is read immediately.
> > --=20
> > 2.21.0
> >=20
--=20
Cheers,
=09Lyude Paul

