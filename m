Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C17C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945CF22ADB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfGXNfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:35:39 -0400
Received: from foss.arm.com ([217.140.110.172]:40916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfGXNfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:35:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E512F28;
        Wed, 24 Jul 2019 06:35:37 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FA4B3F71A;
        Wed, 24 Jul 2019 06:35:35 -0700 (PDT)
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190723101639.GD8085@lakrids.cambridge.arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e108b8a6-deca-e69c-b338-52a98b14be86@arm.com>
Date:   Wed, 24 Jul 2019 14:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723101639.GD8085@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2019 11:16, Mark Rutland wrote:
> On Mon, Jul 22, 2019 at 04:41:49PM +0100, Steven Price wrote:
>> This is a slight reworking and extension of my previous patch set
>> (Convert x86 & arm64 to use generic page walk), but I've continued the
>> version numbering as most of the changes are the same. In particular
>> this series ends with a generic PTDUMP implemention for arm64 and x86.
>>
>> Many architectures current have a debugfs file for dumping the kernel
>> page tables. Currently each architecture has to implement custom
>> functions for this because the details of walking the page tables used
>> by the kernel are different between architectures.
>>
>> This series extends the capabilities of walk_page_range() so that it can
>> deal with the page tables of the kernel (which have no VMAs and can
>> contain larger huge pages than exist for user space). A generic PTDUMP
>> implementation is the implemented making use of the new functionality of
>> walk_page_range() and finally arm64 and x86 are switch to using it,
>> removing the custom table walkers.
>>
>> To enable a generic page table walker to walk the unusual mappings of
>> the kernel we need to implement a set of functions which let us know
>> when the walker has reached the leaf entry. After a suggestion from Will
>> Deacon I've chosen the name p?d_leaf() as this (hopefully) describes
>> the purpose (and is a new name so has no historic baggage). Some
>> architectures have p?d_large macros but this is easily confused with
>> "large pages".
>>
>> Mostly this is a clean up and there should be very little functional
>> change. The exceptions are:
>>
>> * x86 PTDUMP debugfs output no longer display pages which aren't
>>   present (patch 14).
>>
>> * arm64 has the ability to efficiently process KASAN pages (which
>>   previously only x86 implemented). This means that the combination of
>>   KASAN and DEBUG_WX is now useable.
> 
> Are there any visible changes to the arm64 output?

arm64 output shouldn't change. I've confirmed that "efi_page_tables" is
identical on a Juno before/after the change. "kernel_page_tables"
obviously will vary depending on the exact layout of memory, but the
format isn't changed.

x86 output does change due to patch 14. In this case the change is
removing the lines from the output of the form...

> 0xffffffff84800000-0xffffffffa0000000         440M                               pmd

...which are unpopulated areas of the memory map. Populated lines which
have attributes are unchanged.

Steve
