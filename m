Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D189C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB59A20730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKRLtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:49:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:33852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbfKRLtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:49:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32D72AE15;
        Mon, 18 Nov 2019 11:49:06 +0000 (UTC)
Message-ID: <5abdcb0e0e1043a101f579ea65d07a1f6b91f896.camel@suse.de>
Subject: Re: [PATCH v2] ARM: dt: check MPIDR on MP devices built without SMP
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, "kernelci.org bot" <bot@kernelci.org>,
        Russell King <linux@armlinux.org.uk>, wahrenst@gmx.net,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 18 Nov 2019 12:49:04 +0100
In-Reply-To: <20191004155232.17209-1-nsaenzjulienne@suse.de>
References: <20191004155232.17209-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-y1N3c8/y6YfgQR8o2WoR"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y1N3c8/y6YfgQR8o2WoR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-10-04 at 17:52 +0200, Nicolas Saenz Julienne wrote:
> On SMP builds, in order to properly link CPU devices with their
> respective DT nodes we start by matching the boot CPU. This is achieved
> by comparing the 'reg' property on each of the CPU DT nodes with the
> MPIDR. The association is necessary as to validate the whole CPU logical
> map, which ultimately links CPU devices and their DT nodes.
>=20
> On setups built without SMP, no MPIDR read is performed. The only thing
> expected is for the 'reg' property in the CPU DT node to contain the
> value 0x0.
>=20
> This causes problems on MP setups built without SMP. As their boot CPU
> DT node contains the relevant MPIDR as opposed to 0x0. No match is then
> possible. This causes troubles further down the line as drivers are
> unable to get the CPU's DT node.
>=20
> Change the way we choose whether to get the MPIDR or not. On builds
> without SMP check the number of CPUs defined in DT. Anything > 1 means
> the MPIDR should be available and matched accordingly.
>=20
> Note that if there was a rogue UP device exposing multiple active CPUs
> in its DT the possible outcomes depend on the ARM series. For example
> Cortex-A9 specifies that the MPIDR is returns 0x0 on UP devices. On the
> other hand ARM1176JZ's TRM doesn't define a MPIDR register and specifies
> that any unwarranted register access will raise an undefined exception.
> Overall, given the bogus DT, a reasonable outcome.
>=20
> This was originally seen on a Raspberry Pi 2 built with bcm2835_defconfig=
.
>=20
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Tested-by: Stefan Wahren <wahrenst@gmx.net>

ping :)

> ---
>=20
> Changes since v1:
>   - Rewrite patch description
>   - Use of_get_available_child_count()
>=20
> Note: kept Setfan's Tested-by as the changes only affect a corner case.
>=20
>  arch/arm/kernel/devtree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 39c978698406..cd11742d9bc2 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -74,7 +74,7 @@ void __init arm_dt_init_cpu_maps(void)
>  	struct device_node *cpu, *cpus;
>  	int found_method =3D 0;
>  	u32 i, j, cpuidx =3D 1;
> -	u32 mpidr =3D is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
> +	u32 mpidr =3D 0;
> =20
>  	u32 tmp_map[NR_CPUS] =3D { [0 ... NR_CPUS-1] =3D MPIDR_INVALID };
>  	bool bootcpu_valid =3D false;
> @@ -83,6 +83,9 @@ void __init arm_dt_init_cpu_maps(void)
>  	if (!cpus)
>  		return;
> =20
> +	if (is_smp() || of_get_available_child_count(cpus) > 1)
> +		mpidr =3D read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
> +
>  	for_each_of_cpu_node(cpu) {
>  		const __be32 *cell;
>  		int prop_bytes;


--=-y1N3c8/y6YfgQR8o2WoR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3ShTAACgkQlfZmHno8
x/402Qf/dDl/DgJaFBQiLgRKeAI9ObTcxdilX/sxqszha/c/kv60DZzvdWxjwzbh
pCQM0q2CCi0Z7ri1UCk3ugWb8+KAPg+RCFHdv1wMBlt9FclN1Qo24oHUfIqP8/dd
Rzg/GJIdzBonLnDIGu2AjgG7XnjlosfRhSDt/apFFTIT17k50FlKXD5pUPUorIVg
2PJmlr+ezX84CB1nArSZ5p2FQFLpdF1CV9mq85nraCuXtvy+h4DV+m9PBwYMDBs+
exNM1+Ir+PX/YE3Lukulw+U693Fn57nNRrTrE9562f8oyJX64h9IdeMCRLOEi2e5
Muiml1qK7GH4ptZuRZQIb+YiX+EB3Q==
=SjhS
-----END PGP SIGNATURE-----

--=-y1N3c8/y6YfgQR8o2WoR--

