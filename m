Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FBFC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02AF20848
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VMDzn2N9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFDTsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 15:48:22 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2337 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfFDTsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 15:48:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf6cb010001>; Tue, 04 Jun 2019 12:48:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 12:48:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Jun 2019 12:48:20 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 19:48:18 +0000
Subject: Re: [PATCH v3] mm/swap: Fix release_pages() when releasing devmap
 pages
To:     <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190604164813.31514-1-ira.weiny@intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <cfd74a0f-71b5-1ece-80af-7f415321d5c1@nvidia.com>
Date:   Tue, 4 Jun 2019 12:48:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604164813.31514-1-ira.weiny@intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559677699; bh=dg2eFlce2wL8r6pAm2mCz7KFZbTnT7TbRCi0PP+rFvs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VMDzn2N9Weq9nF01e9HdN7Q2C346rS9JiNUOwA+2rSAJpSAXvmGPR/vS8o1biYWvF
         xGEuSPqgs80J4f9vVflVazjnC0wcBvuqWR0qgknO1TRdcV3BZzdjdNHlCjmLZJNhe9
         imzGKpC3YIU9VXkwh7QrxIeofG+RBt7v36HcTJjATu0jByxSqiGNRMNQd8JoOvHv9m
         I2SdbTLcFf9HrtUSAmMTYkRGLTIWP8Z871c0ZeIIRfAIaxfjZO8O3PYKvs6zzqXpQ0
         g5OYXGX6LsD9SY8f3PViEb295WoMoNHOisSnqx9lGFteU9gPdSIwV1tB+NBVo7/A/v
         AIXuwp8vPWeMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 9:48 AM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> release_pages() is an optimized version of a loop around put_page().
> Unfortunately for devmap pages the logic is not entirely correct in
> release_pages().  This is because device pages can be more than type
> MEMORY_DEVICE_PUBLIC.  There are in fact 4 types, private, public, FS
> DAX, and PCI P2PDMA.  Some of these have specific needs to "put" the
> page while others do not.
>=20
> This logic to handle any special needs is contained in
> put_devmap_managed_page().  Therefore all devmap pages should be
> processed by this function where we can contain the correct logic for a
> page put.
>=20
> Handle all device type pages within release_pages() by calling
> put_devmap_managed_page() on all devmap pages.  If
> put_devmap_managed_page() returns true the page has been put and we
> continue with the next page.  A false return of
> put_devmap_managed_page() means the page did not require special
> processing and should fall to "normal" processing.
>=20
> This was found via code inspection while determining if release_pages()
> and the new put_user_pages() could be interchangeable.[1]
>=20
> [1] https://lore.kernel.org/lkml/20190523172852.GA27175@iweiny-DESK2.sc.i=
ntel.com/
>=20
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>=20
> ---
> Changes from V2:
> 	Update changelog for more clarity as requested by Michal
> 	Update comment WRT "failing" of put_devmap_managed_page()
>=20
> Changes from V1:
> 	Add comment clarifying that put_devmap_managed_page() can still
> 	fail.
> 	Add Reviewed-by tags.
>=20
>  mm/swap.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/swap.c b/mm/swap.c
> index 7ede3eddc12a..6d153ce4cb8c 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -740,15 +740,20 @@ void release_pages(struct page **pages, int nr)
>  		if (is_huge_zero_page(page))
>  			continue;
> =20
> -		/* Device public page can not be huge page */
> -		if (is_device_public_page(page)) {
> +		if (is_zone_device_page(page)) {
>  			if (locked_pgdat) {
>  				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
>  						       flags);
>  				locked_pgdat =3D NULL;
>  			}
> -			put_devmap_managed_page(page);
> -			continue;
> +			/*
> +			 * Not all zone-device-pages require special
> +			 * processing.  Those pages return 'false' from
> +			 * put_devmap_managed_page() expecting a call to
> +			 * put_page_testzero()
> +			 */

Just a documentation tweak: how about:=20

			/*
			 * ZONE_DEVICE pages that return 'false' from=20
			 * put_devmap_managed_page() do not require special=20
			 * processing, and instead, expect a call to=20
			 * put_page_testzero().
			 */


thanks,
--=20
John Hubbard
NVIDIA

> +			if (put_devmap_managed_page(page))
> +				continue;
>  		}
> =20
>  		page =3D compound_head(page);
>=20
