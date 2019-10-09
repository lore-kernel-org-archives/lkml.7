Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9E1C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE1A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfJIKzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:55:48 -0400
Received: from foss.arm.com ([217.140.110.172]:59716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfJIKzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:55:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A51628;
        Wed,  9 Oct 2019 03:55:47 -0700 (PDT)
Received: from [10.1.196.133] (unknown [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F3443F703;
        Wed,  9 Oct 2019 03:55:44 -0700 (PDT)
Subject: Re: [PATCH v11 07/22] riscv: mm: Add p?d_leaf() definitions
To:     Paul Walmsley <paul.walmsley@sifive.com>, alex@ghiti.fr
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191007153822.16518-1-steven.price@arm.com>
 <20191007153822.16518-8-steven.price@arm.com>
 <alpine.DEB.2.21.9999.1910081431310.11044@viisi.sifive.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b0ed95cd-703f-9ac2-a2e8-9a059f4095f9@arm.com>
Date:   Wed, 9 Oct 2019 11:55:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1910081431310.11044@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2019 22:33, Paul Walmsley wrote:
> On Mon, 7 Oct 2019, Steven Price wrote:
> 
>> walk_page_range() is going to be allowed to walk page tables other than
>> those of user space. For this it needs to know when it has reached a
>> 'leaf' entry in the page tables. This information is provided by the
>> p?d_leaf() functions/macros.
>>
>> For riscv a page is a leaf page when it has a read, write or execute bit
>> set on it.
>>
>> CC: Palmer Dabbelt <palmer@sifive.com>
>> CC: Albert Ou <aou@eecs.berkeley.edu>
>> CC: linux-riscv@lists.infradead.org
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # for arch/riscv  
> 
> Alex has a good point, but probably the right thing to do is to replace 
> the contents of the arch/riscv/mm/hugetlbpage.c p{u,m}d_huge() functions 
> with calls to Steven's new static inline functions.

The intention is to create new functions that are not dependent on
hugepage support in user space. hugetlbpage.c is only built if
CONFIG_HUGETLB_PAGE is defined.

As you say - the p{u,m}d_huge() functions can be reimplemented using the
new static inline functions if desired.

Thanks for the review.

Steve

> 
> - Paul
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

