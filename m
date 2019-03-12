Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996F0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6697B214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="qeNY4Pwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfCLWDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:03:01 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48088 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbfCLWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:02:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9D30A8EE1ED;
        Tue, 12 Mar 2019 15:02:56 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hcyrnRwVHVYp; Tue, 12 Mar 2019 15:02:56 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BE48B8EE0F5;
        Tue, 12 Mar 2019 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552428176;
        bh=U7pcjLZUXynpVv9sPqYMeEJQfdBRfFFKKYoy1EtXSb8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qeNY4PwkGtrtFKz3pr4MCofOExHT7yE0sxh3QWhSL/9XCD69mNXgXpmxemuXU1Mp0
         vL4Ug/8936YbUisUmYMOoZa+bjed5Xwl21WJv56b22rX+7UE7UDJ6EH8hWGtUsyBdE
         vu7/vj3FeuLDuRQILb5JPpbCGUls6+7pu6HS6v1Q=
Message-ID: <1552428174.14432.39.camel@HansenPartnership.com>
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
Date:   Tue, 12 Mar 2019 15:02:54 -0700
In-Reply-To: <20190312215321.GC25147@redhat.com>
References: <20190311.111413.1140896328197448401.davem@davemloft.net>
         <6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
         <20190311235140-mutt-send-email-mst@kernel.org>
         <76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
         <20190312075033-mutt-send-email-mst@kernel.org>
         <1552405610.3083.17.camel@HansenPartnership.com>
         <20190312200450.GA25147@redhat.com>
         <1552424017.14432.11.camel@HansenPartnership.com>
         <20190312211117.GB25147@redhat.com>
         <1552425555.14432.14.camel@HansenPartnership.com>
         <20190312215321.GC25147@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 17:53 -0400, Andrea Arcangeli wrote:
> On Tue, Mar 12, 2019 at 02:19:15PM -0700, James Bottomley wrote:
> > I mean in the sequence
> > 
> > flush_dcache_page(page);
> > flush_dcache_page(page);
> > 
> > The first flush_dcache_page did all the work and the second it a
> > tightly pipelined no-op.  That's what I mean by there not really
> > being
> > a double hit.
> 
> Ok I wasn't sure it was clear there was a double (profiling) hit on
> that function.
> 
> void flush_kernel_dcache_page_addr(void *addr)
> {
> 	unsigned long flags;
> 
> 	flush_kernel_dcache_page_asm(addr);
> 	purge_tlb_start(flags);
> 	pdtlb_kernel(addr);
> 	purge_tlb_end(flags);
> }
> 
> #define purge_tlb_start(flags)	spin_lock_irqsave(&pa_tlb_lock,
> flags)
> #define purge_tlb_end(flags)	spin_unlock_irqrestore(&pa_tlb_lo
> ck, flags)
> 
> You got a system-wide spinlock in there that won't just go away the
> second time. So it's a bit more than a tightly pipelined "noop".

Well, yes, guilty as charged.  That particular bit of code is a work
around for an N class system which has an internal cross CPU coherency
bus but helpfully crashes if two different CPUs try to use it at once. 
Since the N class was a huge power hog, I thought they'd all been
decommisioned and this was an irrelevant anachronism (or at the very
least runtime patched).

> Your logic of adding the flush on kunmap makes sense, all I'm saying
> is that it's sacrificing some performance for safety. You asked
> "optimized what", I meant to optimize away all the above quoted code
> that will end running twice for each vhost set_bit when it should run
> just once like in other archs. And it clearly paid off until now
> (until now it run just once and it was the only safe one).

I'm sure there must be workarounds elsewhere in the other arch code
otherwise things like this, which appear all over drivers/, wouldn't
work:

drivers/scsi/isci/request.c:1430

	kaddr = kmap_atomic(page);
	memcpy(kaddr + sg->offset, src_addr, copy_len);
	kunmap_atomic(kaddr);

the sequence dirties the kernel virtual address but doesn't flush
before doing kunmap.  There are hundreds of other examples which is why
I think adding flush_kernel_dcache_page() is an already lost cause.

> Before we can leverage your idea to flush the dcache on kunmap in
> common code without having to sacrifice performance in arch code,
> we'd need to change all other archs to add the cache flushes on
> kunmap too, and then remove the cache flushes from the other places
> like copy_page or we'd waste CPU. Then you'd have the best of both
> words, no double flush and kunmap would be enough.

Actually copy_user_page() is unused in the main kernel.  The big
problem is copy_user_highpage() but that's mostly highly optimised by
the VIPT architectures (in other words you can fiddle with kmap without
impacting it).

James

