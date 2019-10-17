Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A7EFA3736
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD632089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j72IxVpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502235AbfJQMBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:01:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43159 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502217AbfJQMBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:01:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so2019162wrq.10;
        Thu, 17 Oct 2019 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ez9CbL63sX7gDGh2tYpWp8dJ1bNhw8H/uQewxmgXJH0=;
        b=j72IxVpRwR2WtFRCiH85HtKgQidkglY9F1ZTbkFhzRVXYtHCSVjqmXfrSlLzw+Fiit
         C+w67spnL5+ezkB5aaoCF/SuBVhkF8F2WKRpUkLAhptxAvxbcXRjrtdyFzlL7WyKcNCI
         anGdB+rrahzlKDTc+UXVw2VvBglXcD1GdMGLV0tYOPfI18gs1JPcNBWhepCXu4QQBsw1
         RK9aPFm4OKRpN46A20GHLdhJg1JeixMj6rcnvwPhOEKvKZ/XonvQe4yqVy1sVtSQXf5e
         op3/6jLGHpmbxW5XaQDdfwKCmK+evW+MZplTmhGoVqRoHmUYwAWmcNMJynPKfJRYRk7A
         +1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ez9CbL63sX7gDGh2tYpWp8dJ1bNhw8H/uQewxmgXJH0=;
        b=siz48idrHtkXiCoZOqm+6dZWFUoPZOrNYBKtcVtEmc1TTeo/dOO3eC/aKAsZ6edIcg
         z44qtFXWSmvl4ihrXyJk2FVfLG0U/9cmtbCA5Il9c+V4edF+cQNdyimJV5r1CQs4bUnh
         lmzraPXdrj4qqOupXsCdtETOqmH1uCZ+n8Xf26AdKjg71c6jofRzeQyt4qH2AclgMzYJ
         y/tlOAEddWCyVxbJURTPYA631gn0Q6zCHrv/fUSwHLEd1QRfM09uGYGoznqbWtClGVWj
         aho8xwiDhvVh3XTTWehK8q7dRDcQvhxIz3L+6uAdyy0ejRJlMPL1CjWiuS+196PubvZh
         l3kQ==
X-Gm-Message-State: APjAAAX5xfdqsL3WIllw7DOYcYk9yQck82bBn1fMf6aqjjZnggTYV9D1
        2OJpgODx8OFWhRsLOabaEWM=
X-Google-Smtp-Source: APXvYqzYQd9TKwpkKLqmNcrY3grnLtu5vU4vNyoc+UoM+SlJAjn5JTdas8JauIoD8/BhDV9KbpjcPg==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr2590018wrq.208.1571313693027;
        Thu, 17 Oct 2019 05:01:33 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id n1sm2094533wrg.67.2019.10.17.05.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 05:01:29 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:01:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>, Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-tegra@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Nagarjuna Kristam <nkristam@nvidia.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: phy: tegra: Add Tegra194 support
Message-ID: <20191017120128.GE3122066@ulmo>
References: <20191009024343.30218-1-jckuo@nvidia.com>
 <20191009024343.30218-4-jckuo@nvidia.com>
 <20191009233900.GA9109@bogus>
 <20191014131752.GF422231@ulmo>
 <CAL_Jsq+aKxfAir3skanfqmM+nFFzXPFL4eMa-+pq1kH-90YTbg@mail.gmail.com>
 <57692050-8284-a31f-71fd-7441823f3f2b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <57692050-8284-a31f-71fd-7441823f3f2b@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 03:48:52PM +0800, JC Kuo wrote:
> Hi Thierry, Hi Rob, Hi Kishon,
> Please let me know your thoughts of the below implementation.
>=20
> 1. Add a "bool disable_gen2" to "phy->attrs" structure.
> 2. In _of_phy_get() of phy-core.c to add the follow to parse a generic pr=
operty.
>=20
> 	phy->attrs.disable_gen2 =3D of_property_read_bool(args.np,
> 							"usb-disable-gen2");

Regarding this, I'm not sure how Rob imagined the generic properties to
work. Perhaps he was thinking about something like the max-link-speed
property found in the PCI bindings.

We could have something like this:

  - max-link-speed:
      If present this property specifies the USB generation supported on
      the PHY/port. Must be:
        1: for USB 3.1 Gen 1 (a.k.a. USB 3.0)
        2: for USB 3.1 Gen 2

I'm not sure if we need to consider anything prior to USB 3.0. I suppose
we could do a similar mapping to what I proposed for the PHY ->set_mode
callback:

  - max-link-speed:
      If present this property specifies the USB generation supported on
      the PHY/port. Must be:
        0x0100: for USB 1.0 (Low-Speed)
        0x0101: for USB 1.1 (Full-Speed)
        0x0200: for USB 2.0 (Hi-Speed)
        0x0300: for USB 3.0 (SuperSpeed) (a.k.a. USB 3.1 Gen 1)
        0x0301: for USB 3.1 (SuperSpeed 10 Gbit/s) (a.k.a. USB 3.1 Gen 2)
        0x0302: for USB 3.2 (SuperSpeed 20 Gbit/s) (a.k.a. USB 3.2 Gen 2 x =
2)
        ...

Or those could just be sequentially enumerated, like in the above
example.

Rob, any thoughts?

Thierry

> 3. In individual phy driver, to add SOC/PHY specific programming accordin=
gly.
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

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2oWBUACgkQ3SOs138+
s6H6Lg//Z16LUbdt8qinrY+mOKkJzVJyY9gk+oxK+7eqnRev93F97H/5xmv+XL4y
WL5gKVxkEzbuca0zrpU/nK0xxNRVQhCXQkCv7ao2dc4M16ZxUUKG6Hskgv1Pa4Ll
nHcmxN6lNmnCH+RVmYM+AoojBUAmaxbga1atV96DBY/6lqxUl3CtkHNFzSyfGw1S
TQ5er1i1HpEuHOqY1Fsx2XTo0x3akWJgtPL/wvnw/exNN+tPXOdgXqJXvU3LF8S1
3bFVF/o23jN6FBnVtzTsaLR5lZyOc5HhvDiwtOUWptck0wmWmeOiL4G5QGj0Cks4
pN5BVm7Of69i5YLWWJWM6VWX8Mo27l+/u/fUkqvyp5QpTpGdrArVbOWhZg+iqpsH
gSeU7Uhw6xdvTrgqnH+5wKH6vdb82W19SQ+xeu01mEiMHsUp0CneAxoafQrH5DIy
TKDfegIEfEGzEbDNYUn1k7ZMjF+5tO1JCOQ6ExLpIknbShWJG7cCi0w0qpeni83F
73H7Sk/32VjO4TJDUe6PbdEBrmGDWHDU3S6cZpgOTujd+tbD+1TNTL3rA40pRXoo
8ikBMJlfKDlnKjhdCtIrtT+OgOlSeA6poK73FfK/I2pvqZuCGNoGuubsvyel1xoK
3egGGoIm5LMurdn4oazcaMcPJt2/YABalS1AYgoJ+6Y+y+oKWnw=
=wH+F
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
