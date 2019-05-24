Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DBBC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBA920879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Gj9MdXQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfEXBFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:05:06 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1314 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbfEXBFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:05:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce743400000>; Thu, 23 May 2019 18:05:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 May 2019 18:05:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 May 2019 18:05:04 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 May
 2019 01:05:04 +0000
Subject: Re: [PATCH] mm/swap: Fix release_pages() when releasing devmap pages
To:     <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190523223746.4982-1-ira.weiny@intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2ac0f1cd-f076-a007-8152-c136efe60694@nvidia.com>
Date:   Thu, 23 May 2019 18:05:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190523223746.4982-1-ira.weiny@intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558659905; bh=SN+7sL6HemPw2Et2gfO0Vw1ZlZItZYzsD2goYpEBJkQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Gj9MdXQbZ92cf7d41CUN+4e4JgAd2OYEpYqtn9+DSHMZIHT2a89BP7cO7AJbww848
         Gx1ff+u3rLKJ+u2iuzhZo6i71uD/IpTovz3DtAXHHXGr5eduHw0WOWHSymxu1I9sSC
         2sK7fUvvh1ARhTRpzYNLkhJBtbkyy+iakzhdSuSPhpkaUihk6GETp+YO4afjypqm0n
         JmzQvP/2isAa/oslMGAt+I4mOz9884vn+diqq8S8Xy28UzPI5HA07tdGkSPGbdPmmC
         40FqdTOgYLKi3RD1jtB1TCyLl0aAcpMHXJ4TuF5cxXSMZVR44dHPQZQT7q85oXegJp
         CNFSuPvIjPopg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 3:37 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> Device pages can be more than type MEMORY_DEVICE_PUBLIC.
>=20
> Handle all device pages within release_pages()
>=20
> This was found via code inspection while determining if release_pages()
> and the new put_user_pages() could be interchangeable.
>=20
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  mm/swap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/swap.c b/mm/swap.c
> index 3a75722e68a9..d1e8122568d0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -739,15 +739,14 @@ void release_pages(struct page **pages, int nr)
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
> +			if (put_devmap_managed_page(page))
> +				continue;
>  		}
> =20
>  		page =3D compound_head(page);
>=20

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
--=20
John Hubbard
NVIDIA
