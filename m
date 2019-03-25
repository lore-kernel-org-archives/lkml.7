Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2D1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B8E20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfCYWzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:55:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47056 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfCYWzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:55:24 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8YUs-0000Tc-Se; Mon, 25 Mar 2019 23:55:15 +0100
Date:   Mon, 25 Mar 2019 23:55:14 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
cc:     linux-kernel@vger.kernel.org, Craig Bergstrom <craigb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Sean Young <sean@mess.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/1] x86/mm: Fix limit mmap() of /dev/mem to valid physical
 addresses
In-Reply-To: <39b65bda-cef5-4ea2-ddaa-418e8e71e306@nvidia.com>
Message-ID: <alpine.DEB.2.21.1903252346310.1789@nanos.tec.linutronix.de>
References: <20190318224653.26549-1-rcampbell@nvidia.com> <20190318224653.26549-2-rcampbell@nvidia.com> <alpine.DEB.2.21.1903231840100.1798@nanos.tec.linutronix.de> <39b65bda-cef5-4ea2-ddaa-418e8e71e306@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph,

On Mon, 25 Mar 2019, Ralph Campbell wrote:
> On 3/23/19 12:02 PM, Thomas Gleixner wrote:
> > > --- a/arch/x86/mm/mmap.c
> > > +++ b/arch/x86/mm/mmap.c
> > > @@ -230,7 +230,7 @@ bool mmap_address_hint_valid(unsigned long addr,
> > > unsigned long len)
> > >   /* Can we access it for direct reading/writing? Must be RAM: */
> > >   int valid_phys_addr_range(phys_addr_t addr, size_t count)
> > >   {
> > > -	return addr + count <= __pa(high_memory);
> > > +	return addr + count <= __pa_nodebug(high_memory);
> > 
> > This lacks a comment. Aside of that I think there is no point in using
> > __pa(high_memory) here. This is all about the physical address range. So
> > this can be simply expressed via:
> > 
> > 	return addr + count <= max_pfn * PAGE_SIZE;
> > 
> > which is much more obvious.
> 
> This looks OK to me for x86_64 but looking at arch/x86/mm/init_32.c,
> initmem_init() sets high_memory based on highstart_pfn or max_low_pfn
> depending on CONFIG_HIGHMEM. Would using max_pfn in this case work?

Aargh. There is also numa_32.c ...

So __pa_nodebug(high_memory) should be fine, but looking at the other
places which do __pa() on high_memory they all use __pa(high_memory - 1)
which is more obvious that the nodebug thing.

Thanks,

	tglx

