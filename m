Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F04C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF0820828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UEz+1FGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfCRUVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:21:14 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52989 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfCRUVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:21:14 -0400
Received: by mail-it1-f193.google.com with SMTP id g17so22562159ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JZMNzWrZePXHcuhdEZbp7VrvshpOH0hZtYHcijCFh9g=;
        b=UEz+1FGffERfZCRWZGenVSAihHBICGIFw3c4KSLYF7YSDwuXL8veDOjxmOSTVnEBzs
         WfVPtp0yDwVmNdu+IfXq62VZdq5PsolnRakEwcHcqcxK99Nw1A2+o9vw9JoNVGd6HykS
         U7qdNRQAtym1QHoovhe5ov53A+uZTrBs3gFUdnPBJJqsWyJGx7CiEFYw9oSRGH+JW5o+
         637sX0AsSORwqf5kpBLeSXkLTQPCEmp1+wj2i03Euz7jHo5MuJBqUawsPmaraZ76KfIW
         UW6cAG8cSk9Km/9TW+rXthTS5dmIkZ1nADG1hvf+Lgxo1nkZwMBpq8W6vCC4hxFlFbUN
         GcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JZMNzWrZePXHcuhdEZbp7VrvshpOH0hZtYHcijCFh9g=;
        b=eJ7hyZArB1pTZ4ReHexf9xBLjsxJs5WNE4uA91dfPmxxDXMwl5FWagy9uceV1/88Cp
         QfTiIfe6c3qFTkcEnuLpooPVs7rJq0Hvndi9QnY70Ictdu9Svk3urzdxDlHNQI/fCBPD
         ecgQz2qDfOl8ipYVeMdRIrX5L0ymTE7F1uxK8RZrRdOFGG4sQqR3Gi9PEXvCd0i1idFq
         cD4BnmP/pQc4JvMzQki1nxvcfLmlKosxOExYwdFqGVLqvyJm7hFiiKLJXtnpFcIJB13T
         BoWhqTyb8tGrcKn37+ivqvdDsf/nZh6pIPk56P+zZ7rVHJb1eXdbiHNiQ0oa4i4lt64g
         5cRw==
X-Gm-Message-State: APjAAAWkbuh+iBj4pNF0KrMIgXgAuLOqLm9Ka86glm9a9v2EVBB1RqtA
        P+j/y3YwgvnIrMkffC/Ep3aB2WhEj91hddS/QVA=
X-Google-Smtp-Source: APXvYqzJuPSks0GAP1oqUsIZfg/wphNwHE+ndlZ4w1hRuPeOs0Y4dUDfZupA1QMq2KGmFGka1++8mRxRVE+oALnzzxY=
X-Received: by 2002:a24:21d5:: with SMTP id e204mr479827ita.56.1552940472503;
 Mon, 18 Mar 2019 13:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190129165428.3931-8-jglisse@redhat.com>
In-Reply-To: <20190129165428.3931-8-jglisse@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Mar 2019 13:21:00 -0700
Message-ID: <CAA9_cmcN+8B_tyrxRy5MMr-AybcaDEEWB4J8dstY6h0cmFxi3g@mail.gmail.com>
Subject: Re: [PATCH 07/10] mm/hmm: add an helper function that fault pages and
 map them to a device
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 8:55 AM <jglisse@redhat.com> wrote:
>
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>
> This is a all in one helper that fault pages in a range and map them to
> a device so that every single device driver do not have to re-implement
> this common pattern.

Ok, correct me if I am wrong but these seem effectively be the typical
"get_user_pages() + dma_map_page()" pattern that non-HMM drivers would
follow. Could we just teach get_user_pages() to take an HMM shortcut
based on the range?

I'm interested in being able to share code across drivers and not have
to worry about the HMM special case at the api level.

And to be clear this isn't an anti-HMM critique this is a "yes, let's
do this, but how about a more fundamental change".

