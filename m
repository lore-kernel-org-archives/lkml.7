Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E20C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C5B20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfCFNpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:45:14 -0500
Received: from foss.arm.com ([217.140.101.70]:32820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfCFNpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:45:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 100A6EBD;
        Wed,  6 Mar 2019 05:45:13 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9503F71D;
        Wed,  6 Mar 2019 05:45:09 -0800 (PST)
Subject: Re: [PATCH v3 08/34] ia64: mm: Add p?d_large() definitions
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, linux-ia64@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-9-steven.price@arm.com>
 <20190301215728.nk7466zohdlgelcb@kshutemo-mobl1>
 <15100043-26e4-2ee1-28fe-101e12f74926@arm.com>
 <20190304190637.GA13947@agluck-desk>
From:   Steven Price <steven.price@arm.com>
Message-ID: <aab0ac18-fe3b-a753-009e-8704edb15623@arm.com>
Date:   Wed, 6 Mar 2019 13:45:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190304190637.GA13947@agluck-desk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2019 19:06, Luck, Tony wrote:
> On Mon, Mar 04, 2019 at 01:16:47PM +0000, Steven Price wrote:
>> On 01/03/2019 21:57, Kirill A. Shutemov wrote:
>>> On Wed, Feb 27, 2019 at 05:05:42PM +0000, Steven Price wrote:
>>>> walk_page_range() is going to be allowed to walk page tables other than
>>>> those of user space. For this it needs to know when it has reached a
>>>> 'leaf' entry in the page tables. This information is provided by the
>>>> p?d_large() functions/macros.
>>>>
>>>> For ia64 leaf entries are always at the lowest level, so implement
>>>> stubs returning 0.
>>>
>>> Are you sure about this? I see pte_mkhuge defined for ia64 and Kconfig
>>> contains hugetlb references.
>>>
>>
>> I'm not completely familiar with ia64, but my understanding is that it
>> doesn't have the situation where a page table walk ends early - there is
>> always the full depth of entries. The p?d_huge() functions always return 0.
>>
>> However my understanding is that it does support huge TLB entries, so
>> when populating the TLB a region larger than a standard page can be mapped.
>>
>> I'd definitely welcome review by someone more familiar with ia64 to
>> check my assumptions.
> 
> ia64 has several ways to manage page tables. The one
> used by Linux has multi-level table walks like other
> architectures, but we don't allow mixing of different
> page sizes within a "region" (there are eight regions
> selected by the high 3 bits of the virtual address).

I'd gathered ia64 has this "region" concept, from what I can tell the
existing p?d_present() etc macros are assuming a particular
configuration of a region, and so the p?d_large macros would follow that
scheme. This of course does limit any generic page walking code to
dealing only with this one type of region, but that doesn't seem
unreasonable.

> Is the series in some GIT tree that I can pull, rather
> than tracking down all 34 pieces?  I can try it out and
> see if things work/break.

At the moment I don't have a public tree - I'm trying to get that set
up. In the meantime you can download the entire series as a mbox from
patchwork:

https://patchwork.kernel.org/series/85673/mbox/

(it's currently based on v5.0-rc6)

However you won't see anything particularly interesting on ia64 (yet)
because my focus has been converting the PTDUMP implementations that
several architecture have (arm, arm64, powerpc, s390, x86) but not ia64.
For now I've also only done the PTDUMP work for arm64/x86 as a way of
testing out the idea. Ideally the PTDUMP code can be made generic enough
that implementing it for other architecture (including ia64) will be
trivial.

Thanks,

Steve
