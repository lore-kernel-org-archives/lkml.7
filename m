Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBBFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3720E2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfB1MLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:11:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46646 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfB1MLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:11:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCD4B80D;
        Thu, 28 Feb 2019 04:11:29 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559843F575;
        Thu, 28 Feb 2019 04:11:26 -0800 (PST)
Subject: Re: [PATCH v3 11/34] mips: mm: Add p?d_large() definitions
To:     Paul Burton <paul.burton@mips.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Morse <james.morse@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-12-steven.price@arm.com>
 <20190228021526.bb6m3my46ohb4o6h@pburton-laptop>
From:   Steven Price <steven.price@arm.com>
Message-ID: <74944d83-f3c0-ff02-590e-b7e5abcea485@arm.com>
Date:   Thu, 28 Feb 2019 12:11:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190228021526.bb6m3my46ohb4o6h@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 02:15, Paul Burton wrote:
> Hi Steven,
> 
> On Wed, Feb 27, 2019 at 05:05:45PM +0000, Steven Price wrote:
>> For mips, we don't support large pages on 32 bit so add stubs returning 0.
> 
> So far so good :)
> 
>> For 64 bit look for _PAGE_HUGE flag being set. This means exposing the
>> flag when !CONFIG_MIPS_HUGE_TLB_SUPPORT.
> 
> Here I have to ask why? We could just return 0 like the mips32 case when
> CONFIG_MIPS_HUGE_TLB_SUPPORT=n, let the compiler optimize the whole
> thing out and avoid redundant work at runtime.
> 
> This could be unified too in asm/pgtable.h - checking for
> CONFIG_MIPS_HUGE_TLB_SUPPORT should be sufficient to cover the mips32
> case along with the subset of mips64 configurations without huge pages.

The intention here is to define a new set of macros/functions which will
always tell us whether we're at the leaf of a page table walk, whether
or not huge pages are compiled into the kernel. Basically this allows
the page walking code to be used on page tables other than user space,
for instance the kernel page tables (which e.g. might use a large
mapping for linear memory even if huge pages are not compiled in) or
page tables from firmware (e.g. EFI on arm64).

I'm not familiar enough with mips to know how it handles things like the
linear map so I don't know how relevant that is, but I'm trying to
introduce a new set of functions which differ from the existing
p?d_huge() macros by not depending on whether these mappings could exist
for a user space VMA (i.e. not depending on HUGETLB support and existing
for all levels that architecturally they can occur at).

Steve
