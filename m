Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A06C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11F92177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pwrunOu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfCME23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:28:29 -0400
Received: from ozlabs.org ([203.11.71.1]:55265 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfCME21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:28:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 44JzNl5nPpz9sDB; Wed, 13 Mar 2019 15:28:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1552451303;
        bh=YwQ5f+H3Ru8vCsfwi5Jh+JuQ9ZKtgXRwSwkRtI2CsaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwrunOu1PWfR6fRj9TQpUxRRlZMt3BsM1hkutfBn91MxkbFMfuBUjKxfIeqNzZEUL
         xhjJxQ02+SUGIvbH4Af9Bivy+mqBFDeGoxWVVPZc+Ibn2uUUkLEy5BHnx3y0JIiJw6
         m6I0cn+/SPL/FpY6XC6IqqjyGQuRGRClqYBRStpA=
Date:   Wed, 13 Mar 2019 15:27:37 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2] powerpc/mm: move warning from resize_hpt_for_hotplug()
Message-ID: <20190313042737.GR9881@umbus.fritz.box>
References: <20190308105413.4302-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jcwRHPSxFqmwpRFb"
Content-Disposition: inline
In-Reply-To: <20190308105413.4302-1-lvivier@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jcwRHPSxFqmwpRFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2019 at 11:54:13AM +0100, Laurent Vivier wrote:
> resize_hpt_for_hotplug() reports a warning when it cannot
> resize the hash page table ("Unable to resize hash page
> table to target order") but in some cases it's not a problem
> and can make user thinks something has not worked properly.
>=20
> This patch moves the warning to arch_remove_memory() to
> only report the problem when it is needed.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/sparsemem.h  |  4 ++--
>  arch/powerpc/mm/hash_utils_64.c       | 17 ++++++-----------
>  arch/powerpc/mm/mem.c                 |  3 ++-
>  arch/powerpc/platforms/pseries/lpar.c |  3 ++-
>  4 files changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/=
asm/sparsemem.h
> index 68da49320592..3192d454a733 100644
> --- a/arch/powerpc/include/asm/sparsemem.h
> +++ b/arch/powerpc/include/asm/sparsemem.h
> @@ -17,9 +17,9 @@ extern int create_section_mapping(unsigned long start, =
unsigned long end, int ni
>  extern int remove_section_mapping(unsigned long start, unsigned long end=
);
> =20
>  #ifdef CONFIG_PPC_BOOK3S_64
> -extern void resize_hpt_for_hotplug(unsigned long new_mem_size);
> +extern int resize_hpt_for_hotplug(unsigned long new_mem_size);
>  #else
> -static inline void resize_hpt_for_hotplug(unsigned long new_mem_size) { }
> +static inline int resize_hpt_for_hotplug(unsigned long new_mem_size) { r=
eturn 0; }
>  #endif
> =20
>  #ifdef CONFIG_NUMA
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils=
_64.c
> index 0cc7fbc3bd1c..40bb2a8326bb 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -755,12 +755,12 @@ static unsigned long __init htab_get_table_size(voi=
d)
>  }
> =20
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -void resize_hpt_for_hotplug(unsigned long new_mem_size)
> +int resize_hpt_for_hotplug(unsigned long new_mem_size)
>  {
>  	unsigned target_hpt_shift;
> =20
>  	if (!mmu_hash_ops.resize_hpt)
> -		return;
> +		return 0;
> =20
>  	target_hpt_shift =3D htab_shift_for_mem_size(new_mem_size);
> =20
> @@ -773,15 +773,10 @@ void resize_hpt_for_hotplug(unsigned long new_mem_s=
ize)
>  	 * current shift
>  	 */
>  	if ((target_hpt_shift > ppc64_pft_size)
> -	    || (target_hpt_shift < (ppc64_pft_size - 1))) {
> -		int rc;
> -
> -		rc =3D mmu_hash_ops.resize_hpt(target_hpt_shift);
> -		if (rc && (rc !=3D -ENODEV))
> -			printk(KERN_WARNING
> -			       "Unable to resize hash page table to target order %d: %d\n",
> -			       target_hpt_shift, rc);
> -	}
> +	    || (target_hpt_shift < (ppc64_pft_size - 1)))
> +		return mmu_hash_ops.resize_hpt(target_hpt_shift);
> +
> +	return 0;
>  }
> =20
>  int hash__create_section_mapping(unsigned long start, unsigned long end,=
 int nid)
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 33cc6f676fa6..0d40d970cf4a 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -169,7 +169,8 @@ int __meminit arch_remove_memory(int nid, u64 start, =
u64 size,
>  	 */
>  	vm_unmap_aliases();
> =20
> -	resize_hpt_for_hotplug(memblock_phys_mem_size());
> +	if (resize_hpt_for_hotplug(memblock_phys_mem_size()) =3D=3D -ENOSPC)
> +		pr_warn("Hash collision while resizing HPT\n");
> =20
>  	return ret;
>  }
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platfor=
ms/pseries/lpar.c
> index f2a9f0adc2d3..1034ef1fe2b4 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -901,8 +901,10 @@ static int pseries_lpar_resize_hpt(unsigned long shi=
ft)
>  		break;
> =20
>  	case H_PARAMETER:
> +		pr_warn("Invalid argument from H_RESIZE_HPT_PREPARE\n");
>  		return -EINVAL;
>  	case H_RESOURCE:
> +		pr_warn("Operation not permitted from H_RESIZE_HPT_PREPARE\n");
>  		return -EPERM;
>  	default:
>  		pr_warn("Unexpected error %d from H_RESIZE_HPT_PREPARE\n", rc);
> @@ -918,7 +920,6 @@ static int pseries_lpar_resize_hpt(unsigned long shif=
t)
>  	if (rc !=3D 0) {
>  		switch (state.commit_rc) {
>  		case H_PTEG_FULL:
> -			pr_warn("Hash collision while resizing HPT\n");
>  			return -ENOSPC;
> =20
>  		default:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jcwRHPSxFqmwpRFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyIhrgACgkQbDjKyiDZ
s5L0exAAymSOpxCfriMb6Npbikc1b9QnS8txmrdxAbX6Jiq0wt3FLblYSVY6RGau
/jacSHypqEXMspnISemTjIImA+BPtDgCBIeuiVuF0eGCZ71I9Vlq4mhnc2lOmP7d
HIrvJ7IlWiqJ50WIlnGER4iypjCW3Mg+I+Z+XyILw+7x03O6GFV6wppit82E9Io3
jZKtXgnEjM/JIMZi1FhPTbM/E42T9D7XdNkwGX1VHzxyMBnKoP+KRSDkRheU1HKv
GlZLCGmeHTvYn3RAOFyIobXPuBKIIZNuOh/jbZ3j9kKbngwElSJ+CaTsqzOWTppf
qdVeOp80P6oehC/PdyjI1Jy3madGIDK/VRzDv9kurK0RVJyltuN+s+PU7V1+o5b9
JE1xGq9mSNFcAewYDEl2UiXAaJVvQ1Jb9b1xIGzTGu9dUl8DtDUfkAE3KeIFWBtA
/UjrjKHGLZIm6YQHeBtCjnEBpF6SJDPYORF5O9JL0p+tNwUIL2cm4RvjyM+Rv5As
DvbIEUryQ0x/Jph1MeNWIpyEDYCINwVh17mKGxSLQlUWg0RcjBDMQEIUe32Mar/V
BLz+iK/D3zmS4Bi7mMR1Cw9+JMbtg63WIx3VGv9NvxJA5Ht4fK/3qJyLrZPgobwi
R0XDc0QKMBZnvVq0xJVUivFOLRWus4vKHmCICLw0aEUGF0apNw0=
=wCLS
-----END PGP SIGNATURE-----

--jcwRHPSxFqmwpRFb--
