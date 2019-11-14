Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6C3C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B6B206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 01:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQ0JGnmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNBYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 20:24:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32403 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726190AbfKNBYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 20:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573694688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m7jXRzyKCm+mM5iPsPq5U8675eMVocuhlR6RXezXlIM=;
        b=FQ0JGnmOXtrH3+V+Dpbwkf0aNXuAYywqTAv0UL/W11GJfgNTxMra/X3BOb5cKw9uCNgOX4
        n2QfFcKXRrklPGJQfjD6LMQcSU6tcRxdHgFAZOUoV2CQHAADmNi4AbRfeMTf/iFF2z7CQP
        RV2oUhak6/GalKG4thjVS/H4T3UIAEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-qQt2hxAlNM2VwrcHmZ_fzg-1; Wed, 13 Nov 2019 20:24:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC5341802CE2;
        Thu, 14 Nov 2019 01:24:43 +0000 (UTC)
Received: from redhat.com (ovpn-121-71.rdu2.redhat.com [10.10.121.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8A791084196;
        Thu, 14 Nov 2019 01:24:42 +0000 (UTC)
Date:   Wed, 13 Nov 2019 20:24:41 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     jhubbard@nvidia.com, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
Message-ID: <20191114012441.GA6395@redhat.com>
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: qQt2hxAlNM2VwrcHmZ_fzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:07:22PM -0800, Dan Williams wrote:
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
> Cc: J=E9r=F4me Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

All looks good to me.

Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat.com>


> ---
> Hi John,
>=20
> This applies on top of today's linux-next and passes my nvdimm unit
> tests. That testing noticed that devmap_managed_enable_get() needed a
> small fixup as well.
>=20
>  drivers/nvdimm/pmem.c |    6 ------
>  mm/memremap.c         |   22 ++++++++++++----------
>  2 files changed, 12 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index f9f76f6ba07b..21db1ce8c0ae 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -338,13 +338,7 @@ static void pmem_release_disk(void *__pmem)
>  =09put_disk(pmem->disk);
>  }
> =20
> -static void pmem_pagemap_page_free(struct page *page)
> -{
> -=09wake_up_var(&page->_refcount);
> -}
> -
>  static const struct dev_pagemap_ops fsdax_pagemap_ops =3D {
> -=09.page_free=09=09=3D pmem_pagemap_page_free,
>  =09.kill=09=09=09=3D pmem_pagemap_kill,
>  =09.cleanup=09=09=3D pmem_pagemap_cleanup,
>  };
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 022e78e68ea0..6e6f3d6fdb73 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -27,7 +27,8 @@ static void devmap_managed_enable_put(void)
> =20
>  static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
>  {
> -=09if (!pgmap->ops || !pgmap->ops->page_free) {
> +=09if (!pgmap->ops || (pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE
> +=09=09=09=09&& !pgmap->ops->page_free)) {
>  =09=09WARN(1, "Missing page_free method\n");
>  =09=09return -EINVAL;
>  =09}
> @@ -449,12 +450,6 @@ void __put_devmap_managed_page(struct page *page)
>  =09 * holds a reference on the page.
>  =09 */
>  =09if (count =3D=3D 1) {
> -=09=09/* Clear Active bit in case of parallel mark_page_accessed */
> -=09=09__ClearPageActive(page);
> -=09=09__ClearPageWaiters(page);
> -
> -=09=09mem_cgroup_uncharge(page);
> -
>  =09=09/*
>  =09=09 * When a device_private page is freed, the page->mapping field
>  =09=09 * may still contain a (stale) mapping value. For example, the
> @@ -476,10 +471,17 @@ void __put_devmap_managed_page(struct page *page)
>  =09=09 * handled differently or not done at all, so there is no need
>  =09=09 * to clear page->mapping.
>  =09=09 */
> -=09=09if (is_device_private_page(page))
> -=09=09=09page->mapping =3D NULL;
> +=09=09if (is_device_private_page(page)) {
> +=09=09=09/* Clear Active bit in case of parallel mark_page_accessed */
> +=09=09=09__ClearPageActive(page);
> +=09=09=09__ClearPageWaiters(page);
> =20
> -=09=09page->pgmap->ops->page_free(page);
> +=09=09=09mem_cgroup_uncharge(page);
> +
> +=09=09=09page->mapping =3D NULL;
> +=09=09=09page->pgmap->ops->page_free(page);
> +=09=09} else
> +=09=09=09wake_up_var(&page->_refcount);
>  =09} else if (!count)
>  =09=09__put_page(page);
>  }
>=20

