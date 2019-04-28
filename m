Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FFCC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431982147A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfD1UrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 16:47:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfD1UrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 16:47:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7FCA3097035;
        Sun, 28 Apr 2019 20:47:17 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3D5E17989;
        Sun, 28 Apr 2019 20:47:16 +0000 (UTC)
Subject: Re: [PATCH-tip v6 01/20] locking/rwsem: Prevent decrement of reader
 count before increment
To:     Sasha Levin <sashal@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
References: <20190428155755.14267-2-longman@redhat.com>
 <20190428203916.E1AA6206A3@mail.kernel.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <64a3b2e2-2a1a-0ca3-8023-4e56d951b4e8@redhat.com>
Date:   Sun, 28 Apr 2019 16:47:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428203916.E1AA6206A3@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 28 Apr 2019 20:47:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/19 4:39 PM, Sasha Levin wrote:
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 70800c3c0cc5 locking/rwsem: Scan the wait_list for readers only once.
>
> The bot has tested the following trees: v5.0.10, v4.19.37, v4.14.114, v4.9.171.
>
> v5.0.10: Failed to apply! Possible dependencies:
>     412f34a82ccf ("locking/qspinlock_stat: Track the no MCS node available case")
>     46ad0840b158 ("locking/rwsem: Remove arch specific rwsem files")
>     579afe866f52 ("xtensa: use generic spinlock/rwlock implementation")
>     a8654596f037 ("locking/rwsem: Enable lock event counting")
>     ad53fa10fa9e ("locking/qspinlock_stat: Introduce generic lockevent_*() counting APIs")
>     c7580c1e8443 ("locking/rwsem: Move owner setting code from rwsem.c to rwsem.h")
>     ce9084ba0d1d ("x86: Make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol")
>     d682b596d993 ("locking/qspinlock: Handle > 4 slowpath nesting levels")
>     eecec78f7777 ("locking/rwsem: Relocate rwsem_down_read_failed()")
>     fb346fd9fc08 ("locking/lock_events: Make lock_events available for all archs & other locks")
>
> v4.19.37: Failed to apply! Possible dependencies:
>     0fa809ca7f81 ("locking/pvqspinlock: Extend node size when pvqspinlock is configured")
>     1222109a5363 ("locking/qspinlock_stat: Count instances of nested lock slowpaths")
>     412f34a82ccf ("locking/qspinlock_stat: Track the no MCS node available case")
>     46ad0840b158 ("locking/rwsem: Remove arch specific rwsem files")
>     4b486b535c33 ("locking/rwsem: Exit read lock slowpath if queue empty & no writer")
>     925b9cd1b89a ("locking/rwsem: Make owner store task pointer of last owning reader")
>     a8654596f037 ("locking/rwsem: Enable lock event counting")
>     ad53fa10fa9e ("locking/qspinlock_stat: Introduce generic lockevent_*() counting APIs")
>     c7580c1e8443 ("locking/rwsem: Move owner setting code from rwsem.c to rwsem.h")
>     ce9084ba0d1d ("x86: Make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol")
>     d682b596d993 ("locking/qspinlock: Handle > 4 slowpath nesting levels")
>     eecec78f7777 ("locking/rwsem: Relocate rwsem_down_read_failed()")
>     fb346fd9fc08 ("locking/lock_events: Make lock_events available for all archs & other locks")
>
> v4.14.114: Failed to apply! Possible dependencies:
>     0fa809ca7f81 ("locking/pvqspinlock: Extend node size when pvqspinlock is configured")
>     11752adb68a3 ("locking/pvqspinlock: Implement hybrid PV queued/unfair locks")
>     1222109a5363 ("locking/qspinlock_stat: Count instances of nested lock slowpaths")
>     1958b5fc4010 ("x86/boot: Add early boot support when running with SEV active")
>     1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into separate translation unit")
>     271ca788774a ("arch: enable relative relocations for arm64, power and x86")
>     412f34a82ccf ("locking/qspinlock_stat: Track the no MCS node available case")
>     81d3dc9a349b ("locking/qspinlock: Add stat tracking for pending vs. slowpath")
>     94d49eb30e85 ("x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME")
>     a8654596f037 ("locking/rwsem: Enable lock event counting")
>     ad53fa10fa9e ("locking/qspinlock_stat: Introduce generic lockevent_*() counting APIs")
>     ce9084ba0d1d ("x86: Make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol")
>     d682b596d993 ("locking/qspinlock: Handle > 4 slowpath nesting levels")
>     d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory encryption")
>     d8aa7eea78a1 ("x86/mm: Add Secure Encrypted Virtualization (SEV) support")
>     dfaaec9033b8 ("x86: Add support for changing memory encryption attribute in early boot")
>     fb346fd9fc08 ("locking/lock_events: Make lock_events available for all archs & other locks")
>
> v4.9.171: Failed to apply! Possible dependencies:
>     1a8b6d76dc5b ("net:add one common config ARCH_WANT_RELAX_ORDER to support relax ordering")
>     271ca788774a ("arch: enable relative relocations for arm64, power and x86")
>     29dee3c03abc ("locking/refcounts: Out-of-line everything")
>     40565b5aedd6 ("sched/cputime, powerpc, s390: Make scaled cputime arch specific")
>     4ad8622dc548 ("powerpc/8xx: Implement hw_breakpoint")
>     51c9c0843993 ("powerpc/kprobes: Implement Optprobes")
>     5b9ff0278598 ("powerpc: Build-time sort the exception table")
>     65c059bcaa73 ("powerpc: Enable support for GCC plugins")
>     9fea59bd7ca5 ("powerpc/mm: Add support for runtime configuration of ASLR limits")
>     a7d2475af7ae ("powerpc: Sort the selects under CONFIG_PPC")
>     a8654596f037 ("locking/rwsem: Enable lock event counting")
>     bd174169c7a1 ("locking/refcount: Add refcount_t API kernel-doc comments")
>     ce9084ba0d1d ("x86: Make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol")
>     d557d1b58b35 ("refcount: change EXPORT_SYMBOL markings")
>     ebfa50df435e ("powerpc: Add helper to check if offset is within relative branch range")
>     f405df5de317 ("refcount_t: Introduce a special purpose refcount type")
>     fa769d3f58e6 ("powerpc/32: Enable HW_BREAKPOINT on BOOK3S")
>     fb346fd9fc08 ("locking/lock_events: Make lock_events available for all archs & other locks")
>     fd25d19f6b8d ("locking/refcount: Create unchecked atomic_t implementation")
>
>
> How should we proceed with this patch?

I will send out a version that will be easier to backport once this
patch lands in the mainline.

Cheers,
Longman

