Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3971AC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F130B213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="TOJYB90P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfCLW5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:57:19 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49232 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726372AbfCLW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:57:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BB7C38EE20E;
        Tue, 12 Mar 2019 15:57:17 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bIXGJAv6LSQ8; Tue, 12 Mar 2019 15:57:17 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D55418EE0F5;
        Tue, 12 Mar 2019 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552431437;
        bh=nqauZTMjLIlCtdjWAuZ6B+xT+zykoUqdVHDcgv40x8U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TOJYB90P8bGGBEgy/p2OzDozxFdWmdmTmVmEbZ2kxfHjm8Wnvw7af8NCL1GtxlDfT
         CejvYaJVYV9EA/FkWkrN20QgY7XgolCcEnHjrMbejdgOOXNh3wKjFfiVxVq932K3Dx
         h2zVGng+Z8FhH1B/f+R4JyloBXH9kXZ0FY4mGKB4=
Message-ID: <1552431434.14432.47.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
 vmap()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Miller <davem@davemloft.net>, hch@infradead.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Date:   Tue, 12 Mar 2019 15:57:14 -0700
In-Reply-To: <20190312225032.GD25147@redhat.com>
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
         <20190312225032.GD25147@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 18:50 -0400, Andrea Arcangeli wrote:
> On Tue, Mar 12, 2019 at 03:02:54PM -0700, James Bottomley wrote:
> > I'm sure there must be workarounds elsewhere in the other arch code
> > otherwise things like this, which appear all over drivers/,
> > wouldn't
> > work:
> > 
> > drivers/scsi/isci/request.c:1430
> > 
> > 	kaddr = kmap_atomic(page);
> > 	memcpy(kaddr + sg->offset, src_addr, copy_len);
> > 	kunmap_atomic(kaddr);
> > 
> 
> Are you sure "page" is an userland page with an alias address?
> 
> 	sg->page_link = (unsigned long)virt_to_page(addr);

Yes, it's an element of a scatter gather list, which may be either a
kernel page or a user page, but is usually the latter.

> page_link seems to point to kernel memory.
> 
> I found an apparent solution like parisc on arm 32bit:
> 
> void __kunmap_atomic(void *kvaddr)
> {
> 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
> 	int idx, type;
> 
> 	if (kvaddr >= (void *)FIXADDR_START) {
> 		type = kmap_atomic_idx();
> 		idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR *
> smp_processor_id();
> 
> 		if (cache_is_vivt())
> 			__cpuc_flush_dcache_area((void *)vaddr,
> PAGE_SIZE);
> 
> However on arm 64bit kunmap_atomic is not implemented at all and
> other 32bit implementations don't do it, for example sparc seems to
> do the cache flush too if the kernel is built with
> CONFIG_DEBUG_HIGHMEM (which makes the flushing conditional to the
> debug option).
> 
> The kunmap_atomic where fixmap is used, is flushing the tlb lazily so
> even on 32bit you can't even be sure if there was a tlb flush for
> each single page you unmapped, so it's hard to see how the above can
> work safe, is "page" would have been an userland page mapped with
> aliased CPU cache.
> 
> > the sequence dirties the kernel virtual address but doesn't flush
> > before doing kunmap.  There are hundreds of other examples which is
> > why I think adding flush_kernel_dcache_page() is an already lost
> > cause.
> 
> In lots of cases kmap is needed to just modify kernel memory not to
> modify userland memory (where get/put_user is more commonly used
> instead..), there's no cache aliasing in such case.

That's why I picked drivers/  The use case in there is mostly kmap to
put a special value into a scatter gather list entry.

> > Actually copy_user_page() is unused in the main kernel.  The big
> > problem is copy_user_highpage() but that's mostly highly optimised
> > by the VIPT architectures (in other words you can fiddle with kmap
> > without impacting it).
> 
> copy_user_page is not unused, it's called precisely by
> copy_user_highpage, which is why the cache flushes are done inside
> copy_user_page.
> 
> static inline void copy_user_highpage(struct page *to, struct page
> *from,
> 	unsigned long vaddr, struct vm_area_struct *vma)
> {
> 	char *vfrom, *vto;
> 
> 	vfrom = kmap_atomic(from);
> 	vto = kmap_atomic(to);
> 	copy_user_page(vto, vfrom, vaddr, to);
> 	kunmap_atomic(vto);
> 	kunmap_atomic(vfrom);
> }

That's the asm/generic implementation.  Most VIPT architectures
override it.

James

