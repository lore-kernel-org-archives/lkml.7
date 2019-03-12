Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16078C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66212147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="oZJBW5KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfCLVTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:19:23 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47448 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfCLVTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:19:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EA5AE8EE1ED;
        Tue, 12 Mar 2019 14:19:21 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0xVaCC_S7-6v; Tue, 12 Mar 2019 14:19:19 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C9EA58EE0F5;
        Tue, 12 Mar 2019 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552425557;
        bh=nBucg5nObt1KlK9vb8n4aq4g77BNSYrOWjbZNOJxaqk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oZJBW5KXIW92FCi6QYBzLSNeWSzJczWdOOQlss5aFpWMkuj7ltNJ+LRAhD2lIbB4W
         7ZJzTIkaZ87beykikhhLN79fTZ86C1lTnEXB1mXKruoOmDSwDzVZV64VafKNPy9HKW
         m+NIZUEPLnH92JH1Y2UNiobJjLrtRC8VYA8p/+kg=
Message-ID: <1552425555.14432.14.camel@HansenPartnership.com>
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
Date:   Tue, 12 Mar 2019 14:19:15 -0700
In-Reply-To: <20190312211117.GB25147@redhat.com>
References: <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
         <20190311095405-mutt-send-email-mst@kernel.org>
         <20190311.111413.1140896328197448401.davem@davemloft.net>
         <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
         <20190311235140-mutt-send-email-mst@kernel.org>
         <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
         <20190312075033-mutt-send-email-mst@kernel.org>
         <1552405610.3083.17.camel@HansenPartnership.com>
         <20190312200450.GA25147@redhat.com>
         <1552424017.14432.11.camel@HansenPartnership.com>
         <20190312211117.GB25147@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we might be talking past each other.  Let me try the double
flush first

On Tue, 2019-03-12 at 17:11 -0400, Andrea Arcangeli wrote:
> On Tue, Mar 12, 2019 at 01:53:37PM -0700, James Bottomley wrote:
> > > Which means after we fix vhost to add the flush_dcache_page after
> > > kunmap, Parisc will get a double hit (but it also means Parisc
> > > was
> > > the only one of those archs needed explicit cache flushes, where
> > > vhost worked correctly so far.. so it kinds of proofs your point
> > > of
> > > giving up being the safe choice).
> > 
> > What double hit?  If there's no cache to flush then cache flush is
> > a no-op.  It's also a highly piplineable no-op because the CPU has
> > the L1 cache within easy reach.  The only event when flush takes a
> > large amount time is if we actually have dirty data to write back
> > to main memory.
> 
> The double hit is in parisc copy_to_user_page:
> 
> #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
> do { \
> 	flush_cache_page(vma, vaddr, page_to_pfn(page)); \
> 	memcpy(dst, src, len); \
> 	flush_kernel_dcache_range_asm((unsigned long)dst, (unsigned
> long)dst + len); \
> } while (0)
> 
> That is executed just before kunmap:
> 
> static inline void kunmap(struct page *page)
> {
> 	flush_kernel_dcache_page_addr(page_address(page));
> }

I mean in the sequence

flush_dcache_page(page);
flush_dcache_page(page);

The first flush_dcache_page did all the work and the second it a
tightly pipelined no-op.  That's what I mean by there not really being
a double hit.

James

