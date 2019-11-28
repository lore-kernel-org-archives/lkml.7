Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BD8C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A51221775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7llt02i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfK1Lns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:43:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44278 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfK1Lnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:43:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so30635902wrn.11;
        Thu, 28 Nov 2019 03:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s4KIjaDjoylBE/jhLiaOmwycMgn5SocvWrqVQfvEDRg=;
        b=H7llt02iof//GJ0Ug5JVITHmGE3LT0WmhiZHY9BsvmdRNWTD8U5IFMuG9+k5uv59IR
         xLu8osIR4nUnOFCCY5ZclkADrUV15wESyoriaayLhuxwi+QqZ7iIGOrC2JoQsFwO0fzQ
         QlgtzmWRl4uGr2cUX3d71++B0mTtBfwhVAVXJ20TnABSTeGmf5D2+xqArsK99WNwB3tO
         JqNyMl4fITNduUSfp0ld+ep1CwgihmORLzioOEeS0I9PrwPNVG0+qImEmImh468KLSLq
         8WYgpNLDlPfktOPc4qn0/rDUPdyR7fetxkL71zJjOwAeRRxFtdaSne8vZirR++7D4e3d
         E3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s4KIjaDjoylBE/jhLiaOmwycMgn5SocvWrqVQfvEDRg=;
        b=G141VXF0eIzBc/u/5b00Fea1tvlXf4qnVAgVsJHq+XnJBS5+I86ZgxgtuYDGFAiktI
         M80ehAuHhoCTGCJ9KYB5lm6Snv53qSPz0BOLVYBJFML5PzpRskCF5kx+TKIcNhXZ6VYZ
         Tx8ptv0tt0CGpTvdmV4moixtgvmE6ibSJVe6/J8AJXpZZn8d3jyYQ4x+ZF4QdB6RwWax
         K3Hinu68o+/AOJh9KkTDZx7eR2P8qnTV7W5q72yvtuf5u2nmZjdC5h61sLzTubhgUxWU
         Z3X/c5qV2I7nLkTO7qjrE4Sd5T9CamRi6Lup549ItkaLNZVoHrIvacts8B2CuBlfbLxN
         hmow==
X-Gm-Message-State: APjAAAWy1ev+YwOS0UwfWHL5/GJELNkqeSOujMkuXHMDGDh+f47CLkYq
        H0PWFmCd+BMhqoriGfz8ApE=
X-Google-Smtp-Source: APXvYqz5sULqQTjpWPr/ip7w52F2Kw5HwuAqOmvzaIGk1vwUEDZk42aP0QpcnLYhOInEogfNZpVYOA==
X-Received: by 2002:a5d:6542:: with SMTP id z2mr49566002wrv.371.1574941423562;
        Thu, 28 Nov 2019 03:43:43 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id x10sm22927351wrv.60.2019.11.28.03.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 03:43:41 -0800 (PST)
Date:   Thu, 28 Nov 2019 12:43:39 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
Message-ID: <20191128113633.GB280099@ulmo>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
 <20190829111407.17191-3-thierry.reding@gmail.com>
 <1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com>
 <20190902145245.GC1445@ulmo>
 <20190917175950.wrwiqnh5bp62uy3c@willie-the-truck>
 <20191126172910.GA2669319@ulmo>
 <20191127141631.GA280099@ulmo>
 <864d5afb-72b4-a3ef-9c93-3a8ad4864c56@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <864d5afb-72b4-a3ef-9c93-3a8ad4864c56@arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 05:09:41PM +0000, Robin Murphy wrote:
> On 27/11/2019 2:16 pm, Thierry Reding wrote:
> [...]
> > Nevermind that, I figured out that I was missingthe initialization of
> > some of the S2CR variables. I've got something that I think is working
> > now, though I don't know yet how to go about cleaning up the initial
> > mapping and "recycling" it.
> >=20
> > I'll clean things up a bit, run some more tests and post a new patch
> > that can serve as a basis for discussion.
>=20
> I'm a little puzzled by the smmu->identity domain - disregarding the fact
> that it's not actually used by the given diff ;) - if isolation is the
> reason for not simply using a bypass S2CR for the window between reset and
> the relevant .add_device call where the default domain proper comes in[1],
> then surely exposing the union of memory regions to the union of all
> associated devices isn't all that desirable either.

