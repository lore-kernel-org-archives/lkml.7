Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC27CC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6E821850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbfGRQUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:20:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:41036 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRQUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:20:24 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1ho98k-00084V-Td; Thu, 18 Jul 2019 19:20:19 +0300
Subject: Re: kasan: paging percpu + kasan causes a double fault
To:     Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>, Tejun Heo <tj@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190708150532.GB17098@dennisz-mbp>
 <CACT4Y+YevDd-y4Au33=mr-0-UQPy8NR0vmG8zSiCfmzx6gTB-w@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <912176db-f616-54cc-7665-94baa61ea11d@virtuozzo.com>
Date:   Thu, 18 Jul 2019 19:20:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YevDd-y4Au33=mr-0-UQPy8NR0vmG8zSiCfmzx6gTB-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/19 6:51 PM, Dmitry Vyukov wrote:
> On Mon, Jul 8, 2019 at 5:05 PM Dennis Zhou <dennis@kernel.org> wrote:
>>
>> Hi Andrey, Alexander, and Dmitry,
>>
>> It was reported to me that when percpu is ran with param
>> percpu_alloc=page or the embed allocation scheme fails and falls back to
>> page that a double fault occurs.
>>
>> I don't know much about how kasan works, but a difference between the
>> two is that we manually reserve vm area via vm_area_register_early().
>> I guessed it had something to do with the stack canary or the irq_stack,
>> and manually mapped the shadow vm area with kasan_add_zero_shadow(), but
>> that didn't seem to do the trick.
>>
>> RIP resolves to the fixed_percpu_data declaration.
>>
>> Double fault below:
>> [    0.000000] PANIC: double fault, error_code: 0x0
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc7-00007-ge0afe6d4d12c-dirty #299
>> [    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
>> [    0.000000] RIP: 0010:no_context+0x38/0x4b0
>> [    0.000000] Code: df 41 57 41 56 4c 8d bf 88 00 00 00 41 55 49 89 d5 41 54 49 89 f4 55 48 89 fd 4c8
>> [    0.000000] RSP: 0000:ffffc8ffffffff28 EFLAGS: 00010096
>> [    0.000000] RAX: dffffc0000000000 RBX: ffffc8ffffffff50 RCX: 000000000000000b
>> [    0.000000] RDX: fffff52000000030 RSI: 0000000000000003 RDI: ffffc90000000130
>> [    0.000000] RBP: ffffc900000000a8 R08: 0000000000000001 R09: 0000000000000000
>> [    0.000000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
>> [    0.000000] R13: fffff52000000030 R14: 0000000000000000 R15: ffffc90000000130
>> [    0.000000] FS:  0000000000000000(0000) GS:ffffc90000000000(0000) knlGS:0000000000000000
>> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    0.000000] CR2: ffffc8ffffffff18 CR3: 0000000002e0d001 CR4: 00000000000606b0
>> [    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [    0.000000] Call Trace:
>> [    0.000000] Kernel panic - not syncing: Machine halted.
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc7-00007-ge0afe6d4d12c-dirty #299
>> [    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
>> [    0.000000] Call Trace:
>> [    0.000000]  <#DF>
>> [    0.000000]  dump_stack+0x5b/0x90
>> [    0.000000]  panic+0x17e/0x36e
>> [    0.000000]  ? __warn_printk+0xdb/0xdb
>> [    0.000000]  ? spurious_kernel_fault_check+0x1a/0x60
>> [    0.000000]  df_debug+0x2e/0x39
>> [    0.000000]  do_double_fault+0x89/0xb0
>> [    0.000000]  double_fault+0x1e/0x30
>> [    0.000000] RIP: 0010:no_context+0x38/0x4b0
>> [    0.000000] Code: df 41 57 41 56 4c 8d bf 88 00 00 00 41 55 49 89 d5 41 54 49 89 f4 55 48 89 fd 4c8
>> [    0.000000] RSP: 0000:ffffc8ffffffff28 EFLAGS: 00010096
>> [    0.000000] RAX: dffffc0000000000 RBX: ffffc8ffffffff50 RCX: 000000000000000b
>> [    0.000000] RDX: fffff52000000030 RSI: 0000000000000003 RDI: ffffc90000000130
>> [    0.000000] RBP: ffffc900000000a8 R08: 0000000000000001 R09: 0000000000000000
>> [    0.000000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
>> [ 0.000000] R13: fffff52000000030 R14: 0000000000000000 R15: ffffc90000000130
> 
> 
> Hi Dennis,
> 
> I don't have lots of useful info, but a naive question: could you stop
> using percpu_alloc=page with KASAN? That should resolve the problem :)
> We could even add a runtime check that will clearly say that this
> combintation does not work.
> 
> I see that setup_per_cpu_areas is called after kasan_init which is
> called from setup_arch. So KASAN should already map final shadow at
> that point.
> The only potential reason that I see is that setup_per_cpu_areas maps
> the percpu region at address that is not covered/expected by
> kasan_init. Where is page-based percpu is mapped? Is that covered by
> kasan_init?
> Otherwise, seeing the full stack trace of the fault may shed some light.
> 

percpu_alloc=page maps percpu areas into vmalloc, which don't have RW KASAN shadow mem.
irq stack are percpu thus we have GPF on attempt to poison stack redzones in irq.
