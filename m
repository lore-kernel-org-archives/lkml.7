Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC46C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C2C206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKNG7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 01:59:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbfKNG7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 01:59:15 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1F858AD4A2CE2703F348;
        Thu, 14 Nov 2019 14:59:13 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 14:59:05 +0800
Subject: Re: [PATCH] debugfs: fix potential infinite loop in
 debugfs_remove_recursive
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <oleg@redhat.com>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>,
        <chenxiang66@hisilicon.com>, <xiexiuqi@huawei.com>
References: <1572528884-67565-1-git-send-email-yukuai3@huawei.com>
 <20191113151755.7125e914@gandalf.local.home>
 <a399ae58-a467-3ff9-5a01-a4a2cdcf4fd6@huawei.com>
 <20191113214307.29a8d001@oasis.local.home>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <0ceb4529-5238-e7fc-2b5b-d2f0bdeb706e@huawei.com>
Date:   Thu, 14 Nov 2019 14:59:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191113214307.29a8d001@oasis.local.home>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/14 10:43, Steven Rostedt wrote:
> On Thu, 14 Nov 2019 10:01:23 +0800
> "yukuai (C)" <yukuai3@huawei.com> wrote:
> 
> 
>> Do you agree with that list_empty(&chile->d_subdirs) here is not
>> appropriate? Since it can't skip the subdirs that is not
>> simple_positive(simple_positive() will return false), which is the
>> reason of infinite loop.
> 
> I do agree that simple_empty() is wrong, for the reasons you pointed out.
> 
>>>> +		if (!simple_empty(child)) {
>>>
>>> Have you tried this with lockdep enabled? I'm thinking that you might
>>> get a splat with holding parent->d_lock and simple_empty(child) taking
>>> the child->d_lock.
>> The locks are taken and released in the right order:
>> take parent->d_lock
>> 	take child->d_lock
>> 		list_for_each_entry(c, &child->d_sundirs, d_child)
>> 			take c->d_lock
>> 			release c->d_lock
>> 	release child->d_lock
>> release parent->d_lock
>> I don't see anything wrong, am I missing something?
> 
> It should be fine, my worry is that we may be missing a lockdep
> annotation, that might confuse lockdep, as lockdep may see this as the
> same type of lock being taken, and wont know the order.
> 
> Have you tried this patch with lockdep enabled and tried to hit this
> code path?
> 
> -- Steve
> 
> .
> 
You are right, I get the results with lockdep enabled:
[   64.314748] ============================================
[   64.315568] WARNING: possible recursive locking detected
[   64.316549] 5.4.0-rc7-dirty #5 Tainted: G           O
[   64.317398] --------------------------------------------
[   64.318230] rmmod/2607 is trying to acquire lock:
[   64.318982] ffff88812c8d01e8 
(&(&dentry->d_lockref.lock)->rlock){+.+.}, at: simple_empty+0x2c/0xf0
[   64.320539]
[   64.320539] but task is already holding lock:
[   64.321466] ffff88812c8d00a8 
(&(&dentry->d_lockref.lock)->rlock){+.+.}, at: 
debugfs_remove_recursive+0x7a/0x260
[   64.323066]
[   64.323066] other info that might help us debug this:
[   64.324200]  Possible unsafe locking scenario:
[   64.324200]
[   64.325166]        CPU0
[   64.325569]        ----
[   64.325966]   lock(&(&dentry->d_lockref.lock)->rlock);
[   64.326790]   lock(&(&dentry->d_lockref.lock)->rlock);
[   64.327604]
[   64.327604]  *** DEADLOCK ***
[   64.327604]
[   64.328675]  May be due to missing lock nesting notation
[   64.328675]
[   64.329758] 2 locks held by rmmod/2607:
[   64.330373]  #0: ffff88812c8ba630 (&sb->s_type->i_mutex_key#3){++++}, 
at: debugfs_remove_recursive+0x6a/0x260
[   64.331997]  #1: ffff88812c8d00a8 
(&(&dentry->d_lockref.lock)->rlock){+.+.}, at: 
debugfs_remove_recursive+0x7a/0x260
[   64.333713]
[   64.333713] stack backtrace:
[   64.334412] CPU: 2 PID: 2607 Comm: rmmod Tainted: G           O 
5.4.0-rc7-dirty #5
[   64.335688] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[   64.337582] Call Trace:
[   64.337999]  dump_stack+0xd6/0x13a
[   64.338554]  __lock_acquire+0x19b1/0x1a70
[   64.339205]  lock_acquire+0x10a/0x2a0
[   64.339821]  ? simple_empty+0x2c/0xf0
[   64.340503]  _raw_spin_lock+0x50/0xd0
[   64.341097]  ? simple_empty+0x2c/0xf0
[   64.341693]  simple_empty+0x2c/0xf0
[   64.342258]  debugfs_remove_recursive+0xef/0x260
[   64.343755]  hisi_sas_test_exit+0x26/0x30 [hisi_sas_test]
[   64.344732]  __x64_sys_delete_module+0x258/0x330
[   64.345474]  ? do_syscall_64+0x74/0x530
[   64.346094]  ? trace_hardirqs_on+0x6a/0x1e0
[   64.346766]  do_syscall_64+0xcc/0x530
[   64.347349]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   64.348265] RIP: 0033:0x7f2418459fc7
[   64.348841] Code: 73 01 c3 48 8b 0d c1 de 2b 00 f7 d8 64 89 01 48 83 
c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 008
[   64.351789] RSP: 002b:00007fffbc2b0ab8 EFLAGS: 00000206 ORIG_RAX: 
00000000000000b0
[   64.353106] RAX: ffffffffffffffda RBX: 00007fffbc2b0b18 RCX: 
00007f2418459fc7
[   64.354238] RDX: 000000000000000a RSI: 0000000000000800 RDI: 
000055b1e1d84258
[   64.355377] RBP: 000055b1e1d841f0 R08: 00007fffbc2afa31 R09: 
0000000000000000
[   64.356628] R10: 00007f24184cc260 R11: 0000000000000206 R12: 
00007fffbc2b0ce0
[   64.357760] R13: 00007fffbc2b13d6 R14: 000055b1e1d83010 R15: 
000055b1e1d841f0

The warning will disappeare by adding 
lockdep_set_novalidate_class(&child->d_lock) before calling 
simple_empty(child). But I'm not sure It's the right modfication.

Thanks
Yu Kuai