A bypass S2CR was what I had originally in mind, but Will objected to
that because it "leaves the thing wide open if we don't subsequently
probe the master."[0]

Will went on to suggest setting up a page-table early for stream IDs
with reserved regions, so that's what I implemented. It ends up working
fairly nicely (see attached patch).

I suppose putting all the masters into the same bucket isn't an ideal
solution, but it's pretty simple and straightforward. Also, I don't
expect this to be a very common use-case. In fact, the only place where
I'm aware that this is needed is for display controllers scanning out a
splash screen. So the worst that could happen here is if they somehow
got the addresses mixed up and read each others' framebuffers, which
would really only be possible if they were already doing so before the
SMMU was initialized. Any harm from that would already be done.

I don't think there's a real risk here. Before the ARM SMMU driver takes
over and configures all contexts as fault by default all of these
devices are reading from physical memory without any isolation. Setting
up this identity domain will allow them to keep accessing the regions
that they were meant to access, while still faulting when access happens
outside.

> Either way, I'll give you the pre-emptive warning that this is the SMMU in
> the way of my EFI framebuffer ;)
>=20
> ...
> arm-smmu 7fb20000.iommu: 	1 context banks (1 stage-2 only)
> ...

Interesting. How did you avoid getting the faults by default? Do you
just enable bypass by default?

If I understand correctly, this would mean that you can have only a
single IOMMU domain in that case, right? In that case it would perhaps
be better to keep a list of identity IOMMU domains and later on somehow
pass them on when the driver takes over. Basically these would have to
become the IOMMU groups' default domains.

> Robin.
>=20
> [1] the fact that it currently depends on probe order whether getting that
> .add_device call requires a driver probing for the device is an error as
> discussed elsewhere, and will get fixed separately, I promise.

I'm not sure I understand how that would fix anything. You'd still need
to program the SMMU first before calling the ->add_device() for all the
masters, in which case you're still going to run into faults.

Thierry

[0]: https://lkml.org/lkml/2019/9/17/745

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline;
	filename="0001-iommu-arm-smmu-Add-support-for-early-direct-mappings.patch"
Content-Transfer-Encoding: quoted-printable

=46rom cd7be912e74bdd463384e42f1aa275e959f4bee2 Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Thu, 28 Nov 2019 12:03:58 +0100
Subject: [PATCH] iommu: arm-smmu: Add support for early direct mappings

On platforms, the firmware will setup hardware to read from a given
region of memory. One such example is a display controller that is
scanning out a splash screen from physical memory.

During Linux's boot process, the ARM SMMU will configure all contexts to
fault by default. This means that memory accesses that happen by an SMMU
master before its driver has had a chance to properly set up the IOMMU
will cause a fault. This is especially annoying for something like the
display controller scanning out a splash screen because the faults will
result in the display controller getting bogus data (all-ones on Tegra)
and since it repeatedly scans that framebuffer, it will keep triggering
such faults and spam the boot log with them.

In order to work around such problems, scan the device tree for IOMMU
masters and set up a special identity domain that will map 1:1 all of
the reserved regions associated with them. This happens before the SMMU
is enabled, so that the mappings are already set up before translations
begin.

TODO: remove identity domain when no longer in use

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 172 ++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/arm-smmu.h |   2 +
 2 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 58ec52d3c5af..3d6c58ce3bab 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1887,6 +1887,172 @@ static int arm_smmu_device_cfg_probe(struct arm_smm=
u_device *smmu)
 	return 0;
 }
