Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14371C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5042184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbfDERWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:22:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49362 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfDERWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:22:54 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCSYA-0000ik-U9; Fri, 05 Apr 2019 19:22:47 +0200
Date:   Fri, 5 Apr 2019 19:22:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mingo@kernel.org, hpa@zytor.com,
        kirill@shutemov.name, keescook@chromium.org,
        yamada.masahiro@socionext.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, thgarnie@google.com,
        mike.travis@hpe.com, frank.ramsay@hpe.com
Subject: Re: [PATCH 1/2] x86/mm/KASLR: Fix the wrong calculation of memory
 region initial size
In-Reply-To: <20190405165856.GJ23348@zn.tnic>
Message-ID: <alpine.DEB.2.21.1904051919430.1802@nanos.tec.linutronix.de>
References: <20190404020314.8162-1-bhe@redhat.com> <20190404020314.8162-2-bhe@redhat.com> <20190405165856.GJ23348@zn.tnic>
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

On Fri, 5 Apr 2019, Borislav Petkov wrote:
> On Thu, Apr 04, 2019 at 10:03:13AM +0800, Baoquan He wrote:
> > In memory region KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate
> 
> What is "memory region KASLR"?
> 
> > the initial size of the direct mapping region. This is correct in
> > the old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> > 46 bits, and only 4-level mode was supported.
> > 
> > Later, in commit:
> > b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
> > __PHYSICAL_MASK_SHIFT was changed to be always 52 bits, no matter it's
> > 5-level or 4-level.
> > 
> > This is wrong for 4-level paging since it may cause randomness of KASLR
> > being greatly weakened in 4-level. For KASLR, we compare the sum of RAM
> > size and CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING with the size of the
> > max RAM which can be supported by system, then choose the bigger one as
> > the value to reserve space for the direct mapping region. The max RAM
> > supported in 4-level is 64 TB according to MAX_PHYSMEM_BITS. However,
> > here it's 4 PB in code to be compared with when __PHYSICAL_MASK_SHIFT is
> > mistakenly used. E.g in a system owning 64 TB RAM, it will reserve 74 TB
> > (which is 64 TB plus CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING). In fact
> > it should reserve 64 TB according to the algorithm which is supposed to
> > do. Obviously the extra 10 TB space should be saved to join randomization.
> 
> It is not a trivial situation you're trying to explain and that
> paragraph is very very hard to understand. I can only rhyme up what
> you're trying to say.
> 
> So please rewrite it using simple declarative sentences. Don't try to
> say three things in one sentence but say one thing in three sentences.
> Keep it simple.

For complex scenarios a simple ascii scheme is often helpful

Situation A

    ------- LIMIT1

    ------- LIMIT2
			<- unused area
    -------

    ------- 0

Situation B

    ------- LIMIT1


		
    ------- LIMIT2

    ------- 0


I was not trying to depict your problem, it's just a random thing, but you get
the idea.

Thanks,

	tglx
