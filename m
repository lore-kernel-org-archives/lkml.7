Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B05CC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D7420989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfHSGar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:30:47 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:24619 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726174AbfHSGaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:30:46 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x7J6HLhb095426;
        Mon, 19 Aug 2019 14:17:21 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 19 Aug 2019
 14:29:18 +0800
Date:   Mon, 19 Aug 2019 14:29:19 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Quey-Liang =?utf-8?B?S2FvKOmrmOmtgeiJryk=?= 
        <alankao@andestech.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        =?utf-8?B?6Zui6IG3Wm9uZyBab25nLVhpYW4gTGko5p2O5a6X5oayKQ==?= 
        <zong@andestech.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 1/2] riscv: Add memmove string operation.
Message-ID: <20190819062919.GA6480@andestech.com>
References: <mhng-ba92c635-7087-4783-baa5-2a111e0e2710@palmer-si-x1e>
 <alpine.DEB.2.21.9999.1908131921180.19217@viisi.sifive.com>
 <20190814032732.GA8989@andestech.com>
 <alpine.DEB.2.21.9999.1908141002500.18249@viisi.sifive.com>
 <20190815031225.GA5666@andestech.com>
 <alpine.DEB.2.21.9999.1908151124450.18249@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908151124450.18249@viisi.sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x7J6HLhb095426
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Aug 15, 2019 at 11:27:51AM -0700, Paul Walmsley wrote:
> On Thu, 15 Aug 2019, Nick Hu wrote:
> 
> > On Wed, Aug 14, 2019 at 10:03:39AM -0700, Paul Walmsley wrote:
> >
> > > Thanks for the explanation.  What do you think about Palmer's idea to 
> > > define a generic C set of KASAN string operations, derived from the newlib 
> > > code?
> > 
> > That sounds good to me. But it should be another topic. We need to investigate
> > it further about replacing something generic and fundamental in lib/string.c
> > with newlib C functions.  Some blind spots may exist.  So I suggest, let's
> > consider KASAN for now.
> 
> OK.  Here is the problem for us as maintainers.  You, Palmer, and I all 
> agree that a C-language version would be better.  We'd rather not merge a 
> pure assembly-language version unless it had significant advantages, and 
> right now we're not anticipating that.  So that suggests that a C-language 
> memmove() is the right way to go.
> 
> But if we merge a C-language memmove() into arch/riscv, other kernel 
> developers would probably ask us why we're doing that, since there's 
> nothing RISC-V-specific about it.  So do you think you might reconsider 
> sending patches to add a generic C-language memmove()?
> 
> 
> - Paul

About pushing mem*() generic, let's start with the reason why in the first place
KASAN needs re-implement its own string operations:

In mm/kasan/common.c:

	#undef memset
	void *memset(void *addr, int c, size_t len)
	{
		check_memory_region((unsigned long)addr, len, true, _RET_IP_);

		return __memset(addr, c, len);
	}

KASAN would call the string operations with the prefix '__', which should be
just an alias to the proper one.

In the past, every architecture that supports KASAN does this in assembly.
E.g. ARM64:

In arch/arm64/lib/memset.S:

	ENTRY(__memset)
	ENTRY(memset)
	...
	...
	EXPORT_SYMBOL(memset)
	EXPORT_SYMBOL(__memset) // export this as an alias

In arch/arm64/include/asm/string.h

	#define __HAVE_ARCH_MEMSET
	extern void *memset(void *, int, __kernel_size_t);
	extern void *__memset(void *, int, __kernel_size_t);

Now, if we are going to replace the current string operations with newlib ones
and let KASAN use them, we must provide something like this:

In lib/string.c:
        void *___memset(...)
        {
                ...
        }

In include/linux/string.h:

	#ifndef __HAVE_ARCH_MEMCPY 
	#ifdef CONFIG_KASAN
	static inline void* __memset(...)
	{
		___memset(...);
        }
	extern void memset(...); // force those who include this header uses the
					memset wrapped by KASAN
	#else
	static inline void *memset(...)
	{
		___memset(...);
	}
	#endif
	#endif

Does this look OK to you?

Nick
