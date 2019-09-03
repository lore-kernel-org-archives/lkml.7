Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD382C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6A223401
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfICNFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:05:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:32926 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbfICNFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:05:23 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x83D4XqU001876;
        Tue, 3 Sep 2019 08:04:33 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x83D4VSl001875;
        Tue, 3 Sep 2019 08:04:31 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 3 Sep 2019 08:04:31 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v2 3/6] powerpc: Convert flush_icache_range & friends to C
Message-ID: <20190903130430.GC31406@gate.crashing.org>
References: <20190903052407.16638-1-alastair@au1.ibm.com> <20190903052407.16638-4-alastair@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903052407.16638-4-alastair@au1.ibm.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Sep 03, 2019 at 03:23:57PM +1000, Alastair D'Silva wrote:
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c

> +#if !defined(CONFIG_PPC_8xx) & !defined(CONFIG_PPC64)

Please write that as &&?  That is more usual, and thus, easier to read.

> +static void flush_dcache_icache_phys(unsigned long physaddr)

> +	asm volatile(
> +		"   mtctr %2;"
> +		"   mtmsr %3;"
> +		"   isync;"
> +		"0: dcbst   0, %0;"
> +		"   addi    %0, %0, %4;"
> +		"   bdnz    0b;"
> +		"   sync;"
> +		"   mtctr %2;"
> +		"1: icbi    0, %1;"
> +		"   addi    %1, %1, %4;"
> +		"   bdnz    1b;"
> +		"   sync;"
> +		"   mtmsr %5;"
> +		"   isync;"
> +		: "+r" (loop1), "+r" (loop2)
> +		: "r" (nb), "r" (msr), "i" (bytes), "r" (msr0)
> +		: "ctr", "memory");

This outputs as one huge assembler statement, all on one line.  That's
going to be fun to read or debug.

loop1 and/or loop2 can be assigned the same register as msr0 or nb.  They
need to be made earlyclobbers.  (msr is fine, all of its reads are before
any writes to loop1 or loop2; and bytes is fine, it's not a register).


Segher
