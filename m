Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19883C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D910C20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcwNIL1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfCDXXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:23:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40422 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDXXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:23:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so7092767qta.7;
        Mon, 04 Mar 2019 15:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ljyPL5i1WoN3mvunW9FODJ77UdH1SfcH8eqM5Yb2soE=;
        b=gcwNIL1iQ1+0Wj8XI3h8PlbN1UtG5rSZHvyweMFKgnlPRn8DGjgujKmws+Q5fLzw/l
         62WdpxNGhprcSZ/v5T9RVzT0NCsw8eQrf7KKI6Rrdek84PUDs7+9EzI4rDTXRI8UfBYl
         9I99oy8dpHGEooSiNqJpit1Qqnewx2ksB+q+MlZLa53H32cGwDnqOv6hVkj3jr2bj1SE
         BvdA1loSD8/xE9Kt3tKRVmNXPAEYnPpdY58CJAYnEYZ4Bl3U60RXXJntMWYvDAufIYc8
         P2rvzQpIBa7+vhEaKQSvvSTG+A0unKiZFXB4pACCsRtmrTskcLv1eJ9YdDyrKS/btEih
         cVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljyPL5i1WoN3mvunW9FODJ77UdH1SfcH8eqM5Yb2soE=;
        b=OxcL1bdEKlE6R4GUQUiZRoMdXP0Q81QKoDEb9DfufRP2I78w0Nl/SwqlDDoc6gbITH
         imuEr+RZFkT5vNO401nUh7DZbfhoHVA42/ookfWculWru3Q1rpO09gxFJHxd1tvtxDHw
         xqeU83SBxCSDzpilRcanOlqCI5R34DT89l4m0mNC4NN0ATjGtw0rOG6LRM+gKD2QIRue
         xstsDdilIszTqdpovlklXTpvQLz9kJjVaArvM7Kcp9YLx8HwaFT/eAZU5YNycLtvxYJt
         q5bVc/whyG0iQQufpJiVdOlt6GtmfsOXUCqoCaIKI14FbtCs+aHUJ5cjtXUqMXwuBsRt
         isBg==
X-Gm-Message-State: APjAAAXBjpIj3prQtoyzqwArqQ5lypbzXuaxL9kRqrgF8g+B8zu8EWj0
        TLFAO/dUOlM3X/cKxqCKyBo=
X-Google-Smtp-Source: APXvYqzmiG1D2BY+NGMvm+lBKgV+g/OdCqLKwtEX0k3JDyZ9xBEaR4o4Y35fbys7pZFcQCuyNl+diQ==
X-Received: by 2002:aed:3bb3:: with SMTP id r48mr16977589qte.278.1551741797321;
        Mon, 04 Mar 2019 15:23:17 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d32sm4594527qtc.88.2019.03.04.15.23.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 04 Mar 2019 15:23:16 -0800 (PST)
Date:   Mon, 4 Mar 2019 20:23:12 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vkms: fix use-after-free when
 drm_gem_handle_create() fails
Message-ID: <20190304232312.qy6x2xmtueq22m3j@smtp.gmail.com>
References: <20190226213053.GC218103@gmail.com>
 <20190226220858.214438-1-ebiggers@kernel.org>
 <20190227231202.tycdbcqtk5ylwp4k@smtp.gmail.com>
 <CACT4Y+bXsD3FjOYMnpfPz3PtUpNNkpLtxqmZPmnQuk=r2OSpDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n3twmywmxq4dmydp"
