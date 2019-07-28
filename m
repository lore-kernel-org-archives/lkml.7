Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5B7C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FC72075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfG1Ln6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:43:58 -0400
Received: from foss.arm.com ([217.140.110.172]:60472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfG1Ln6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:43:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A702F337;
        Sun, 28 Jul 2019 04:43:57 -0700 (PDT)
Received: from [10.163.1.126] (unknown [10.163.1.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F39DE3F71F;
        Sun, 28 Jul 2019 04:43:50 -0700 (PDT)
Subject: Re: [PATCH v9 10/21] mm: Add generic p?d_leaf() macros
To:     Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190722154210.42799-11-steven.price@arm.com>
 <20190723094113.GA8085@lakrids.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ce4e21f2-020f-6677-d79c-5432e3061d6e@arm.com>
Date:   Sun, 28 Jul 2019 17:14:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190723094113.GA8085@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/23/2019 03:11 PM, Mark Rutland wrote:
> On Mon, Jul 22, 2019 at 04:41:59PM +0100, Steven Price wrote:
>> Exposing the pud/pgd levels of the page tables to walk_page_range() means
>> we may come across the exotic large mappings that come with large areas
>> of contiguous memory (such as the kernel's linear map).
>>
>> For architectures that don't provide all p?d_leaf() macros, provide
>> generic do nothing default that are suitable where there cannot be leaf
>> pages that that level.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> Not a big deal, but it would probably make sense for this to be patch 1
> in the series, given it defines the semantic of p?d_leaf(), and they're
> not used until we provide all the architectural implemetnations anyway.

Agreed.

> 
> It might also be worth pointing out the reasons for this naming, e.g.
> p?d_large() aren't currently generic, and this name minimizes potential
> confusion between p?d_{large,huge}().

Agreed. But these fallback also need to first check non-availability of large
pages. I am not sure whether CONFIG_HUGETLB_PAGE config being clear indicates
that conclusively or not. Being a page table leaf entry has a broader meaning
than a large page but that is really not the case today. All leaf entries here
are large page entries from MMU perspective. This dependency can definitely be
removed when there are other types of leaf entries but for now IMHO it feels
bit problematic not to directly associate leaf entries with large pages in
config restriction while doing exactly the same.
