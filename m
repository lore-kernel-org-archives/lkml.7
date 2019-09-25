Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4922C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7522D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/Xtt6+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392755AbfIYUIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:08:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46717 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731229AbfIYUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569442109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LcLmFqGSM1s6mN/O2t109E0X1OGHtsGizUfXFNR+Qk=;
        b=Y/Xtt6+M+bo02n6RnCb4bY6c0JakB/hdGS92w6ktrNQEs9VFQqHOphVIqgn7XrQyQVVjP+
        /nhRDjgHXDh10Bv2TLmxio6jsEjzyPgqfBHTr6bLeXBkhP4o/ybXlquc8ox69DX6Dhuv30
        u5/vMXhceXpsb7330X70M8Q+mh0OmFQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353--sKr3NVXNs6WGFzmUwXbUg-1; Wed, 25 Sep 2019 16:08:26 -0400
Received: by mail-qk1-f200.google.com with SMTP id x62so24616qkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=6RI78/QxVcqOiPhPRo7LmwwAAik3UfINvaiF/hWgBTo=;
        b=c48bqLF4z6u5EV8EF0XITa67p7Agrs248PVaQmjefv7LiutZQWzn4U39wkkvwOvSIj
         zXulP8T8Np3iFj4GcPZx1P0xHdEbAvvISlx0aXLQ7koVNsT98wpjEC6gbEKmaRJBvHLQ
         6DeYSi5lWyZhGJHPadnncRWPUoVYEzJx97Txv+MCN3mOlkWy3a/Ii5mtLWWjGxf9F+jE
         A+1U4b+b6hlBfQzGfFtrq41EFHjwHJesSf7CVoeFq5+VbIdQZFS+4QJ0eOOw7Bqdf3fc
         YRkuxas8hyDjSurIqbbjIN5vEbq5fZu/BA++W1tgk3eddBxYVjLVZ5ZDQUBiUXqPf3m0
         NmfA==
X-Gm-Message-State: APjAAAU5qXoKkg6wZkFKgfefzoeacoFmTUYmjwH5NMT9NYQemQOOwIfv
        J7ciVv8hGj7zEccFLklfSQ5qe8eP2CVj78OXdGfTr6aX7hoL3zk5NmoROQYkoBuSBVtfRJOHr/D
        Qk9/8Rj9+TFTHEmKFVZP8nHCC
X-Received: by 2002:ad4:5812:: with SMTP id dd18mr1252106qvb.136.1569442106037;
        Wed, 25 Sep 2019 13:08:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzBPRll5U6s7sHwg3laNMaq+mZa9+HRMqOD6R8stBTUPiZ2ndztI+H0jAH617UEYq1rvGtUQ==
X-Received: by 2002:ad4:5812:: with SMTP id dd18mr1252061qvb.136.1569442105560;
        Wed, 25 Sep 2019 13:08:25 -0700 (PDT)
Received: from dhcp-10-20-1-34.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id w18sm224484qts.44.2019.09.25.13.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:08:24 -0700 (PDT)
Message-ID: <e9a2638663549d86779002e3616fc2e89f9c7028.camel@redhat.com>
Subject: Re: [PATCH v2 03/27] drm/dp_mst: Destroy MSTBs asynchronously
From:   Lyude Paul <lyude@redhat.com>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Date:   Wed, 25 Sep 2019 16:08:22 -0400
In-Reply-To: <20190925181644.GD218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
         <20190903204645.25487-4-lyude@redhat.com>
         <20190925181644.GD218215@art_vandelay>
