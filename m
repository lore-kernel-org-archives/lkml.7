Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ECEC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C21206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfLPPgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:36:06 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62130 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfLPPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:36:05 -0500
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBGFZ10r004944;
        Tue, 17 Dec 2019 00:35:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Tue, 17 Dec 2019 00:35:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBGFZ17Y004938
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 17 Dec 2019 00:35:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
Date:   Tue, 17 Dec 2019 00:35:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191216114636.GB1515069@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/16 20:46, Greg Kroah-Hartman wrote:
> Why isn't it the job of the fuzzers to keep a blacklist of things they
> should not do without expecting the system to crash?  Why is it up to
> the kernel to do that work for them?

Details will be explained by Dmitry Vyukov.
In short, fuzzer wants cooperation with the kernel.

>> @@ -633,6 +633,9 @@ static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
>>  	     kbd->kbdmode == VC_OFF) &&
>>  	     value != KVAL(K_SAK))
>>  		return;		/* SAK is allowed even in raw mode */
>> +	/* Repeating SysRq-t forever causes RCU stalls. */
>> +	if (IS_ENABLED(CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING))
>> +		return;
> 
> That does not make sense.  What does this comment mean?

https://syzkaller.appspot.com/text?tag=CrashLog&x=12eb1e67600000 (already gone)
reported that a USB fuzz test is triggering SysRq-t until RCU stall happens. We don't
need to disable whole module only for avoiding RCU stall due to crazy SysRq-t requests.

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



>> diff --git a/fs/ioctl.c b/fs/ioctl.c
>> index 2f5e4e5b97e1..f879aa94b118 100644
>> --- a/fs/ioctl.c
>> +++ b/fs/ioctl.c
>> @@ -601,6 +601,11 @@ static int ioctl_fsfreeze(struct file *filp)
>>  	if (sb->s_op->freeze_fs == NULL && sb->s_op->freeze_super == NULL)
>>  		return -EOPNOTSUPP;
>>  
>> +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
>> +	/* Freezing filesystems causes hung tasks. */
>> +	return -EBUSY;
>> +#endif
> 
> ick ick ick.

syzbot was failing to blacklist ioctl(FIFREEZE) due to a bug fixed at
https://lore.kernel.org/linux-fsdevel/03633af8-fab8-a985-c215-f619ea4ded08@I-love.SAKURA.ne.jp/ .

Then, syzbot was not blacklisting ioctl(EXT4_IOC_SHUTDOWN) which was fixed at
https://github.com/google/syzkaller/commit/61ed43a86a3721708aeeee72b23bfa1eacd921b2 .

These bugs could be fixed (in a whack-a-mole manner) but

>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 1ef6f75d92f1..9a2f95a78fef 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1198,6 +1198,14 @@ MODULE_PARM_DESC(ignore_loglevel,
>>  
>>  static bool suppress_message_printing(int level)
>>  {
>> +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
>> +	/*
>> +	 * Changing console_loglevel causes "no output". But ignoring
>> +	 * console_loglevel is easier than preventing change of
>> +	 * console_loglevel.
>> +	 */
>> +	return (level >= CONSOLE_LOGLEVEL_DEFAULT && !ignore_loglevel);
>> +#endif
> 
> I don't understand the need for this change at all.

this case was too hard to blacklist, as explained at
https://lore.kernel.org/lkml/4d1a4b51-999b-63c6-5ce3-a704013cecb6@i-love.sakura.ne.jp/ .
syz_execute_func() can find deeper bug by executing arbitrary binary code, but
we cannot blacklist specific syscalls/arguments for syz_execute_func() testcases.
Unless we guard on the kernel side, we won't be able to re-enable syz_execute_func()
testcases.

> 
>>  	return (level >= console_loglevel && !ignore_loglevel);
>>  }
>>  

Also, although ability to interpret kernel messages was improved by CONFIG_PRINTK_CALLER
config option, we still cannot tell whether some string such as "BUG:" "WARNING:" came from
BUG(), BUG_ON(), WARN(), WARN_ON() etc. Therefore, modules emitting such string causes
syzbot to report as crash. For example, TOMOYO security module introduced
CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING in order to allow syzbot to fuzz TOMOYO
security module, and then extended CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING to
prevent TOMOYO from emitting "WARNING:" string so that syzbot will not detect it as crash.


commit e80b18599a39a625bc8b2e39ba3004a62f78805a
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Fri Apr 12 20:04:54 2019 +0900

    tomoyo: Add a kernel config option for fuzzing testing.

    syzbot is reporting kernel panic triggered by memory allocation fault
    injection before loading TOMOYO's policy [1]. To make the fuzzing tests
    useful, we need to assign a profile other than "disabled" (no-op) mode.
    Therefore, let's allow syzbot to load TOMOYO's built-in policy for
    "learning" mode using a kernel config option. This option must not be
    enabled for kernels built for production system, for this option also
    disables domain/program checks when modifying policy configuration via
    /sys/kernel/security/tomoyo/ interface.

    [1] https://syzkaller.appspot.com/bug?extid=29569ed06425fcf67a95

    Reported-by: syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
    Reported-by: syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>
    Reported-by: syzbot <syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com>
    Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    Signed-off-by: James Morris <jamorris@linux.microsoft.com>

commit 4ad98ac46490d5f8441025930070eaf028cfd0f2
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Tue May 7 20:34:22 2019 +0900

    tomoyo: Don't emit WARNING: string while fuzzing testing.

    Commit cff0e6c3ec3e6230 ("tomoyo: Add a kernel config option for fuzzing
    testing.") enabled the learning mode, but syzkaller is detecting any
    "WARNING:" string as a crash. Thus, disable TOMOYO's quota warning if
    built for fuzzing testing.

    Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    Cc: Dmitry Vyukov <dvyukov@google.com>
    Signed-off-by: James Morris <jamorris@linux.microsoft.com>


As a result of these two patches, TOMOYO is now fuzzed by syzbot. But there are
other modules emitting these strings. We need to somehow make it possible to
distinguish whether these string came from BUG(), BUG_ON(), WARN(), WARN_ON() etc.
in a generically applicable way.



To summarize, syzbot wants a kernel config option for two purposes:

  (1) Allow syzkaller run testcases as far/deep as possible.

  (2) Prevent syzkaller from generating false alarms.

This is beyond merely maintaining blacklist on the fuzzer side.

