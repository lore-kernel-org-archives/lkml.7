Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB78C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448382053B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfEIOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:42:57 -0400
Received: from ozlabs.org ([203.11.71.1]:47891 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfEIOm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:42:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 450GKT2bqhz9s00;
        Fri, 10 May 2019 00:42:53 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Crashes in linux-next on powerpc with CONFIG_PPC_KUAP and CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
In-Reply-To: <20190509092942.ei4myfzt5dczuptj@pathway.suse.cz>
References: <87k1f2wc04.fsf@concordia.ellerman.id.au> <20190509092942.ei4myfzt5dczuptj@pathway.suse.cz>
Date:   Fri, 10 May 2019 00:42:52 +1000
Message-ID: <87woizvgcz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek <pmladek@suse.com> writes:
> On Wed 2019-05-08 00:54:51, Michael Ellerman wrote:
>> Hi folks,
>> 
>> Just an FYI in case anyone else is seeing crashes very early in boot in
>> linux-next with the above config options.
>>
>> The problem is the combination of some new code called via printk(),
>> check_pointer() which calls probe_kernel_read(). That then calls 
>> allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
>> (before we've patched features). With the JUMP_LABEL debug enabled that
>> causes us to call printk() & dump_stack() and we end up recursing and
>> overflowing the stack.
>
> Sigh, the check_pointer() stuff is in Linus's tree now, see
> the commit 3e5903eb9cff707301712 ("vsprintf: Prevent crash when
> dereferencing invalid pointers").

No worries.

>> Because it happens so early you don't get any output, just an apparently
>> dead system.
>> 
>> The stack trace (which you don't see) is something like:
>> 
>>   ...
>>   dump_stack+0xdc
>>   probe_kernel_read+0x1a4
>>   check_pointer+0x58
>>   string+0x3c
>>   vsnprintf+0x1bc
>>   vscnprintf+0x20
>>   printk_safe_log_store+0x7c
>>   printk+0x40
>>   dump_stack_print_info+0xbc
>>   dump_stack+0x8
>>   probe_kernel_read+0x1a4
>>   probe_kernel_read+0x19c
>>   check_pointer+0x58
>>   string+0x3c
>>   vsnprintf+0x1bc
>>   vscnprintf+0x20
>>   vprintk_store+0x6c
>>   vprintk_emit+0xec
>>   vprintk_func+0xd4
>>   printk+0x40
>>   cpufeatures_process_feature+0xc8
>>   scan_cpufeatures_subnodes+0x380
>>   of_scan_flat_dt_subnodes+0xb4
>>   dt_cpu_ftrs_scan_callback+0x158
>>   of_scan_flat_dt+0xf0
>>   dt_cpu_ftrs_scan+0x3c
>>   early_init_devtree+0x360
>>   early_setup+0x9c
>> 
>> 
>> The simple fix is to use early_mmu_has_feature() in allow_user_access(),
>> but we'd rather not do that because it penalises all
>> copy_to/from_users() for the life of the system with the cost of the
>> runtime check vs the jump label. The irony is probe_kernel_read()
>> shouldn't be allowing user access at all, because we're reading the
>> kernel not userspace.
>
> I have tried to find a lightweight way for a safe reading of unknown
> kernel pointer. But I have not succeeded so far. I see only variants
> with user access. The user access is handled in arch-specific code
> and I do not see any variant without it.
>
> I am not sure on which level it should get fixed.

I sent a fix in powerpc code (sorry might have forgot to Cc you):

  https://patchwork.ozlabs.org/patch/1097015/

I've merged that into the powerpc tree. I think it's too subtle for us
to have an ordering requirement that deep in the user copy code, it was
just a matter of time before it caused a problem, you were just unlucky
it was your patch that did :)

We'll eventually switch it back to using a jump label but make it safe
to call early in boot before we've detected features.

> Could you please send it to lkml to get a wider audience?

I see you also sent a fix, that looks like a safe default to me.

But as I said I'm happy with the powerpc fix, so there's no requirement
from us that your fix get merged.

cheers