Organization: Red Hat
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-MC-Unique: -sKr3NVXNs6WGFzmUwXbUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-25 at 14:16 -0400, Sean Paul wrote:
> On Tue, Sep 03, 2019 at 04:45:41PM -0400, Lyude Paul wrote:
> > When reprobing an MST topology during resume, we have to account for th=
e
> > fact that while we were suspended it's possible that mstbs may have bee=
n
> > removed from any ports in the topology. Since iterating downwards in th=
e
> > topology requires that we hold &mgr->lock, destroying MSTBs from this
> > context would result in attempting to lock &mgr->lock a second time and
> > deadlocking.
> >=20
> > So, fix this by first moving destruction of MSTBs into
> > destroy_connector_work, then rename destroy_connector_work and friends
> > to reflect that they now destroy both ports and mstbs.
> >=20
> > Changes since v1:
> > * s/destroy_connector_list/destroy_port_list/
> >   s/connector_destroy_lock/delayed_destroy_lock/
> >   s/connector_destroy_work/delayed_destroy_work/
> >   s/drm_dp_finish_destroy_branch_device/drm_dp_delayed_destroy_mstb/
> >   s/drm_dp_finish_destroy_port/drm_dp_delayed_destroy_port/
> >   - danvet
> > * Use two loops in drm_dp_delayed_destroy_work() - danvet
> > * Better explain why we need to do this - danvet
> > * Use cancel_work_sync() instead of flush_work() - flush_work() doesn't
> >   account for work requeing
> >=20
> > Cc: Juston Li <juston.li@intel.com>
> > Cc: Imre Deak <imre.deak@intel.com>
> > Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> Took me a while to grok this, and I'm still not 100% confident my mental
> model
> is correct, so please bear with me while I ask silly questions :)
>=20
> Now that the destroy is delayed, and the port remains in the topology, is=
 it
> possible we will underflow the topology kref by calling put_mstb multiple
> times?
> It looks like that would result in a WARN from refcount.c, and wouldn't c=
all
> the
> destroy function multiple times, so that's nice :)
>=20
> Similarly, is there any defense against calling get_mstb() between destro=
y()
> and
> the delayed destroy worker running?
>=20
Good question! There's only one instance where we unconditionally grab an M=
STB
ref, drm_dp_mst_topology_mgr_set_mst(), and in that location we're guarante=
ed
to be the only one with access to that mstb until we drop &mgr->lock.
Everywhere else we use drm_dp_mst_topology_try_get_mstb(), which uses
kref_get_unless_zero() to protect against that kind of situation (and force=
s
the caller to check with __must_check)