=20
+static int arm_smmu_identity_map_regions(struct arm_smmu_device *smmu,
+					 struct device_node *np)
+{
+	struct device *dev =3D smmu->dev;
+	struct of_phandle_iterator it;
+	unsigned long page_size;
+	unsigned int count =3D 0;
+	int ret;
+
+	page_size =3D 1UL << __ffs(smmu->identity->pgsize_bitmap);
+
+	/* parse memory regions and add them to the identity mapping */
+	of_for_each_phandle(&it, ret, np, "memory-region", NULL, 0) {
+		int prot =3D IOMMU_READ | IOMMU_WRITE;
+		dma_addr_t start, limit, iova;
+		struct resource res;
+
+		ret =3D of_address_to_resource(it.node, 0, &res);
+		if (ret < 0) {
+			dev_err(dev, "failed to parse memory region %pOF: %d\n",
+				it.node, ret);
+			continue;
+		}
+
+		/* check that region is not empty */
+		if (resource_size(&res) =3D=3D 0) {
+			dev_dbg(dev, "skipping empty memory region %pOF\n",
+				it.node);
+			continue;
+		}
+
+		start =3D ALIGN(res.start, page_size);
+		limit =3D ALIGN(res.start + resource_size(&res), page_size);
+
+		for (iova =3D start; iova < limit; iova +=3D page_size) {
+			phys_addr_t phys;
+
+			/* check that this IOVA isn't already mapped */
+			phys =3D iommu_iova_to_phys(smmu->identity, iova);
+			if (phys)
+				continue;
+
+			ret =3D iommu_map(smmu->identity, iova, iova, page_size,
+					prot);
+			if (ret < 0) {
+				dev_err(dev, "failed to map %pad for %pOF: %d\n",
+					&iova, it.node, ret);
+				continue;
+			}
+		}
+
+		dev_dbg(dev, "identity mapped memory region %pR\n", &res);
+		count++;
+	}
+
+	return count;
+}
+
+static int arm_smmu_identity_add_master(struct arm_smmu_device *smmu,
+					struct of_phandle_args *args)
+{
+	struct arm_smmu_domain *identity =3D to_smmu_domain(smmu->identity);
+	struct arm_smmu_smr *smrs =3D smmu->smrs;
+	struct device *dev =3D smmu->dev;
+	unsigned int index;
+	u16 sid, mask;
+	u32 fwid;
+	int ret;
+
+	/* skip masters that aren't ours */
+	if (args->np !=3D dev->of_node)
+		return 0;
+
+	fwid =3D arm_smmu_of_parse(args->np, args->args, args->args_count);
+	sid =3D FIELD_GET(SMR_ID, fwid);
+	mask =3D FIELD_GET(SMR_MASK, fwid);
+
+	ret =3D arm_smmu_find_sme(smmu, sid, mask);
+	if (ret < 0) {
+		dev_err(dev, "failed to find SME: %d\n", ret);
+		return ret;
+	}
+
+	index =3D ret;
+
+	if (smrs && smmu->s2crs[index].count =3D=3D 0) {
+		smrs[index].id =3D sid;
+		smrs[index].mask =3D mask;
+		smrs[index].valid =3D true;
+	}
+
+	smmu->s2crs[index].type =3D S2CR_TYPE_TRANS;
+	smmu->s2crs[index].privcfg =3D S2CR_PRIVCFG_DEFAULT;
+	smmu->s2crs[index].cbndx =3D identity->cfg.cbndx;
+	smmu->s2crs[index].count++;
+
+	return 0;
+}
+
+static int arm_smmu_identity_add_device(struct arm_smmu_device *smmu,
+					struct device_node *np)
+{
+	struct device *dev =3D smmu->dev;
+	struct of_phandle_args args;
+	unsigned int index =3D 0;
+	int ret;
+
+	/* add stream IDs to the identity mapping */
+	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
+					   index, &args)) {
+		ret =3D arm_smmu_identity_add_master(smmu, &args);
+		if (ret < 0)
+			return ret;
+
+		index++;
+	}
+
+	return 0;
+}
+
+static int arm_smmu_setup_identity(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_domain *identity;
+	struct device *dev =3D smmu->dev;
+	struct device_node *np;
+	int ret;
+
+	/* create early identity mapping */
+	smmu->identity =3D arm_smmu_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+	if (!smmu->identity) {
+		dev_err(dev, "failed to create identity domain\n");
+		return -ENOMEM;
+	}
+
+	smmu->identity->pgsize_bitmap =3D smmu->pgsize_bitmap;
+	smmu->identity->type =3D IOMMU_DOMAIN_UNMANAGED;
+	smmu->identity->ops =3D &arm_smmu_ops;
+
+	ret =3D arm_smmu_init_domain_context(smmu->identity, smmu);
+	if (ret < 0) {
+		dev_err(dev, "failed to initialize identity domain: %d\n", ret);
+		return ret;
+	}
+
+	identity =3D to_smmu_domain(smmu->identity);
+
+	for_each_node_with_property(np, "iommus") {
+		ret =3D arm_smmu_identity_map_regions(smmu, np);
+		if (ret < 0)
+			continue;
+
+		/*
+		 * Do not add devices to the early identity mapping if they
+		 * do not define any memory-regions.
+		 */
+		if (ret =3D=3D 0)
+			continue;
+
+		ret =3D arm_smmu_identity_add_device(smmu, np);
+		if (ret < 0)
+			continue;
+	}
+
+	return 0;
+}
+
 struct arm_smmu_match_data {
 	enum arm_smmu_arch_version version;
 	enum arm_smmu_implementation model;
@@ -2128,6 +2294,10 @@ static int arm_smmu_device_probe(struct platform_dev=
ice *pdev)
 	if (err)
 		return err;
=20
+	err =3D arm_smmu_setup_identity(smmu);
+	if (err)
+		return err;
+
 	if (smmu->version =3D=3D ARM_SMMU_V2) {
 		if (smmu->num_context_banks > smmu->num_context_irqs) {
 			dev_err(dev,
@@ -2170,8 +2340,8 @@ static int arm_smmu_device_probe(struct platform_devi=
ce *pdev)
 	}
=20
 	platform_set_drvdata(pdev, smmu);
-	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
+	arm_smmu_device_reset(smmu);
=20
 	/*
 	 * We want to avoid touching dev->power.lock in fastpaths unless
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 6b6b877135de..001e60a3d18c 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -280,6 +280,8 @@ struct arm_smmu_device {
=20
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	struct iommu_domain		*identity;
 };
=20
 enum arm_smmu_context_fmt {
--=20
2.23.0


--AqsLC8rIMeq19msA--

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3fsusACgkQ3SOs138+
s6GAfg/9HnqEYP34VZRpHRKWFWE9obt/03KUw6jheVdj7YUz6VhONFCNI1aHKGMu
GsJImtRYW2OnTQjBPCZqiEGJK5KQwIdpzHDRgwvgPViKyP7pyWJdV0ZZ8RgvDLtz
LZtfJdyR8US0yuOcJBhALweoT4swq4rElmYa6SLZa3v2DyC3Yq4qi7arJZZBAND3
bc/4dpc1LdOhpiED5QPBaq7aUMuKweUN4vDxL+QR5TBkBvRbOGksbQB7sAmF6/Xo
RBZ7jfXbZ3kMfMVL2mtfRBcQjeuLWQwii9sbH1nKcXf/8Yyk+ar+Fs+7Lj7XIosg
8mbhOQF0bvSKUJ0opLXy0+QL1WGSSU8JyoiNnWoU6MPS9la7TJsR5j2Kz2hFjMTz
7wKHmd8A/ZsleroFbZmt6ymq623sLaxFp/HjBTqDp0yl/6KPIgZOC+y2oLpPVhQB
v4jmKXzyUv++8HKQ6l7FUKeDWttUzjMS1WWNdHx5VCL+vh8MlZBr5w6bl/d0YHst
5goP2MQcm2Y563cTWBPy9fiZHDidvDixtAud9HUDuPXxi74r2jeYazYZn1Wm/vKO
nCdq0QR3Pe5DENDyvkzTIDnudVkRC4ABMmVq/UHsbf2zpbVJ5/oBB9O2L3S8MO2k
+Ecv9e/8Lvwd3BRF1+lE0bwLlX9ouXtfTtlzj43jXFO/UECQ3nw=
=Db6D
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
