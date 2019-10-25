Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E00CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66C021872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437919AbfJYIYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:24:01 -0400
Received: from foss.arm.com ([217.140.110.172]:36578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405823AbfJYIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:23:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF61228;
        Fri, 25 Oct 2019 01:23:57 -0700 (PDT)
Received: from [10.162.41.137] (p8cg001049571a15.blr.arm.com [10.162.41.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D6FC3F718;
        Fri, 25 Oct 2019 01:23:44 -0700 (PDT)
Subject: Re: [PATCH V7] mm/debug: Add tests validating architecture page table
 helpers
To:     Christophe Leroy <christophe.leroy@c-s.fr>, Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Matthew Wilcox <willy@infradead.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <ccdd4f7a-c7dc-ca10-d30c-0bc05c7136c7@arm.com>
 <69256008-2235-4AF1-A3BA-0146C82CCB93@lca.pw>
 <3cfec421-4006-4159-ca32-313ff5196ff9@c-s.fr>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <763d58b4-f532-0bba-bf2b-71433ac514fb@arm.com>
Date:   Fri, 25 Oct 2019 13:54:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3cfec421-4006-4159-ca32-313ff5196ff9@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2019 12:41 PM, Christophe Leroy wrote:
> 
> 
> Le 25/10/2019 à 07:52, Qian Cai a écrit :
>>
>>
>>> On Oct 24, 2019, at 11:45 PM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>>
>>> Nothing specific. But just tested this with x86 defconfig with relevant configs
>>> which are required for this test. Not sure if it involved W=1.
>>
>> No, it will not. It needs to run like,
>>
>> make W=1 -j 64 2>/tmp/warns
>>
> 
> Are we talking about this peace of code ?
> 
> +static unsigned long __init get_random_vaddr(void)
> +{
> +    unsigned long random_vaddr, random_pages, total_user_pages;
> +
> +    total_user_pages = (TASK_SIZE - FIRST_USER_ADDRESS) / PAGE_SIZE;
> +
> +    random_pages = get_random_long() % total_user_pages;
> +    random_vaddr = FIRST_USER_ADDRESS + random_pages * PAGE_SIZE;
> +
> +    WARN_ON((random_vaddr > TASK_SIZE) ||
> +        (random_vaddr < FIRST_USER_ADDRESS));
> +    return random_vaddr;
> +}
> +
> 
> ramdom_vaddr is unsigned,
> random_pages is unsigned and lower than total_user_pages
> 
> So the max value random_vaddr can get is FIRST_USER_ADDRESS + ((TASK_SIZE - FIRST_USER_ADDRESS - 1) / PAGE_SIZE) * PAGE_SIZE = TASK_SIZE - 1
> And the min value random_vaddr can get is FIRST_USER_ADDRESS (that's when random_pages = 0)

That's right.

> 
> So the WARN_ON() is just unneeded, isn't it ?

It is just a sanity check on possible vaddr values before it's corresponding
page table mappings could be created. If it's worth to drop this in favor of
avoiding these unwanted warning messages on x86, will go ahead with it as it
is not super important.

> 
> Christophe
> 