> Sean
>=20
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 162 +++++++++++++++++---------
> >  include/drm/drm_dp_mst_helper.h       |  26 +++--
> >  2 files changed, 127 insertions(+), 61 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 3054ec622506..738f260d4b15 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -1113,34 +1113,17 @@ static void
> > drm_dp_destroy_mst_branch_device(struct kref *kref)
> >  =09struct drm_dp_mst_branch *mstb =3D
> >  =09=09container_of(kref, struct drm_dp_mst_branch, topology_kref);
> >  =09struct drm_dp_mst_topology_mgr *mgr =3D mstb->mgr;
> > -=09struct drm_dp_mst_port *port, *tmp;
> > -=09bool wake_tx =3D false;
> > =20
> > -=09mutex_lock(&mgr->lock);
> > -=09list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
> > -=09=09list_del(&port->next);
> > -=09=09drm_dp_mst_topology_put_port(port);
> > -=09}
> > -=09mutex_unlock(&mgr->lock);
> > -
> > -=09/* drop any tx slots msg */
> > -=09mutex_lock(&mstb->mgr->qlock);
> > -=09if (mstb->tx_slots[0]) {
> > -=09=09mstb->tx_slots[0]->state =3D DRM_DP_SIDEBAND_TX_TIMEOUT;
> > -=09=09mstb->tx_slots[0] =3D NULL;
> > -=09=09wake_tx =3D true;
> > -=09}
> > -=09if (mstb->tx_slots[1]) {
> > -=09=09mstb->tx_slots[1]->state =3D DRM_DP_SIDEBAND_TX_TIMEOUT;
> > -=09=09mstb->tx_slots[1] =3D NULL;
> > -=09=09wake_tx =3D true;
> > -=09}
> > -=09mutex_unlock(&mstb->mgr->qlock);
> > +=09INIT_LIST_HEAD(&mstb->destroy_next);
> > =20
> > -=09if (wake_tx)
> > -=09=09wake_up_all(&mstb->mgr->tx_waitq);
> > -
> > -=09drm_dp_mst_put_mstb_malloc(mstb);
> > +=09/*
> > +=09 * This can get called under mgr->mutex, so we need to perform the
> > +=09 * actual destruction of the mstb in another worker
> > +=09 */
> > +=09mutex_lock(&mgr->delayed_destroy_lock);
> > +=09list_add(&mstb->destroy_next, &mgr->destroy_branch_device_list);
> > +=09mutex_unlock(&mgr->delayed_destroy_lock);
> > +=09schedule_work(&mgr->delayed_destroy_work);
> >  }
> > =20
> >  /**
> > @@ -1255,10 +1238,10 @@ static void drm_dp_destroy_port(struct kref *kr=
ef)
> >  =09=09=09 * we might be holding the mode_config.mutex
> >  =09=09=09 * from an EDID retrieval */
> > =20
> > -=09=09=09mutex_lock(&mgr->destroy_connector_lock);
> > -=09=09=09list_add(&port->next, &mgr->destroy_connector_list);
> > -=09=09=09mutex_unlock(&mgr->destroy_connector_lock);
> > -=09=09=09schedule_work(&mgr->destroy_connector_work);
> > +=09=09=09mutex_lock(&mgr->delayed_destroy_lock);
> > +=09=09=09list_add(&port->next, &mgr->destroy_port_list);
> > +=09=09=09mutex_unlock(&mgr->delayed_destroy_lock);
> > +=09=09=09schedule_work(&mgr->delayed_destroy_work);
> >  =09=09=09return;
> >  =09=09}
> >  =09=09/* no need to clean up vcpi
> > @@ -2792,7 +2775,7 @@ void drm_dp_mst_topology_mgr_suspend(struct
> > drm_dp_mst_topology_mgr *mgr)
> >  =09=09=09   DP_MST_EN | DP_UPSTREAM_IS_SRC);
> >  =09mutex_unlock(&mgr->lock);
> >  =09flush_work(&mgr->work);
> > -=09flush_work(&mgr->destroy_connector_work);
> > +=09flush_work(&mgr->delayed_destroy_work);
> >  }
> >  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
> > =20
> > @@ -3740,34 +3723,104 @@ static void drm_dp_tx_work(struct work_struct
> > *work)
> >  =09mutex_unlock(&mgr->qlock);
> >  }
> > =20
> > -static void drm_dp_destroy_connector_work(struct work_struct *work)
> > +static inline void
> > +drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
> >  {
> > -=09struct drm_dp_mst_topology_mgr *mgr =3D container_of(work, struct
> > drm_dp_mst_topology_mgr, destroy_connector_work);
> > -=09struct drm_dp_mst_port *port;
> > -=09bool send_hotplug =3D false;
> > +=09port->mgr->cbs->destroy_connector(port->mgr, port->connector);
> > +
> > +=09drm_dp_port_teardown_pdt(port, port->pdt);
> > +=09port->pdt =3D DP_PEER_DEVICE_NONE;
> > +
> > +=09drm_dp_mst_put_port_malloc(port);
> > +}
> > +
> > +static inline void
> > +drm_dp_delayed_destroy_mstb(struct drm_dp_mst_branch *mstb)
> > +{
> > +=09struct drm_dp_mst_topology_mgr *mgr =3D mstb->mgr;
> > +=09struct drm_dp_mst_port *port, *tmp;
> > +=09bool wake_tx =3D false;
> > +
> > +=09mutex_lock(&mgr->lock);
> > +=09list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
> > +=09=09list_del(&port->next);
> > +=09=09drm_dp_mst_topology_put_port(port);
> > +=09}
> > +=09mutex_unlock(&mgr->lock);
> > +
> > +=09/* drop any tx slots msg */
> > +=09mutex_lock(&mstb->mgr->qlock);
> > +=09if (mstb->tx_slots[0]) {
> > +=09=09mstb->tx_slots[0]->state =3D DRM_DP_SIDEBAND_TX_TIMEOUT;
> > +=09=09mstb->tx_slots[0] =3D NULL;
> > +=09=09wake_tx =3D true;
> > +=09}
> > +=09if (mstb->tx_slots[1]) {
> > +=09=09mstb->tx_slots[1]->state =3D DRM_DP_SIDEBAND_TX_TIMEOUT;
> > +=09=09mstb->tx_slots[1] =3D NULL;
> > +=09=09wake_tx =3D true;
> > +=09}
> > +=09mutex_unlock(&mstb->mgr->qlock);
> > +
> > +=09if (wake_tx)
> > +=09=09wake_up_all(&mstb->mgr->tx_waitq);
> > +
> > +=09drm_dp_mst_put_mstb_malloc(mstb);
> > +}
> > +
> > +static void drm_dp_delayed_destroy_work(struct work_struct *work)
> > +{
> > +=09struct drm_dp_mst_topology_mgr *mgr =3D
> > +=09=09container_of(work, struct drm_dp_mst_topology_mgr,
> > +=09=09=09     delayed_destroy_work);
> > +=09bool send_hotplug =3D false, go_again;
> > +
> >  =09/*
> >  =09 * Not a regular list traverse as we have to drop the destroy
> > -=09 * connector lock before destroying the connector, to avoid AB->BA
> > +=09 * connector lock before destroying the mstb/port, to avoid AB->BA
> >  =09 * ordering between this lock and the config mutex.
> >  =09 */
> > -=09for (;;) {
> > -=09=09mutex_lock(&mgr->destroy_connector_lock);
> > -=09=09port =3D list_first_entry_or_null(&mgr->destroy_connector_list,
> > struct drm_dp_mst_port, next);
> > -=09=09if (!port) {
> > -=09=09=09mutex_unlock(&mgr->destroy_connector_lock);
> > -=09=09=09break;
> > +=09do {
> > +=09=09go_again =3D false;
> > +
> > +=09=09for (;;) {
> > +=09=09=09struct drm_dp_mst_branch *mstb;
> > +
> > +=09=09=09mutex_lock(&mgr->delayed_destroy_lock);
> > +=09=09=09mstb =3D list_first_entry_or_null(&mgr-
> > >destroy_branch_device_list,
> > +=09=09=09=09=09=09=09struct
> > drm_dp_mst_branch,
> > +=09=09=09=09=09=09=09destroy_next);
> > +=09=09=09if (mstb)
> > +=09=09=09=09list_del(&mstb->destroy_next);
> > +=09=09=09mutex_unlock(&mgr->delayed_destroy_lock);
> > +
> > +=09=09=09if (!mstb)
> > +=09=09=09=09break;
> > +
> > +=09=09=09drm_dp_delayed_destroy_mstb(mstb);
> > +=09=09=09go_again =3D true;
> >  =09=09}
> > -=09=09list_del(&port->next);
> > -=09=09mutex_unlock(&mgr->destroy_connector_lock);
> > =20
> > -=09=09mgr->cbs->destroy_connector(mgr, port->connector);
> > +=09=09for (;;) {
> > +=09=09=09struct drm_dp_mst_port *port;
> > =20
> > -=09=09drm_dp_port_teardown_pdt(port, port->pdt);
> > -=09=09port->pdt =3D DP_PEER_DEVICE_NONE;
> > +=09=09=09mutex_lock(&mgr->delayed_destroy_lock);
> > +=09=09=09port =3D list_first_entry_or_null(&mgr-
> > >destroy_port_list,
> > +=09=09=09=09=09=09=09struct
> > drm_dp_mst_port,
> > +=09=09=09=09=09=09=09next);
> > +=09=09=09if (port)
> > +=09=09=09=09list_del(&port->next);
> > +=09=09=09mutex_unlock(&mgr->delayed_destroy_lock);
> > +
> > +=09=09=09if (!port)
> > +=09=09=09=09break;
> > +
> > +=09=09=09drm_dp_delayed_destroy_port(port);
> > +=09=09=09send_hotplug =3D true;
> > +=09=09=09go_again =3D true;
> > +=09=09}
> > +=09} while (go_again);
> > =20
> > -=09=09drm_dp_mst_put_port_malloc(port);
> > -=09=09send_hotplug =3D true;
> > -=09}
> >  =09if (send_hotplug)
> >  =09=09drm_kms_helper_hotplug_event(mgr->dev);
> >  }
> > @@ -3957,12 +4010,13 @@ int drm_dp_mst_topology_mgr_init(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  =09mutex_init(&mgr->lock);
> >  =09mutex_init(&mgr->qlock);
> >  =09mutex_init(&mgr->payload_lock);
> > -=09mutex_init(&mgr->destroy_connector_lock);
> > +=09mutex_init(&mgr->delayed_destroy_lock);
> >  =09INIT_LIST_HEAD(&mgr->tx_msg_downq);
> > -=09INIT_LIST_HEAD(&mgr->destroy_connector_list);
> > +=09INIT_LIST_HEAD(&mgr->destroy_port_list);
> > +=09INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
> >  =09INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
> >  =09INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
> > -=09INIT_WORK(&mgr->destroy_connector_work,
> > drm_dp_destroy_connector_work);
> > +=09INIT_WORK(&mgr->delayed_destroy_work, drm_dp_delayed_destroy_work);
> >  =09init_waitqueue_head(&mgr->tx_waitq);
> >  =09mgr->dev =3D dev;
> >  =09mgr->aux =3D aux;
> > @@ -4005,7 +4059,7 @@ void drm_dp_mst_topology_mgr_destroy(struct
> > drm_dp_mst_topology_mgr *mgr)
> >  {
> >  =09drm_dp_mst_topology_mgr_set_mst(mgr, false);
> >  =09flush_work(&mgr->work);
> > -=09flush_work(&mgr->destroy_connector_work);
> > +=09cancel_work_sync(&mgr->delayed_destroy_work);
> >  =09mutex_lock(&mgr->payload_lock);
> >  =09kfree(mgr->payloads);
> >  =09mgr->payloads =3D NULL;
> > diff --git a/include/drm/drm_dp_mst_helper.h
> > b/include/drm/drm_dp_mst_helper.h
> > index fc349204a71b..4a4507fe928d 100644
> > --- a/include/drm/drm_dp_mst_helper.h
> > +++ b/include/drm/drm_dp_mst_helper.h
> > @@ -143,6 +143,12 @@ struct drm_dp_mst_branch {
> >  =09 */
> >  =09struct kref malloc_kref;
> > =20
> > +=09/**
> > +=09 * @destroy_next: linked-list entry used by
> > +=09 * drm_dp_delayed_destroy_work()
> > +=09 */
> > +=09struct list_head destroy_next;
> > +
> >  =09u8 rad[8];
> >  =09u8 lct;
> >  =09int num_ports;
> > @@ -575,18 +581,24 @@ struct drm_dp_mst_topology_mgr {
> >  =09struct work_struct tx_work;
> > =20
> >  =09/**
> > -=09 * @destroy_connector_list: List of to be destroyed connectors.
> > +=09 * @destroy_port_list: List of to be destroyed connectors.
> > +=09 */
> > +=09struct list_head destroy_port_list;
> > +=09/**
> > +=09 * @destroy_branch_device_list: List of to be destroyed branch
> > +=09 * devices.
> >  =09 */
> > -=09struct list_head destroy_connector_list;
> > +=09struct list_head destroy_branch_device_list;
> >  =09/**
> > -=09 * @destroy_connector_lock: Protects @connector_list.
> > +=09 * @delayed_destroy_lock: Protects @destroy_port_list and
> > +=09 * @destroy_branch_device_list.
> >  =09 */
> > -=09struct mutex destroy_connector_lock;
> > +=09struct mutex delayed_destroy_lock;
> >  =09/**
> > -=09 * @destroy_connector_work: Work item to destroy connectors. Needed=
 to
> > -=09 * avoid locking inversion.
> > +=09 * @delayed_destroy_work: Work item to destroy MST port and branch
> > +=09 * devices, needed to avoid locking inversion.
> >  =09 */
> > -=09struct work_struct destroy_connector_work;
> > +=09struct work_struct delayed_destroy_work;
> >  };
> > =20
> >  int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
> > --=20
> > 2.21.0
> >=20
--=20
Cheers,
=09Lyude Paul

