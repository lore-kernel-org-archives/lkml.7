Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EC22177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfCLWul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfCLWuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:50:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25A1C3086201;
        Tue, 12 Mar 2019 22:50:37 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFABE19C4F;
        Tue, 12 Mar 2019 22:50:32 +0000 (UTC)
Date:   Tue, 12 Mar 2019 18:50:32 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>, hch@infradead.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
Message-ID: <20190312225032.GD25147@redhat.com>
References: <20190311235140-mutt-send-email-mst@kernel.org>
 <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
 <20190312075033-mutt-send-email-mst@kernel.org>
 <1552405610.3083.17.camel@HansenPartnership.com>
 <20190312200450.GA25147@redhat.com>
 <1552424017.14432.11.camel@HansenPartnership.com>
 <20190312211117.GB25147@redhat.com>
 <1552425555.14432.14.camel@HansenPartnership.com>
 <20190312215321.GC25147@redhat.com>
 <1552428174.14432.39.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552428174.14432.39.camel@HansenPartnership.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 12 Mar 2019 22:50:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 03:02:54PM -0700, James Bottomley wrote:
> I'm sure there must be workarounds elsewhere in the other arch code
> otherwise things like this, which appear all over drivers/, wouldn't
> work:
> 
> drivers/scsi/isci/request.c:1430
> 
> 	kaddr = kmap_atomic(page);
> 	memcpy(kaddr + sg->offset, src_addr, copy_len);
> 	kunmap_atomic(kaddr);
> 

Are you sure "page" is an userland page with an alias address?

	sg->page_link = (unsigned long)virt_to_page(addr);

page_link seems to point to kernel memory.

I found an apparent solution like parisc on arm 32bit:

void __kunmap_atomic(void *kvaddr)
{
	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
	int idx, type;

	if (kvaddr >= (void *)FIXADDR_START) {
		type = kmap_atomic_idx();
		idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();

		if (cache_is_vivt())
			__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);

However on arm 64bit kunmap_atomic is not implemented at all and other
32bit implementations don't do it, for example sparc seems to do the
cache flush too if the kernel is built with CONFIG_DEBUG_HIGHMEM
(which makes the flushing conditional to the debug option).

The kunmap_atomic where fixmap is used, is flushing the tlb lazily so
even on 32bit you can't even be sure if there was a tlb flush for each
single page you unmapped, so it's hard to see how the above can work
safe, is "page" would have been an userland page mapped with aliased
CPU cache.

> the sequence dirties the kernel virtual address but doesn't flush
> before doing kunmap.  There are hundreds of other examples which is why
> I think adding flush_kernel_dcache_page() is an already lost cause.

In lots of cases kmap is needed to just modify kernel memory not to
modify userland memory (where get/put_user is more commonly used
instead..), there's no cache aliasing in such case.

> Actually copy_user_page() is unused in the main kernel.  The big
> problem is copy_user_highpage() but that's mostly highly optimised by
> the VIPT architectures (in other words you can fiddle with kmap without
> impacting it).

copy_user_page is not unused, it's called precisely by
copy_user_highpage, which is why the cache flushes are done inside
copy_user_page.

static inline void copy_user_highpage(struct page *to, struct page *from,
	unsigned long vaddr, struct vm_area_struct *vma)
{
	char *vfrom, *vto;

	vfrom = kmap_atomic(from);
	vto = kmap_atomic(to);
	copy_user_page(vto, vfrom, vaddr, to);
	kunmap_atomic(vto);
	kunmap_atomic(vfrom);
}
