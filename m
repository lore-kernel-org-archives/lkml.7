Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE1FC072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE46121841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 00:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZMYGXlLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfEVAw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 20:52:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35632 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEVAw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:52:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id a39so425405qtk.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 17:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZOweq9C5/sAwgIheMCHpcweG051omLMFbmApOs9CKxA=;
        b=ZMYGXlLNouwxZe6ucV0Ymq51wEpoiie8l2v+9oH2yZG55XNjtDebjw4ANTA+pIIL+G
         i44h0u88/j33fL4julinN3GPIbrh52AzSfWnFa86A/BMkglx/djFW0HGKtm6SR5U0Ths
         y05xELJ7PguM5zJ17mqkwRdf6kbcuctRP1lAnKtpNlZVm7o5xOQO3+4ygr8H/iVgUeG4
         NnGfLr4uixJg0Jd8WrOvCQq8SMVcTo8gNiD+U+u8m0vrE/pegE6SxhEcMuD34oI1iWFA
         Xlt7eEtjwkLvqQJblig5VS0r5eYECB833BdEEHuKT+PhMwpDLTJkRHy6/aDM/ccDiGq5
         V6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZOweq9C5/sAwgIheMCHpcweG051omLMFbmApOs9CKxA=;
        b=ZDNOpl1xP90K8VGdRK0x+DMy6+SNej2FwgGwYJNxQMu6cfH/MCuf0NFDetrXzpG2Kg
         mkjipTMCXD3fksXgpfY4qzm/nhz7PLWk5uVoqKUdsm4co2Ox8q6ALfMph2i0jWuvnUQx
         //ZRL2x8Ad4YR7xpUEQZNFzQ9w69txiYMx92+LAD/Ya7bWkvej78CVXTjgU7N72zycjY
         qO7XBiWmzZfwEPZiOd5HhfikMHO3LUawE3svpH41EecEObAFsQCTcH98SBgvoh1SC6Rk
         yN21bNKI+zy8aA4pqoibdA1+QT/PmXFDJP37w8H4QxKmqbAPegEw/nrqoMyMDvu0YBPA
         88mg==
X-Gm-Message-State: APjAAAV0QxN825yzMR3mdvBNceDH01OSxIfW7QLnC3KZ+F02i5iF0I4P
        mQutsHSf0Nst1Gf5k50JCXH1yg==
X-Google-Smtp-Source: APXvYqwYfxUpgoMYc2f/SwV1osJohn5+H7ZWoq4Ez8dsPo45h8zeu1MKvxKOP7X8rx1ugGQZQib9gg==
X-Received: by 2002:a0c:d163:: with SMTP id c32mr51518109qvh.139.1558486346947;
        Tue, 21 May 2019 17:52:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id q56sm14203206qtk.72.2019.05.21.17.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 17:52:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTFUX-0000AR-M7; Tue, 21 May 2019 21:52:25 -0300
