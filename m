Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2521EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 03:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0770020679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 03:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHND3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 23:29:05 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:36836 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726797AbfHND3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 23:29:05 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x7E3G38F041472;
        Wed, 14 Aug 2019 11:16:03 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 14 Aug 2019
 11:27:32 +0800
Date:   Wed, 14 Aug 2019 11:27:33 +0800
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
Message-ID: <20190814032732.GA8989@andestech.com>
References: <mhng-ba92c635-7087-4783-baa5-2a111e0e2710@palmer-si-x1e>
 <alpine.DEB.2.21.9999.1908131921180.19217@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908131921180.19217@viisi.sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x7E3G38F041472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:22:15AM +0800, Paul Walmsley wrote:
> On Tue, 13 Aug 2019, Palmer Dabbelt wrote:
> 
> > On Mon, 12 Aug 2019 08:04:46 PDT (-0700), Christoph Hellwig wrote:
> > > On Wed, Aug 07, 2019 at 03:19:14PM +0800, Nick Hu wrote:
> > > > There are some features which need this string operation for compilation,
> > > > like KASAN. So the purpose of this porting is for the features like KASAN
> > > > which cannot be compiled without it.
> > > > 
> > > > KASAN's string operations would replace the original string operations and
> > > > call for the architecture defined string operations. Since we don't have
> > > > this in current kernel, this patch provides the implementation.
> > > > 
> > > > This porting refers to the 'arch/nds32/lib/memmove.S'.
> > > 
> > > This looks sensible to me, although my stringop asm is rather rusty,
> > > so just an ack and not a real review-by:
> > > 
> > > Acked-by: Christoph Hellwig <hch@lst.de>
> > 
> > FWIW, we just write this in C everywhere else and rely on the compiler to
> > unroll the loops.  I always prefer C to assembly when possible, so I'd prefer
> > if we just adopt the string code from newlib.  We have a RISC-V-specific
> > memcpy in there, but just use the generic memmove.
> > 
> > Maybe the best bet here would be to adopt the newlib memcpy/memmove as generic
> > Linux functions?  They're both in C so they should be fine, and they both look
> > faster than what's in lib/string.c.  Then everyone would benefit and we don't
> > need this tricky RISC-V assembly.  Also, from the look of it the newlib code
> > is faster because the inner loop is unrolled.
> 
> There's a generic memmove implementation in the kernel already:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/string.h#n362
> 
> Nick, could you tell us more about why the generic memmove() isn't 
> suitable?
> 
> 
> - Paul

Hi Paul,

KASAN has its own string operations(memcpy/memmove/memset) because it needs to
hook some code to check memory region. It would undefined the original string
operations and called the string operations with the prefix '__'. But the
generic string operations didn't declare with the prefix. Other archs with
KASAN support like arm64 and xtensa all have their own string operations and
defined with the prefix.

Nick
