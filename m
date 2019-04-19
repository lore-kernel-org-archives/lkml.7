Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BB3C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529182171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfDSTl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:41:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfDSTl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:41:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A7B7C0798ED;
        Fri, 19 Apr 2019 19:41:56 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 753F25C219;
        Fri, 19 Apr 2019 19:41:54 +0000 (UTC)
Subject: Re: [tip:locking/core] locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON()
 macro
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, mingo@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, a.p.zijlstra@chello.nl, will.deacon@arm.com,
        tim.c.chen@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, dave@stgolabs.net, dbueso@suse.de,
        torvalds@linux-foundation.org, peterz@infradead.org
Cc:     linux-tip-commits@vger.kernel.org
References: <20190404174320.22416-7-longman@redhat.com>
 <tip-3b4ba6643d26a95e08067fca9a5da1828f9afabf@git.kernel.org>
 <20190419193650.GA10656@roeck-us.net>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <14d7668c-e6db-3ae3-94db-1d1d313cf9cf@redhat.com>
Date:   Fri, 19 Apr 2019 15:41:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190419193650.GA10656@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 19 Apr 2019 19:41:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2019 03:36 PM, Guenter Roeck wrote:
> On Tue, Apr 16, 2019 at 03:04:41AM -0700, tip-bot for Waiman Long wrote:
>> Commit-ID:  3b4ba6643d26a95e08067fca9a5da1828f9afabf
>> Gitweb:     https://git.kernel.org/tip/3b4ba6643d26a95e08067fca9a5da1828f9afabf
>> Author:     Waiman Long <longman@redhat.com>
>> AuthorDate: Thu, 4 Apr 2019 13:43:15 -0400
>> Committer:  Ingo Molnar <mingo@kernel.org>
>> CommitDate: Wed, 10 Apr 2019 10:56:03 +0200
>>
>> locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
>>
>> Currently, the DEBUG_RWSEMS_WARN_ON() macro just dumps a stack trace
>> when the rwsem isn't in the right state. It does not show the actual
>> states of the rwsem. This may not be that helpful in the debugging
>> process.
>>
>> Enhance the DEBUG_RWSEMS_WARN_ON() macro to also show the current
>> content of the rwsem count and owner fields to give more information
>> about what is wrong with the rwsem. The debug_locks_off() function is
>> called as is done inside DEBUG_LOCKS_WARN_ON().
>>
> This patch results in a large number of runtime warnings with several
> architectures (at least arm, arm64, ppc, s390, sparc64, x86) if lock
> debugging is enabled.
>
> Example backtrace (ppc64):
>
> DEBUG_RWSEMS_WARN_ON(sem->owner != current): count = 0x0, owner = 0x0, curr
> 0xc0000000012e0e00, list empty
> WARNING: CPU: 0 PID: 0 at kernel/locking/rwsem.h:277 .up_write+0x138/0x150
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 5.1.0-rc5-next-20190418-08527-g856544124538 #1
> NIP:  c00000000015b7c8 LR: c00000000015b7c4 CTR: c0000000007b37a0
> REGS: c00000000141f940 TRAP: 0700   Not tainted
> (5.1.0-rc5-next-20190418-08527-g856544124538)
> MSR:  8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 24000444  XER: 00000000
> IRQMASK: 0 
> GPR00: c00000000015b7c4 c00000000141fbd0 c00000000141ff00 000000000000006a 
> GPR04: 0000000000000001 c000000000179fe8 0000000000000000 0000000000000001 
> GPR08: c0000000012e0e00 0000000000000001 c00000000207ff00 0000000000000000 
> GPR12: 0000000022000444 c000000002118000 000000003fde7ee0 0000000001fce4d8 
> GPR16: 0000000001fce218 0000000001fce8f8 0000000002470000 0000000001fdcee8 
> GPR20: 0000000000000000 fffffffffffffffd 0000000001fcea18 00000000ffffffff 
> GPR24: 0000000001000000 c0000000014324bc c00000000104cf00 c00000000104c4f0 
> GPR28: 0000000000000008 c000000000fd13d0 0000000000000000 c0000000012919b0 
> NIP [c00000000015b7c8] .up_write+0x138/0x150
> LR [c00000000015b7c4] .up_write+0x134/0x150
> Call Trace:
> [c00000000141fbd0] [c00000000015b7c4] .up_write+0x134/0x150 (unreliable)
> [c00000000141fc60] [c000000000729808] .double_unlock_wsem+0x38/0x50
> [c00000000141fce0] [c0000000007312f0] .dotest+0x88/0x7e8
> [c00000000141fe20] [c00000000072f394] .locking_selftest+0x664/0x21e8
> [c00000000141fed0] [c000000001102628] .start_kernel+0x4c4/0x640
> [c00000000141ff90] [c00000000000aef0] start_here_common+0x1c/0x52c
> Instruction dump:
> 7fe9fb78 e9490051 7fa95000 419e002c 3d02ffbd 39083bf8 3c82ffbd 3c62ffbd 
> 38843cc0 38633c50 4bf7bd81 60000000 <0fe00000> 4bffff64 3d02ffc2 39080e18 
>
> Reverting the patch fixes the problem.
>
> Bisect log (generated from ppc64 qemu run) attached.
>
> Guenter
>
> ---
> # bad: [856544124538f33105302451a9fbf0676598dddb] block: avoid scatterlist offsets > PAGE_SIZE
> 	Note: This was on top of next-20190418
> # good: [dc4060a5dc2557e6b5aa813bf5b73677299d62d2] Linux 5.1-rc5
> git bisect start 'HEAD' 'v5.1-rc5'
> # good: [d49e1f8649c84f154e7df59300264f59b736f329] Merge remote-tracking branch 'crypto/master'
> git bisect good d49e1f8649c84f154e7df59300264f59b736f329
> # good: [06a21957e5c0aae87fb94b97ef965818bd7c9dac] Merge remote-tracking branch 'spi/for-next'
> git bisect good 06a21957e5c0aae87fb94b97ef965818bd7c9dac
> # bad: [c44f3caed068c67fe01056329e7e6cbf8f4920a8] Merge remote-tracking branch 'staging/staging-next'
> git bisect bad c44f3caed068c67fe01056329e7e6cbf8f4920a8
> # bad: [7b621018ce44727ffcc1f548187fead9e8fd6680] Merge remote-tracking branch 'usb-chipidea-next/ci-for-usb-next'
> git bisect bad 7b621018ce44727ffcc1f548187fead9e8fd6680
> # bad: [c8d9806ebb40150b6b4ee20f24ad0220fee7970a] Merge branch 'core/core'
> git bisect bad c8d9806ebb40150b6b4ee20f24ad0220fee7970a
> # good: [b9541e74fdc7673058c0db87dd9901aa10dda221] Merge branch 'perf/urgent'
> git bisect good b9541e74fdc7673058c0db87dd9901aa10dda221
> # bad: [408da98e8208df4664e775f393b1af9052ce61c6] Merge branch 'locking/core'
> git bisect bad 408da98e8208df4664e775f393b1af9052ce61c6
> # good: [cabf5ebbabcd4ad59b6eb216876c4c2e56fd3386] Merge tag 'perf-core-for-mingo-5.2-20190402' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
> git bisect good cabf5ebbabcd4ad59b6eb216876c4c2e56fd3386
> # bad: [ad53fa10fa9e816067bbae7109845940f5e6df50] locking/qspinlock_stat: Introduce generic lockevent_*() counting APIs
> git bisect bad ad53fa10fa9e816067bbae7109845940f5e6df50
> # good: [f1887143f5984f23d2360f2efed6ef481bb41117] Documentation/atomic_t: Clarify signed vs unsigned
> git bisect good f1887143f5984f23d2360f2efed6ef481bb41117
> # good: [f7c2b7477bdc79a1e0cc3751a26c28031c1ab609] Merge branch 'lkmm-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into locking/core
> git bisect good f7c2b7477bdc79a1e0cc3751a26c28031c1ab609
> # good: [12a30a7fc142a123c61da9623bd824d95d36c12e] locking/rwsem: Move rwsem internal function declarations to rwsem-xadd.h
> git bisect good 12a30a7fc142a123c61da9623bd824d95d36c12e
> # good: [a68e2c4c637918da47b3aa270051545cff7d8245] locking/rwsem: Add debug check for __down_read*()
> git bisect good a68e2c4c637918da47b3aa270051545cff7d8245
> # bad: [3b4ba6643d26a95e08067fca9a5da1828f9afabf] locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
> git bisect bad 3b4ba6643d26a95e08067fca9a5da1828f9afabf
> # first bad commit: [3b4ba6643d26a95e08067fca9a5da1828f9afabf] locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro

This is a known problem and fix has been merged into tip:locking/core.

Cheers,
Longman