Date:   Tue, 21 May 2019 21:52:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522005225.GA30819@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521205321.GC3331@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 04:53:22PM -0400, Jerome Glisse wrote:
> On Mon, May 06, 2019 at 04:56:57PM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 11, 2019 at 02:13:13PM -0400, jglisse@redhat.com wrote:
> > > From: Jérôme Glisse <jglisse@redhat.com>
> > > 
> > > Just fixed Kconfig and build when ODP was not enabled, other than that
> > > this is the same as v3. Here is previous cover letter:
> > > 
> > > Git tree with all prerequisite:
> > > https://cgit.freedesktop.org/~glisse/linux/log/?h=rdma-odp-hmm-v4
> > > 
> > > This patchset convert RDMA ODP to use HMM underneath this is motivated
> > > by stronger code sharing for same feature (share virtual memory SVM or
> > > Share Virtual Address SVA) and also stronger integration with mm code to
> > > achieve that. It depends on HMM patchset posted for inclusion in 5.2 [2]
> > > and [3].
> > > 
> > > It has been tested with pingpong test with -o and others flags to test
> > > different size/features associated with ODP.
> > > 
> > > Moreover they are some features of HMM in the works like peer to peer
> > > support, fast CPU page table snapshot, fast IOMMU mapping update ...
> > > It will be easier for RDMA devices with ODP to leverage those if they
> > > use HMM underneath.
> > > 
> > > Quick summary of what HMM is:
> > >     HMM is a toolbox for device driver to implement software support for
> > >     Share Virtual Memory (SVM). Not only it provides helpers to mirror a
> > >     process address space on a device (hmm_mirror). It also provides
> > >     helper to allow to use device memory to back regular valid virtual
> > >     address of a process (any valid mmap that is not an mmap of a device
> > >     or a DAX mapping). They are two kinds of device memory. Private memory
> > >     that is not accessible to CPU because it does not have all the expected
> > >     properties (this is for all PCIE devices) or public memory which can
> > >     also be access by CPU without restriction (with OpenCAPI or CCIX or
> > >     similar cache-coherent and atomic inter-connect).
> > > 
> > >     Device driver can use each of HMM tools separatly. You do not have to
> > >     use all the tools it provides.
> > > 
> > > For RDMA device i do not expect a need to use the device memory support
> > > of HMM. This device memory support is geared toward accelerator like GPU.
> > > 
> > > 
> > > You can find a branch [1] with all the prerequisite in. This patch is on
> > > top of rdma-next with the HMM patchset [2] and mmu notifier patchset [3]
> > > applied on top of it.
> > > 
> > > [1] https://cgit.freedesktop.org/~glisse/linux/log/?h=rdma-odp-hmm-v4
> > > [2] https://lkml.org/lkml/2019/4/3/1032
> > > [3] https://lkml.org/lkml/2019/3/26/900
> > 
> > Jerome, please let me know if these dependent series are merged during
> > the first week of the merge window.
> > 
> > This patch has been tested and could go along next week if the
> > dependencies are met.
> > 
> 
> So attached is a rebase on top of 5.2-rc1, i have tested with pingpong
> (prefetch and not and different sizes). Seems to work ok.

Urk, it already doesn't apply to the rdma tree :(

The conflicts are a little more extensive than I'd prefer to handle..
Can I ask you to rebase it on top of this branch please:

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next

Specifically it conflicts with this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=d2183c6f1958e6b6dfdde279f4cee04280710e34

