Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D59C71142
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5199A20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGJNGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:06:20 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44547 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJNGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:06:20 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8E1BF60010;
        Wed, 10 Jul 2019 13:06:15 +0000 (UTC)
Date:   Wed, 10 Jul 2019 15:06:15 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/modes: Skip invalid cmdline mode
Message-ID: <20190710130615.gvi2jwgr2cds66xr@flea>
References: <20190709145151.23086-1-digetx@gmail.com>
 <20190710101229.54ufuhmh22dfxclr@flea>
 <4ad69d15-07f8-9753-72d6-a51402c94c20@gmail.com>
 <20190710125552.qvmnh6qs63ikiu2k@flea>
 <f530844d-70f2-c3cc-d5f6-b435f1dbdfd2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fs2o7js5tfex73gh"
Content-Disposition: inline
In-Reply-To: <f530844d-70f2-c3cc-d5f6-b435f1dbdfd2@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fs2o7js5tfex73gh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2019 at 03:59:55PM +0300, Dmitry Osipenko wrote:
> 10.07.2019 15:55, Maxime Ripard =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, Jul 10, 2019 at 03:42:28PM +0300, Dmitry Osipenko wrote:
> >> 10.07.2019 13:12, Maxime Ripard =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Tue, Jul 09, 2019 at 05:51:51PM +0300, Dmitry Osipenko wrote:
> >>>> The named mode could be invalid and then cmdline parser misses to va=
lidate
> >>>> mode's dimensions, happily adding 0x0 mode as a valid mode. One case=
 where
> >>>> this happens is NVIDIA Tegra devices that are using downstream bootl=
oader
> >>>> which adds "video=3Dtegrafb" to the kernel's cmdline and thus upstre=
am Tegra
> >>>> DRM driver fails to probe because of the invalid mode.
> >>>>
> >>>> Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command =
line")
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>
> >>> Applied to drm-misc-next-fixes
> >>>
> >>> Thanks for figuring this out!
> >>
> >> Thank you very much! So the driver now doesn't fail to probe because
> >> of the cmdline, but what else I noticed is that the framebuffer
> >> console is now rotated by 90=C2=B0 on a 800x1280 panel, while display =
in
> >> Xorg is vertical as it was before. Seems something else is still
> >> missing, reverting "drm/modes: Rewrite the command line parser"
> >> returns the framebuffer's console orientation into the original
> >> state.
> >
> > What is the whole command line passed by the bootloader ?
>
> tegraid=3D30.1.3.0.0 mem=3D1022M@2048M android.commchip=3D0 vmalloc=3D512=
M androidboot.serialno=3D015d3f18c9081210 video=3Dtegrafb no_console_suspen=
d=3D1 console=3Dnone
> debug_uartport=3Dhsport usbcore.old_scheme_first=3D1 lp0_vec=3D8192@0xbdd=
f9000 tegra_fbmem=3D8195200@0xabe01000 core_edp_mv=3D0 audio_codec=3Drt5640=
 board_info=3Df41:a00:1:44:2
> root=3D/dev/sda1 rw rootwait tegraboot=3Dsdmmc gpt gpt_sector=3D61079551 =
androidboot.bootloader=3D4.23 androidboot.baseband=3D1231_0.18.0_0409

Thanks.

It still doesn't really make sense to me why that video=3Dtegrafb should
be considered valid.

However, I don't see anything rotation related in the commit you
list. Are you sure it's really the offending one and not another one?

Also, do you have the option to recompile a kernel so that we can add
some debug?

maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fs2o7js5tfex73gh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXSXixwAKCRDj7w1vZxhR
xZJ8APwKATjjI3jXmnH2a50E0m2yRtsFtO2lofNbWAy/uAcoJAEA/td86ptP2WBi
yXQ06TZAJjZz+wKKZu0NeagAYnoHSAQ=
=5a5o
-----END PGP SIGNATURE-----

--fs2o7js5tfex73gh--
