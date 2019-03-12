Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BE5C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5322173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCLVx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfCLVx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D2298666A;
        Tue, 12 Mar 2019 21:53:27 +0000 (UTC)
Received: from sky.random (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35DAB60C6E;
        Tue, 12 Mar 2019 21:53:22 +0000 (UTC)
Date:   Tue, 12 Mar 2019 17:53:21 -0400
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
Message-ID: <20190312215321.GC25147@redhat.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552425555.14432.14.camel@HansenPartnership.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 12 Mar 2019 21:53:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 02:19:15PM -0700, James Bottomley wrote:
> I mean in the sequence
> 
> flush_dcache_page(page);
> flush_dcache_page(page);
> 
> The first flush_dcache_page did all the work and the second it a
> tightly pipelined no-op.  That's what I mean by there not really being
> a double hit.

Ok I wasn't sure it was clear there was a double (profiling) hit on
that function.

void flush_kernel_dcache_page_addr(void *addr)
{
	unsigned long flags;

	flush_kernel_dcache_page_asm(addr);
	purge_tlb_start(flags);
	pdtlb_kernel(addr);
	purge_tlb_end(flags);
}

#define purge_tlb_start(flags)	spin_lock_irqsave(&pa_tlb_lock, flags)
#define purge_tlb_end(flags)	spin_unlock_irqrestore(&pa_tlb_lock, flags)

You got a system-wide spinlock in there that won't just go away the
second time. So it's a bit more than a tightly pipelined "noop".

Your logic of adding the flush on kunmap makes sense, all I'm saying
is that it's sacrificing some performance for safety. You asked
"optimized what", I meant to optimize away all the above quoted code
that will end running twice for each vhost set_bit when it should run
just once like in other archs. And it clearly paid off until now
(until now it run just once and it was the only safe one).

Before we can leverage your idea to flush the dcache on kunmap in
common code without having to sacrifice performance in arch code, we'd
need to change all other archs to add the cache flushes on kunmap too,
and then remove the cache flushes from the other places like copy_page
or we'd waste CPU. Then you'd have the best of both words, no double
flush and kunmap would be enough.

Thanks,
Andrea