Content-Disposition: inline
In-Reply-To: <CACT4Y+bXsD3FjOYMnpfPz3PtUpNNkpLtxqmZPmnQuk=r2OSpDw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n3twmywmxq4dmydp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02/28, Dmitry Vyukov wrote:
> On Thu, Feb 28, 2019 at 12:12 AM Rodrigo Siqueira
> <rodrigosiqueiramelo@gmail.com> wrote:
> >
> > On 02/26, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > >
> > > If drm_gem_handle_create() fails in vkms_gem_create(), then the
> > > vkms_gem_object is freed twice: once when the reference is dropped by
> > > drm_gem_object_put_unlocked(), and again by the extra calls to
> > > drm_gem_object_release() and kfree().
> > >
> > > Fix it by skipping the second release and free.
> > >
> > > This bug was originally found in the vgem driver by syzkaller using
> > > fault injection, but I noticed it's also present in the vkms driver.
> > >
> > > Fixes: 559e50fd34d1 ("drm/vkms: Add dumb operations")
> > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_gem.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/v=
kms_gem.c
> > > index 138b0bb325cf9..69048e73377dc 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_gem.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> > > @@ -111,11 +111,8 @@ struct drm_gem_object *vkms_gem_create(struct dr=
m_device *dev,
> > >
> > >       ret =3D drm_gem_handle_create(file, &obj->gem, handle);
> > >       drm_gem_object_put_unlocked(&obj->gem);
> > > -     if (ret) {
> > > -             drm_gem_object_release(&obj->gem);
> > > -             kfree(obj);
> > > +     if (ret)
> > >               return ERR_PTR(ret);
> > > -     }
> > >
> > >       return &obj->gem;
> > >  }
> > > --
> > > 2.21.0.rc2.261.ga7da99ff1b-goog
> > >
> >
> > Hi,
> >
> > Thanks for your patch! :)
> >
> > The patch looks good for me. I also tested it under the IGT tests on my
> > local VM and everything was fine.

Hi,

Patch applied to drm-misc-fixes.
=20
> Hi Rodrigo,
>=20
> What are IGT tests? How can I run them?

Hi Dmitry,

IGT is a test suite focused on DRM drivers.

You can clone the project using the link below:

  https://gitlab.freedesktop.org/drm/igt-gpu-tools.git

In the README, you will find the software dependencies. After you
install all the required package, just use:

 mkdir build && meson build && cd build && ninja

Finally, if you want to test VKMS, I recommend you to do it inside a VM.

Best Regards
Rodrigo Siqueira

> >
> > Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> >
> > --
> > Rodrigo Siqueira
> > https://siqueira.tech
> > Graduate Student
> > Department of Computer Science
> > University of S=E3o Paulo
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/syzkaller-bugs/20190227231202.tycdbcqtk5ylwp4k%40smtp.gmail.com.
> > For more options, visit https://groups.google.com/d/optout.

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--n3twmywmxq4dmydp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlx9s18ACgkQWJzP/com
vP8vJg/5ATmYH8IjAS2gklfG1oaEZjYiHpEtIIM1dABXAAQVKqCf1UXUdfCoM1Sf
8sid1fGOWXBXAI9oAHiPQvii3gIShMOwxKnPA7Ul3TynYNSkm4PY/vc+Qn9KoZ7T
sN4vpYQrpVjweuAcncJVDmj9eWxsyfbvu8WrbPoz0QvPcAxYi3slMsX0zYnq1TbL
2ZUiReZdHdE9V/K08xVsdsQn5jsrU2NLZTT/BDTQlo+VfV1evSNjioc1wHW/P33m
kwdKOVh4kCxmI6k1Oc2IzxHnjtOvL65uuOMqgGPxDjFe4z3SuRXJ1OIutj6wSe9a
fc5Emzl2eGq80uibB1d0SpQZ82bUtl73b04SOUN7EcLyywPf3aryOmfexrCkUdB1
j1zA48DyRsiSjMDO3ytj/PbPa9PM9oVnKXJLfbQh5FKaUXSnfeo6a++y9aJpe/0C
klNy++3dynKqk/bATWac31TbUsVUkxIcnTnOVc+VF8PGGNMGg8R2W1hiwyp9QtFc
9Q6SJCqgmznZdLu13byMKEhpLki9xB91f/chNkK710NWRJOYki2Cwb7udyJh2UJo
YZc8X7hm6SPFwzH7KxhLVpQEGZgPi5jdJO6h4QZSobLUUVH5hZvb2wnDglWSJLsI
oRR+x+rSTzWaRlplE5t5Cmkjoon6TNM25I3PSp5tJYCKrJPBPqQ=
=efmC
-----END PGP SIGNATURE-----

--n3twmywmxq4dmydp--
