Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21818C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4470206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlpJMaUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfK0OQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:16:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36059 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0OQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:16:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so26858561wru.3;
        Wed, 27 Nov 2019 06:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h7Gq5DLh41EM/oDzQk3AdwgGK5M9dTaIOifeHYS0tnw=;
        b=SlpJMaUpxR2p7xKiDxW8pxNSkJmKG7U3DLiqtMWiQ9jLOYAifZlu6UtZ/nkej1K+v3
         pX64kN8NyVLfAN+SeaSAR7bbd7PdV7ArYl6P/OkQyH6NDl6QChmKnHqIDXhWTS9Kpgym
         vq1UXpSvru1uOdIlqIgPPE90DPLQzMPjm6hg2tSXfbPuGwmdSUB01EWHOydFSTc/eSr6
         e1pEmPqAcfdfpEAUyjtjJZ0EBb2ftH0BOitEFHekP4TxMbhRz82hBWi/znH+4Pw9qkKT
         Zxv18fWAJG1Dudu/29nWbXN2Pjzb/JvlJ+o6Jy7k981J7h0+tcGBY+Ch6Px32CX7v3Zj
         qj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h7Gq5DLh41EM/oDzQk3AdwgGK5M9dTaIOifeHYS0tnw=;
        b=WK72pl143kQ7IFBvu9v7IBxDOSUAK/QufCR62EKkBG4d/l6aKnGHt+S8tIPkCCyT31
         GPfNOZDTUSgi8wKG0FOJXNym8cz0oQk4gV5955dL0W0FEWeeoQPKvVAEvm3IXGyTTUbS
         h3j2NiVuGzOlUnv3RMFpsNs3rBkvJFQa716TBy4YLkkzIv7LYKBZpefAX7laovNOwQ4r
         P3WWkXeeUpkFfR8cVPyi9Fs2m8ziy8A1rGdaq53yAKfh/6E3kRGKFcOgdYGN76whJeqM
         CogaL4qrnzG1DaqHwPCQLfD0TVUdzkHmuZWf/jqIcIs9X4ny+eb8igL3TUIpumlzkVd4
         h3Rg==
X-Gm-Message-State: APjAAAUvtzmypsUZvJyZ68AfOVgKNW+BQvbbw3Sbl603Os0pimV5R4AX
        sNUTDlCmi9sZ1uHAr77V2lQ=
X-Google-Smtp-Source: APXvYqxGWk1xnDKBLs61+g7BirP2m1yQoC2BdKrEHaZZz2kLRG2Lx8CCExfzk8UB4dE11W7Pa1+6xg==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr570867wrv.364.1574864195803;
        Wed, 27 Nov 2019 06:16:35 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id s8sm19088227wrt.57.2019.11.27.06.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 06:16:33 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:16:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
Message-ID: <20191127141631.GA280099@ulmo>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
 <20190829111407.17191-3-thierry.reding@gmail.com>
 <1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com>
 <20190902145245.GC1445@ulmo>
 <20190917175950.wrwiqnh5bp62uy3c@willie-the-truck>
 <20191126172910.GA2669319@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20191126172910.GA2669319@ulmo>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 01:16:54PM +0100, Thierry Reding wrote:
> On Tue, Sep 17, 2019 at 06:59:50PM +0100, Will Deacon wrote:
> > On Mon, Sep 02, 2019 at 04:52:45PM +0200, Thierry Reding wrote:
> > > On Mon, Sep 02, 2019 at 03:22:35PM +0100, Robin Murphy wrote:
> > > > On 29/08/2019 12:14, Thierry Reding wrote:
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >=20
> > > > > For device tree nodes, use the standard of_iommu_get_resv_regions=
()
> > > > > implementation to obtain the reserved memory regions associated w=
ith a
> > > > > device.
> > > >=20
> > > > This covers the window between iommu_probe_device() setting up a de=
fault
> > > > domain and the device's driver finally probing and taking control, =
but
> > > > iommu_probe_device() represents the point that the IOMMU driver fir=
st knows
> > > > about this device - there's still a window from whenever the IOMMU =
driver
> > > > itself probed up to here where the "unidentified" traffic may have =
already
> > > > been disrupted. Some IOMMU drivers have no option but to make the n=
ecessary
> > > > configuration during their own probe routine, at which point a stru=
ct device
> > > > for the display/etc. endpoint may not even exist yet.
> > >=20
> > > Yeah, I think I'm actually running into this issue with the ARM SMMU
> > > driver. The above works fine with the Tegra SMMU driver, though, beca=
use
> > > it doesn't touch the SMMU configuration until a device is attached to=
 a
