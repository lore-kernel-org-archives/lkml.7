Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC6AC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2F420657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 15:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMK8HPAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCJPg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 11:36:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42005 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCJPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 11:36:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id b74so1272199qkg.9;
        Sun, 10 Mar 2019 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gJGX0JwU9Otvc6xfybZXNJmvdXbDWvTbA2vdP2KZb+0=;
        b=AMK8HPARdm/R8isBKJzsuKJk8mG6urpu61SXVhUUFS6plhc02rKuEZqXtNHPiU5v00
         xSbuEqBCd4/df0SHuz1NeT4nPh/vkVeE8SodaKs5GGOGWm8SoaN1+n/GIO5DUXSXRLeT
         M+WrM3BSq+k2Y8D1YHTg6f5Kcs5s2u+SZ6QnYpsutAAJow57fHcoFQUMqjE8emXhNH8+
         W5k+DfuzroHrv7Pcm4gk0cKSLfknOSsf+qFGN7+/vt4uwAm9GpcHMW+GlFcgG7F0bOHT
         skX+VB4GQsltLgMbcA4B21Q9rOQTMl/fSfUgaG4VP6iAItTEpJDZomZcc8rY0qu7iJjv
         pdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gJGX0JwU9Otvc6xfybZXNJmvdXbDWvTbA2vdP2KZb+0=;
        b=h9PzGGfvOkSix7VYW8h1tl0hh7AuE8Fb1J1ng+rELM7cyCx6tqJskmyKYunriEiaI+
         Pyqs8nTjmXz+pO7nLUf0MxkQ+Onf35EWL4VScCJDMSg2M/4KdsHa6uAWw7pccIPr5tQJ
         7IowhuDJts+qx7HhG3xm7BZ9VSRU99Hm4Q6tYVjQ9K9q6eWBHDPcYd7M315UaSV9jUzK
         oGbwn+n4GwrwmO7g8yKL1GHFAjmcvMX0xUTQy5yhLzX6qSWTvsZtheREyzPFesZkLWop
         3bhTWzSs3iWMeADJopoDH5Mez80WyXi4SYhJu5W+BdUq/jdbzv8V3l6+R4UBfuOyQCnd
         LWBw==
X-Gm-Message-State: APjAAAVy5zdi3LeKB/1QQsXOONqdHQgHT2/itEGRrItQT43UTMn29jNk
        8S6al4D/ChL3FV/I3jZ77QU=
X-Google-Smtp-Source: APXvYqxIFXmvINnZrLliHerB4d2ENBhVKgQhhwJfLiefw/I2Mj/DlKnb+FFpawfhmywfcR5voWECUA==
X-Received: by 2002:a05:620a:35e:: with SMTP id t30mr21660793qkm.15.1552232184257;
        Sun, 10 Mar 2019 08:36:24 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 10sm2111731qtx.40.2019.03.10.08.36.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Mar 2019 08:36:22 -0700 (PDT)
Date:   Sun, 10 Mar 2019 12:36:18 -0300
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
Message-ID: <20190310153618.pvi2ysb3snajqmoe@smtp.gmail.com>
References: <20190226213053.GC218103@gmail.com>
 <20190226220858.214438-1-ebiggers@kernel.org>
 <20190227231202.tycdbcqtk5ylwp4k@smtp.gmail.com>
 <CACT4Y+bXsD3FjOYMnpfPz3PtUpNNkpLtxqmZPmnQuk=r2OSpDw@mail.gmail.com>
 <20190304232312.qy6x2xmtueq22m3j@smtp.gmail.com>
 <CACT4Y+bxmb6AEc3YOJ8knVjWWxNDjw7cO0YVYnpOHVE980Ymiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g5fo5fu5zxtmglip"
