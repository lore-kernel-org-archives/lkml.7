Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C99BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CFB20818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbfCALYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:24:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33368 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732835AbfCALYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:24:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E290EBD;
        Fri,  1 Mar 2019 03:24:30 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06C343F5C1;
        Fri,  1 Mar 2019 03:24:26 -0800 (PST)
Subject: Re: [PATCH v3 27/34] mm: pagewalk: Add 'depth' parameter to pte_hole
To:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
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
 <02b9ec67-75c5-4a36-9110-cc4ba6ee4f94@arm.com>
 <5f354bf5-4ac8-d0e2-048c-0857c91a21e6@intel.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <26df02dd-c54e-ea91-bdd1-0a4aad3a30ac@arm.com>
Date:   Fri, 1 Mar 2019 11:24:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <5f354bf5-4ac8-d0e2-048c-0857c91a21e6@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 19:00, Dave Hansen wrote:
> On 2/28/19 3:28 AM, Steven Price wrote:
>> static int get_level(unsigned long addr, unsigned long end)
>> {
>> 	/* Add 1 to account for ~0ULL */
>> 	unsigned long size = (end - addr) + 1;
>> 	if (size < PMD_SIZE)
>> 		return 4;
>> 	else if (size < PUD_SIZE)
>> 		return 3;
>> 	else if (size < P4D_SIZE)
>> 		return 2;
>> 	else if (size < PGD_SIZE)
>> 		return 1;
>> 	return 0;
>> }
>>
>> There are two immediate problems with that:
>>
>>  * The "+1" to deal with ~0ULL is fragile
>>
>>  * PGD_SIZE isn't what you might expect, it's not defined for most
>> architectures and arm64/x86 use it as the size of the PGD table.
>> Although that's easy enough to fix up.
>>
>> Do you think a function like above would be preferable?
> 
> The question still stands of why we *need* the depth/level in the first
> place.  As I said, we obviously need it for printing out the "name" of
> the level.  Is that it?

That is the only use I'm currently aware of.

>> The other option would of course be to just drop the information from
>> the debugfs file about at which level the holes are. But it can be
>> useful information to see whether there are empty levels in the page
>> table structure. Although this is an area where x86 and arm64 differ
>> currently (x86 explicitly shows the gaps, arm64 doesn't), so if x86
>> doesn't mind losing that functionality that would certainly simplify things!
> 
> I think I'd actually be OK with the holes just not showing up.  I
> actually find it kinda hard to read sometimes with the holes in there.
> I'd be curious what others think though.

If no-one has any objections to dropping the holes in the output, then I
can rebase on something like below and drop this 'depth' patch.

Steve

----8<----
From a9eabadfc212389068ec5cc60265c7a55585bb76 Mon Sep 17 00:00:00 2001
From: Steven Price <steven.price@arm.com>
Date: Fri, 1 Mar 2019 10:06:33 +0000
Subject: [PATCH] x86: mm: Hide page table holes in debugfs

For the /sys/kernel/debug/page_tables/ files, rather than outputing a
mostly empty line when a block of memory isn't present just skip the
line. This keeps the output shorter and will help with a future change
switching to using the generic page walk code as we no longer care about
the 'level' that the page table holes are at.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/x86/mm/dump_pagetables.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e3cdc85ce5b6..a0f4139631dd 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -304,8 +304,8 @@ static void note_page(struct seq_file *m, struct
pg_state *st,
 		/*
 		 * Now print the actual finished series
 		 */
-		if (!st->marker->max_lines ||
-		    st->lines < st->marker->max_lines) {
+		if ((cur & _PAGE_PRESENT) && (!st->marker->max_lines ||
+		    st->lines < st->marker->max_lines)) {
 			pt_dump_seq_printf(m, st->to_dmesg,
 					   "0x%0*lx-0x%0*lx   ",
 					   width, st->start_address,
@@ -321,7 +321,9 @@ static void note_page(struct seq_file *m, struct
pg_state *st,
 			printk_prot(m, st->current_prot, st->level,
 				    st->to_dmesg);
 		}
-		st->lines++;
+		if (cur & _PAGE_PRESENT) {
+			st->lines++;
+		}

 		/*
 		 * We print markers for special areas of address space,
-- 
2.20.1

