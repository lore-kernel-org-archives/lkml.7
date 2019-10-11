Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22636C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E25218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL3PEHkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfJKUvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:51:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23676 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726354AbfJKUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570827081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wuK6DATQ4V//HJO+1AZKISVwFlXejco5yABCuAYRLxo=;
        b=AL3PEHkSekwcM0FAP6EGSlYToDNhDtwz36rGUikHVGbp3Yy027tZSlfmPFtLY4Lb71So4J
        UMpnGRiyHcmYgarX2KRaAejcnI6ElHfqALZgFi2N8C2t0GRMiF9z4DNbJHg0N0WEOJyEid
        rSeqIaRVv27y0Q+v3HtAPMnD6GQa1+w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-UeiqB8VLNCKYl97poSEVQQ-1; Fri, 11 Oct 2019 16:51:18 -0400
Received: by mail-qk1-f200.google.com with SMTP id k67so10227742qkc.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 13:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=+zuu7eYogEulpZPtegnHbQEtBXGwniTgDcVuXagVfdg=;
        b=dAN7626s5LRRMzgKiCTT2gfVIsM+JzoaMurtrfdhcHVFBnveKGDnMlzH3LRxncGIcZ
         3+OAs9FvfEXRjOMPNu/Pt130stqKX2K6CzAeXlO+Qznr9h5IVFLg0sFP42J3CaIGQg5R
         ++4+s0rFJ9x2fApuw0BswG9nF2StFfphNUmcKJilcMz1feZqsP46sZoENolfAdBW0oni
         DyhnzMtE2/6Rpgu9VKWmBCftS+lJe+mQZ69fupVxHaqQ5NdQAyfZxHbsjeq85Nixo3gS
         yJafbr7TaxI3x20Rk+LbYrA3lvgwhGIkU65Ugdk6gpBQoz5F/ci92agtlmxHRDdX22wU
         5c3g==
X-Gm-Message-State: APjAAAX5u2yS1G6kyo+JPb7Z8KVjGXXhDDayxQ1Nl3n5hX45SDjQExfv
        EF0K1S1WWMz33MCVIcu2YB9T/DLrvgVQ+ZSQdv9sJTy1J8Nb/4c1YVs6JwYPe+kidnLs2KBofaP
        1I2gBYGSbtwRXoZJSPehQTqpe
X-Received: by 2002:a37:e402:: with SMTP id y2mr18042919qkf.327.1570827077507;
        Fri, 11 Oct 2019 13:51:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMuFWtg72ENPlm8d+3ToMm4o8BcOZE4MnLrCafgNV5fwjnZME1flLvapsRIKa2DLsEeUPY2w==
X-Received: by 2002:a37:e402:: with SMTP id y2mr18042892qkf.327.1570827077207;
        Fri, 11 Oct 2019 13:51:17 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id e5sm5888785qtk.35.2019.10.11.13.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 13:51:16 -0700 (PDT)
Message-ID: <2d813b2fdf39756ebee087d97f9ee4b2965f4193.camel@redhat.com>
Subject: Re: [PATCH 5/6] drm/amdgpu/dm/mst: Report possible_crtcs
 incorrectly, for now
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Cc:     amd-gfx@lists.freedesktop.org,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 11 Oct 2019 16:51:13 -0400
In-Reply-To: <20191009150155.GD16989@phenom.ffwll.local>
References: <20190926225122.31455-1-lyude@redhat.com>
         <20190926225122.31455-6-lyude@redhat.com>
         <20190927152741.GU218215@art_vandelay>
         <20191009150155.GD16989@phenom.ffwll.local>
Organization: Red Hat
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-MC-Unique: UeiqB8VLNCKYl97poSEVQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a little late but: i915 does have this hack (or rather-possible_crtcs with =
MST
in i915 has been broken for a while and got fixed, but had to get reverted
because of this issue), it's where this originally came from.

On Wed, 2019-10-09 at 17:01 +0200, Daniel Vetter wrote:
> On Fri, Sep 27, 2019 at 11:27:41AM -0400, Sean Paul wrote:
> > On Thu, Sep 26, 2019 at 06:51:07PM -0400, Lyude Paul wrote:
> > > This commit is seperate from the previous one to make it easier to
> > > revert in the future. Basically, there's multiple userspace applicati=
ons
> > > that interpret possible_crtcs very wrong:
> > >=20
> > > https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
> > > https://gitlab.gnome.org/GNOME/mutter/issues/759
> > >=20
> > > While work is ongoing to fix these issues in userspace, we need to
> > > report ->possible_crtcs incorrectly for now in order to avoid
> > > introducing a regression in in userspace. Once these issues get fixed=
,
> > > this commit should be reverted.
> > >=20
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > > ---
> > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index b404f1ae6df7..fe8ac801d7a5 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -4807,6 +4807,17 @@ static int amdgpu_dm_crtc_init(struct
> > > amdgpu_display_manager *dm,
> > >  =09if (!acrtc->mst_encoder)
> > >  =09=09goto fail;
> > > =20
> > > +=09/*
> > > +=09 * FIXME: This is a hack to workaround the following issues:
> > > +=09 *
> > > +=09 * https://gitlab.gnome.org/GNOME/mutter/issues/759
> > > +=09 * https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
> > > +=09 *
> > > +=09 * One these issues are closed, this should be removed
> >=20
> > Even when these issues are closed, we'll still be introducing a regress=
ion
> > if we
> > revert this change. Time for actually_possible_crtcs? :)
> >=20
> > You also might want to briefly explain the u/s bug in case the links go
> > sour.
> >=20
> > > +=09 */
> > > +=09acrtc->mst_encoder->base.possible_crtcs =3D
> > > +=09=09amdgpu_dm_get_encoder_crtc_mask(dm->adev);
> >=20
> > Why don't we put this hack in amdgpu_dm_dp_create_fake_mst_encoder()?
>=20
> If we don't have the same hack for i915 mst I think we shouldn't merge
> this ... broken userspace is broken.
> -Daniel
--=20
Cheers,
=09Lyude Paul

