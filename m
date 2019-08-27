Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6511DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340A020828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MHYvhQTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfH0OEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:04:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0OEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=661U0lSjozJky25e5/EuVz5qAI0zmTf9XyJtMCPs0n0=; b=MHYvhQTl7K//OKrXEbamD4ni1
        UvrLZ3Lz0teQfWmr6PngU7IqrWfwUicXW+jUHr8dLMN1JozqkCrSN4KDkJbeZ8nOtl7mds9mUT4hF
        36GNcEtt2d360CH1CNyEuNrQJJ5N+eHgsdmmsx7Vdr1I81RSN86Yrh+dq8FetfkBVh50QXXrNGrRv
        +YdJcDZV07q5nK/ZG034qdRWyjUuF64/S+tU1oqF2QYUWEbPhLw77Sir1pvnmBoXcWfvHzj4Axs+u
        P6Mid9tbKsY+3lIM/mGNe/EN5/xnq7ZjP4nRaoebAqq+t8BSjVxR29XT0w1lq+v3qdJM15/WS15oN
        w/Qc13A5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2c5S-0004DE-5P; Tue, 27 Aug 2019 14:04:42 +0000
Date:   Tue, 27 Aug 2019 07:04:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Gary Guo <gary@garyguo.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/2] RISC-V: Mark existing SBI as legacy SBI.
Message-ID: <20190827140442.GB21855@infradead.org>
References: <20190826233256.32383-1-atish.patra@wdc.com>
 <20190826233256.32383-2-atish.patra@wdc.com>
 <20190827140304.GA21855@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827140304.GA21855@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 07:03:04AM -0700, Christoph Hellwig wrote:
> > +#define SBI_EXT_LEGACY_SET_TIMER 0x0
> > +#define SBI_EXT_LEGACY_CONSOLE_PUTCHAR 0x1
> > +#define SBI_EXT_LEGACY_CONSOLE_GETCHAR 0x2
> > +#define SBI_EXT_LEGACY_CLEAR_IPI 0x3
> > +#define SBI_EXT_LEGACY_SEND_IPI 0x4
> > +#define SBI_EXT_LEGACY_REMOTE_FENCE_I 0x5
> > +#define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA 0x6
> > +#define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID 0x7
> > +#define SBI_EXT_LEGACY_SHUTDOWN 0x8
> 
> As Mike said legacy is a bit of a weird name.  I think this should
> be SBI01_* or so.  And pleae align the numeric values and maybe use
> an enum.
> 
> > +
> > +#define SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3) ({             \
> >  	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
> >  	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
> >  	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
> 
> Instead of the weird inline assembly with forced register allocation,
> why not move this to pure assembly?  AFAICs this is the whole assembly
> code we'd need:
> 
> ENTRY(sbi01_call)
>         ecall
> END(sbi01_call)

Actually we'll need a mv to a7 for the function id, but the point
still stands.