Content-Disposition: inline
In-Reply-To: <CACT4Y+bxmb6AEc3YOJ8knVjWWxNDjw7cO0YVYnpOHVE980Ymiw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g5fo5fu5zxtmglip
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/05, Dmitry Vyukov wrote:
> On Tue, Mar 5, 2019 at 12:23 AM Rodrigo Siqueira
> <rodrigosiqueiramelo@gmail.com> wrote:
> >
> > On 02/28, Dmitry Vyukov wrote:
> > > On Thu, Feb 28, 2019 at 12:12 AM Rodrigo Siqueira
> > > <rodrigosiqueiramelo@gmail.com> wrote:
> > > >
> > > > On 02/26, Eric Biggers wrote:
> > > > > From: Eric Biggers <ebiggers@google.com>
> > > > >
> > > > > If drm_gem_handle_create() fails in vkms_gem_create(), then the
> > > > > vkms_gem_object is freed twice: once when the reference is droppe=
d by
> > > > > drm_gem_object_put_unlocked(), and again by the extra calls to
> > > > > drm_gem_object_release() and kfree().
> > > > >
> > > > > Fix it by skipping the second release and free.
> > > > >
> > > > > This bug was originally found in the vgem driver by syzkaller usi=
ng
> > > > > fault injection, but I noticed it's also present in the vkms driv=
er.
> > > > >
> > > > > Fixes: 559e50fd34d1 ("drm/vkms: Add dumb operations")
> > > > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > > ---
> > > > >  drivers/gpu/drm/vkms/vkms_gem.c | 5 +----
> > > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vk=
ms/vkms_gem.c
> > > > > index 138b0bb325cf9..69048e73377dc 100644
> > > > > --- a/drivers/gpu/drm/vkms/vkms_gem.c
> > > > > +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> > > > > @@ -111,11 +111,8 @@ struct drm_gem_object *vkms_gem_create(struc=
t drm_device *dev,
> > > > >
> > > > >       ret =3D drm_gem_handle_create(file, &obj->gem, handle);
> > > > >       drm_gem_object_put_unlocked(&obj->gem);
> > > > > -     if (ret) {
> > > > > -             drm_gem_object_release(&obj->gem);
> > > > > -             kfree(obj);
> > > > > +     if (ret)
> > > > >               return ERR_PTR(ret);
> > > > > -     }
> > > > >
> > > > >       return &obj->gem;
> > > > >  }
> > > > > --
> > > > > 2.21.0.rc2.261.ga7da99ff1b-goog
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > Thanks for your patch! :)
> > > >
> > > > The patch looks good for me. I also tested it under the IGT tests o=
n my
> > > > local VM and everything was fine.
> >
> > Hi,
> >
> > Patch applied to drm-misc-fixes.
> >
> > > Hi Rodrigo,
> > >
> > > What are IGT tests? How can I run them?
> >
> > Hi Dmitry,
> >
> > IGT is a test suite focused on DRM drivers.
> >
> > You can clone the project using the link below:
> >
> >   https://gitlab.freedesktop.org/drm/igt-gpu-tools.git
> >
> > In the README, you will find the software dependencies. After you
> > install all the required package, just use:
> >
> >  mkdir build && meson build && cd build && ninja
>=20
> Hi Rodrigo,
>=20
> Thanks for the info, but this did not work for me.
> I installed all recommended packages (including libdw-dev), but then got:

Hi Dmitry,

I would like to recommend you to join the dri-devel channel (Freenode).
There you can quickly get help from me and others ;)

My nick in the dri-devel is 'siqueira'.

