Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56752C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB972339D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMeqXcyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfIBPBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 11:01:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56283 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfIBPBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:01:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so10955288wmg.5;
        Mon, 02 Sep 2019 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGIFqmZP9pkCyqxppuqhSPyEsriWQeE+IIdy1JuGQCI=;
        b=YMeqXcyZSgnEDTUfVpQxK7+iDnb0fDEgPxsYDJj+mqx8qnvvQ59wPcrq+C1AQCOw0F
         SqPToxeCMqOLw1wC0YcH4Vq3wGq7KE+K6RvHXA1irxu9swjK7pX8BC+5tP/UGQkb23vd
         KbcriaI4oIHHyUoKhcG41k8IUVNVrf/bXVNVSTSZskcGFevuvydBbGfWdd4DNmN/UGmf
         tgitmQs6qu6aeEjOXSxcbjdivvABZ6kqEUM6dmYwrlVkbBTpWrQqQ2RNJQcL0HW/m/vi
         +Dc7ZZrOcxkhvuoA1zHBweOwYrRRHY3+qLm5mQ0sugrI9Ebgqj/e2dRaE1ET60StNVmP
         0ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGIFqmZP9pkCyqxppuqhSPyEsriWQeE+IIdy1JuGQCI=;
        b=ikOU/Zl+E4v1MgP1ipAzCpvxsxndSLoSSlo6lCHc6ykfdaBCajaIk8s4BuNP3mWJzC
         iNCViiS7rFb4rDTU4XNUMc+pzURIpY020NbaXFTGhAFaJfqzl+K9YBuVOzjKXWTZcugU
         apW0BuuZZoscuUbCAzv+UnL3DTGSCH7MFAQwaOecsJvyximQzUWS1wEk+1OLEQIqGTSc
         zTwzjpoV5Hq7pm80MZvjy1XC5lKmZ7mwH+nr6YMErUxTJnwemMVvXEVi3BLujlj4qpKG
         ckae5Sg9li3DRQ7mKMaZU0UuQ5dTxz1qDoKz4USO/f6VI7EEbRuXsQmHTSpaKaRydveI
         Z5Cg==
X-Gm-Message-State: APjAAAUZSKuVxx+ooVUqa/rUJdGo4XWvgw3MaLg3n/C3A1YwLDDM4eag
        6fnmz+nR+oH1B4+kLphP4cazGrJc
X-Google-Smtp-Source: APXvYqzmGzje6KF7Zsi4HtkXeCIk+p8GOr45YA1Em+n0ej/VBC649Dq5MxBEYxlIU0w0wm8+JHcUyQ==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr36706223wmc.131.1567436458947;
        Mon, 02 Sep 2019 08:00:58 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id t19sm16367831wmi.29.2019.09.02.08.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 08:00:57 -0700 (PDT)
Date:   Mon, 2 Sep 2019 17:00:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: Implement of_iommu_get_resv_regions()
Message-ID: <20190902150056.GD1445@ulmo>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
 <20190829111407.17191-2-thierry.reding@gmail.com>
 <0b7e050a-cec6-6ce7-9ed6-2146eabb2fe8@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <0b7e050a-cec6-6ce7-9ed6-2146eabb2fe8@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2019 at 02:54:23PM +0100, Robin Murphy wrote:
