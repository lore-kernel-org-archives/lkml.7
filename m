Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99818C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BE62063F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391141AbfFKFNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:13:51 -0400
Received: from foss.arm.com ([217.140.110.172]:52938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390539AbfFKFNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:13:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9DC9344;
        Mon, 10 Jun 2019 22:13:49 -0700 (PDT)
Received: from [10.162.43.135] (p8cg001049571a15.blr.arm.com [10.162.43.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2A743F73C;
        Mon, 10 Jun 2019 22:13:41 -0700 (PDT)
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Matthew Wilcox <willy@infradead.org>,
        sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
 <ec764ff4-f68a-fce5-ac1e-a4664e1123c7@c-s.fr>
 <97e9c9b3-89c8-d378-4730-841a900e6800@arm.com>
 <8dd6168592437378ff4a7c204e0f2962d002b44f.camel@linux.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7b0a7afd-2776-0d95-19c5-3e15959744eb@arm.com>
Date:   Tue, 11 Jun 2019 10:44:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8dd6168592437378ff4a7c204e0f2962d002b44f.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/10/2019 08:57 PM, Leonardo Bras wrote:
> On Mon, 2019-06-10 at 08:09 +0530, Anshuman Khandual wrote:
>>>> +    /*
>>>> +     * To be potentially processing a kprobe fault and to be allowed
>>>> +     * to call kprobe_running(), we have to be non-preemptible.
>>>> +     */
>>>> +    if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
>>>> +        if (kprobe_running() && kprobe_fault_handler(regs, trap))
>>>
>>> don't need an 'if A if B', can do 'if A && B'
>>
>> Which will make it a very lengthy condition check.
> 
> Well, is there any problem line-breaking the if condition?
> 
> if (A && B && C &&
>     D && E )
> 
> Also, if it's used only to decide the return value, maybe would be fine
> to do somethink like that:
> 
> return (A && B && C &&
>         D && E ); 

Got it. But as Dave and Matthew had pointed out earlier, the current x86
implementation has better readability. Hence will probably stick with it.
