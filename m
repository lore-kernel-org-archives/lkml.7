Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA9FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D59120863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcor0mMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfI2U5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 16:57:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31301 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726390AbfI2U5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569790634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5jH4f4LZDZqaaEScj6lnIVv5jlaNTZBJty54S6GxOfw=;
        b=gcor0mMANZ2Z1Ing3S2ONjaTtYt/oPvntOcGfvjzikipw0m0ZCS0RXi2h/lRmbVKCWXRDT
        GIk9zOUHPleh2K/3nNsLEvk5WhQHEd+LKPTP01eP7oSSIKOknlDnrmSPYADgPGCMH59dFt
        JcHx4OGHGNyWv1v382zHfVOA1LT6XZg=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-V4ZV6DXmN2Sj81KXcOoavA-1; Sun, 29 Sep 2019 16:57:12 -0400
Received: by mail-vk1-f199.google.com with SMTP id o205so5702154vka.23
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 13:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gFvDTt7rQrsZZ2B9OPwXJlEOA+EfFx47BQVi5RhehjE=;
        b=gPi4eCtBMs+sSBw5LKUjA9dMkoJbPv8tTdbGrBYHTjzMkaRiEetXfxcV2g/+5uv16A
         MepBdGbrr9klO29A6+CzOcrpS/bBB7ou+ZZnQDzyExCvnxD4DE5okBaqO5mcCA0nxMwC
         LIPsKAEWQdOq9JvsGvVo3CmrpNLm0ajJyeel5WPEmllVVWlS3Ddg1rekjAoMop1Jj/sj
         kUXPneUk0XvnzKzOw9Ihu0E8ZM7vKZqx3sikE+DkgY24LGtK8z+iRxjejzFNBCkJDAkt
         h7RhMPqQWfZ7IuE/bAme06K1VsNcNknxFXTSKxMdc+Mkq+fG/aHevzLJdKqvBzLZktS1
         AANg==
X-Gm-Message-State: APjAAAX1xiQ4/7sVP7qCUD7qrmX3Hluk+UsIW9nIJNBSWgQVuuo7pnjO
        We0nZdefVF32B1jjQTZ9TdgGWZgXlw7b3cBhKYhBh+DJTi1i44KNWQbAy0LSbZkAemswq3mm2v2
        ec/eeFWOLnVcNgDfUHJ+tywIn
X-Received: by 2002:a67:e953:: with SMTP id p19mr7940248vso.79.1569790631758;
        Sun, 29 Sep 2019 13:57:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzh4aLzX78Mglpneti4IO9tW37qPuzGkqqbl4KUInJc9W0aU/g8pfaIxVb+kTYNDJVDGxfudw==
X-Received: by 2002:a67:e953:: with SMTP id p19mr7940242vso.79.1569790631423;
        Sun, 29 Sep 2019 13:57:11 -0700 (PDT)
Received: from ?IPv6:2601:342:8200:6edc::b073? ([2601:342:8200:6edc::b073])
        by smtp.gmail.com with ESMTPSA id n189sm3395140vkf.40.2019.09.29.13.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2019 13:57:10 -0700 (PDT)
Subject: Re: [PATCH] ion_system_heap: support X86 archtecture
To:     jun.zhang@intel.com, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        bo <bo.he@intel.com>, Jie A <jie.a.bai@intel.com>
References: <20190929072841.14848-1-jun.zhang@intel.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <7aad1995-4bb2-a74e-954f-872ea21a752b@redhat.com>
Date:   Sun, 29 Sep 2019 16:57:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190929072841.14848-1-jun.zhang@intel.com>
Content-Language: en-US
X-MC-Unique: V4ZV6DXmN2Sj81KXcOoavA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/19 3:28 AM, jun.zhang@intel.com wrote:
> From: zhang jun <jun.zhang@intel.com>
>=20
> we see tons of warning like:
> [   45.846872] x86/PAT: NDK MediaCodec_:3753 map pfn RAM range req
> write-combining for [mem 0x1e7a80000-0x1e7a87fff], got write-back
> [   45.848827] x86/PAT: .vorbis.decoder:4088 map pfn RAM range req
> write-combining for [mem 0x1e7a58000-0x1e7a58fff], got write-back
> [   45.848875] x86/PAT: NDK MediaCodec_:3753 map pfn RAM range req
> write-combining for [mem 0x1e7a48000-0x1e7a4ffff], got write-back
> [   45.849403] x86/PAT: .vorbis.decoder:4088 map pfn RAM range
> req write-combining for [mem 0x1e7a70000-0x1e7a70fff], got write-back
>=20
> check the kernel Documentation/x86/pat.txt, it says:
> A. Exporting pages to users with remap_pfn_range, io_remap_pfn_range,
> vm_insert_pfn
> Drivers wanting to export some pages to userspace do it by using
> mmap interface and a combination of
> 1) pgprot_noncached()
> 2) io_remap_pfn_range() or remap_pfn_range() or vm_insert_pfn()
> With PAT support, a new API pgprot_writecombine is being added.
> So, drivers can continue to use the above sequence, with either
> pgprot_noncached() or pgprot_writecombine() in step 1, followed by step 2=
.
>=20
> In addition, step 2 internally tracks the region as UC or WC in
> memtype list in order to ensure no conflicting mapping.
>=20
> Note that this set of APIs only works with IO (non RAM) regions.
> If driver ants to export a RAM region, it has to do set_memory_uc() or
> set_memory_wc() as step 0 above and also track the usage of those pages
> and use set_memory_wb() before the page is freed to free pool.
>=20
> the fix follow the pat document, do set_memory_wc() as step 0 and
> use the set_memory_wb() before the page is freed.
>=20