> > > domain.
> > >=20
> > > For anything earlier than iommu_probe_device(), I don't see a way of
> > > doing this generically. I've been working on a prototype to make these
> > > reserved memory regions early on for ARM SMMU but I've been failing so
> > > far. I think it would possibly work if we just switched the default f=
or
> > > stream IDs to be "bypass" if they have any devices that have reserved
> > > memory regions, but again, this isn't quite working (yet).
> >=20
> > I think we should avoid the use of "bypass" outside of the IOMMU probe()
> > routine if at all possible, since it leaves the thing wide open if we d=
on't
> > subsequently probe the master.
> >=20
> > Why can't we initialise a page-table early for StreamIDs with these
> > reserved regions, and then join that up later on if we see a device with
> > one of those StreamIDs attaching to a DMA domain? I suppose the nasty
> > case would be attaching to a domain that already has other masters
> > attached to it. Can we forbid that somehow for these devices? Otherwise,
> > I think we'd have to transiently switch to bypass whilst switching page
> > table.
> >=20
> > What problems did you run into trying to implement this?
>=20
> I picked this up again and was trying to make this work with your
> suggestion. Below is a rough draft and it seems to be working to some
> degree. Here's an extract of the log when I run this on Jetson TX2:
>=20
> 	[    3.755328] arm-smmu 12000000.iommu: probing hardware configuration...
> 	[    3.762187] arm-smmu 12000000.iommu: SMMUv2 with:
> 	[    3.767137] arm-smmu 12000000.iommu:         stage 1 translation
> 	[    3.772806] arm-smmu 12000000.iommu:         stage 2 translation
> 	[    3.778471] arm-smmu 12000000.iommu:         nested translation
> 	[    3.784050] arm-smmu 12000000.iommu:         stream matching with 128=
 register groups