> On 29/08/2019 12:14, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > This is an implementation that IOMMU drivers can use to obtain reserved
> > memory regions from a device tree node. It uses the reserved-memory DT
> > bindings to find the regions associated with a given device. These
> > regions will be used to create 1:1 mappings in the IOMMU domain that
> > the devices will be attached to.
> >=20
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >   drivers/iommu/of_iommu.c | 39 +++++++++++++++++++++++++++++++++++++++
> >   include/linux/of_iommu.h |  8 ++++++++
> >   2 files changed, 47 insertions(+)
> >=20
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 614a93aa5305..0d47f626b854 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -9,6 +9,7 @@
> >   #include <linux/iommu.h>
> >   #include <linux/limits.h>
> >   #include <linux/of.h>
> > +#include <linux/of_address.h>
> >   #include <linux/of_iommu.h>
> >   #include <linux/of_pci.h>
> >   #include <linux/slab.h>
> > @@ -225,3 +226,41 @@ const struct iommu_ops *of_iommu_configure(struct =
device *dev,
> >   	return ops;
> >   }
> > +
> > +/**
> > + * of_iommu_get_resv_regions - reserved region driver helper for devic=
e tree
> > + * @dev: device for which to get reserved regions
> > + * @list: reserved region list
> > + *
> > + * IOMMU drivers can use this to implement their .get_resv_regions() c=
allback
> > + * for memory regions attached to a device tree node. See the reserved=
-memory
> > + * device tree bindings on how to use these:
> > + *
> > + *   Documentation/devicetree/bindings/reserved-memory/reserved-memory=
=2Etxt
> > + */
> > +void of_iommu_get_resv_regions(struct device *dev, struct list_head *l=
ist)
> > +{
> > +	struct of_phandle_iterator it;
> > +	int err;
> > +
> > +	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0)=
 {
> > +		struct iommu_resv_region *region;
> > +		struct resource res;
> > +
> > +		err =3D of_address_to_resource(it.node, 0, &res);
> > +		if (err < 0) {
> > +			dev_err(dev, "failed to parse memory region %pOF: %d\n",
> > +				it.node, err);
> > +			continue;
> > +		}
>=20
> What if the device node has memory regions for other purposes, like priva=
te
> CMA carveouts? We wouldn't want to force mappings of those (and in the ve=
ry
> worst case doing so could even render them unusable).

I suppose we could come up with additional properties to mark such
memory regions and skip them here.

One other alternative might be to make sure that the driver claims
the memory regions that have been mapped and then tells the IOMMU to
undo the mappings for them. That way the driver could set up the new
mappings, reprogram the hardware and then have the old mappings torn
down. I'm not sure that could always be done in a race-free way. For
example, what if the new mappings need to be in a region, such as a
private CMA carveout, that's already mapped. Can we temporarily map
one physical address to two DMA addresses?

The details here probably depend on the IOMMU hardware.

Thierry

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1tLqgACgkQ3SOs138+
s6HrGw/+MSAvdUmu9+GY2m0d4voTxSMsfPtF3Wj0kOWgJ+chMsV5ieVkcpgA5DVN
/AIhBL+4qhbv9bSNa4RNNYQVte3ivzADhYNjB/O9Nl8Lx6m51bOPeIZtN+nMFVox
fGkrcuk+lwm6BFx9WT+Z/8g5QL8k0XwD9BRmgYiDV/VhDA+CbhNkJDs2jP9xV4od
ZV6X0sZtp+9+l+gRCfVDZyWRCmhNMGB0XKfdFHn5jLWo8VYcRNtjFuDxYv7IanKK
FJeBTNRWZeQHO34Ckj35orvVpUUPyvvtbEd8+VUCGLbVINU2UljMUTEnnTAg6uRi
H4PRRxzf+7CqpOd6+RDUg+yf3DGB+snbC0rcsfsrDYOASHJZkRFpDSwqeOM1D5Cr
JbHkcrnpbha0S8RyX51okkkz7wmQhWbmzYT0NDO/xG617XN3aOTvB0YfU05Hz7aV
t5KZMjuq92pncfpx5Ekf9vWEcVklTHrHjrg7lGV7EueHTp+wcz7SSn/2Tbl/MSeo
sXUxNAFr88le8plm1rqn+CY6C6Ha/RsHirrFahNiZKs8QmQvIRjEK8cVv/667cBl
7/F1o4sAYEdAT8tzeDaEAGqHIx+H9Q1cWXi692FEx47N3dYwPHfzFyUkPpIrde/r
YeJgtGzAq/AFyINhLoAQrGgOZC4lR7I6bdcuRiwiSSX5bNBX80s=
=v6VM
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
