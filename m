Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA91FECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A155C20679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9V7v3Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfJITki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:40:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49523 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJITkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570650035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AES1euluYpt8pZOrifbFD6nxniRMA/NiiVgR/kvQytg=;
        b=Y9V7v3DzBkVIobpuA68tDZ+Jz3XJ1Vv71GsEGBxgGay9vgg6yWALRtCSyIzwv8iggmjL7L
        lgb3f5gAMhibtuVUtE+jBAp2leGiW6j/wXMqyRSNx1T2kTMD+9wv8038JDUsoJb9dCfBuD
        XTbZirbAExAiTl2zaAmUx1LnQHw8IE4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-vn2ZJXzPMjCfnCJrFZAhQg-1; Wed, 09 Oct 2019 15:40:32 -0400
Received: by mail-qk1-f198.google.com with SMTP id s28so3070311qkm.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 12:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=4KxjULPGLqjAZrTVsVVDxzvB76dQUgaEDF7zWxkJIms=;
        b=ovmrJma26T2Bi4flOYZnB1+UP4S5rQ/ik9yueLGkxtKSE87E+mmVYzWRytmDTSkxhd
         NKMp3JHAlXiMcXVg6XZlbzaFDBprCiEii/KIklRj1vX+tmUrjDMl475e56YfdAeeWltM
         EMZvP3YvUhEEETzceRYAzKdkXZhVue99SkCcK3M8LGeZrsCuA7FTLTHfJoTaYBTBqM3Z
         /c0lugktPwvkuejsKdl77C8S/fOtw7GzbTf2i4p3INYMKOnzwdRNyg5yx/t3TR9PQOdj
         YSlXyzCmFhNcI+n8rhmBOG75XQLqzocQjAAluhjpGIlxcmleN5G/n+I1BNlrdfZXQ0/M
         Ireg==
X-Gm-Message-State: APjAAAVjPTPvxqC02gtXHovfGP897kWm4KtSpun6E37BG0YfpedCbdwd
        OQpZZgmKke00TYVgzdoxStQyYzytnY+nwgYRZFQjRAGJdacxPNr5shLu/ndv94kUFvxln6QXmaq
        qtZhgX8UkFS/5MuNYz3Lcdan3
X-Received: by 2002:ac8:6683:: with SMTP id d3mr5538957qtp.85.1570650031902;
        Wed, 09 Oct 2019 12:40:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzTfbsLv4+WnHvBD3IUlVlWZk20K6FFZoR9W+ieQtbpCsR8I5HeuaYr+WgOErds/sxPg/WDDw==
X-Received: by 2002:ac8:6683:: with SMTP id d3mr5538940qtp.85.1570650031595;
        Wed, 09 Oct 2019 12:40:31 -0700 (PDT)
Received: from dhcp-10-20-1-34.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id 139sm1451793qkf.14.2019.10.09.12.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 12:40:30 -0700 (PDT)
Message-ID: <308f0fe3bf2705a975d4b1f9dfd16dc07724d454.camel@redhat.com>
Subject: Re: [PATCH v2 26/27] drm/dp_mst: Also print unhashed pointers for
 malloc/topology references
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
Date:   Wed, 09 Oct 2019 15:40:29 -0400
In-Reply-To: <20190927142510.GS218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
         <20190903204645.25487-27-lyude@redhat.com>
         <20190927142510.GS218215@art_vandelay>
Organization: Red Hat
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-MC-Unique: vn2ZJXzPMjCfnCJrFZAhQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey! Re: our discussion about this at XDC, I think I'm going to drop this
patch and just fix KASAN so it prints the hashed pointer as well, I'll cc y=
ou
on the patches for that as well

