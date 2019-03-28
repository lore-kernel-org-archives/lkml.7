Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD19C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933A52183E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cI2sZWCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfC1V7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 17:59:53 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2887 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfC1V7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 17:59:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d43da0001>; Thu, 28 Mar 2019 14:59:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 14:59:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 14:59:51 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 21:59:50 +0000
Subject: Re: [PATCH v2 07/11] mm/hmm: add default fault flags to avoid the
 need to pre-fill pfns arrays.
To:     <jglisse@redhat.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-8-jglisse@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <2f790427-ea87-b41e-b386-820ccdb7dd38@nvidia.com>
Date:   Thu, 28 Mar 2019 14:59:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190325144011.10560-8-jglisse@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553810394; bh=NNa4/s5RLr8tBsJiCFnRZr38vKbxE2ngsDs1pGWjIlg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cI2sZWCF4+YGKEOgcJkUT3mkH1Jc5Nyt+uoIoHzVIKMZ4xb84m+F0wvL7eWW4AybC
         E+Vg/fKOCOUCvOAIJsRZ4ErgncGzMlC4u0jqjZp0taoiagLD5dYx50WQgPKPAnC28b
         QiGx+5vZR9MOoN+7h/XvFW4FmcXRjCfYsBhGVNBJOmlAH3C7HhXzNoQ+Xg0a9meoQV
         eugVY37iCwti5sciGjkF61tSPNzB5sPl+jwniGxrDQpPz7NgDvTixOMm5YRor1i2Yj
         +GmAoB0UZisLt5CmuBDnHKjX0VwzTgL8Mj+b0IiV5zm6jNRlQdR3dC8dggn2POgmT3
         Qs3LP9FdDaQDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
> The HMM mirror API can be use in two fashions. The first one where the HM=
M
> user coalesce multiple page faults into one request and set flags per pfn=
s
> for of those faults. The second one where the HMM user want to pre-fault =
a
> range with specific flags. For the latter one it is a waste to have the u=
ser
> pre-fill the pfn arrays with a default flags value.
>=20
> This patch adds a default flags value allowing user to set them for a ran=
ge
> without having to pre-fill the pfn array.
>=20
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/hmm.h |  7 +++++++
>  mm/hmm.c            | 12 ++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 79671036cb5f..13bc2c72f791 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -165,6 +165,8 @@ enum hmm_pfn_value_e {
>   * @pfns: array of pfns (big enough for the range)
>   * @flags: pfn flags to match device driver page table
>   * @values: pfn value for some special case (none, special, error, ...)
> + * @default_flags: default flags for the range (write, read, ...)
> + * @pfn_flags_mask: allows to mask pfn flags so that only default_flags =
matter
>   * @pfn_shifts: pfn shift value (should be <=3D PAGE_SHIFT)
>   * @valid: pfns array did not change since it has been fill by an HMM fu=
nction
>   */
> @@ -177,6 +179,8 @@ struct hmm_range {
>  	uint64_t		*pfns;
>  	const uint64_t		*flags;
>  	const uint64_t		*values;
> +	uint64_t		default_flags;
> +	uint64_t		pfn_flags_mask;
>  	uint8_t			pfn_shift;
>  	bool			valid;
>  };
> @@ -521,6 +525,9 @@ static inline int hmm_vma_fault(struct hmm_range *ran=
ge, bool block)
>  {
>  	long ret;
> =20
> +	range->default_flags =3D 0;
> +	range->pfn_flags_mask =3D -1UL;

Hi Jerome,

This is nice to have. Let's constrain it a little bit more, though: the pfn=
_flags_mask
definitely does not need to be a run time value. And we want some assurance=
 that
the mask is=20
	a) large enough for the flags, and
	b) small enough to avoid overrunning the pfns field.

Those are less certain with a run-time struct field, and more obviously cor=
rect with
something like, approximately:

 	#define PFN_FLAGS_MASK 0xFFFF

or something.

In other words, this is more flexibility than we need--just a touch too muc=
h,
IMHO.

> +
>  	ret =3D hmm_range_register(range, range->vma->vm_mm,
>  				 range->start, range->end);
>  	if (ret)
> diff --git a/mm/hmm.c b/mm/hmm.c
> index fa9498eeb9b6..4fe88a196d17 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -415,6 +415,18 @@ static inline void hmm_pte_need_fault(const struct h=
mm_vma_walk *hmm_vma_walk,
>  	if (!hmm_vma_walk->fault)
>  		return;
> =20
> +	/*
> +	 * So we not only consider the individual per page request we also
> +	 * consider the default flags requested for the range. The API can
> +	 * be use in 2 fashions. The first one where the HMM user coalesce
> +	 * multiple page fault into one request and set flags per pfns for
> +	 * of those faults. The second one where the HMM user want to pre-
> +	 * fault a range with specific flags. For the latter one it is a
> +	 * waste to have the user pre-fill the pfn arrays with a default
> +	 * flags value.
> +	 */
> +	pfns =3D (pfns & range->pfn_flags_mask) | range->default_flags;

Need to verify that the mask isn't too large or too small.

> +
>  	/* We aren't ask to do anything ... */
>  	if (!(pfns & range->flags[HMM_PFN_VALID]))
>  		return;
>=20



thanks,
--=20
John Hubbard
NVIDIA