> 	[    3.791651] arm-smmu 12000000.iommu:         64 context banks (0 stag=
e-2 only)
> 	[    3.798603] arm-smmu 12000000.iommu:         Supported page sizes: 0x=
61311000
> 	[    3.805460] arm-smmu 12000000.iommu:         Stage-1: 48-bit VA -> 48=
-bit IPA
> 	[    3.812310] arm-smmu 12000000.iommu:         Stage-2: 48-bit IPA -> 4=
8-bit PA
> 	[    3.819159] arm-smmu 12000000.iommu: > arm_smmu_setup_identity(smmu=
=3Dffff0001eabcec80)
> 	[    3.827373] arm-smmu 12000000.iommu:   identity domain: ffff0001eaf8c=
ae8 (ops: 0x0)
> 	[    3.835614] arm-smmu 12000000.iommu:   np: /ethernet@2490000
> 	[    3.841635] arm-smmu 12000000.iommu:   np: /sdhci@3400000
> 	[    3.847315] arm-smmu 12000000.iommu:   np: /sdhci@3420000
> 	[    3.852990] arm-smmu 12000000.iommu:   np: /sdhci@3440000
> 	[    3.858683] arm-smmu 12000000.iommu:   np: /sdhci@3460000
> 	[    3.864370] arm-smmu 12000000.iommu:   np: /hda@3510000
> 	[    3.869897] arm-smmu 12000000.iommu:   np: /usb@3530000
> 	[    3.875421] arm-smmu 12000000.iommu:   np: /pcie@10003000
> 	[    3.881109] arm-smmu 12000000.iommu:   np: /host1x@13e00000
> 	[    3.887012] arm-smmu 12000000.iommu:   np: /host1x@13e00000/display-h=
ub@15200000/display@15200000
> 	[    3.896344] arm-smmu 12000000.iommu:     region: /reserved-memory/fra=
mebuffer@9607c000
> 	[    3.904707] arm-smmu 12000000.iommu:       [mem 0x9607c000-0x9687bfff]
> 	[    3.915719] arm-smmu 12000000.iommu:     /iommu@12000000: 1 arguments
> 	[    3.922487] arm-smmu 12000000.iommu:       0: 00000009
> 	[    3.927888] arm-smmu 12000000.iommu:       SID: 0009 MASK: 7f80
> 	[    3.934132] arm-smmu 12000000.iommu:       found index: 0
> 	[    3.939840] arm-smmu 12000000.iommu:   np: /host1x@13e00000/display-h=
ub@15200000/display@15210000
> 	[    3.949183] arm-smmu 12000000.iommu:   np: /host1x@13e00000/display-h=
ub@15200000/display@15220000
> 	[    3.958499] arm-smmu 12000000.iommu:   np: /host1x@13e00000/vic@15340=
000
> 	[    3.965557] arm-smmu 12000000.iommu:   np: /gpu@17000000
> 	[    3.971145] arm-smmu 12000000.iommu:   np: /bpmp
> 	[    3.976084] arm-smmu 12000000.iommu: < arm_smmu_setup_identity()
> 	[    3.982613] arm-smmu 12000000.iommu: > arm_smmu_write_sme(smmu=3Dffff=
0001eabcec80, idx=3D0)
> 	[    3.991072] arm-smmu 12000000.iommu:   ARM_SMMU_GR0_S2CR(0) < 00020000
> 	[    3.997922] arm-smmu 12000000.iommu:   ARM_SMMU_GR0_SMR(0) < ff800009
> 	[    4.004677] arm-smmu 12000000.iommu: < arm_smmu_write_sme()
> 	[    4.010528] arm-smmu 12000000.iommu: > arm_smmu_write_sme(smmu=3Dffff=
0001eabcec80, idx=3D1)
> 	[    4.018919] arm-smmu 12000000.iommu:   ARM_SMMU_GR0_S2CR(1) < 00020000
> 	[    4.025773] arm-smmu 12000000.iommu:   ARM_SMMU_GR0_SMR(1) < 00000000
> 	[    4.032543] arm-smmu 12000000.iommu: < arm_smmu_write_sme()
> 	...
>=20
> There's a bunch of these, but idx=3D0 is the only one that's actually
> populated because it corresponds to the display controller. However,
> shortly after this I see a bunch of these:
>=20
> 	...
> 	[    7.588908] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x809;=
 boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have securi=
ty implications
> 	[    7.589907] arm-smmu: > arm_smmu_of_xlate(dev=3Dffff0001eaecf010, arg=
s=3Dffff80001024bae8)
> 	[    7.603599] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0=
 0x00000000, GFSYNR1 0x00000809, GFSYNR2 0x00000000
> 	[    7.604218] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x1409=
; boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have secur=
ity implications
> 	[    7.611956] arm-smmu: < arm_smmu_of_xlate() =3D 0
> 	[    7.622636] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0=
 0x00000000, GFSYNR1 0x00001409, GFSYNR2 0x00000000
> 	[    7.622658] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x1809=
; boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have secur=
ity implications
> 	[    7.622662] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0=
 0x00000000, GFSYNR1 0x00001809, GFSYNR2 0x00000000
> 	[    7.622676] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x409;=
 boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have securi=
ty implications
> 	[    7.637739] arm-smmu 12000000.iommu:   ARM_SMMU_GR0_S2CR(1) < 00000001
> 	[    7.642199] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0=
 0x00000000, GFSYNR1 0x00000409, GFSYNR2 0x00000000
> 	[    7.642216] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x9; b=
oot with "arm-smmu.disable_bypass=3D0" to allow, but this may have security=
 implications
> 	[    7.642221] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0=
 0x00000000, GFSYNR1 0x00000009, GFSYNR2 0x00000000
