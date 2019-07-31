Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0326C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A97206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfGaLSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:18:40 -0400
Received: from foss.arm.com ([217.140.110.172]:44418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfGaLSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:18:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC0CD344;
        Wed, 31 Jul 2019 04:18:38 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23D7D3F71F;
        Wed, 31 Jul 2019 04:18:36 -0700 (PDT)
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
To:     Sven Schnelle <svens@stackframe.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190722154210.42799-1-steven.price@arm.com>
 <794fb469-00c8-af10-92a8-cb7c0c83378b@arm.com>
 <270ce719-49f9-7c61-8b25-bc9548a2f478@arm.com>
 <20190731092703.GA31316@t470p.stackframe.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <788180f7-88ae-c88d-1531-68febb462010@arm.com>
Date:   Wed, 31 Jul 2019 12:18:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731092703.GA31316@t470p.stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2019 10:27, Sven Schnelle wrote:
> Hi Steven,
> 
> On Mon, Jul 29, 2019 at 12:32:25PM +0100, Steven Price wrote:
>>
>> parisc is more interesting and I'm not sure if this is necessarily
>> correct. I originally proposed a patch with the line "For parisc, we
>> don't support large pages, so add stubs returning 0" which got Acked by
>> Helge Deller. However going back to look at that again I see there was a
>> follow up thread[2] which possibly suggests I was wrong?
> 
> I just started a week ago implementing ptdump for PA-RISC. Didn't notice that
> you're working on making it generic, which is nice. I'll adjust my code
> to use the infrastructure you're currently developing.

Great, hopefully it will make it easier to implement.

>> Can anyone shed some light on whether parisc does support leaf entries
>> of the page table tree at a higher than the normal depth?
>>
>> [1] https://lkml.org/lkml/2019/2/27/572
>> [2] https://lkml.org/lkml/2019/3/5/610
> 
> My understanding is that PA-RISC only has leaf entries on PTE level.

Yes, that's my current interpretation.

>> The intention is that the page table walker would be available for all
>> architectures so that it can be used in any generic code - PTDUMP simply
>> seemed like a good place to start.
>>
>>> Now that pmd_leaf() and pud_leaf() are getting used in walk_page_range() these
>>> functions need to be defined on all arch irrespective if they use PTDUMP or not
>>> or otherwise just define it for archs which need them now for sure i.e x86 and
>>> arm64 (which are moving to new generic PTDUMP framework). Other archs can
>>> implement these later.
> 
> I'll take care of the PA-RISC part - for 32 bit your generic code works, for 64Bit
> i need to learn a bit more about the following hack:
> 
> arch/parisc/include/asm/pgalloc.h:15
> /* Allocate the top level pgd (page directory)
>  *
>  * Here (for 64 bit kernels) we implement a Hybrid L2/L3 scheme: we
>  * allocate the first pmd adjacent to the pgd.  This means that we can
>  * subtract a constant offset to get to it.  The pmd and pgd sizes are
>  * arranged so that a single pmd covers 4GB (giving a full 64-bit
>  * process access to 8TB) so our lookups are effectively L2 for the
>  * first 4GB of the kernel (i.e. for all ILP32 processes and all the
>  * kernel for machines with under 4GB of memory)
>  */

As far as I understand this, the page table tree isn't any different
here. It's just that there's a PMD which is allocated at the same time
as the PGD. The PGD's first entry then points to the PMD (P4D/PUD are
folded). There are then some tricks which means that for addresses < 4GB
the PGD stage can be skipped because you already know where the relevant
PMD is.

However, nothing should stop a simple walk from PGD down - it's just an
optimisation to remove the pointer fetch from PGD in the usual case for
accesses < 4GB.

> I see that your change clear P?D entries when p?d_bad() returns true, which - i think -
> would be the case with the PA-RISC implementation.

The only case where p?d_bad() is checked is at the PGD and P4D levels
(unless I'm missing something?). I have to admit I'm a little unsure
about this. Basically the code as it stands doesn't allow leaf entries
at PGD or P4D. I'm not aware of any architectures that do this though.

Thanks,

Steve
