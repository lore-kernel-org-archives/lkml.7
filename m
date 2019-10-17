Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF19FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FD22089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlU+UtEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409270AbfJQLoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:44:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39633 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389551AbfJQLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:44:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so2188438wml.4;
        Thu, 17 Oct 2019 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tKphLTG5rDz1Oeqj0pmCIxFB6Sb2iosdUC35W2fCKWo=;
        b=tlU+UtEPC3a3HlrxERUI/LSDEK7gP9cIzDyZBdVl93+xB75AcUNELT1YnrZnxDa2/Q
         hQlNuOdI3Tl1+aQN2X1/LqOeZGUg9ROWejHRBelXLMvOtxkrs7J52XH3jXJpujzkWH5P
         kEFuEa61Zjhf7c52/9OfPepbbGTv3c8iOdzhDakBZZfFhyzl42xvH8+8Eh70GqPhKuqX
         g923U4cmqz5rBGfbrX+WgPaL4dOKHtW4JJdxUYhlp4lYMRIuxYaE2or3vQNwh6nBNyLG
         IMVuC4CC3eDBQVqr8XQF6RNxg8Kekd825FvFF7aYRh7BmVluJCVhnWKLJgRDYcbUJs5Z
         UEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tKphLTG5rDz1Oeqj0pmCIxFB6Sb2iosdUC35W2fCKWo=;
        b=tVOluZI0YxSlUtLRBRFHcgOcqKVfTW4nhmX3WeuIhd8nXNTVxOrbV+yLih1iFd8QU2
         ZiAlGFzMkbgxAIAkkb9FiuPGPJ62h6+p63uCfusDDA1H4/ID2lfDqCzcq8A39DOrFJlN
         le1hnZahJTin08q6wsHlbfHS9e4FL+sWitqLyIUqmDsS8SkNufCHO8DXkstqjaCT9LsG
         ToA5jW6XvGWE6xsbrm/VBWIJ0860gWsDcMHDxpBy7QxPvOsBCChb4E+BiEJH9fWj3e/Y
         +tL6ySdQl9B+yovvN/Ip3AOBnActeOR2elrZzL4xFol3pWDTYi94qKq7+JftBVrOesuo
         xgXQ==
X-Gm-Message-State: APjAAAXna8loHvNsrdWHQZ0g+/d+FJuST51Jrkew2/WExOqq7quU93M5
        iGARi5AMYsuYp1zcNIuTMyE=
X-Google-Smtp-Source: APXvYqzAHe7HqGQfPmIdiEERsGWfUFSwbxqOV/s4zGAk450HldnjoDMiHFlRjZivL6hhl5EDrsh+4w==
X-Received: by 2002:a7b:ca4d:: with SMTP id m13mr2573792wml.95.1571312652581;
        Thu, 17 Oct 2019 04:44:12 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id y3sm11980657wmg.2.2019.10.17.04.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:44:11 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:44:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-tegra@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Nagarjuna Kristam <nkristam@nvidia.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: phy: tegra: Add Tegra194 support
Message-ID: <20191017114410.GD3122066@ulmo>
References: <20191009024343.30218-1-jckuo@nvidia.com>
 <20191009024343.30218-4-jckuo@nvidia.com>
 <20191009233900.GA9109@bogus>
 <20191014131752.GF422231@ulmo>
 <CAL_Jsq+aKxfAir3skanfqmM+nFFzXPFL4eMa-+pq1kH-90YTbg@mail.gmail.com>
 <57692050-8284-a31f-71fd-7441823f3f2b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <57692050-8284-a31f-71fd-7441823f3f2b@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 03:48:52PM +0800, JC Kuo wrote:
> Hi Thierry, Hi Rob, Hi Kishon,
> Please let me know your thoughts of the below implementation.
>=20
> 1. Add a "bool disable_gen2" to "phy->attrs" structure.

phy->attrs is pretty bus agnostic, so adding a USB-specific property
doesn't sound like the right thing to do here.

> 2. In _of_phy_get() of phy-core.c to add the follow to parse a generic pr=
operty.
>=20
> 	phy->attrs.disable_gen2 =3D of_property_read_bool(args.np,
> 							"usb-disable-gen2");
> 3. In individual phy driver, to add SOC/PHY specific programming accordin=
gly.