> 	[    7.642237] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x1c09=
; boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have secur=
ity implications
> 	[    7.652992] tegra-host1x 13e00000.host1x: Adding to iommu group 0
> 	[    7.667720] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0=
 0x00000000, GFSYNR1 0x00001c09, GFSYNR2 0x00000000
> 	[    7.667732] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x9; b=
oot with "arm-smmu.disable_bypass=3D0" to allow, but this may have security=
 implications
> 	[    7.667736] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0=
 0x00000000, GFSYNR1 0x00000009, GFSYNR2 0x00000000
> 	[    7.667748] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x1809=
; boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have secur=
ity implications
> 	[    7.667752] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0=
 0x00000000, GFSYNR1 0x00001809, GFSYNR2 0x00000000
> 	[    7.667765] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x9; b=
oot with "arm-smmu.disable_bypass=3D0" to allow, but this may have security=
 implications
> 	[    7.678511] arm-smmu 12000000.iommu: > arm_smmu_write_sme(smmu=3Dffff=
0001eabcec80, idx=3D1)
> 	[    7.693158] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0=
 0x00000000, GFSYNR1 0x00000009, GFSYNR2 0x00000000
> 	[    7.693170] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x1009=
; boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have secur=
ity implications
> 	[    7.693174] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0=
 0x00000000, GFSYNR1 0x00001009, GFSYNR2 0x00000000
>=20
> Note that stream ID 0x9 is TEGRA186_SID_NVDISPLAY, which is associated
> with the display controllers. One of these display controllers is live
> because it was turned on by the bootloader to show a splash screen.
>=20
> What I don't really understand is why it thinks that that stream ID is
> unknown. One possibility I see is that perhaps the S2CR(0) and/or SMR(0)
> registers might have gotten overwritten, but I don't see where that may
> happen.
>=20
> The errors stop eventually when the display controller is hooked up
> properly via the DMA API, but the whole purpose here is obviously to get
> to that point much earlier.
>=20
> Any ideas what I might be doing wrong? Any comments on the general
> approach?

Nevermind that, I figured out that I was missingthe initialization of
some of the S2CR variables. I've got something that I think is working
now, though I don't know yet how to go about cleaning up the initial
mapping and "recycling" it.

I'll clean things up a bit, run some more tests and post a new patch
that can serve as a basis for discussion.

Thierry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3ehTsACgkQ3SOs138+
s6GiQw//Vsrz9YWQANyvvEc/JOYSr3PA3x0e2we3woLgDLBPynXqAsT6A1DEvvdc
jaKhRewf/VmyUjoMsUt49N4zBXJwYmk1YVlDIr9HujA7++Fe7KQi7qyl88IhCb/K
f8ZZvUj5pVrhjRzcZxRQmsA0eQJQpEkYaB7yMXFzB53II/fmTVCfqOCjTENySCy3
abtPE7dj5m4ZfY3TqPEuqCu7TdYNOcM8Bj7ChiPMlltZ66YBXCCLR9/gqQlPSdVo
uPXx/NHKzAkd7/iYhMHm9vfuskUk40RBDnit56iXYCiyzsQcjVfpfVO4Pe1QxU9d
8XnCzdOs78NLIYwfnOAVYENMNXsCSVmdRC3sClElZo2Qnz0wXcx0WFwRUfSoMBk4
YeYi3GQd8LOwmsI8SkrjIGcfZ2PX9yhNxf2pOBS4xikaxXaxImkFu2196UWzZx46
65grFb42PamDEJxyAIbVMHQCNUobNNoaXgYAoiY/XNI0TNgMsEFwrgJD9qNYB46V
Oli34TkpzntN/3qjoZvGJTqe4fIqYr47lEZcNnmSAIm7e+aagrGNvdtNNjrajiqA
QiIgWOEnAJ0x7MgLXj2gO/lUqCe0HJNfBwOHkxPr6Cj3SwRh+QH2hy817c2UfL5E
cKHcWhoAcJ88PamCTUCdboV2vICnHzi+EBppmdbai30M1G+kZvk=
=1CBB
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
