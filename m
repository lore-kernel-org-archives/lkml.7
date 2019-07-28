Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA55C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937B521655
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfG1LTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:19:32 -0400
Received: from foss.arm.com ([217.140.110.172]:60268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfG1LTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:19:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1C89344;
        Sun, 28 Jul 2019 04:19:29 -0700 (PDT)
Received: from [10.163.1.126] (unknown [10.163.1.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 855083F71F;
        Sun, 28 Jul 2019 04:19:23 -0700 (PDT)
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
To:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190722154210.42799-1-steven.price@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <794fb469-00c8-af10-92a8-cb7c0c83378b@arm.com>
Date:   Sun, 28 Jul 2019 16:50:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190722154210.42799-1-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22/2019 09:11 PM, Steven Price wrote:
> Steven Price (21):
>   arc: mm: Add p?d_leaf() definitions
>   arm: mm: Add p?d_leaf() definitions
>   arm64: mm: Add p?d_leaf() definitions
>   mips: mm: Add p?d_leaf() definitions
>   powerpc: mm: Add p?d_leaf() definitions
>   riscv: mm: Add p?d_leaf() definitions
>   s390: mm: Add p?d_leaf() definitions
>   sparc: mm: Add p?d_leaf() definitions
>   x86: mm: Add p?d_leaf() definitions

The set of architectures here is neither complete (e.g ia64, parisc missing)
nor does it only include architectures which had previously enabled PTDUMP
like arm, arm64, powerpc, s390 and x86. Is there any reason for this set of
archs to be on the list and not the others which are currently falling back
on generic p?d_leaf() defined later in the series ? Are the missing archs
do not have huge page support in the MMU ? If there is a direct dependency
for these symbols with CONFIG_HUGETLB_PAGE then it must be checked before
falling back on the generic ones.

Now that pmd_leaf() and pud_leaf() are getting used in walk_page_range() these
functions need to be defined on all arch irrespective if they use PTDUMP or not
or otherwise just define it for archs which need them now for sure i.e x86 and
arm64 (which are moving to new generic PTDUMP framework). Other archs can
implement these later.