Could this perhaps be done using the ->set_mode() callback? We don't
currently implement that, but we could implement it and then perhaps use
the submode parameter to distinguish between USB 3.1 Gen 1 and USB 3.1
Gen 2. Perhaps a good mapping would look like this:

	USB 3.1 Gen 1: mode =3D PHY_MODE_USB_HOST_SS, submode =3D 0x0300
	USB 3.1 Gen 2: mode =3D PHY_MODE_USB_HOST_SS, submode =3D 0x0301

The above basically reflects that USB 3.1 Gen 1 is really USB 3.0. This
would also work with other speeds:

	USB 2.0: mode =3D PHY_MODE_USB_HOST_HS, submode =3D 0x0200

etc. I suppose to make this clearer we could add defines for the various
submodes. It seems like submode may be intended to represent one of the
interface modes defined by USBPHY_INTERFACE_MODE_*, but perhaps it can
be repurposed for PHY_MODE_USB_HOST_SS?

Thierry

>=20
> Thanks,
> JC
>=20
> On 10/14/19 9:40 PM, Rob Herring wrote:
> > On Mon, Oct 14, 2019 at 8:17 AM Thierry Reding <thierry.reding@gmail.co=
m> wrote:
> >>
> >> On Wed, Oct 09, 2019 at 06:39:00PM -0500, Rob Herring wrote:
> >>> On Wed, Oct 09, 2019 at 10:43:41AM +0800, JC Kuo wrote:
> >>>> Extend the bindings to cover the set of features found in Tegra194.
> >>>> Note that, technically, there are four more supplies connected to the
> >>>> XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_P=
LL)
> >>>> , but the power sequencing requirements of Tegra194 require these to=
 be
> >>>> under the control of the PMIC.
> >>>>
> >>>> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it=
 is
> >>>> possible for some platforms have long signal trace that could not
> >>>> provide sufficient electrical environment for Gen 2 speed. To deal w=
ith
> >>>> this, a new device node property "nvidia,disable-gen2" was added to
> >>>> Tegra194 that be used to specifically disable Gen 2 speed for a
> >>>> particular USB 3.0 port so that the port can be limited to Gen 1 spe=
ed
> >>>> and avoid the instability.
> >>>
> >>> I suspect this may be a common issue and we should have a common
> >>> property. Typically, this kind of property is in the controller though
> >>> and supports multiple speed limits. See PCI bindings for inspiration.
> >>
> >> Given that support for gen 2 speeds is dependent on signal trace lengt=
h,
> >> it doesn't really make sense to restrict the whole controller to a giv=
en
> >> speed if only the signal trace for a single port exceeds the limit for
> >> which gen 2 would work.
> >>
> >> Also, the USB PHYs are in a different hardware block than the USB
> >> controller, so this really is a property of the PHY block, not the USB
> >> controller.
> >=20
> > Okay, but still should be common for USB PHYs IMO.
> >=20
> > Rob
> >=20

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2oVAkACgkQ3SOs138+
s6H0XhAAkIXr/bF4284DsOZ2ZcXx5pNP+GIEKALOqU4zATVgYWQaKG8FACjwJ1vy
TuKvlCN0w635625Cw+YzHot9ZsmaYdnr/m81QiLE74b94oClKSY3kftvdcmuOZMJ
goQERkEraMNYL2vfhPhoUJkuEqG1k3Y2pgi/BvCuct5loRAaNCSLCtjG6H4KG5tN
+36lEdTRmbtFMfc36lGdaRHb5PFe/zEXcjoJePEF56RVW9zW1/sQqIMqULYxzjh4
BAcYtJ2lJP+4/0mOJLZuqo40mVFf1p0gIPMhx0M67h9gkfNbkXb4li2+JCQ/sI9B
dCF+jz3g9L3HfLtWK3AMk1Of5id5kSG3UU23+64UfmL4MWM3xYzn7D9U9bac4k7o
Ua6XD7coC9Y8aRsQR+zSLkFC9/GmTQuOBlgPghQXUYHGN9dTymPIZHG7w1wPK8ik
R4krezTCHLB2MjtGqoFl/A1zvHcDbqJxCbZDgq1Sk5t2ekqfy5nsu6VrxtzjgTLG
p0Z7/cIyOVcj8qvb62OHS9A/zlfd2jobWRo/Hhla39cHAS4LaKWi+j9oTQ6l9z65
GeilzgAVGJiJ62oaWRI8zbXmZzaxxAOavj4WolTcL6jrmj+sfLOlqv3wh/ziXTSI
E3AVNXer0JurJCQXCBz1Iwc7TPqEp+LEMEQi9hFcWrd4S1s41to=
=mhb4
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