On Fri, 2019-09-27 at 10:25 -0400, Sean Paul wrote:
> On Tue, Sep 03, 2019 at 04:46:04PM -0400, Lyude Paul wrote:
> > Currently we only print mstb/port pointer addresses in our malloc and
> > topology refcount functions using the hashed-by-default %p, but
> > unfortunately if you're trying to debug a use-after-free error caused b=
y
> > a refcounting error then this really isn't terribly useful. On the othe=
r
> > hand though, everything in the rest of the DP MST helpers uses hashed
> > pointer values as well and probably isn't useful to convert to unhashed=
.
> > So, let's just get the best of both worlds and print both the hashed an=
d
> > unhashed pointer in our malloc/topology refcount debugging output. This
> > will hopefully make it a lot easier to figure out which port/mstb is
> > causing KASAN to get upset.
> >=20
> > Cc: Juston Li <juston.li@intel.com>
> > Cc: Imre Deak <imre.deak@intel.com>
> > Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> It's really too bad there isn't a CONFIG_DEBUG_SHOW_PK_ADDRESSES or even =
a
> value
> of kptr_restrict value that bypasses pointer hashing. I'm sure we're not =
the
> only ones to feel this pain. Maybe everyone just hacks vsnprintf...
>=20
> As it is, I'm not totally sold on exposing the actual addresses
> unconditionally.
> What do you think about pulling the print out into a function and only
> printing
> px if a debug kconfig is set?
>=20
> Sean
>=20
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 34 ++++++++++++++++-----------
> >  1 file changed, 20 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 2fe24e366925..5b5c0b3b3c0e 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -1327,7 +1327,8 @@ static void
> >  drm_dp_mst_get_mstb_malloc(struct drm_dp_mst_branch *mstb)
> >  {
> >  =09kref_get(&mstb->malloc_kref);
> > -=09DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->malloc_kref));
> > +=09DRM_DEBUG("mstb %p/%px (%d)\n",
> > +=09=09  mstb, mstb, kref_read(&mstb->malloc_kref));
> >  }
> > =20
> >  /**
> > @@ -1344,7 +1345,8 @@ drm_dp_mst_get_mstb_malloc(struct drm_dp_mst_bran=
ch
> > *mstb)
> >  static void
> >  drm_dp_mst_put_mstb_malloc(struct drm_dp_mst_branch *mstb)
> >  {
> > -=09DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->malloc_kref) - 1=
);
> > +=09DRM_DEBUG("mstb %p/%px (%d)\n",
> > +=09=09  mstb, mstb, kref_read(&mstb->malloc_kref) - 1);
> >  =09kref_put(&mstb->malloc_kref, drm_dp_free_mst_branch_device);
> >  }
> > =20
> > @@ -1379,7 +1381,8 @@ void
> >  drm_dp_mst_get_port_malloc(struct drm_dp_mst_port *port)
> >  {
> >  =09kref_get(&port->malloc_kref);
> > -=09DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->malloc_kref));
> > +=09DRM_DEBUG("port %p/%px (%d)\n",
> > +=09=09  port, port, kref_read(&port->malloc_kref));
> >  }
> >  EXPORT_SYMBOL(drm_dp_mst_get_port_malloc);
> > =20
> > @@ -1396,7 +1399,8 @@ EXPORT_SYMBOL(drm_dp_mst_get_port_malloc);
> >  void
> >  drm_dp_mst_put_port_malloc(struct drm_dp_mst_port *port)
> >  {
> > -=09DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->malloc_kref) - 1=
);
> > +=09DRM_DEBUG("port %p/%px (%d)\n",
> > +=09=09  port, port, kref_read(&port->malloc_kref) - 1);
> >  =09kref_put(&port->malloc_kref, drm_dp_free_mst_port);
> >  }
> >  EXPORT_SYMBOL(drm_dp_mst_put_port_malloc);
> > @@ -1447,8 +1451,8 @@ drm_dp_mst_topology_try_get_mstb(struct
> > drm_dp_mst_branch *mstb)
> >  =09int ret =3D kref_get_unless_zero(&mstb->topology_kref);
> > =20
> >  =09if (ret)
> > -=09=09DRM_DEBUG("mstb %p (%d)\n", mstb,
> > -=09=09=09  kref_read(&mstb->topology_kref));
> > +=09=09DRM_DEBUG("mstb %p/%px (%d)\n",
> > +=09=09=09  mstb, mstb, kref_read(&mstb->topology_kref));
> > =20
> >  =09return ret;
> >  }
> > @@ -1471,7 +1475,8 @@ static void drm_dp_mst_topology_get_mstb(struct
> > drm_dp_mst_branch *mstb)
> >  {
> >  =09WARN_ON(kref_read(&mstb->topology_kref) =3D=3D 0);
> >  =09kref_get(&mstb->topology_kref);
> > -=09DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->topology_kref));
> > +=09DRM_DEBUG("mstb %p/%px (%d)\n",
> > +=09=09  mstb, mstb, kref_read(&mstb->topology_kref));
> >  }
> > =20
> >  /**
> > @@ -1489,8 +1494,8 @@ static void drm_dp_mst_topology_get_mstb(struct
> > drm_dp_mst_branch *mstb)
> >  static void
> >  drm_dp_mst_topology_put_mstb(struct drm_dp_mst_branch *mstb)
> >  {
> > -=09DRM_DEBUG("mstb %p (%d)\n",
> > -=09=09  mstb, kref_read(&mstb->topology_kref) - 1);
> > +=09DRM_DEBUG("mstb %p/%px (%d)\n",
> > +=09=09  mstb, mstb, kref_read(&mstb->topology_kref) - 1);
> >  =09kref_put(&mstb->topology_kref, drm_dp_destroy_mst_branch_device);
> >  }
> > =20
> > @@ -1546,8 +1551,8 @@ drm_dp_mst_topology_try_get_port(struct
> > drm_dp_mst_port *port)
> >  =09int ret =3D kref_get_unless_zero(&port->topology_kref);
> > =20
> >  =09if (ret)
> > -=09=09DRM_DEBUG("port %p (%d)\n", port,
> > -=09=09=09  kref_read(&port->topology_kref));
> > +=09=09DRM_DEBUG("port %p/%px (%d)\n",
> > +=09=09=09  port, port, kref_read(&port->topology_kref));
> > =20
> >  =09return ret;
> >  }
> > @@ -1569,7 +1574,8 @@ static void drm_dp_mst_topology_get_port(struct
> > drm_dp_mst_port *port)
> >  {
> >  =09WARN_ON(kref_read(&port->topology_kref) =3D=3D 0);
> >  =09kref_get(&port->topology_kref);
> > -=09DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->topology_kref));
> > +=09DRM_DEBUG("port %p/%px (%d)\n",
> > +=09=09  port, port, kref_read(&port->topology_kref));
> >  }
> > =20
> >  /**
> > @@ -1585,8 +1591,8 @@ static void drm_dp_mst_topology_get_port(struct
> > drm_dp_mst_port *port)
> >   */
> >  static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
> >  {
> > -=09DRM_DEBUG("port %p (%d)\n",
> > -=09=09  port, kref_read(&port->topology_kref) - 1);
> > +=09DRM_DEBUG("port %p/%px (%d)\n",
> > +=09=09  port, port, kref_read(&port->topology_kref) - 1);
> >  =09kref_put(&port->topology_kref, drm_dp_destroy_port);
> >  }
> > =20
> > --=20
> > 2.21.0
> >=20
--=20
Cheers,
=09Lyude Paul

