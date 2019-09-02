Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660FCC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329D821881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVySUU1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbfIBOwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:52:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39566 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbfIBOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:52:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id u6so10007081edq.6;
        Mon, 02 Sep 2019 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=24FRW/WZxXq/QDNoUHaKW8WDlW4jeIy2D1ot2PHugcc=;
        b=AVySUU1V+vz2mL44o30zCTNbsJ0/n+iwXnlv+he2TJRi5NQ7O5DyBZDfjaexS0gKp6
         MrY2cQBszZYcIo9bTQMdc/3KsF9puGKTrZiYDHlFZ00zqf78w0WLTFn76RPoPw9AylJw
         Ay8mpNdut6RvN/cvtASulXaFMoUZ0HhzeJt1lpT6nBAHyTpK4i0hWVPipyu/Gb0o1h67
         Uj7gX6ionbryiKcFyj3NBfWTrs+SgWeFXWCwd+ZDGAH1CMNR8DiUUS3T8h2vyQl42HK3
         Wok/Kwcn7DM4OCHc9taawRCHtNtZgJwlog6UsGchDX1RuwTJ/lhJcW01K7Dor5MXnkAs
         gV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=24FRW/WZxXq/QDNoUHaKW8WDlW4jeIy2D1ot2PHugcc=;
        b=OKX42SBEuVE4M/G4d2psxjHiNdM6SNd8w5JTTnMZU1X1AtkrUS2FEzpeNRd9VfeW89
         0kH0zA3lHJyEwwDvJ3sNPTmmRZ6SpKCL9nDrcFfuFInnyW54PF/txzYj4wf0mEwjwuQW
         ZaUsXOx7Af+ih0Dx6fHa9BbK1G9nZCErgzbOM7VxnmgHIq4OihStAugwY0zztw4tl13q
         buGoGPIwPannaMySYfKWwaD9yh+D3/wED7GZkz1DRrpDpjrvIbkgSJpXA29X7HYZZ/K4
         Lyr/2p3Mc02FQcRNxnWSZjKZDkgyd5Tp/Dt0RxeGbVc4a9hG9zuL4df4cWIORhhAkfZn
         FYjg==
X-Gm-Message-State: APjAAAVCoTm1rljB+qWO/w6SPjB0slhSh0KK8Pl721YxLtKSj1ruAAcB
        LpZpznvGiDHb42IOVposcMg=
X-Google-Smtp-Source: APXvYqyOEROUe8DyT6Hqij/gPP/W6Fz/WxQjxkDY4zYOs4TzfahavSwP7jrAGvQ4gwJV4Mv+PGSkbQ==
X-Received: by 2002:a17:906:512:: with SMTP id j18mr23963123eja.28.1567435968151;
        Mon, 02 Sep 2019 07:52:48 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id a11sm2972544edf.73.2019.09.02.07.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:52:46 -0700 (PDT)
Date:   Mon, 2 Sep 2019 16:52:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
Message-ID: <20190902145245.GC1445@ulmo>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
 <20190829111407.17191-3-thierry.reding@gmail.com>
 <1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2019 at 03:22:35PM +0100, Robin Murphy wrote:
> On 29/08/2019 12:14, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > For device tree nodes, use the standard of_iommu_get_resv_regions()
> > implementation to obtain the reserved memory regions associated with a
> > device.
>=20
> This covers the window between iommu_probe_device() setting up a default
> domain and the device's driver finally probing and taking control, but
> iommu_probe_device() represents the point that the IOMMU driver first kno=
ws
> about this device - there's still a window from whenever the IOMMU driver
> itself probed up to here where the "unidentified" traffic may have already
> been disrupted. Some IOMMU drivers have no option but to make the necessa=
ry
> configuration during their own probe routine, at which point a struct dev=
ice
> for the display/etc. endpoint may not even exist yet.

Yeah, I think I'm actually running into this issue with the ARM SMMU
driver. The above works fine with the Tegra SMMU driver, though, because
it doesn't touch the SMMU configuration until a device is attached to a
domain.

For anything earlier than iommu_probe_device(), I don't see a way of
doing this generically. I've been working on a prototype to make these
reserved memory regions early on for ARM SMMU but I've been failing so
far. I think it would possibly work if we just switched the default for
stream IDs to be "bypass" if they have any devices that have reserved
memory regions, but again, this isn't quite working (yet).

Thierry

> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index de68b4a02aea..31d48e55ab55 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -19,6 +19,7 @@
> >   #include <linux/iova.h>
> >   #include <linux/irq.h>
> >   #include <linux/mm.h>
> > +#include <linux/of_iommu.h>
> >   #include <linux/pci.h>
> >   #include <linux/scatterlist.h>
> >   #include <linux/vmalloc.h>
> > @@ -164,6 +165,8 @@ void iommu_dma_get_resv_regions(struct device *dev,=
 struct list_head *list)
> >   	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> >   		iort_iommu_msi_get_resv_regions(dev, list);
> > +	if (dev->of_node)
> > +		of_iommu_get_resv_regions(dev, list);
> >   }
> >   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> >=20

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1tLLoACgkQ3SOs138+
s6HlcQ/9Fygivox982dpWeIcABcFv3w+hcjZPGp/Gbb/waKwE6F8y+M83AaxL2Zb
1QMp/wSZ438o+nMgXmqw8nFeC1HHCbGGRrtQz7Nl8jYiGt86J6WNGcG0pmzKcuCP
y0OiRm5yOhIVWqQDzaeNQ8OWS0b2Pgbrw0PRCu/k6zis9WeAQw9MJig24ljtdojF
U81u8/jOYn4oa+VpBfD3gsI9lenkZn/aBrW40m8M2b9P2/NtdV5XHrbq6ec+q2/I
UWC6UlLQ2F+iMUmFsXP1ol1h6E7ioVWRAH91hsAEAOGkQ0GZbOdlBHdPKJBJ15Hg
TwPxh5xzlZWDUWH5/EMIB4GDhhwuh11wUv4ZowHv2s1zVClHPUCNGeaJyXOZhYM6
i7pfw2UiVVSzAOJRaifnVNeyvOFAGad1X4WP5U+Bzz5nSGlKD/H8Pr6OkIF6ibnU
JUMMFE8VANLT64TWv+bfIkN30Pw08tdfFJIb7LZWqjDhuTra+1+UJL2mAdzJSjml
U4oYvsiegSbe93lJCsmuF0M8Lgi4FtKYDJuPQk2/uEZW3EVJauyUzcwnmAlx8m2O
X9xfkY6/fZYJghXZ1Sary0csp8HaILgDDCHDDFTkxXQXVWvKWT5AT6eWP/bnQC5Q
L5w7pjU2sWYURUEk04JjVotFO680raUhaZrwG2dooJMHvV1K0Ho=
=YWPY
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
