Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5783C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFD6206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfJHJ6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:58:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54529 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfJHJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:58:22 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x989w26j028075;
        Tue, 8 Oct 2019 18:58:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Tue, 08 Oct 2019 18:58:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x989vvGx028053
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 8 Oct 2019 18:58:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Kernel config for fuzz testing.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>
References: <20190820222403.GB8120@kroah.com>
 <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
 <20190822133538.GA16793@kroah.com>
 <e8d3ce30-8c61-048e-2606-f8a4e8f08d87@i-love.sakura.ne.jp>
 <20190822164249.GA12551@kroah.com>
 <CACT4Y+Z0yCAwie83Oqd7XBNgQjWtEkuEg5WJCd6rW-ZMWqosxg@mail.gmail.com>
 <433f12f7-cc17-c88b-4f26-7f45eee42884@i-love.sakura.ne.jp>
 <CACT4Y+YCNR5_M29juV9-2UDj55BJVuYbj7bzbjtMDM_odut1Pg@mail.gmail.com>
 <f89b6329-37f5-e0ac-03aa-a58edc4267e4@i-love.sakura.ne.jp>
Message-ID: <3e4e2b6b-7828-54ab-cf28-db1a396d7e20@i-love.sakura.ne.jp>
Date:   Tue, 8 Oct 2019 18:57:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f89b6329-37f5-e0ac-03aa-a58edc4267e4@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/23 17:17, Tetsuo Handa wrote:
> On 2019/08/23 8:59, Dmitry Vyukov wrote:
>>> Can't we introduce a kernel config which selectively blocks specific actions?
>>> If we don't need to worry about bypassing blacklist checks, we will be able to
>>> enable syz_execute_func() again.
>>
>>
>> We can consider this, but we need some set of good use cases first.
>> For /dev/{mem,kmem} we disable them with config, right?
> 
> /dev/{mem,kmem} can be disabled by kernel config options. But
> 
>>                                                         That looks
>> like the right thing to do because we don't want fuzzer to do anything
>> with these files anyway.
> 
> I don't think so. To examine as corner as possible (e.g. lock dependency),
> I consider that even doing
> 
> ----------
> +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
> +static char dummybuf[PAGE_SIZE];
> +#endif
> ----------
> 
> ----------
>                         ptr = xlate_dev_mem_ptr(p);
>                         if (!ptr) {
>                                 if (written)
>                                         break;
>                                 return -EFAULT;
>                         }
> +#ifndef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
>                         copied = copy_from_user(ptr, buf, sz);
> +#else
> +                       copied = copy_from_user(dummybuf, buf, min(sizeof(dummybuf), sz));
> +#endif
>                         unxlate_dev_mem_ptr(p, ptr);
> ----------
> 
> makes sense, for copy_from_user() might find new lock dependency
> which would otherwise be unnoticed.
> 
>>                          So this won't be a good use case for
>> CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING.
>> Fuzzer can also reliably filter out based on syscall numbers of
>> top-level argument values. The potential problem is with (1)
>> pointers/indirect memory and (2) where blacklisting some top-level
>> argument values would backlist too much (e.g. prohibiting 3rd ioctl
>> argument 0 entirely).
> 
> I consider that functions that freezes processes/filesystems, 
> reboots/shutdowns a system, changes console loglevels can be blocked
> as well. Trying to examine up to last-second conditional branches will
> catch more bugs (e.g. bugs in error recovery paths).
> 

A USB fuzz test is triggering SysRq-t until RCU stall happens. ;-)
Can we introduce a kernel config (for linux.git) which selectively
blocks specific actions?

https://syzkaller.appspot.com/text?tag=CrashLog&x=12eb1e67600000

[  563.439044][    C1] ksoftirqd/1     R  running task    28264    16      2 0x80004008
[  563.447037][    C1] Call Trace:
[  563.450321][    C1]  sched_show_task.cold+0x2e0/0x359
[  563.455502][    C1]  show_state_filter+0x164/0x209
[  563.460421][    C1]  ? fn_caps_on+0x90/0x90
[  563.464730][    C1]  k_spec+0xdc/0x120
[  563.468605][    C1]  kbd_event+0x927/0x3790
[  563.472914][    C1]  ? k_pad+0x720/0x720
[  563.476964][    C1]  ? mark_held_locks+0xe0/0xe0
[  563.481791][    C1]  ? sysrq_filter+0xdf/0xeb0
[  563.486359][    C1]  ? k_pad+0x720/0x720
[  563.490419][    C1]  input_to_handler+0x3b6/0x4c0
[  563.495247][    C1]  input_pass_values.part.0+0x2e3/0x720
[  563.500770][    C1]  input_repeat_key+0x1ee/0x2c0
[  563.505622][    C1]  ? input_dev_suspend+0x80/0x80
[  563.510535][    C1]  ? rcu_read_lock_bh_held+0xb0/0xb0
[  563.515805][    C1]  call_timer_fn+0x179/0x650
[  563.520385][    C1]  ? input_dev_suspend+0x80/0x80
[  563.525389][    C1]  ? msleep_interruptible+0x130/0x130
[  563.531528][    C1]  ? rcu_read_lock_sched_held+0x9c/0xd0
[  563.537058][    C1]  ? rcu_read_lock_bh_held+0xb0/0xb0
[  563.542334][    C1]  ? _raw_spin_unlock_irq+0x24/0x30
[  563.547519][    C1]  ? input_dev_suspend+0x80/0x80
[  563.552443][    C1]  run_timer_softirq+0x5e3/0x1490
[  563.557454][    C1]  ? add_timer+0x7a0/0x7a0
[  563.561853][    C1]  ? rcu_read_lock_sched_held+0x9c/0xd0
[  563.567377][    C1]  ? rcu_read_lock_bh_held+0xb0/0xb0
[  563.572644][    C1]  __do_softirq+0x221/0x912
[  563.577147][    C1]  ? takeover_tasklets+0x720/0x720
[  563.582246][    C1]  run_ksoftirqd+0x1f/0x40
[  563.586638][    C1]  smpboot_thread_fn+0x3e8/0x850
[  563.591640][    C1]  ? smpboot_unregister_percpu_thread+0x190/0x190
[  563.598031][    C1]  ? __kthread_parkme+0x10a/0x1c0
[  563.603031][    C1]  ? smpboot_unregister_percpu_thread+0x190/0x190
[  563.609440][    C1]  kthread+0x318/0x420
[  563.613746][    C1]  ? kthread_create_on_node+0xf0/0xf0
[  563.619092][    C1]  ret_from_fork+0x24/0x30
