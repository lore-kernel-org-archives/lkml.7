Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F4C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA30423C0F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfEaIri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:47:38 -0400
Received: from foss.arm.com ([217.140.101.70]:47918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaIri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:47:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7619E341;
        Fri, 31 May 2019 01:47:37 -0700 (PDT)
Received: from [10.162.42.223] (unknown [10.162.42.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20D713F59C;
        Fri, 31 May 2019 01:47:28 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC] mm: Generalize notify_page_fault()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Konovalov <andreyknvl@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>
References: <1559195713-6956-1-git-send-email-anshuman.khandual@arm.com>
 <20190530110639.GC23461@bombadil.infradead.org>
 <4f9a610d-e856-60f6-4467-09e9c3836771@arm.com>
 <20190530133954.GA2024@bombadil.infradead.org>
Message-ID: <f1995445-d5ab-f292-d26c-809581002184@arm.com>
Date:   Fri, 31 May 2019 14:17:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190530133954.GA2024@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/30/2019 07:09 PM, Matthew Wilcox wrote:
> On Thu, May 30, 2019 at 05:31:15PM +0530, Anshuman Khandual wrote:
>> On 05/30/2019 04:36 PM, Matthew Wilcox wrote:
>>> The two handle preemption differently.  Why is x86 wrong and this one
>>> correct?
>>
>> Here it expects context to be already non-preemptible where as the proposed
>> generic function makes it non-preemptible with a preempt_[disable|enable]()
>> pair for the required code section, irrespective of it's present state. Is
>> not this better ?
> 
> git log -p arch/x86/mm/fault.c
> 
> search for 'kprobes'.
> 
> tell me what you think.
> 

Are you referring to these following commits

a980c0ef9f6d ("x86/kprobes: Refactor kprobes_fault() like kprobe_exceptions_notify()")
b506a9d08bae ("x86: code clarification patch to Kprobes arch code")

In particular the later one (b506a9d08bae). It explains how the invoking context
in itself should be non-preemptible for the kprobes processing context irrespective
of whether kprobe_running() or perhaps smp_processor_id() is safe or not. Hence it
does not make much sense to continue when original invoking context is preemptible.
Instead just bail out earlier. This seems to be making more sense than preempt
disable-enable pair. If there are no concerns about this change from other platforms,
I will change the preemption behavior in proposed generic function next time around.
