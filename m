Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59471C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295BA20844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMTQ7eJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfGHNkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:40:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45202 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbfGHNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:39:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so15923007lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=rFJ1YohAhChRBvN+rq4ZayJk8ZQVc91gQHNoz8T+GmI=;
        b=vMTQ7eJqZY5o5Dz5n2a+hG0SllLMSGixSn+JrbUtFO36GlZJ3mWkO6BM44RBISJ4dJ
         +Ntg5oRBCKceJcE5Az7Ook81sWZHD2TgMPEAeUgFc6MvOtJ8UhysuMNhOfmYXXkwdsvh
         oy979nzsd9GKHXp7bDlie9f5ANQlQar1kfxr6Eu0h1vgM+KsufAPMZWkTpgKjauleQry
         P1FSwZSjJkoOS1x8VaDGrkAzba6Zyf4nPakOuqirkN+LpAHrT1lRcDZGhLnmmewkf5of
         O2S4JCATvMS+rAkjy3YgLgavBE2IK9OuUBDbGT9/oLM7mdJymHvapns0v6t/QNj+HNep
         +zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=rFJ1YohAhChRBvN+rq4ZayJk8ZQVc91gQHNoz8T+GmI=;
        b=E4JkwFi+YKn4w59rJH4uu6lPbCvViOzUw8lvKVszIyoSjlMZ60G5+aj6jRPKCw8eRB
         v2Wnmca4Por6DufU+KiC+47CpN7wjd0fdzn0wgdowsi04nRiipdsmUEsuOITauO4cjLb
         HPxWjlSQ4iWZP7QbTDpTSvCSOxp3Vt3vJs6KrFQIgN6bRrQrIKAyT0pJhk9CiUAZ48Ko
         j8Awpp99MnISWAF8gz5FV2/NTL3h7azcWtK/+hoY2Z/uT/j/0qGDrCZKdzGg/xsYb85H
         hfYgQDvGvtyhbB/oBlffBuS8rtX+afW2H1JicjvfgjTCeX7YX8Ygehd7YdULa/Gtowma
         2s0Q==
X-Gm-Message-State: APjAAAW/AGv9No50Qdt8A+kqcgur36W9nB9k6SKNh1W2LyrhzfSWZpIo
        0Xi6NYd8MAv7CO7nTW5yTdI=
X-Google-Smtp-Source: APXvYqwF4o3SZRjPILjE2EMx4peMIcjS5/ZJ7ngkaQyollrgOkYZ9gOrxdd75DermQFoCAU43w6YYg==
X-Received: by 2002:a2e:970d:: with SMTP id r13mr10383942lji.126.1562593196852;
        Mon, 08 Jul 2019 06:39:56 -0700 (PDT)
Received: from eldfell.localdomain ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id o17sm1824019ljg.71.2019.07.08.06.39.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 06:39:56 -0700 (PDT)
Date:   Mon, 8 Jul 2019 16:39:45 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>, tzimmermann@suse.de,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/2] drm/vram: store dumb bo dimensions.
Message-ID: <20190708163945.1d3757b3@eldfell.localdomain>
In-Reply-To: <20190626162754.GV12905@phenom.ffwll.local>
References: <20190626065551.12956-1-kraxel@redhat.com>
        <20190626065551.12956-2-kraxel@redhat.com>
        <20190626144013.GB12510@ravnborg.org>
        <20190626162754.GV12905@phenom.ffwll.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wnlJH/ehfcclRFy4H4Y+==g"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wnlJH/ehfcclRFy4H4Y+==g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jun 2019 18:27:54 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Wed, Jun 26, 2019 at 04:40:13PM +0200, Sam Ravnborg wrote:
> > Hi Gerd.
> >=20
> > On Wed, Jun 26, 2019 at 08:55:50AM +0200, Gerd Hoffmann wrote: =20
> > > Store width and height of the bo.  Needed in case userspace
> > > sets up a framebuffer with fb->width !=3D bo->width..
> > >=20
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >  include/drm/drm_gem_vram_helper.h     | 1 +
> > >  drivers/gpu/drm/drm_gem_vram_helper.c | 2 ++
> > >  2 files changed, 3 insertions(+)
> > >=20
> > > diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_=
vram_helper.h
> > > index 1a0ea18e7a74..3692dba167df 100644
> > > --- a/include/drm/drm_gem_vram_helper.h
> > > +++ b/include/drm/drm_gem_vram_helper.h
> > > @@ -39,6 +39,7 @@ struct drm_gem_vram_object {
> > >  	struct drm_gem_object gem;
> > >  	struct ttm_buffer_object bo;
> > >  	struct ttm_bo_kmap_obj kmap;
> > > +	unsigned int width, height;
> > > =20
> > >  	/* Supported placements are %TTM_PL_VRAM and %TTM_PL_SYSTEM */
> > >  	struct ttm_placement placement;
> > > diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/=
drm_gem_vram_helper.c
> > > index 4de782ca26b2..c02bf7694117 100644
> > > --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> > > +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> > > @@ -377,6 +377,8 @@ int drm_gem_vram_fill_create_dumb(struct drm_file=
 *file,
> > >  	gbo =3D drm_gem_vram_create(dev, bdev, size, pg_align, interruptibl=
e);
> > >  	if (IS_ERR(gbo))
> > >  		return PTR_ERR(gbo);
> > > +	gbo->width =3D args->width;
> > > +	gbo->height =3D args->height;
> > > =20
> > >  	ret =3D drm_gem_handle_create(file, &gbo->gem, &handle);
> > >  	if (ret) =20
> >=20
> > Be warned, I may have missed something in the bigger picture.
> >=20
> > Your patch will set width and height only for dumb bo's
> > But we have several users of drm_gem_vram_create() that will
> > not set the width and height.
> >=20
> > So only in some cases can we rely on them being set.
> > Should this be refactored so we always set width, height.
> > Or maybe say in a small comment that width,height are only
> > set for dumb bo's? =20
>=20
> Also for dumb bo allocated buffers if userspace gets the dimensions wrong
> between dumb_create and the addfb, something is wrong. Papering over that
> by remembering the right dimensions doesn't look like a good solution.

Hi,

just a note irrelevant to this particular driver:

I have deliberately allocated a too high dumb buffer in userspace and
created multiple smaller DRM FBs out of it with different offsets
(i * 128 * stride). This has been a very useful hack to see that a
GPU-less driver actually honours fences correctly, because if it
doesn't, the whole image will be off by the offset delta, which is
epileptically easy to see.

So I'm not getting the height wrong, I am deliberately overallocating
and aliasing.


Thanks,
pq

--Sig_/wnlJH/ehfcclRFy4H4Y+==g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl0jR6IACgkQI1/ltBGq
qqeSQA/+J+YqrwtK1roO/I1eO3EqtoZ5Q0OMdQls7KQTtoG4X1z2oZpHtU52JvNG
xv96kK9Ci3VbIRRoO14+Qp9Rvc0k3V7QP4/l2T/+/NameNlWv5lI8MRS6rmFEP4M
0qUWWvasbP63KvRpl2k/Dr8Bg3JfeLYfisPYziV+AeUxOvEfYAAq5w5+kuYRndwB
i/DHLI0SXJsveIZRiwOwqWheMBQJDM2w3j8j+SrZ00en4M6oUgKzkIqVgLHlIm51
cmBGeVxyh+HbJ2gBBMGzOFccfKe31OgjrJv+d8FsX4KX+mojZfV9qm75I2eZp24V
GruUjf1/yifSvRXsD4CdA3AA9VCzMUrrpODO6LQvW7iRm9mHdEuWWkWZyDNTL1pr
d1eSrsX+TxQklLAmdziBw1eb6ryc87bRG5O1zfrAPItNeCULnf5VT5MjNL4Qhu5b
14i+DnOkGiiQKafMTmMVb9SwGMxR2MaBIVhQauu6RdC2C5hCZBFe96j612dDndUy
iJSBlb4xgGgDdeLD2OsyqhFEcQxg5RuvK5uRVPcy0irqs6rlyWcdcY+PLjsPj2Dt
JEbBxJgYLjsa2Dtsa5dMb7Z5wtNFXuEDbsKFWoAJhJ7vd1OxURYOkOlg/ubftzrC
7njt14ETHiyYQwY8zrWvJwixTYuLGVNzsymqPemUkXj3cc575L8=
=/yEE
-----END PGP SIGNATURE-----

--Sig_/wnlJH/ehfcclRFy4H4Y+==g--