> +long ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp,
> +			       struct hmm_range *range)
>  {
> +	struct device *device = umem_odp->umem.context->device->dma_device;
> +	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
>  	struct ib_umem *umem = &umem_odp->umem;
> -	struct task_struct *owning_process  = NULL;
> -	struct mm_struct *owning_mm = umem_odp->umem.owning_mm;
> -	struct page       **local_page_list = NULL;
> -	u64 page_mask, off;
> -	int j, k, ret = 0, start_idx, npages = 0, page_shift;
> -	unsigned int flags = 0;
> -	phys_addr_t p = 0;
> -
> -	if (access_mask == 0)
> +	struct mm_struct *mm = per_mm->mm;
> +	unsigned long idx, npages;
> +	long ret;
> +
> +	if (mm == NULL)
> +		return -ENOENT;
> +
> +	/* Only drivers with invalidate support can use this function. */
> +	if (!umem->context->invalidate_range)
>  		return -EINVAL;
>  
> -	if (user_virt < ib_umem_start(umem) ||
> -	    user_virt + bcnt > ib_umem_end(umem))
> -		return -EFAULT;
> +	/* Sanity checks. */
> +	if (range->default_flags == 0)
> +		return -EINVAL;
>  
> -	local_page_list = (struct page **)__get_free_page(GFP_KERNEL);
> -	if (!local_page_list)
> -		return -ENOMEM;
> +	if (range->start < ib_umem_start(umem) ||
> +	    range->end > ib_umem_end(umem))
> +		return -EINVAL;
>  
> -	page_shift = umem->page_shift;
> -	page_mask = ~(BIT(page_shift) - 1);
> -	off = user_virt & (~page_mask);
> -	user_virt = user_virt & page_mask;
> -	bcnt += off; /* Charge for the first page offset as well. */
> +	idx = (range->start - ib_umem_start(umem)) >> umem->page_shift;

Is this math OK? What is supposed to happen if the range->start is not
page aligned to the internal page size?

> +	range->pfns = &umem_odp->pfns[idx];
> +	range->pfn_shift = ODP_FLAGS_BITS;
> +	range->values = odp_hmm_values;
> +	range->flags = odp_hmm_flags;
>  
>  	/*
> -	 * owning_process is allowed to be NULL, this means somehow the mm is
> -	 * existing beyond the lifetime of the originating process.. Presumably
> -	 * mmget_not_zero will fail in this case.
> +	 * If mm is dying just bail out early without trying to take mmap_sem.
> +	 * Note that this might race with mm destruction but that is fine the
> +	 * is properly refcounted so are all HMM structure.
>  	 */
> -	owning_process = get_pid_task(umem_odp->per_mm->tgid, PIDTYPE_PID);
> -	if (!owning_process || !mmget_not_zero(owning_mm)) {

But we are not in a HMM context here, and per_mm is not a HMM
structure. 

So why is mm suddenly guarenteed valid? It was a bug report that
triggered the race the mmget_not_zero is fixing, so I need a better
explanation why it is now safe. From what I see the hmm_range_fault
is doing stuff like find_vma without an active mmget??

> @@ -603,11 +603,29 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
>  
>  next_mr:
>  	size = min_t(size_t, bcnt, ib_umem_end(&odp->umem) - io_virt);
> -
>  	page_shift = mr->umem->page_shift;
>  	page_mask = ~(BIT(page_shift) - 1);
> +	/*
> +	 * We need to align io_virt on page size so off is the extra bytes we
> +	 * will be faulting and fault_size is the page aligned size we are
> +	 * faulting.
> +	 */
> +	io_virt = io_virt & page_mask;
> +	off = (io_virt & (~page_mask));
> +	fault_size = ALIGN(size + off, 1UL << page_shift);
> +
> +	if (io_virt < ib_umem_start(&odp->umem))
> +		return -EINVAL;
> +
>  	start_idx = (io_virt - (mr->mmkey.iova & page_mask)) >> page_shift;
> -	access_mask = ODP_READ_ALLOWED_BIT;
> +
> +	if (odp_mr->per_mm == NULL || odp_mr->per_mm->mm == NULL)
> +		return -ENOENT;

How can this happen? Where is the locking?

per_mm is supposed to outlive any odp_mr's the refer to it, and the mm
is supposed to remain grab'd as long as the per_mm exists..

> diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
> index eeec4e53c448..70b2df8e5a6c 100644
> +++ b/include/rdma/ib_umem_odp.h
> @@ -36,6 +36,7 @@
>  #include <rdma/ib_umem.h>
>  #include <rdma/ib_verbs.h>
>  #include <linux/interval_tree.h>
> +#include <linux/hmm.h>
>  
>  struct umem_odp_node {
>  	u64 __subtree_last;
> @@ -47,11 +48,11 @@ struct ib_umem_odp {
>  	struct ib_ucontext_per_mm *per_mm;
>  
>  	/*
> -	 * An array of the pages included in the on-demand paging umem.
> -	 * Indices of pages that are currently not mapped into the device will
> -	 * contain NULL.
> +	 * An array of the pages included in the on-demand paging umem. Indices
> +	 * of pages that are currently not mapped into the device will contain
> +	 * 0.
>  	 */
> -	struct page		**page_list;
> +	uint64_t *pfns;

Are these actually pfns, or are they mangled with some shift? (what is range->pfn_shift?)

Jason
