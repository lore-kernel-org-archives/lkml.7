Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9CDCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BD020862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfJaNdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:33:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfJaNdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:33:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10D831FB;
        Thu, 31 Oct 2019 06:33:00 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEF543F71E;
        Thu, 31 Oct 2019 06:32:57 -0700 (PDT)
Subject: Re: [PATCH v14 21/22] arm64: mm: Convert mm/dump.c to use
 walk_page_range()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
References: <20191028135910.33253-1-steven.price@arm.com>
 <20191028135910.33253-22-steven.price@arm.com>
 <20191030164535.GC13309@arrakis.emea.arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <40956d62-241c-6685-72f1-bfc01183141e@arm.com>
Date:   Thu, 31 Oct 2019 13:32:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030164535.GC13309@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2019 16:45, Catalin Marinas wrote:
> On Mon, Oct 28, 2019 at 01:59:09PM +0000, Steven Price wrote:
>> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
>> index 93f9f77582ae..9d9b740a86d2 100644
>> --- a/arch/arm64/mm/dump.c
>> +++ b/arch/arm64/mm/dump.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/io.h>
>>  #include <linux/init.h>
>>  #include <linux/mm.h>
>> +#include <linux/ptdump.h>
>>  #include <linux/sched.h>
>>  #include <linux/seq_file.h>
>>  
>> @@ -75,10 +76,11 @@ static struct addr_marker address_markers[] = {
>>   * dumps out a description of the range.
>>   */
>>  struct pg_state {
>> +	struct ptdump_state ptdump;
>>  	struct seq_file *seq;
>>  	const struct addr_marker *marker;
>>  	unsigned long start_address;
>> -	unsigned level;
>> +	int level;
>>  	u64 current_prot;
>>  	bool check_wx;
>>  	unsigned long wx_pages;
>> @@ -178,6 +180,10 @@ static struct pg_level pg_level[] = {
>>  		.name	= "PGD",
>>  		.bits	= pte_bits,
>>  		.num	= ARRAY_SIZE(pte_bits),
>> +	}, { /* p4d */
>> +		.name	= "P4D",
>> +		.bits	= pte_bits,
>> +		.num	= ARRAY_SIZE(pte_bits),
>>  	}, { /* pud */
>>  		.name	= (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
>>  		.bits	= pte_bits,
> 
> We could use "PGD" for the p4d entry since we don't have five levels.
> This patches the "PGD" name used for pud/pmd when these levels are
> folded.

Good point, although I'd actually be more tempted to do the opposite -
remove the special casing for PUD/PMD as the generic code should now
never provide those levels if they are folded. What do you think?

>> @@ -240,11 +246,15 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
>>  	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
>>  }
>>  
>> -static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
>> -				u64 val)
>> +static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
>> +		      unsigned long val)
>>  {
>> +	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
>>  	static const char units[] = "KMGTPE";
>> -	u64 prot = val & pg_level[level].mask;
>> +	u64 prot = 0;
>> +
>> +	if (level >= 0)
>> +		prot = val & pg_level[level].mask;
> 
> I think this test is not needed as we never have level < 0. The only
> call with a level 0 is from ptdump_hole() where the level passed is
> depth+1 while depth is -1 or higher.

Yes, sorry - that was needed in a previous version of the series, but I
apparently forgot to remove it.

> Anyway, we can keep this test _if_ we shift the levels down. I find it
> quite confusing that ptdump_hole() takes a 'depth' argument where 0 is
> PGD and 4 is PTE while for note_page() 1 is PGD and 5 PTE.
> 

Yes - I'll send a follow up patch which shifts the levels down. I
originally picked the levels to match the existing dump implementations
on x86/arm64. But it appears that x86 has had its levels artificially
inflated in the past, so actually moving it back down and matching
'depth' should make the code slightly more simple.

Steve

