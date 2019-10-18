Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99708CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7728F21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634324AbfJRPCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:02:43 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47445 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634283AbfJRPCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:02:42 -0400
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7412A100004;
        Fri, 18 Oct 2019 15:02:36 +0000 (UTC)
Date:   Fri, 18 Oct 2019 17:04:26 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 0/7] backlight: gpio: simplify the driver
Message-ID: <20191018150426.7w5q55nhkiqbqhuk@uno.localdomain>
References: <20191007033200.13443-1-brgl@bgdev.pl>
 <20191014081220.GK4545@dell>
 <CACRpkda9Kco-bVPw1OA6FMpQ1L8dZ4WFJ227wTCM9rh5JE7-+A@mail.gmail.com>
 <20191016130536.222vsi5whkoy6vzo@uno.localdomain>
 <20191017072550.GK4365@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jig6tcqnwznz3xde"
Content-Disposition: inline
In-Reply-To: <20191017072550.GK4365@dell>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jig6tcqnwznz3xde
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 17, 2019 at 08:25:50AM +0100, Lee Jones wrote:
> On Wed, 16 Oct 2019, Jacopo Mondi wrote:
>
> > Hi, sorry for not having replied earlier
> >
> > On Wed, Oct 16, 2019 at 02:56:57PM +0200, Linus Walleij wrote:
> > > On Mon, Oct 14, 2019 at 10:12 AM Lee Jones <lee.jones@linaro.org> wro=
te:
> > >
> > > > >  arch/sh/boards/mach-ecovec24/setup.c         |  33 ++++--
> > > >
> > > > I guess we're just waiting for the SH Acks now?
> > >
> > > The one maintainer with this board is probably overloaded.
> > >
> > > I would say just apply it, it can't hold back the entire series.
> >
> > I've been able to resurect the Ecovec, and I've also been given a copy
> > of its schematics file a few weeks ago.
> >
> > It's in my TODO list to test this series but I didn't manage to find
> > time. If I pinky promise I get back to you before end of the week,
> > could you wait for me ? :)

Finally had some time to spend on this.

As I've reported to Bartosz, this version does not work on Ecovec out
of the box, as the GPIO line connected to the backlight needs to be
configured to work in output mode before registering the backlight
device.

With this simple change:

$ git diff
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-eco=
vec24/setup.c
index dd427bac5cde..eec6e805c3ed 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1473,6 +1473,7 @@ static int __init arch_setup(void)
 #endif
 #endif

+       gpio_direction_output(GPIO_PTR1, 1);
        gpiod_add_lookup_table(&gpio_backlight_lookup);
        gpio_backlight_device =3D platform_device_register_full(
                                        &gpio_backlight_device_info);

I can now control the gpio through the backlight interface.

So please add this bit on top of next iteration and add my:
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks and sorry for the long time it took!

>
> Yes, no problem.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

--jig6tcqnwznz3xde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl2p1HoACgkQcjQGjxah
Vjw07Q//bXUAvYL4NvrQlWy03A4kCrvX0kolkx71JTQHnVprfyCz2qyP1BvfL7Cc
VM0CnuW2dGjWKd1/9Fx9ltM25fbm/OJzGLCa+OLeGH54sTUzDTAwdkDkpqLAVM16
lOx7QxHu+prPYDwbjwnS6lvO+SppEigTCV+NPXT2Y7qKkYiNb9COLsiYu+hkXAia
lxyogP5H+JWKEPLK5uYhASSqKCcxgu39dIWxItj7+mfjOBiUHOFCpHIee2kY1+Q2
+wrIXrET20X4YDvCQPZd2egXin5k+hLD0LtR9Gcel+w4Eikg7vB8vRm7I0NJ2g5a
FbOpRDdyLj+7uh4vyNeW8gbrnsJ4qPhtb5KxUlQ48WVrIhtLsfLnYqN/WjN4n2ET
lR6BKAjyZuo7PQ9xBzU0/O2s7bCOsLVHTu3iH97ZWy5KMbXEuKMCxK4UGiGjyYmX
mhqSDXEamf7x/8NqJmEZ/iam4/9GbrMa7p0uQVODMz3xJjgkjMbSvWCNMoqe4vv+
hM5JyuSDKvrJ7DHXi8TNXb6l5iInQVijhRPh/k2YrwA22DKcxrn42QMb1XmIZgTh
1Db7DHdBOULpQIxDjzJ7zOOOH1GbCO6SlMtRzwMuT8O2PuX8W6PkFd32UDjZgyPQ
tAy24dJqceX2t2EVUY86PWKi3hH6fmtkTzVbVw8JNLl61ZATd3I=
=T0RW
-----END PGP SIGNATURE-----

--jig6tcqnwznz3xde--
