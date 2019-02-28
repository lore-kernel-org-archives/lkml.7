Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99334C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCB420854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfB1L2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:28:07 -0500
Received: from foss.arm.com ([217.140.101.70]:45990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfB1L2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:28:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A9D9EBD;
        Thu, 28 Feb 2019 03:28:06 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AABA3F738;
        Thu, 28 Feb 2019 03:28:03 -0800 (PST)
Subject: Re: [PATCH v3 27/34] mm: pagewalk: Add 'depth' parameter to pte_hole
To:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-28-steven.price@arm.com>
 <aece3046-6040-e2ec-fcd7-204113d40eb7@intel.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <02b9ec67-75c5-4a36-9110-cc4ba6ee4f94@arm.com>
Date:   Thu, 28 Feb 2019 11:28:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <aece3046-6040-e2ec-fcd7-204113d40eb7@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 17:38, Dave Hansen wrote:
> On 2/27/19 9:06 AM, Steven Price wrote:
>>  #ifdef CONFIG_SHMEM
>>  static int smaps_pte_hole(unsigned long addr, unsigned long end,
>> -		struct mm_walk *walk)
>> +			  __always_unused int depth, struct mm_walk *walk)
>>  {
> 
> I think this 'depth' argument is a mistake.  It's synthetic and it's
> surely going to be a source of bugs.
> 
> The page table dumpers seem to be using this to dump out the "name" of a
> hole which seems a bit bogus in the first place.  I'd much rather teach
> the dumpers about the length of the hole, "the hole is 0x12340000 bytes
> long", rather than "there's a hole at this level".

I originally started by trying to calculate the 'depth' from (end -
addr), e.g. for arm64:

level = 4 - (ilog2(end - addr) - PAGE_SHIFT) / (PAGE_SHIFT - 3)

However there are two issues that I encountered:

* walk_page_range() takes a range of addresses to walk. This means that
holes at the beginning/end of the range are clamped to the address
range. This particularly shows up at the end of the range as I use ~0ULL
as the end which leads to (~0ULL - addr) which is 1 byte short of the
desired size. Obviously that particular corner-case is easy to work
round, but it seemed fragile.

* The above definition for arm64 isn't correct in all cases. You need to
account for things like CONFIG_PGTABLE_LEVELS. Other architectures also
have various quirks in their page tables.

I guess I could try something like:

static int get_level(unsigned long addr, unsigned long end)
{
	/* Add 1 to account for ~0ULL */
	unsigned long size = (end - addr) + 1;
	if (size < PMD_SIZE)
		return 4;
	else if (size < PUD_SIZE)
		return 3;
	else if (size < P4D_SIZE)
		return 2;
	else if (size < PGD_SIZE)
		return 1;
	return 0;
}

There are two immediate problems with that:

 * The "+1" to deal with ~0ULL is fragile

 * PGD_SIZE isn't what you might expect, it's not defined for most
architectures and arm64/x86 use it as the size of the PGD table.
Although that's easy enough to fix up.

Do you think a function like above would be preferable?

The other option would of course be to just drop the information from
the debugfs file about at which level the holes are. But it can be
useful information to see whether there are empty levels in the page
table structure. Although this is an area where x86 and arm64 differ
currently (x86 explicitly shows the gaps, arm64 doesn't), so if x86
doesn't mind losing that functionality that would certainly simplify things!

Thanks,

Steve