Best Regards
=20
> igt-gpu-tools$ mkdir -p build && meson build && cd build && ninja
> The Meson build system
> Version: 0.46.1
> Source dir: /src/igt-gpu-tools
> Build dir: /src/igt-gpu-tools/build
> Build type: native build
> Project name: igt-gpu-tools
> Native C compiler: ccache cc (gcc 7.3.0 "cc (Debian 7.3.0-5) 7.3.0")
> Build machine cpu family: x86_64
> Build machine cpu: x86_64
> Compiler for C supports arguments -Wbad-function-cast: YES
> Compiler for C supports arguments -Wdeclaration-after-statement: YES
> Compiler for C supports arguments -Wformat=3D2: YES
> Compiler for C supports arguments -Wimplicit-fallthrough=3D0: YES
> Compiler for C supports arguments -Wlogical-op: YES
> Compiler for C supports arguments -Wmissing-declarations: YES
> Compiler for C supports arguments -Wmissing-format-attribute: YES
> Compiler for C supports arguments -Wmissing-noreturn: YES
> Compiler for C supports arguments -Wmissing-prototypes: YES
> Compiler for C supports arguments -Wnested-externs: YES
> Compiler for C supports arguments -Wold-style-definition: YES
> Compiler for C supports arguments -Wpointer-arith: YES
> Compiler for C supports arguments -Wredundant-decls: YES
> Compiler for C supports arguments -Wshadow: YES
> Compiler for C supports arguments -Wstrict-prototypes: YES
> Compiler for C supports arguments -Wuninitialized: YES
> Compiler for C supports arguments -Wunused: YES
> Compiler for C supports arguments -Wno-clobbered -Wclobbered: YES
> Compiler for C supports arguments -Wno-maybe-uninitialized
> -Wmaybe-uninitialized: YES
> Compiler for C supports arguments -Wno-missing-field-initializers
> -Wmissing-field-initializers: YES
> Compiler for C supports arguments -Wno-pointer-arith -Wpointer-arith: YES
> Compiler for C supports arguments -Wno-sign-compare -Wsign-compare: YES
> Compiler for C supports arguments -Wno-type-limits -Wtype-limits: YES
> Compiler for C supports arguments -Wno-unused-parameter -Wunused-paramete=
r: YES
> Compiler for C supports arguments -Wno-unused-result -Wunused-result: YES
> Compiler for C supports arguments -Werror=3Daddress: YES
> Compiler for C supports arguments -Werror=3Darray-bounds: YES
> Compiler for C supports arguments -Werror=3Dimplicit: YES
> Compiler for C supports arguments -Werror=3Dinit-self: YES
> Compiler for C supports arguments -Werror=3Dint-to-pointer-cast: YES
> Compiler for C supports arguments -Werror=3Dmain: YES
> Compiler for C supports arguments -Werror=3Dmissing-braces: YES
> Compiler for C supports arguments -Werror=3Dnonnull: YES
> Compiler for C supports arguments -Werror=3Dpointer-to-int-cast: YES
> Compiler for C supports arguments -Werror=3Dreturn-type: YES
> Compiler for C supports arguments -Werror=3Dsequence-point: YES
> Compiler for C supports arguments -Werror=3Dtrigraphs: YES
> Compiler for C supports arguments -Werror=3Dwrite-strings: YES
> Found pkg-config: /usr/bin/pkg-config (0.29)
> Native dependency libdrm found: YES 2.4.91
> Native dependency libdrm_intel found: YES 2.4.91
> Native dependency libdrm_nouveau found: YES 2.4.91
> Native dependency libdrm_amdgpu found: YES 2.4.91
> Native dependency pciaccess found: YES 0.13.4
> Native dependency libkmod found: YES 24
> Native dependency libprocps found: YES 3.3.15
> Native dependency libunwind found: YES 1.21
>=20
> meson.build:151:0: ERROR:  Could not generate cargs for libdw:
>=20
> A full log can be found at /src/igt-gpu-tools/build/meson-logs/meson-log.=
txt
>=20
>=20
> and meson-log.txt ends with:
>=20
> Compiler for C supports arguments -Werror=3Dwrite-strings: YES
> Found pkg-config: /usr/bin/pkg-config (0.29)
> Determining dependency 'libdrm' with pkg-config executable '/usr/bin/pkg-=
config'
> Native dependency libdrm found: YES 2.4.91
> Determining dependency 'libdrm_intel' with pkg-config executable
> '/usr/bin/pkg-config'
> Native dependency libdrm_intel found: YES 2.4.91
> Determining dependency 'libdrm_nouveau' with pkg-config executable
> '/usr/bin/pkg-config'
> Native dependency libdrm_nouveau found: YES 2.4.91
> Determining dependency 'libdrm_amdgpu' with pkg-config executable
> '/usr/bin/pkg-config'
> Native dependency libdrm_amdgpu found: YES 2.4.91
> Determining dependency 'pciaccess' with pkg-config executable
> '/usr/bin/pkg-config'
> Native dependency pciaccess found: YES 0.13.4
> Determining dependency 'libkmod' with pkg-config executable
> '/usr/bin/pkg-config'
> Native dependency libkmod found: YES 24
> Determining dependency 'libprocps' with pkg-config executable
> '/usr/bin/pkg-config'
> Native dependency libprocps found: YES 3.3.15
> Determining dependency 'libunwind' with pkg-config executable
> '/usr/bin/pkg-config'
> Native dependency libunwind found: YES 1.21
> Determining dependency 'libdw' with pkg-config executable '/usr/bin/pkg-c=
onfig'
>=20
> meson.build:151:0: ERROR:  Could not generate cargs for libdw:

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--g5fo5fu5zxtmglip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlyFLvIACgkQWJzP/com
vP+0WA//drkwFKuj6m1VmddDUgIW5JegTIb3IcdD/3/uFsMHjuKx0rtjaoDQQaW3
JpM0TaFTBdiq4dJcvI+lXRl1yIk1xXdA/xuo0HpIyg0V3GwjdRgscMT+BozmJqLs
UO6BPG+lnLQ3jZZIXkgOePEEnPDIOLYj+RV3AapgWVi88hr6k4iDNmDzRIrRKX+i
1rlhErlgw7UwMZwYBCn+0gdCBCv0SXxRKyAPDiuGqtS8Wie5zZhdMBD7NACAqSZY
iw/lsGDyvxAipqmQJbOfFefoALr8ajJ0VsMxGQMGcbZIPBlc2dKymSGebejr3G1m
4DRseKBJbrKhyIssL1cL6PVeiqsM2L0Dsyy2Zyrrxp9IK8G06bILEozm0w3ru9ph
aHwhzlO3/L5wQp6NJ1/whqqR7fvSP7zmiCQuBDbdY6I0Lt8ZSc9GU5m7zCQpzan3
jVrZAqD7/Y3YiCdrjzZIvTnIsSyyGfXkaEdEZwTDiB4N/BlMbgelx+HaIxiJ7gBA
Bw9zfYWBj3hxRc6Ty5DQqDEDOCldnkrUoDZW/bEZVCrlGCEUMWFppdmmOhNo7k/L
Wa7AMOYwug2ZuLz5rKZKuaAP01Z2VfM0wNg9M6Y9DgzUd+gdOkiZHiZqeWJb6+iV
Nv7Fnx7QSTEjraBsDd8dbH0hlcPCN3+A4divKuPqHL1njp8yzDY=
=gqzs
-----END PGP SIGNATURE-----

--g5fo5fu5zxtmglip--
