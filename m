Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089DC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C05206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbfG2Lca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:32:30 -0400
Received: from foss.arm.com ([217.140.110.172]:42402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387483AbfG2Lc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:32:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF9BD28;
        Mon, 29 Jul 2019 04:32:28 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 609A73F694;
        Mon, 29 Jul 2019 04:32:26 -0700 (PDT)
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Helge Deller <deller@gmx.de>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190722154210.42799-1-steven.price@arm.com>
 <794fb469-00c8-af10-92a8-cb7c0c83378b@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <270ce719-49f9-7c61-8b25-bc9548a2f478@arm.com>
Date:   Mon, 29 Jul 2019 12:32:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <794fb469-00c8-af10-92a8-cb7c0c83378b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2019 12:20, Anshuman Khandual wrote:
> On 07/22/2019 09:11 PM, Steven Price wrote:
>> Steven Price (21):
>>   arc: mm: Add p?d_leaf() definitions
>>   arm: mm: Add p?d_leaf() definitions
>>   arm64: mm: Add p?d_leaf() definitions
>>   mips: mm: Add p?d_leaf() definitions
>>   powerpc: mm: Add p?d_leaf() definitions
>>   riscv: mm: Add p?d_leaf() definitions
>>   s390: mm: Add p?d_leaf() definitions
>>   sparc: mm: Add p?d_leaf() definitions
>>   x86: mm: Add p?d_leaf() definitions
> 
> The set of architectures here is neither complete (e.g ia64, parisc missing)
> nor does it only include architectures which had previously enabled PTDUMP
> like arm, arm64, powerpc, s390 and x86. Is there any reason for this set of
> archs to be on the list and not the others which are currently falling back
> on generic p?d_leaf() defined later in the series ? Are the missing archs
> do not have huge page support in the MMU ? If there is a direct dependency
> for these symbols with CONFIG_HUGETLB_PAGE then it must be checked before
> falling back on the generic ones.

The list of architectures here is what I believe to be the list of
architectures which can have leaf entries further up the tree than
normal. I'm by no means an expert on all these architectures so I'm
hoping someone will chime in if they notice something amiss. Obviously
all the NO_MMU

ia64 as far as I can tell doesn't implement leaf entries further up - it
has an interesting hybrid hardware/software walk mechanism and as I
understand it the hardware never walks the page table tree that the
p?d_xxx() operations operate on. So this is a software implementation
detail - but the existance of p?d_huge functions which always return 0
were my first clue that leaf entries are only at the bottom of the tree.

parisc is more interesting and I'm not sure if this is necessarily
correct. I originally proposed a patch with the line "For parisc, we
don't support large pages, so add stubs returning 0" which got Acked by
Helge Deller. However going back to look at that again I see there was a
follow up thread[2] which possibly suggests I was wrong?

Can anyone shed some light on whether parisc does support leaf entries
of the page table tree at a higher than the normal depth?

[1] https://lkml.org/lkml/2019/2/27/572
[2] https://lkml.org/lkml/2019/3/5/610

The intention is that the page table walker would be available for all
architectures so that it can be used in any generic code - PTDUMP simply
seemed like a good place to start.

> Now that pmd_leaf() and pud_leaf() are getting used in walk_page_range() these
> functions need to be defined on all arch irrespective if they use PTDUMP or not
> or otherwise just define it for archs which need them now for sure i.e x86 and
> arm64 (which are moving to new generic PTDUMP framework). Other archs can
> implement these later.

The intention was to have valid definitions for all architectures, but
obviously I need help from those familiar with those other architectures
to check whether I've understood them correctly.

Thanks,

Steve
