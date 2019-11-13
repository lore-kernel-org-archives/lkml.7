Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D119EC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDD9206F2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyGleelL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfKMStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:49:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60220 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727142AbfKMStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573670990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQKSKMCx61JrTGmjzIH7zmEV71/sY7mBBeVPTjH2mmc=;
        b=cyGleelLnYQK2JryBR9uieViP3Q0vWEl4E8lpcuGa4/e8RHKy+wloCti5E1d0icRfRBfzq
        YQk6FXQ5X0eJkvHjUId1zXQQmRaI82OATjrAPoZq/Du9SrYpt/uY1Po8q3ub+Wpx4SGpAA
        Dx8NMadKzV2uJZUM2Y5gr4hK8Z3LAZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-7B_03SPCN56mJHyLWlKiGQ-1; Wed, 13 Nov 2019 13:49:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 810208C268F;
        Wed, 13 Nov 2019 18:49:46 +0000 (UTC)
Received: from redhat.com (ovpn-121-71.rdu2.redhat.com [10.10.121.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE5781E01;
        Wed, 13 Nov 2019 18:49:45 +0000 (UTC)
Date:   Wed, 13 Nov 2019 13:49:43 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     jgg@ziepe.ca, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hmm: remove hmm_range_dma_map and hmm_range_dma_unmap
Message-ID: <20191113184943.GA4319@redhat.com>
References: <20191113134528.21187-1-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20191113134528.21187-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7B_03SPCN56mJHyLWlKiGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:45:28PM +0100, Christoph Hellwig wrote:
> These two functions have never been used since they were added.

The mlx5 convertion (which has been posted few times now) uses them
dunno what Jason plans is on that front.

>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/hmm.h |  23 -------
>  mm/hmm.c            | 147 --------------------------------------------
>  2 files changed, 170 deletions(-)
>=20
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index b4af51735232..922c8d015cdb 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -230,34 +230,11 @@ static inline uint64_t hmm_device_entry_from_pfn(co=
nst struct hmm_range *range,
>   * Please see Documentation/vm/hmm.rst for how to use the range API.
>   */
>  long hmm_range_fault(struct hmm_range *range, unsigned int flags);
> -
> -long hmm_range_dma_map(struct hmm_range *range,
> -=09=09       struct device *device,
> -=09=09       dma_addr_t *daddrs,
> -=09=09       unsigned int flags);
> -long hmm_range_dma_unmap(struct hmm_range *range,
> -=09=09=09 struct device *device,
> -=09=09=09 dma_addr_t *daddrs,
> -=09=09=09 bool dirty);
>  #else
>  static inline long hmm_range_fault(struct hmm_range *range, unsigned int=
 flags)
>  {
>  =09return -EOPNOTSUPP;
>  }
> -
> -static inline long hmm_range_dma_map(struct hmm_range *range,
> -=09=09=09=09     struct device *device, dma_addr_t *daddrs,
> -=09=09=09=09     unsigned int flags)
> -{
> -=09return -EOPNOTSUPP;
> -}
> -
> -static inline long hmm_range_dma_unmap(struct hmm_range *range,
> -=09=09=09=09       struct device *device,
> -=09=09=09=09       dma_addr_t *daddrs, bool dirty)
> -{
> -=09return -EOPNOTSUPP;
> -}
>  #endif
> =20
>  /*
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 9e9d3f4ea17c..ab883eefe847 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -698,150 +698,3 @@ long hmm_range_fault(struct hmm_range *range, unsig=
ned int flags)
>  =09return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
>  }
>  EXPORT_SYMBOL(hmm_range_fault);
> -
> -/**
> - * hmm_range_dma_map - hmm_range_fault() and dma map page all in one.
> - * @range:=09range being faulted
> - * @device:=09device to map page to
> - * @daddrs:=09array of dma addresses for the mapped pages
> - * @flags:=09HMM_FAULT_*
> - *
> - * Return: the number of pages mapped on success (including zero), or an=
y
> - * status return from hmm_range_fault() otherwise.
> - */
> -long hmm_range_dma_map(struct hmm_range *range, struct device *device,
> -=09=09dma_addr_t *daddrs, unsigned int flags)
> -{
> -=09unsigned long i, npages, mapped;
> -=09long ret;
> -
> -=09ret =3D hmm_range_fault(range, flags);
> -=09if (ret <=3D 0)
> -=09=09return ret ? ret : -EBUSY;
> -
> -=09npages =3D (range->end - range->start) >> PAGE_SHIFT;
> -=09for (i =3D 0, mapped =3D 0; i < npages; ++i) {
> -=09=09enum dma_data_direction dir =3D DMA_TO_DEVICE;
> -=09=09struct page *page;
> -
> -=09=09/*
> -=09=09 * FIXME need to update DMA API to provide invalid DMA address
> -=09=09 * value instead of a function to test dma address value. This
> -=09=09 * would remove lot of dumb code duplicated accross many arch.
> -=09=09 *
> -=09=09 * For now setting it to 0 here is good enough as the pfns[]
> -=09=09 * value is what is use to check what is valid and what isn't.
> -=09=09 */
> -=09=09daddrs[i] =3D 0;
> -
> -=09=09page =3D hmm_device_entry_to_page(range, range->pfns[i]);
> -=09=09if (page =3D=3D NULL)
> -=09=09=09continue;
> -
> -=09=09/* Check if range is being invalidated */
> -=09=09if (mmu_range_check_retry(range->notifier,
> -=09=09=09=09=09  range->notifier_seq)) {
> -=09=09=09ret =3D -EBUSY;
> -=09=09=09goto unmap;
> -=09=09}
> -
> -=09=09/* If it is read and write than map bi-directional. */
> -=09=09if (range->pfns[i] & range->flags[HMM_PFN_WRITE])
> -=09=09=09dir =3D DMA_BIDIRECTIONAL;
> -
> -=09=09daddrs[i] =3D dma_map_page(device, page, 0, PAGE_SIZE, dir);
> -=09=09if (dma_mapping_error(device, daddrs[i])) {
> -=09=09=09ret =3D -EFAULT;
> -=09=09=09goto unmap;
> -=09=09}
> -
> -=09=09mapped++;
> -=09}
> -
> -=09return mapped;
> -
> -unmap:
> -=09for (npages =3D i, i =3D 0; (i < npages) && mapped; ++i) {
> -=09=09enum dma_data_direction dir =3D DMA_TO_DEVICE;
> -=09=09struct page *page;
> -
> -=09=09page =3D hmm_device_entry_to_page(range, range->pfns[i]);
> -=09=09if (page =3D=3D NULL)
> -=09=09=09continue;
> -
> -=09=09if (dma_mapping_error(device, daddrs[i]))
> -=09=09=09continue;
> -
> -=09=09/* If it is read and write than map bi-directional. */
> -=09=09if (range->pfns[i] & range->flags[HMM_PFN_WRITE])
> -=09=09=09dir =3D DMA_BIDIRECTIONAL;
> -
> -=09=09dma_unmap_page(device, daddrs[i], PAGE_SIZE, dir);
> -=09=09mapped--;
> -=09}
> -
> -=09return ret;
> -}
> -EXPORT_SYMBOL(hmm_range_dma_map);
> -
> -/**
> - * hmm_range_dma_unmap() - unmap range of that was map with hmm_range_dm=
a_map()
> - * @range: range being unmapped
> - * @device: device against which dma map was done
> - * @daddrs: dma address of mapped pages
> - * @dirty: dirty page if it had the write flag set
> - * Return: number of page unmapped on success, -EINVAL otherwise
> - *
> - * Note that caller MUST abide by mmu notifier or use HMM mirror and abi=
de
> - * to the sync_cpu_device_pagetables() callback so that it is safe here =
to
> - * call set_page_dirty(). Caller must also take appropriate locks to avo=
id
> - * concurrent mmu notifier or sync_cpu_device_pagetables() to make progr=
ess.
> - */
> -long hmm_range_dma_unmap(struct hmm_range *range,
> -=09=09=09 struct device *device,
> -=09=09=09 dma_addr_t *daddrs,
> -=09=09=09 bool dirty)
> -{
> -=09unsigned long i, npages;
> -=09long cpages =3D 0;
> -
> -=09/* Sanity check. */
> -=09if (range->end <=3D range->start)
> -=09=09return -EINVAL;
> -=09if (!daddrs)
> -=09=09return -EINVAL;
> -=09if (!range->pfns)
> -=09=09return -EINVAL;
> -
> -=09npages =3D (range->end - range->start) >> PAGE_SHIFT;
> -=09for (i =3D 0; i < npages; ++i) {
> -=09=09enum dma_data_direction dir =3D DMA_TO_DEVICE;
> -=09=09struct page *page;
> -
> -=09=09page =3D hmm_device_entry_to_page(range, range->pfns[i]);
> -=09=09if (page =3D=3D NULL)
> -=09=09=09continue;
> -
> -=09=09/* If it is read and write than map bi-directional. */
> -=09=09if (range->pfns[i] & range->flags[HMM_PFN_WRITE]) {
> -=09=09=09dir =3D DMA_BIDIRECTIONAL;
> -
> -=09=09=09/*
> -=09=09=09 * See comments in function description on why it is
> -=09=09=09 * safe here to call set_page_dirty()
> -=09=09=09 */
> -=09=09=09if (dirty)
> -=09=09=09=09set_page_dirty(page);
> -=09=09}
> -
> -=09=09/* Unmap and clear pfns/dma address */
> -=09=09dma_unmap_page(device, daddrs[i], PAGE_SIZE, dir);
> -=09=09range->pfns[i] =3D range->values[HMM_PFN_NONE];
> -=09=09/* FIXME see comments in hmm_vma_dma_map() */
> -=09=09daddrs[i] =3D 0;
> -=09=09cpages++;
> -=09}
> -
> -=09return cpages;
> -}
> -EXPORT_SYMBOL(hmm_range_dma_unmap);
> --=20
> 2.20.1
>=20

