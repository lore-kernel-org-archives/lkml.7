Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D172C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DEE2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfCDL4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:56:19 -0500
Received: from foss.arm.com ([217.140.101.70]:60698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDL4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:56:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE573A78;
        Mon,  4 Mar 2019 03:56:18 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9426E3F703;
        Mon,  4 Mar 2019 03:56:15 -0800 (PST)
Subject: Re: [PATCH v3 03/34] arm: mm: Add p?d_large() definitions
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-4-steven.price@arm.com>
 <20190301214715.hyzy5tevvwgki4w5@kshutemo-mobl1>
From:   Steven Price <steven.price@arm.com>
Message-ID: <974310a0-0114-9a0c-9041-4e0394c4b9aa@arm.com>
Date:   Mon, 4 Mar 2019 11:56:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190301214715.hyzy5tevvwgki4w5@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 21:47, Kirill A. Shutemov wrote:
> On Wed, Feb 27, 2019 at 05:05:37PM +0000, Steven Price wrote:
>> walk_page_range() is going to be allowed to walk page tables other than
>> those of user space. For this it needs to know when it has reached a
>> 'leaf' entry in the page tables. This information will be provided by the
>> p?d_large() functions/macros.
>>
>> For arm, we already provide most p?d_large() macros. Add a stub for PUD
>> as we don't have huge pages at that level.
> 
> We do not have PUD for 2- and 3-level paging. Macros from generic header
> should cover it, shouldn't it?
> 

I'm not sure of the reasoning behind this, but levels are folded in a
slightly strange way. arm/include/asm/pgtable.h defines
__ARCH_USE_5LEVEL_HACK which means:

PGD has 2048 (2-level) or 4 (3-level) entries which are always
considered 'present' (pgd_present() returns 1 defined in
asm-generic/pgtables-nop4d-hack.h).

P4D has 1 entry which is always present (see asm-generic/5level-fixup.h)

PUD has 1 entry (see asm-generic/pgtable-nop4d-hack.h). This is always
present for 2-level, and present only if the first level of real page
table is present with a 3-level.

PMD/PTE are as you might expect.

So in terms of tables which are more than one entry you have PGD,
(optionally) PMD, PTE. But the levels which actually read the table
entries are PUD, PMD, PTE.

This means that the corresponding p?d_large() macros are needed for
PUD/PMD as that is where the actual entries are read. The asm-generic
files provide the definitions for PGD/P4D.

Steve