>
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/hmm.h |   9 +++
>  mm/hmm.c            | 152 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+)
>
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 4263f8fb32e5..fc3630d0bbfd 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -502,6 +502,15 @@ int hmm_range_register(struct hmm_range *range,
>  void hmm_range_unregister(struct hmm_range *range);
>  long hmm_range_snapshot(struct hmm_range *range);
>  long hmm_range_fault(struct hmm_range *range, bool block);
> +long hmm_range_dma_map(struct hmm_range *range,
> +                      struct device *device,
> +                      dma_addr_t *daddrs,
> +                      bool block);
> +long hmm_range_dma_unmap(struct hmm_range *range,
> +                        struct vm_area_struct *vma,
> +                        struct device *device,
> +                        dma_addr_t *daddrs,
> +                        bool dirty);
>
>  /*
>   * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a r=
ange
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 0a4ff31e9d7a..9cd68334a759 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -30,6 +30,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/memremap.h>
>  #include <linux/jump_label.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/memory_hotplug.h>
>
> @@ -985,6 +986,157 @@ long hmm_range_fault(struct hmm_range *range, bool =
block)
>         return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
>  }
>  EXPORT_SYMBOL(hmm_range_fault);
> +
> +/*
> + * hmm_range_dma_map() - hmm_range_fault() and dma map page all in one.
> + * @range: range being faulted
> + * @device: device against to dma map page to
> + * @daddrs: dma address of mapped pages
> + * @block: allow blocking on fault (if true it sleeps and do not drop mm=
ap_sem)
> + * Returns: number of pages mapped on success, -EAGAIN if mmap_sem have =
been
> + *          drop and you need to try again, some other error value other=
wise
> + *
> + * Note same usage pattern as hmm_range_fault().
> + */
> +long hmm_range_dma_map(struct hmm_range *range,
> +                      struct device *device,
> +                      dma_addr_t *daddrs,
> +                      bool block)
> +{
> +       unsigned long i, npages, mapped;
> +       long ret;
> +
> +       ret =3D hmm_range_fault(range, block);
> +       if (ret <=3D 0)
> +               return ret ? ret : -EBUSY;
> +
> +       npages =3D (range->end - range->start) >> PAGE_SHIFT;
> +       for (i =3D 0, mapped =3D 0; i < npages; ++i) {
> +               enum dma_data_direction dir =3D DMA_FROM_DEVICE;
> +               struct page *page;
> +
> +               /*
> +                * FIXME need to update DMA API to provide invalid DMA ad=
dress
> +                * value instead of a function to test dma address value.=
 This
> +                * would remove lot of dumb code duplicated accross many =
arch.
> +                *
> +                * For now setting it to 0 here is good enough as the pfn=
s[]
> +                * value is what is use to check what is valid and what i=
sn't.
> +                */
> +               daddrs[i] =3D 0;
> +
> +               page =3D hmm_pfn_to_page(range, range->pfns[i]);
> +               if (page =3D=3D NULL)
> +                       continue;
> +
> +               /* Check if range is being invalidated */
> +               if (!range->valid) {
> +                       ret =3D -EBUSY;
> +                       goto unmap;
> +               }
> +
> +               /* If it is read and write than map bi-directional. */
> +               if (range->pfns[i] & range->values[HMM_PFN_WRITE])
> +                       dir =3D DMA_BIDIRECTIONAL;
> +
> +               daddrs[i] =3D dma_map_page(device, page, 0, PAGE_SIZE, di=
r);
> +               if (dma_mapping_error(device, daddrs[i])) {
> +                       ret =3D -EFAULT;
> +                       goto unmap;
> +               }
> +
> +               mapped++;
> +       }
> +
> +       return mapped;
> +
> +unmap:
> +       for (npages =3D i, i =3D 0; (i < npages) && mapped; ++i) {
> +               enum dma_data_direction dir =3D DMA_FROM_DEVICE;
> +               struct page *page;
> +
> +               page =3D hmm_pfn_to_page(range, range->pfns[i]);
> +               if (page =3D=3D NULL)
> +                       continue;
> +
> +               if (dma_mapping_error(device, daddrs[i]))
> +                       continue;
> +
> +               /* If it is read and write than map bi-directional. */
> +               if (range->pfns[i] & range->values[HMM_PFN_WRITE])
> +                       dir =3D DMA_BIDIRECTIONAL;
> +
> +               dma_unmap_page(device, daddrs[i], PAGE_SIZE, dir);
> +               mapped--;
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(hmm_range_dma_map);
> +
> +/*
> + * hmm_range_dma_unmap() - unmap range of that was map with hmm_range_dm=
a_map()
> + * @range: range being unmapped
> + * @vma: the vma against which the range (optional)
> + * @device: device against which dma map was done
> + * @daddrs: dma address of mapped pages
> + * @dirty: dirty page if it had the write flag set
> + * Returns: number of page unmapped on success, -EINVAL otherwise
> + *
> + * Note that caller MUST abide by mmu notifier or use HMM mirror and abi=
de
> + * to the sync_cpu_device_pagetables() callback so that it is safe here =
to
> + * call set_page_dirty(). Caller must also take appropriate locks to avo=
id
> + * concurrent mmu notifier or sync_cpu_device_pagetables() to make progr=
ess.
> + */
> +long hmm_range_dma_unmap(struct hmm_range *range,
> +                        struct vm_area_struct *vma,
> +                        struct device *device,
> +                        dma_addr_t *daddrs,
> +                        bool dirty)
> +{
> +       unsigned long i, npages;
> +       long cpages =3D 0;
> +
> +       /* Sanity check. */
> +       if (range->end <=3D range->start)
> +               return -EINVAL;
> +       if (!daddrs)
> +               return -EINVAL;
> +       if (!range->pfns)
> +               return -EINVAL;
> +
> +       npages =3D (range->end - range->start) >> PAGE_SHIFT;
> +       for (i =3D 0; i < npages; ++i) {
> +               enum dma_data_direction dir =3D DMA_FROM_DEVICE;
> +               struct page *page;
> +
> +               page =3D hmm_pfn_to_page(range, range->pfns[i]);
> +               if (page =3D=3D NULL)
> +                       continue;
> +
> +               /* If it is read and write than map bi-directional. */
> +               if (range->pfns[i] & range->values[HMM_PFN_WRITE]) {
> +                       dir =3D DMA_BIDIRECTIONAL;
> +
> +                       /*
> +                        * See comments in function description on why it=
 is
> +                        * safe here to call set_page_dirty()
> +                        */
> +                       if (dirty)
> +                               set_page_dirty(page);
> +               }
> +
> +               /* Unmap and clear pfns/dma address */
> +               dma_unmap_page(device, daddrs[i], PAGE_SIZE, dir);
> +               range->pfns[i] =3D range->values[HMM_PFN_NONE];
> +               /* FIXME see comments in hmm_vma_dma_map() */
> +               daddrs[i] =3D 0;
> +               cpages++;
> +       }
> +
> +       return cpages;
> +}
> +EXPORT_SYMBOL(hmm_range_dma_unmap);
>  #endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
>
>
> --
> 2.17.2
>
