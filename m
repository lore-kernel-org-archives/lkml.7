Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A58CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F34B20659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXkfrlW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393838AbfJXNuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:50:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39879 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbfJXNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:50:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id r141so2680918wme.4;
        Thu, 24 Oct 2019 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BNVT8s5YLvHt7gxW7SLpEK9iP3Gh4HQHf+HDtpo3lNo=;
        b=cXkfrlW/4fM9olewKWD+UO6INbtmib8tnXAdXioxT6aF3jB5LnTGQHwBkRXgtC/qvN
         FCHuG3FKIzQrt8+Ux9fPw2+ZGprDlI5mc/nsymvm8ZFUZYLJJbNo3B4etcJqSrTI1gG8
         DLIz/gXXY+g1Awfmg/4zcTQVAM61neYCcd06/MSVNBZYxct1wT5yzkApdiVXZzTiD5+0
         doVXP6OCKqWdsy9PtGeH52EGo+c7gQRc870gwSbrZCEKQksMI2dvZpIA/8u0xt2ZEk8O
         QueQslfgLDZCa9Dl7uVPR/WSPMpUqFK5gGlEAiVNDlK21nFLo9lYpClyIZ6Lcm86W8Ca
         bFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BNVT8s5YLvHt7gxW7SLpEK9iP3Gh4HQHf+HDtpo3lNo=;
        b=oMFe/qQ0vSrp1hzkqYQ5VwB9xBFmGJjIBReSJeMQoITy9b9MDgqbOHLwQPc1WmR47c
         oCqGSqqQC7KsqxWX5OdoicY5sxtHdhh+dDLwZq099QLaQtiluMhvbIKDjIjt3I3B36u0
         FXE2p2wNQqzsM8kO7N1AuHcJXnzzVhEiwC+6m2Zc+7UaDlRL6RIvMO0oIEwEHuhPA0Zp
         lF8o7OiweJdl9TU/Ga8Ky3xN7Kgwc7pKnaqNOZ0TMx52DgqlXLaw9QFYMs7TaxwNiZu0
         dYJfw9uWfsVhf7Po7/d+sNfVIdhNQ7GrRpR02F+/dmCBONv5omYwFgDX+m0I6aGQUMoO
         mHyw==
X-Gm-Message-State: APjAAAWpCOUxwFDuM0mvOBZHTSE3o+PglU4kr0oM88gTNuDb8e1IaeVo
        EJb9CyaJzjch9IQT7vD3m6o0jdPD
X-Google-Smtp-Source: APXvYqyLpFMf0M3rkZjmRIwdx9h/rq2fKSXG/zj0MjpFy6R0GgeMfd5gHwKEPuKWVMJD4fRVLyBrgg==
X-Received: by 2002:a1c:e154:: with SMTP id y81mr5110281wmg.126.1571925021103;
        Thu, 24 Oct 2019 06:50:21 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id e3sm2690812wme.39.2019.10.24.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:50:19 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:50:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drm/tegra: Fix 2d and 3d clients detaching from
 IOMMU domain
Message-ID: <20191024135018.GD2924027@ulmo>
References: <20190623173743.24088-1-digetx@gmail.com>
 <20190623173743.24088-2-digetx@gmail.com>
 <20191024115804.GB2924027@ulmo>
 <45926d95-3e7a-c56b-402a-2b2c6475c5db@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <45926d95-3e7a-c56b-402a-2b2c6475c5db@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 04:28:41PM +0300, Dmitry Osipenko wrote:
> 24.10.2019 14:58, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, Jun 23, 2019 at 08:37:42PM +0300, Dmitry Osipenko wrote:
> >> This should should fire up on the DRM's driver module re-loader because
> >> there won't be enough available domains on older Tegra SoCs.
> >>
> >> Cc: stable <stable@vger.kernel.org>
> >> Fixes: 0c407de5ed1a ("drm/tegra: Refactor IOMMU attach/detach")
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/gpu/drm/tegra/dc.c   | 4 ++--
> >>  drivers/gpu/drm/tegra/drm.c  | 9 ++++++---
> >>  drivers/gpu/drm/tegra/drm.h  | 3 ++-
> >>  drivers/gpu/drm/tegra/gr2d.c | 4 ++--
> >>  drivers/gpu/drm/tegra/gr3d.c | 4 ++--
> >>  5 files changed, 14 insertions(+), 10 deletions(-)
> >=20
> > I think I understand what this is trying to do, but the commit message
> > does not help at all. So what's really going on here is that we need to
> > detach the device from the group regardless of whether we're sharing the
> > group or not, just like we attach groups to the shared domain whether
> > they share the same group or not.
>=20
> Yes, the commit's message could be improved.
>=20
> > But in that case, I wonder if it's even worth splitting groups the way
> > we are right now. Wouldn't it be better to just put all the devices into
> > the same group and be done with it?
> >=20
> > The current code gives me headaches every time I read it, so if we can
> > just make it so that all the devices under the DRM device share the same
> > group, this would become a lot easier to deal with. I'm not really
> > convinced that it makes much sense to keep them on separate domains,
> > especially given the constraints on the number of domains available on
> > earlier Tegra devices.
> >=20
> > Note that sharing a group will also make it much easier for these to use
> > the DMA API if it is backed by an IOMMU.
>=20
> Probably I'm blanking on everything about IOMMU now.. could you please
> remind me what "IOMMU group" is?
>=20
> Isn't it that each IOMMU group relates to the HW ID (SWGROUP)? But then
> each display controller has its own SWGROUP.. and thus that sharing just
> doesn't make any sense, hm.

IOMMU groups are not directly related to SWGROUPs. But by default the
IOMMU framework will share a domain between members of the same IOMMU
group. Seems like that's really what we want here, so that when we do
use the DMA API, all the devices part of the DRM device get attached to
the same IOMMU domain, yet if we don't want to use the DMA API we only
need to detach the one group from the backing.

Thierry

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2xrBoACgkQ3SOs138+
s6HAxA/5AeNjNjEtlebhSve7R8IrbcFhMUsOJ4W+Kk3Fht2LEborZyXuxc8rAu+a
4ddRKtOPBDigYniq484cKh+HrDvpj3O0tkcoPotx84I7r0fDpyqdt/s47p3mOlLB
pGeCEDR8RoQyfxPfKwVQOITYVlJ7GspcYheBWZUM2gaIdFJn9gK20gd5QITlYWMj
IjjNOejpHSahXqoHKJ9pOWiNiW4YR6e0vciegEqYddRBIy3qhl34UsfQew0SejqU
61J+mmcb0YyB5WnipM91yUZlVIG5s6iR+GzPXyMwiLIVIJRz/j7zT8gptFED+tGy
/toXxINL3toi/t2jceIB0A7qTjUQ38UKkc/HNcsY9EJ+aeB/oOKX2KcwZjKTZjct
KTuYrMVhOZfB4FSLy+0hRpmi2/wf7RSjmSV2g22eHPtvw5y0hmENIZBYPZn29O22
lW/I/71RSYl0cJ61hxwzhZCpRx/zINKp63GFyZhtmxuR0uftEjLkZV1msItRZbOl
3khkuU+ccAeLXr3P2LyriTGnhP0Jz73uC+KH6tZ4jcdJHFBP0q70TtROa3hBKY1Q
TXE0pFDFdM8rA14IrqBIaNj4tdQoMrSVZhhlhy8loABjJ8azys+VW6SQGx4+lo0z
EKyDaMw3lL9EwP8plsTqZHDSCHRO1BnsOuFhoBnDEJt8zgeEDwE=
=YETi
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
