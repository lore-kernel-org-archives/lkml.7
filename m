Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3242FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6ED421848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTEToaQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393245AbfJPMqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:46:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54586 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388855AbfJPMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:46:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so2773973wmp.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zKeyF68jMzkZ8PZE+zyf0AJaz2r+snV2TpAgt4NOVLs=;
        b=KTEToaQ6qrUyieyWQDtnZTqU0uLP/8iwXQlf8besLewIcU49APKdYdkSgI38Agh1MC
         fybhBfRdkx5N+TTVr1tYMxdymZL3T0riuRTK/LOyyxhgaZQubAeRVPpVt+A3RnXX8QXs
         URwFg3CqEOZzLc5RyI2hhW6B0aejSropBsziuKyyH/FIwM2Q/afI6g5YmezT97h0gfC5
         m7l0yztoR6wQheMj/D2XjlMwJcTuiMahzWX2A2g4HbTmV1V3s2gVyEtGwQa4xFvdKB7X
         +hlE/qsb3XwJejEKcLz/Da0ZJ8PWWa/2vOpEx0Rr6ALCbfpwZCOQM8tBCVrg0yVT28Nz
         rENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zKeyF68jMzkZ8PZE+zyf0AJaz2r+snV2TpAgt4NOVLs=;
        b=IqMADy6HrY+hEV3HqKujEX9Xh5foocsWciApTdR5x6izzNhzSIFSIOOTSXR2JjV5J/
         hIU066zRGVpbE/aKCAnrRnmTJYHx1Do/5uhSmGKVjyAs0TrdNU4amNbkyTaU+12+mtJx
         ecmdMqlN6KPjAEaQu1EBiG7FCbhCmGUeNs8gi4O+1EkOWvHz1gh8B8IbsWzk6oaiP/xV
         oJ0Y6ls3VhoBPc7PeP5Yr7/gNLhcXTuTMfXjYaEyIoe9giXG5r+cGLw8jK8gY0u7n8iN
         JuzIWEi7KPL28ly9ujNk+CDf6X132fOYxAvXxo6ryN5iWHVHhXh2at7iE5DxMySRPLXT
         wMhQ==
X-Gm-Message-State: APjAAAVswcR/GJO1Z+n1HFSjarJI/U5Y5xeUr+ZaIffs1udpH6gdrstm
        rQ8KEofSlqJXT/rkvPY+UWI=
X-Google-Smtp-Source: APXvYqy4uLAxXK8dZ9uj0Q5OXVcdh/jm7RvNEApTwfDvS63JBb+q8OpwLefZS54uymyMLUA4t9VzRQ==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr3276352wmk.126.1571230003562;
        Wed, 16 Oct 2019 05:46:43 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id c18sm22646572wrv.10.2019.10.16.05.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:46:41 -0700 (PDT)
Date:   Wed, 16 Oct 2019 14:46:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu: Implement iommu_put_resv_regions_simple()
Message-ID: <20191016124640.GA1772382@ulmo>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
 <20190829111752.17513-2-thierry.reding@gmail.com>
 <20190918153737.dea2z5dddhuus25g@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20190918153737.dea2z5dddhuus25g@willie-the-truck>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 04:37:38PM +0100, Will Deacon wrote:
> On Thu, Aug 29, 2019 at 01:17:48PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Implement a generic function for removing reserved regions. This can be
> > used by drivers that don't do anything fancy with these regions other
> > than allocating memory for them.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/iommu/iommu.c | 19 +++++++++++++++++++
> >  include/linux/iommu.h |  2 ++
> >  2 files changed, 21 insertions(+)
> >=20
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 0f585b614657..73a2a6b13507 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2170,6 +2170,25 @@ void iommu_put_resv_regions(struct device *dev, =
struct list_head *list)
> >  		ops->put_resv_regions(dev, list);
> >  }
> > =20
> > +/**
> > + * iommu_put_resv_regions_simple - Reserved region driver helper
> > + * @dev: device for which to free reserved regions
> > + * @list: reserved region list for device
> > + *
> > + * IOMMU drivers can use this to implement their .put_resv_regions() c=
allback
> > + * for simple reservations. Memory allocated for each reserved region =
will be
> > + * freed. If an IOMMU driver allocates additional resources per region=
, it is
> > + * going to have to implement a custom callback.
> > + */
> > +void iommu_put_resv_regions_simple(struct device *dev, struct list_hea=
d *list)
> > +{
> > +	struct iommu_resv_region *entry, *next;
> > +
> > +	list_for_each_entry_safe(entry, next, list, list)
> > +		kfree(entry);
> > +}
> > +EXPORT_SYMBOL(iommu_put_resv_regions_simple);
>=20
> Can you call this directly from iommu_put_resv_regions() if the function
> pointer in ops is NULL? That would save having to plumb the default callb=
ack
> into a bunch of drivers.

I probably could, but I don't think that necessarily improves things.
The reason is that that would cause the helper to get called even if the
driver doesn't support reserved regions. That's likely harmless because
in that case the list of regions passed to it would be empty. However, I
think the current way to do this, where we have to implement both hooks
for ->get_resv_regions() and ->put_resv_regions() is nicely symmetric.

Thierry

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2nES4ACgkQ3SOs138+
s6EONg//ZrYWm5ShwdyQ9XivGxuuU1NxmrAJMtWHz2z0xMVhLv8vVlvNeGNNepm/
AYozw/NMlEZokXfJVW9zNHDpOdr+MB6EchafhOZo9kK592CE18NhVrpVDptMvf29
K1QsQvgCq5Lu9EHBeDMxpx6Kn9VNBFJuAeYCIVzD5GOm80sHdAp1eKMwu/od+oTQ
IwZLB0K82tKdvnwYDYjN/JUW0dbrthH+fW843oOxAqQgrJYApL64k6WuPn6evN11
V7xbw3/Yk3LMqxmBzve7b7ATYXdGRuN7TdMX7aZmLX8xyu11L6LbK+Lss10BbBKi
Vja3MbZgoD54Eam3zOvj+b7tfdiRry4jhqqVksJ/Q2U7KOygrzLORgYR6wTgtz9g
opzD+i9cGdaSj1k8kvVeFPqX9TL/er2hy05MIEWYYTuVh3Y6xiPekH988bHvxf9X
bcl8I5YARin8U2n5R9kaS+drtuo3HvgeQMfszEf9UDNLQc+Pl5niTQPJzljWiZ36
zI8Tq7Sq8Fph33gOGbpcZMTDux4cjlYtGWle7U5tkS38Xte7+IgRxmpwWDC6Y0jX
muP1UNGkXJMLvJtssGseFZZw9qkJcq0NPRdjaN4k+LTdbrw0B10f1CDST8g/9Z4H
xvmbe6SyeWzgcBc43Fs4V3YjZXAYWxf66eD2B9h9AdAEHSmCgD4=
=LljU
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
