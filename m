Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33309C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D1720673
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfE2BoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:44:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49539 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfE2BoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:44:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45DD5Z6xB4z9s4V;
        Wed, 29 May 2019 11:44:02 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Young Xiao <92siuyang@gmail.com>
Cc:     will.deacon@arm.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.vnet.ibm.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
In-Reply-To: <20190528140103.GT2623@hirez.programming.kicks-ass.net>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com> <20190528140103.GT2623@hirez.programming.kicks-ass.net>
Date:   Wed, 29 May 2019 11:44:02 +1000
Message-ID: <87a7f6ox0d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Tue, May 28, 2019 at 08:31:29PM +0800, Young Xiao wrote:
>> When a kthread calls call_usermodehelper() the steps are:
>>   1. allocate current->mm
>>   2. load_elf_binary()
>>   3. populate current->thread.regs
>> 
>> While doing this, interrupts are not disabled. If there is a perf
>> interrupt in the middle of this process (i.e. step 1 has completed
>> but not yet reached to step 3) and if perf tries to read userspace
>> regs, kernel oops.
>> 
>> Fix it by setting abi to PERF_SAMPLE_REGS_ABI_NONE when userspace
>> pt_regs are not set.
>> 
>> See commit bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs
>> user process") for details.
>
> Why the hell do we set current->mm before it is complete? Note that
> normally exec() builds the new mm before attaching it, see exec_mmap()
> in flush_old_exec().
>
> Also, why did those PPC folks 'fix' this in isolation? And why didn't
> you Cc them?

We just assumed it was our bug, 'cause we have plenty of those :)

cheers
