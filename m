Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D10C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F0C22ADB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfGXOSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:18:49 -0400
Received: from foss.arm.com ([217.140.110.172]:41898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfGXOSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:18:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0319428;
        Wed, 24 Jul 2019 07:18:48 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55C7A3F71A;
        Wed, 24 Jul 2019 07:18:45 -0700 (PDT)
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190723101639.GD8085@lakrids.cambridge.arm.com>
 <e108b8a6-deca-e69c-b338-52a98b14be86@arm.com>
 <alpine.DEB.2.21.1907241541570.1791@nanos.tec.linutronix.de>
From:   Steven Price <steven.price@arm.com>
Message-ID: <fd898367-b44e-9328-bdab-7a3de0db6bda@arm.com>
Date:   Wed, 24 Jul 2019 15:18:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907241541570.1791@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2019 14:57, Thomas Gleixner wrote:
> On Wed, 24 Jul 2019, Steven Price wrote:
>> On 23/07/2019 11:16, Mark Rutland wrote:
>>> Are there any visible changes to the arm64 output?
>>
>> arm64 output shouldn't change. I've confirmed that "efi_page_tables" is
>> identical on a Juno before/after the change. "kernel_page_tables"
>> obviously will vary depending on the exact layout of memory, but the
>> format isn't changed.
>>
>> x86 output does change due to patch 14. In this case the change is
>> removing the lines from the output of the form...
>>
>>> 0xffffffff84800000-0xffffffffa0000000         440M                               pmd
>>
>> ...which are unpopulated areas of the memory map. Populated lines which
>> have attributes are unchanged.
> 
> Having the hole size and the level in the dump is a very conveniant thing.
> 
> Right now we have:
> 
> 0xffffffffc0427000-0xffffffffc042b000          16K     ro                     NX pte
> 0xffffffffc042b000-0xffffffffc042e000          12K     RW                     NX pte
> 0xffffffffc042e000-0xffffffffc042f000           4K                               pte
> 0xffffffffc042f000-0xffffffffc0430000           4K     ro                     x  pte
> 0xffffffffc0430000-0xffffffffc0431000           4K     ro                     NX pte
> 0xffffffffc0431000-0xffffffffc0433000           8K     RW                     NX pte
> 0xffffffffc0433000-0xffffffffc0434000           4K                               pte
> 0xffffffffc0434000-0xffffffffc0436000           8K     ro                     x  pte
> 0xffffffffc0436000-0xffffffffc0438000           8K     ro                     NX pte
> 0xffffffffc0438000-0xffffffffc043a000           8K     RW                     NX pte
> 0xffffffffc043a000-0xffffffffc043f000          20K                               pte
> 0xffffffffc043f000-0xffffffffc0444000          20K     ro                     x  pte
> 0xffffffffc0444000-0xffffffffc0447000          12K     ro                     NX pte
> 0xffffffffc0447000-0xffffffffc0449000           8K     RW                     NX pte
> 0xffffffffc0449000-0xffffffffc044f000          24K                               pte
> 0xffffffffc044f000-0xffffffffc0450000           4K     ro                     x  pte
> 0xffffffffc0450000-0xffffffffc0451000           4K     ro                     NX pte
> 0xffffffffc0451000-0xffffffffc0453000           8K     RW                     NX pte
> 0xffffffffc0453000-0xffffffffc0458000          20K                               pte
> 0xffffffffc0458000-0xffffffffc0459000           4K     ro                     x  pte
> 0xffffffffc0459000-0xffffffffc045b000           8K     ro                     NX pte
> 
> with your change this becomes:
> 
> 0xffffffffc0427000-0xffffffffc042b000          16K     ro                     NX pte
> 0xffffffffc042b000-0xffffffffc042e000          12K     RW                     NX pte
> 0xffffffffc042f000-0xffffffffc0430000           4K     ro                     x  pte
> 0xffffffffc0430000-0xffffffffc0431000           4K     ro                     NX pte
> 0xffffffffc0431000-0xffffffffc0433000           8K     RW                     NX pte
> 0xffffffffc0434000-0xffffffffc0436000           8K     ro                     x  pte
> 0xffffffffc0436000-0xffffffffc0438000           8K     ro                     NX pte
> 0xffffffffc0438000-0xffffffffc043a000           8K     RW                     NX pte
> 0xffffffffc043f000-0xffffffffc0444000          20K     ro                     x  pte
> 0xffffffffc0444000-0xffffffffc0447000          12K     ro                     NX pte
> 0xffffffffc0447000-0xffffffffc0449000           8K     RW                     NX pte
> 0xffffffffc044f000-0xffffffffc0450000           4K     ro                     x  pte
> 0xffffffffc0450000-0xffffffffc0451000           4K     ro                     NX pte
> 0xffffffffc0451000-0xffffffffc0453000           8K     RW                     NX pte
> 0xffffffffc0458000-0xffffffffc0459000           4K     ro                     x  pte
> 0xffffffffc0459000-0xffffffffc045b000           8K     ro                     NX pte
> 
> which is 5 lines less, but a pain to figure out the size of the holes. And
> it becomes even more painful when the holes go across different mapping
> levels.
> 
> From your 14/N changelog:
> 
>> This keeps the output shorter and will help with a future change
> 
> I don't care about shorter at all. It's debug information.

Sorry, the "shorter" part was because Dave Hansen originally said[1]:
> I think I'd actually be OK with the holes just not showing up.  I
> actually find it kinda hard to read sometimes with the holes in there.
> I'd be curious what others think though.

[1]
https://lore.kernel.org/lkml/5f354bf5-4ac8-d0e2-048c-0857c91a21e6@intel.com/

And I'd abbreviated "holes not showing up" as "shorter" in the commit
message - not the best wording I agree.

>> switching to using the generic page walk code as we no longer care about
>> the 'level' that the page table holes are at.
> 
> I really do not understand why you think that WE no longer care about the
> level (and the size) of the holes. I assume that WE is pluralis majestatis
> and not meant to reflect the opinion of you and everyone else.

Again, I apologise - that was sloppy wording in the commit message. By
"we" I meant the code not any particular person. In my original patch[2]
the only use of the 'depth' argument to pte_hole was to report the level
for these debug lines. Removing those lines simplified the code and at
the time nobody raised any objections.

[2]
https://lore.kernel.org/lkml/20190227170608.27963-28-steven.price@arm.com/

> I have no idea whether you ever had to do serious work with PT dump, but I
> surely have at various occasions including the PTI mess and I definitely
> found the size and the level information from holes very useful.

On arm64 we don't have those lines, but equally it's possible they might
be useful in the future. So this might be something to add.

As I said in a previous email[3] I was dropping the lines from the
output assuming nobody had any objections. Since you find these lines
useful, I'll see about reworking the change to retain the lines.

Steve

[3]
https://lore.kernel.org/lkml/26df02dd-c54e-ea91-bdd1-0a4aad3a30ac@arm.com/
