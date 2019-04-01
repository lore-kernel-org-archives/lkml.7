Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254F6C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF9020870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIlQwFHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfDAMAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:00:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38419 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfDAMAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:00:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so7855520ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 05:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lONlQLaEvJFultSO5a8NUBSr+5P5+0uVNlPDaqTG73w=;
        b=SIlQwFHQZvwbKWh1gXNbMAsQCDe1RPYDmv5JQpb1qXgh8tAieDYIZ+KG/wLs9zRAib
         XNvzW8s6DNMBFTOoWj8OqJ6DEU7ITmcMlutzyb6Ry8nMSPKjwzw4MNknUjzccjnHBVmO
         +UTDFo3HyyDKCT9gVwNPw9cUwrRe7qWUIQdpO3OY7FUJevtI4xHv9Q7F3zC7bMzwDBgj
         e66i2SMdqseC83T6UbuvODLerrR2i9/4+uvB5eNtzjtvGn4qr5ftNn52mCB0xCn4MLnU
         u/zIpjh0PzmI1wNgduTyNqLOiAr721XBGSLzFYcZUNZEhM2SUsTENqWNW2etB25/iFoJ
         h4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lONlQLaEvJFultSO5a8NUBSr+5P5+0uVNlPDaqTG73w=;
        b=d9Y6kpWMHyAMwaBim5fzuiht/xT1ncO3uu18X9Ie2hlQMciqVTHdHENs0fu5z3CTpQ
         xkeoIA5wn1LOGN1JcQ/jAZtm7bwPFNe2gkQAqhFKmZAZ5kpmpo2YwYwHJIRdECAfH3CM
         qj1MfWQpAUNOE7z2UyMtvgPkSf4DmxLfNA7oeSeTyvhecj6sfyjEAl9LTBLVwOumHvYu
         E0no6gmkEIo0ot5OXOfNBwODE62PEtWB8JPbMqJ1FfdS+djBv8sw7xmNTTY9BzvLhz0f
         W6TQ7PVfv82DzYHBcBRvbpsX2KYzZJir1/Le9iKtwsLjdfZVBBp0X/W7Cny60JofaS5b
         H90Q==
X-Gm-Message-State: APjAAAWA+QCniVELTVa3VGm8TZRvT+cE0UPHBGWBopVGwyKBRUnqt+Zo
        tSQpQmxY99gTwfIkE+Jj0gyhJp+t87diK+qAvLw=
X-Google-Smtp-Source: APXvYqzy4/fWp4TYhA9MtAZpxY4sRxXpk/Awh75ofm/avT6FmdX9b1svh0Y1z9IMRIWq9nqTz12MOjFYlkpAdsc8BBU=
X-Received: by 2002:a2e:8888:: with SMTP id k8mr15485928lji.43.1554120007575;
 Mon, 01 Apr 2019 05:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190325144011.10560-1-jglisse@redhat.com> <20190325144011.10560-12-jglisse@redhat.com>
In-Reply-To: <20190325144011.10560-12-jglisse@redhat.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 1 Apr 2019 17:29:54 +0530
Message-ID: <CAFqt6zau2+Z-D1noF4VeWW6Fa3=xZ8WGbaKpkAdPJcB70dGZjQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] mm/hmm: add an helper function that fault pages
 and map them to a device v2
To:     jglisse@redhat.com
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 8:11 PM <jglisse@redhat.com> wrote:
>
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>
> This is a all in one helper that fault pages in a range and map them to
> a device so that every single device driver do not have to re-implement
> this common pattern.
>
> This is taken from ODP RDMA in preparation of ODP RDMA convertion. It
> will be use by nouveau and other drivers.
>
> Changes since v1:
>     - improved commit message
>
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/hmm.h |   9 +++
>  mm/hmm.c            | 152 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+)
>
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 5f9deaeb9d77..7aadf18b29cb 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -568,6 +568,15 @@ int hmm_range_register(struct hmm_range *range,
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
> index ce33151c6832..fd143251b157 100644
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
> @@ -1163,6 +1164,157 @@ long hmm_range_fault(struct hmm_range *range, boo=
l block)
>         return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
>  }
>  EXPORT_SYMBOL(hmm_range_fault);
> +
> +/*

Adding extra * might be helpful here for documentation.

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

Same here.

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
