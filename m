Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95672C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2BC20643
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mfj+mls9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKNAmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:42:04 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18192 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfKNAmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:42:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcca2da0000>; Wed, 13 Nov 2019 16:42:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 16:42:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 16:42:03 -0800
Received: from [10.2.160.107] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Nov
 2019 00:42:02 +0000
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <913133b7-58d8-9645-fc89-c2819825e1ee@nvidia.com>
Date:   Wed, 13 Nov 2019 16:39:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573692122; bh=nHBqKFuyS3Jqi47A+b+7bCsdLPkBjyfHLHVyQVlH5s4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mfj+mls9Md6loxbYBg0RKUGTHWE83J7r/HTza4FSYS/5NJpTEpg2CWpo40dqRX44+
         ajl43OHTFYsQowjpTzBH7ZG1pTO8SEok2b2z6W9HC0AEQFF5y+7ki4ZiCjuAmJhSUr
         9145t48pXQ16RpzNBRlEsbqImCl8QHDCSXJVmguYGxAxx7q3iSEy9ByUVyfDVBNq71
         aqkHuqQyRRpBigl9VkMvUrwWr/3fmaRqMIns6aKSWPne9X5LHUJKn05kH8ejTwpgaC
         UQKKSqa3O0YFIGHAms67s2H1FHY6cwFQ/zBsA72LKnaD5bDaMSzkNvOJRvU456t2A+
         JWCL34W+vVxBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/19 4:07 PM, Dan Williams wrote:
> After the removal of the device-public infrastructure there are only 2
> ->page_free() call backs in the kernel. One of those is a device-private
> callback in the nouveau driver, the other is a generic wakeup needed in
> the DAX case. In the hopes that all ->page_free() callbacks can be
> migrated to common core kernel functionality, move the device-private
> specific actions in __put_devmap_managed_page() under the
> is_device_private_page() conditional, including the ->page_free()
> callback. For the other page types just open-code the generic wakeup.
>=20
> Yes, the wakeup is only needed in the MEMORY_DEVICE_FSDAX case, but it
> does no harm in the MEMORY_DEVICE_DEVDAX and MEMORY_DEVICE_PCI_P2PDMA
> case.
>=20
> Cc: Jan Kara <jack@suse.cz>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Hi John,
>=20
> This applies on top of today's linux-next and passes my nvdimm unit
> tests. That testing noticed that devmap_managed_enable_get() needed a
> small fixup as well.

Got it. This will appear in the next posted version of my "mm/gup: track
dma-pinned pages: FOLL_PIN, FOLL_LONGTERM" patchset.


>=20
>   drivers/nvdimm/pmem.c |    6 ------
>   mm/memremap.c         |   22 ++++++++++++----------
>   2 files changed, 12 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index f9f76f6ba07b..21db1ce8c0ae 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -338,13 +338,7 @@ static void pmem_release_disk(void *__pmem)
>   	put_disk(pmem->disk);
>   }
>  =20
> -static void pmem_pagemap_page_free(struct page *page)
> -{
> -	wake_up_var(&page->_refcount);
> -}
> -
>   static const struct dev_pagemap_ops fsdax_pagemap_ops =3D {
> -	.page_free		=3D pmem_pagemap_page_free,
>   	.kill			=3D pmem_pagemap_kill,
>   	.cleanup		=3D pmem_pagemap_cleanup,
>   };
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 022e78e68ea0..6e6f3d6fdb73 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -27,7 +27,8 @@ static void devmap_managed_enable_put(void)
>  =20
>   static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
>   {
> -	if (!pgmap->ops || !pgmap->ops->page_free) {
> +	if (!pgmap->ops || (pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE
> +				&& !pgmap->ops->page_free)) {


OK, so only MEMORY_DEVICE_PRIVATE has .page_free ops. That looks
correct to me, based on looking at the .page_free setters--I
only see Nouveau setting it.


thanks,
--=20
John Hubbard
NVIDIA
