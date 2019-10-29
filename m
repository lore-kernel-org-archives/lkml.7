Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954EDCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726A520717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfJ2JJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:09:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60886 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbfJ2JJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:09:18 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0E42FDE524131C6977CF;
        Tue, 29 Oct 2019 17:09:14 +0800 (CST)
Received: from [127.0.0.1] (10.177.224.82) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 17:09:06 +0800
Subject: Re: [QUESTION] Hung task warning while running syzkaller test
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <patrick.bellasi@arm.com>, <tglx@linutronix.de>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <0d7aa66d-d2b9-775c-56b3-543d132fdb84@huawei.com>
 <1693d19e-56c7-9d6f-8e80-10fe82101cff@arm.com>
 <aa5d0f35-e707-f5e3-251e-f940c0b0232b@huawei.com>
 <4ca01869-7997-cfce-edce-e75337d3a6fa@arm.com>
 <abba880d-cfa6-3485-7831-9998db290396@huawei.com>
 <d7e9f62e-d7a6-50ec-6fb5-76ad136506df@arm.com>
 <4453942d-c4f2-bbbe-64a9-4313c0fccfbf@huawei.com>
Message-ID: <3588cd32-fed5-7a2e-3d8a-a7ed27b887dc@huawei.com>
Date:   Tue, 29 Oct 2019 17:09:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4453942d-c4f2-bbbe-64a9-4313c0fccfbf@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.224.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PS: Both preemption enabled or disabled, and the hung task will appear.

在 2019/10/29 10:25, Zhihao Cheng 写道:
> I don't know much about the freezer mechanism of CGroup, but I tried it. I turned off all the CGroup related config options and reproduced the hung task on a fresh busybox-made root file system. I added rootfs in attachment. So, I guess hung task has nothing to do with CGroup(freezer).
>
>
> ~ # mount
> rootfs on / type rootfs (rw,size=2005040k,nr_inodes=501260)
> nodev on /proc type proc (rw,relatime)
> nodev on /sys type sysfs (rw,relatime)
> nodev on /dev type devtmpfs (rw,relatime,size=2005056k,nr_inodes=501264,mode=755)
> devpts on /dev/pts type devpts (rw,relatime,mode=600,ptmxmode=000)
>
> ---
>
> 2019/10/29 02:22:04 executed programs: 190
> 2019/10/29 02:22:10 executed programs: 191
> [  280.639337] INFO: task syz-executor.14:3190 blocked for more than 140 seconds.
> [  280.641762]       Not tainted 4.4.197-514.55.6.9.x86_64+ #276
> [  280.642746] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  280.644003] syz-executor.14 D ffff8800b3247c60 13864  3190   3189 0x00000000
> [  280.645190]  ffff8800b3247c60 0000000000000006 000000007dc6b6e8 ffffffff00000000
> [  280.646469]  ffff880137071d80 ffff880138771d80 ffff8800b3248000 0000000000000246
> [  280.647750]  ffff8800b79117b0 ffff880138771d80 00000000ffffffff ffff8800b3247c78
> [  280.649015] Call Trace:
> [  280.649439]  [<ffffffff81b0b4f2>] schedule+0x32/0x90
> [  280.650250]  [<ffffffff81b0ba15>] schedule_preempt_disabled+0x15/0x20
> [  280.651302]  [<ffffffff81b0e94b>] mutex_lock_nested+0x17b/0x4f0
> [  280.652264]  [<ffffffff812f5d1e>] ? walk_component+0x23e/0x5f0
> [  280.653223]  [<ffffffff812f5d1e>] walk_component+0x23e/0x5f0
> [  280.654137]  [<ffffffff812f2db4>] ? inode_permission+0x14/0x50
> [  280.655083]  [<ffffffff812f6153>] ? link_path_walk+0x83/0x5d0
> [  280.656009]  [<ffffffff812f6feb>] ? path_lookupat+0x1b/0x120
> [  280.656923]  [<ffffffff812f7023>] path_lookupat+0x53/0x120
> [  280.657811]  [<ffffffff812f952f>] filename_lookup+0xaf/0x170
> [  280.658732]  [<ffffffff812e2052>] ? __check_object_size+0x102/0x1d7
> [  280.659744]  [<ffffffff8161c496>] ? strncpy_from_user+0x46/0x160
> [  280.660712]  [<ffffffff812f96c6>] user_path_at_empty+0x36/0x40
> [  280.661657]  [<ffffffff81316b73>] path_removexattr+0x43/0xb0
> [  280.662580]  [<ffffffff81005017>] ? trace_hardirqs_on_thunk+0x17/0x19
> [  280.663622]  [<ffffffff81317c90>] SyS_lremovexattr+0x10/0x20
> [  280.664537]  [<ffffffff81b129a1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
> [  280.665573] 1 lock held by syz-executor.14/3190:
> [  280.666322]  #0:  (&type->i_mutex_dir_key){+.+.+.}, at: [<ffffffff812f5d1e>] walk_component+0x23e/0x5f0
>
>
> 在 2019/10/29 1:54, Valentin Schneider 写道:
>> On 26/10/2019 03:48, Zhihao Cheng wrote:> 3. You can convert the repro file into a C program by 'syzprog' tool(see syzprog.c). Using compiled syzprog.c directly for testing did not show hung task, which confused me.
>> Good to know that you can get a readable program out of this, but that diff
>> in behaviour isn't reassuring.
>>
>> Also, I don't see anything in there that would try to play with cgroups - I
>> was mostly curious about the use of the freezer, but don't see any in the
>> C code. Out of curiosity I ran a similar kernel that I tried before (without
>> the right configs), and it doesn't complain about missing cgroup options...
>>
>> .

