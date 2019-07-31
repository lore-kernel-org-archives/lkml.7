Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A355C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD4A208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="VWmBZSuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfGaJ1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:27:16 -0400
Received: from smtp.duncanthrax.net ([89.31.1.170]:40094 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbfGaJ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=tys11WF7FiBbva0mPM06RvxVHoTJLCHaJFi1kgHKOlY=; b=VWmBZSuU83JjDnf9gMTaxrmzwn
        L9+fc/xpWeDeXZSEI/yzPMyWYCcv0q+KeV8O2qeIlc0spZPwS8zCive5J22gcI0xvRa6BgxYG0eT8
        ty5Kg3Pq+IeY2sPwZwChlunbSVDEXqnQBnphMnW8RDTnsCCyKFs/eIxGSi6de0U8qTQw=;
Received: from frobwit.duncanthrax.net ([89.31.1.178] helo=t470p.stackframe.org)
        by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <svens@stackframe.org>)
        id 1hsksy-0002wy-IF; Wed, 31 Jul 2019 11:27:04 +0200
Date:   Wed, 31 Jul 2019 11:27:03 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Helge Deller <deller@gmx.de>,
        Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
Message-ID: <20190731092703.GA31316@t470p.stackframe.org>
References: <20190722154210.42799-1-steven.price@arm.com>
 <794fb469-00c8-af10-92a8-cb7c0c83378b@arm.com>
 <270ce719-49f9-7c61-8b25-bc9548a2f478@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270ce719-49f9-7c61-8b25-bc9548a2f478@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Mon, Jul 29, 2019 at 12:32:25PM +0100, Steven Price wrote:
> 
> parisc is more interesting and I'm not sure if this is necessarily
> correct. I originally proposed a patch with the line "For parisc, we
> don't support large pages, so add stubs returning 0" which got Acked by
> Helge Deller. However going back to look at that again I see there was a
> follow up thread[2] which possibly suggests I was wrong?

I just started a week ago implementing ptdump for PA-RISC. Didn't notice that
you're working on making it generic, which is nice. I'll adjust my code
to use the infrastructure you're currently developing.

> Can anyone shed some light on whether parisc does support leaf entries
> of the page table tree at a higher than the normal depth?
> 
> [1] https://lkml.org/lkml/2019/2/27/572
> [2] https://lkml.org/lkml/2019/3/5/610

My understanding is that PA-RISC only has leaf entries on PTE level.

> The intention is that the page table walker would be available for all
> architectures so that it can be used in any generic code - PTDUMP simply
> seemed like a good place to start.
> 
> > Now that pmd_leaf() and pud_leaf() are getting used in walk_page_range() these
> > functions need to be defined on all arch irrespective if they use PTDUMP or not
> > or otherwise just define it for archs which need them now for sure i.e x86 and
> > arm64 (which are moving to new generic PTDUMP framework). Other archs can
> > implement these later.

I'll take care of the PA-RISC part - for 32 bit your generic code works, for 64Bit
i need to learn a bit more about the following hack:

arch/parisc/include/asm/pgalloc.h:15
/* Allocate the top level pgd (page directory)
 *
 * Here (for 64 bit kernels) we implement a Hybrid L2/L3 scheme: we
 * allocate the first pmd adjacent to the pgd.  This means that we can
 * subtract a constant offset to get to it.  The pmd and pgd sizes are
 * arranged so that a single pmd covers 4GB (giving a full 64-bit
 * process access to 8TB) so our lookups are effectively L2 for the
 * first 4GB of the kernel (i.e. for all ILP32 processes and all the
 * kernel for machines with under 4GB of memory)
 */

I see that your change clear P?D entries when p?d_bad() returns true, which - i think -
would be the case with the PA-RISC implementation.

Regards
Sven