All this work needs to be done on the new dma-buf heap rework and I
don't think it makes sense to put it on the staging version

https://lore.kernel.org/lkml/20190906184712.91980-1-john.stultz@linaro.org/

(I also continue to question the value of uncached buffers, especially on
x86)

> Signed-off-by: he, bo <bo.he@intel.com>
> Signed-off-by: zhang jun <jun.zhang@intel.com>
> Signed-off-by: Bai, Jie A <jie.a.bai@intel.com>
> ---
>   drivers/staging/android/ion/ion_system_heap.c | 28 ++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/stag=
ing/android/ion/ion_system_heap.c
> index b83a1d16bd89..d298b8194820 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -13,6 +13,7 @@
>   #include <linux/scatterlist.h>
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
> +#include <asm/set_memory.h>
>  =20
>   #include "ion.h"
>  =20
> @@ -134,6 +135,13 @@ static int ion_system_heap_allocate(struct ion_heap =
*heap,
>   =09sg =3D table->sgl;
>   =09list_for_each_entry_safe(page, tmp_page, &pages, lru) {
>   =09=09sg_set_page(sg, page, page_size(page), 0);
> +
> +#ifdef CONFIG_X86
> +=09if (!(buffer->flags & ION_FLAG_CACHED))
> +=09=09set_memory_wc((unsigned long)page_address(sg_page(sg)),
> +=09=09=09      PAGE_ALIGN(sg->length) >> PAGE_SHIFT);
> +#endif
> +
>   =09=09sg =3D sg_next(sg);
>   =09=09list_del(&page->lru);
>   =09}
> @@ -162,8 +170,15 @@ static void ion_system_heap_free(struct ion_buffer *=
buffer)
>   =09if (!(buffer->private_flags & ION_PRIV_FLAG_SHRINKER_FREE))
>   =09=09ion_heap_buffer_zero(buffer);
>  =20
> -=09for_each_sg(table->sgl, sg, table->nents, i)
> +=09for_each_sg(table->sgl, sg, table->nents, i) {
> +#ifdef CONFIG_X86
> +=09=09if (!(buffer->flags & ION_FLAG_CACHED))
> +=09=09=09set_memory_wb((unsigned long)page_address(sg_page(sg)),
> +=09=09=09=09      PAGE_ALIGN(sg->length) >> PAGE_SHIFT);
> +#endif
> +
>   =09=09free_buffer_page(sys_heap, buffer, sg_page(sg));
> +=09}
>   =09sg_free_table(table);
>   =09kfree(table);
>   }
> @@ -316,6 +331,12 @@ static int ion_system_contig_heap_allocate(struct io=
n_heap *heap,
>  =20
>   =09buffer->sg_table =3D table;
>  =20
> +#ifdef CONFIG_X86
> +=09if (!(buffer->flags & ION_FLAG_CACHED))
> +=09=09set_memory_wc((unsigned long)page_address(page),
> +=09=09=09      PAGE_ALIGN(len) >> PAGE_SHIFT);
> +#endif
> +
>   =09return 0;
>  =20
>   free_table:
> @@ -334,6 +355,11 @@ static void ion_system_contig_heap_free(struct ion_b=
uffer *buffer)
>   =09unsigned long pages =3D PAGE_ALIGN(buffer->size) >> PAGE_SHIFT;
>   =09unsigned long i;
>  =20
> +#ifdef CONFIG_X86
> +=09if (!(buffer->flags & ION_FLAG_CACHED))
> +=09=09set_memory_wb((unsigned long)page_address(page), pages);
> +#endif
> +
>   =09for (i =3D 0; i < pages; i++)
>   =09=09__free_page(page + i);
>   =09sg_free_table(table);
>=20

