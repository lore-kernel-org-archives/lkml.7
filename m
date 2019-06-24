Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A82C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E808720674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfFXLXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:23:01 -0400
Received: from foss.arm.com ([217.140.110.172]:47458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfFXLXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:23:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 755622B;
        Mon, 24 Jun 2019 04:23:00 -0700 (PDT)
Received: from [192.168.1.27] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BAB43F718;
        Mon, 24 Jun 2019 04:22:58 -0700 (PDT)
Subject: Re: [PATCH 0/4] arm64: wire up VM_FLUSH_RESET_PERMS
To:     Will Deacon <will@kernel.org>, Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
 <20190528100413.GA20809@fuggles.cambridge.arm.com>
 <20190624111600.b7e5kkfvuszj6522@willie-the-truck>
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
Message-ID: <07e3d9ea-b917-2adb-6f88-0f1a31692d04@arm.com>
Date:   Mon, 24 Jun 2019 13:22:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624111600.b7e5kkfvuszj6522@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/19 1:16 PM, Will Deacon wrote:
> On Tue, May 28, 2019 at 11:04:20AM +0100, Will Deacon wrote:
>> On Thu, May 23, 2019 at 11:22:52AM +0100, Ard Biesheuvel wrote:
>>> Wire up the code introduced in v5.2 to manage the permissions
>>> of executable vmalloc regions (and their linear aliases) more
>>> strictly.
>>>
>>> One of the things that came up in the internal discussion is
>>> whether non-x86 architectures have any benefit at all from the
>>> lazy vunmap feature, and whether it would perhaps be better to
>>> implement eager vunmap instead.
>>>
>>> Cc: Nadav Amit <namit@vmware.com>
>>> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>> Cc: James Morse <james.morse@arm.com>
>>>
>>> Ard Biesheuvel (4):
>>>    arm64: module: create module allocations without exec permissions
>>>    arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
>>>    arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
>>>    arm64: bpf: do not allocate executable memory
>>>
>>>   arch/arm64/Kconfig                  |  1 +
>>>   arch/arm64/include/asm/cacheflush.h |  3 ++
>>>   arch/arm64/kernel/module.c          |  4 +-
>>>   arch/arm64/kernel/probes/kprobes.c  |  4 +-
>>>   arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
>>>   arch/arm64/net/bpf_jit_comp.c       |  2 +-
>>>   mm/vmalloc.c                        | 11 -----
>>>   7 files changed, 50 insertions(+), 23 deletions(-)
>>
>> Thanks, this all looks good to me. I can get pick this up for 5.2 if
>> Rick's fixes [1] land soon enough.
> 
> Bah, I missed these landing in -rc5 and I think it's a bit too late for
> us to take this for 5.2. now particularly with our limited ability to
> fix any late regressions that might arise.
> 
> In which case, Catalin, please can you take these for 5.3? You might run
> into some testing failures with for-next/core due to the late of Rick's
> fixes, but linux-next should be alright and I don't think you'll get any
> conflicts.
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Ard: are you ok with that?
> 

That is fine, although I won't be around to pick up the pieces by the 
time the merge window opens. Also, I'd like to follow up on the lazy 
vunmap thing for non-x86, but perhaps we can talk about this at plumbers?

