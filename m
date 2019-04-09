Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D29C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D1720830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L581bj+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDIPfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:35:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42473 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDIPfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:35:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id cv12so9606248plb.9;
        Tue, 09 Apr 2019 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pdhVh0QfJAzC6OGMy1VorrMB4DEvEZ0UwGjxwpVCIy8=;
        b=L581bj+cGpAdj9dnXBC+qlMaYUGOhGE7WnXpber2LwXx/WM2WmjgPQkCr9GoXlwptH
         BrgpsJ4Yqh+hEFW60kKA5CEWjvYbItTN80/bfK17Tmmqu5p8l2cqriML2mzHkM92xIi1
         iGoCdbdCEOA5oQwyHCEEAz8JSgn8OjxNm/DhaH10v5KF5EolSJn+L2gG9nMtVibeWZ5z
         Oo6xL0LiudlqqhKf/4b5KjmS1ucM5tpNGda2I10KikIjPFMRYtjnohyB7vZdbcRp8Vch
         1b7jUo27lhwKWtAUmvpuu+lPBDY4mrjeqWGeBFeo9tCG5+66ZdqxC04I8gObKFwTj+dK
         tMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pdhVh0QfJAzC6OGMy1VorrMB4DEvEZ0UwGjxwpVCIy8=;
        b=AxzpIPLuR8ecwOyGbDx8MGty3DT9iYiD11Af+scagLDd2q2cOMBs4miDPKyKTc+zgk
         wN+LYpxMaZAJxwP7tjqNPUgn92QEDVSRDyeCYfnUd19noT5AzGN0VtKOyV/RaLsSb+Es
         PwvMZd5gDNeFAHZOEhBWECaIrrAyWw/RMwyXRRtd5loj7y1NsfXRvYpf8s1FCBOngcRR
         g0A41o8igtTwfBXJxM7jpcqQbnFnuo64zgRSjVvAsnv/tym8A681Ni6ZJqNUZ5zEzWMt
         ktykhP3zuZd64mQQ/vn/aWB6dpNIL9tuKsWRFG1TGjdoY9FJ48PEaIce99wgNTaVBonY
         m/8Q==
X-Gm-Message-State: APjAAAUvyEl78PlI8G67F2LRHGJ1wpFpuaC7ZEH2k94bsUhrQCBoVEsZ
        7pAu90KKKp7mxIPHPCZMeYA=
X-Google-Smtp-Source: APXvYqzUWtE3LS0sXH1aq/gNjf4SljmryNKQRX2monRENb3WXPpLutSdiRiQTP7CiJvdvO2qg+FrUg==
X-Received: by 2002:a17:902:6b8a:: with SMTP id p10mr37549983plk.109.1554824101613;
        Tue, 09 Apr 2019 08:35:01 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id h1sm21734138pgs.67.2019.04.09.08.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:35:00 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in __dev_map_entry_free
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     syzbot <syzbot+457d3e2ffbcf31aee5c0@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <0000000000009cd09a056f1451d1@google.com>
 <cc82200a-6374-0a87-a3e0-471d04a8306a@gmail.com>
 <CAADnVQKbZgXDvbwSREYYGTeTX42oD-Q4UrKRjowTVsdktu4t4w@mail.gmail.com>
 <20190404104756.6b591ad6@carbon> <87mukzxmf6.fsf@toke.dk>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4c36a368-35de-edd3-2774-9a8747b53ade@gmail.com>
Date:   Tue, 9 Apr 2019 08:34:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87mukzxmf6.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2019 07:50 AM, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <brouer@redhat.com> writes:
> 
>> On Wed, 3 Apr 2019 20:59:24 -0700
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>
>>> On Tue, Apr 2, 2019 at 1:03 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 06/20/2018 08:19 AM, syzbot wrote:  
>>>>> Hello,
>>>>>
>>>>> syzbot found the following crash on:
>>>>>
>>>>> HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
>>>>> git tree:       bpf-next
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15ad7d10400000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=457d3e2ffbcf31aee5c0
>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1195225f800000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171a7ce4400000
>>>>>
>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>> Reported-by: syzbot+457d3e2ffbcf31aee5c0@syzkaller.appspotmail.com
>>>>>
>>>>> ==================================================================
>>>>> BUG: KASAN: use-after-free in dev_map_flush_old kernel/bpf/devmap.c:365 [inline]
>>>>> BUG: KASAN: use-after-free in __dev_map_entry_free+0x2a8/0x300 kernel/bpf/devmap.c:379
>>>>> Read of size 8 at addr ffff8801b8da38c8 by task ksoftirqd/1/18
>>>>>
>>>>> CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 4.17.0+ #39
>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>>>> Call Trace:
>>>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>>>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>>>>>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>>>>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>>>>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>>>>>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>>>>>  dev_map_flush_old kernel/bpf/devmap.c:365 [inline]
>>>>>  __dev_map_entry_free+0x2a8/0x300 kernel/bpf/devmap.c:379
>>>>>  __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
>>>>>  rcu_do_batch kernel/rcu/tree.c:2558 [inline]
>>>>>  invoke_rcu_callbacks kernel/rcu/tree.c:2818 [inline]
>>>>>  __rcu_process_callbacks kernel/rcu/tree.c:2785 [inline]
>>>>>  rcu_process_callbacks+0xe9d/0x1760 kernel/rcu/tree.c:2802
>>>>>  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:284
>>>>>  run_ksoftirqd+0x86/0x100 kernel/softirq.c:645
>>>>>  smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
>>>>>  kthread+0x345/0x410 kernel/kthread.c:240
>>>>>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>>>>>
>>>>> Allocated by task 6675:
>>>>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>>>>  set_track mm/kasan/kasan.c:460 [inline]
>>>>>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>>>>>  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
>>>>>  kmalloc include/linux/slab.h:513 [inline]
>>>>>  kzalloc include/linux/slab.h:706 [inline]
>>>>>  dev_map_alloc+0x208/0x7f0 kernel/bpf/devmap.c:102
>>>>>  find_and_alloc_map kernel/bpf/syscall.c:129 [inline]
>>>>>  map_create+0x393/0x1010 kernel/bpf/syscall.c:453
>>>>>  __do_sys_bpf kernel/bpf/syscall.c:2351 [inline]
>>>>>  __se_sys_bpf kernel/bpf/syscall.c:2328 [inline]
>>>>>  __x64_sys_bpf+0x303/0x510 kernel/bpf/syscall.c:2328
>>>>>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
>>>>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>>
>>>>> Freed by task 26:
>>>>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>>>>  set_track mm/kasan/kasan.c:460 [inline]
>>>>>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>>>>>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>>>>>  __cache_free mm/slab.c:3498 [inline]
>>>>>  kfree+0xd9/0x260 mm/slab.c:3813
>>>>>  dev_map_free+0x4fa/0x670 kernel/bpf/devmap.c:191
>>>>>  bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:262
>>>>>  process_one_work+0xc64/0x1b70 kernel/workqueue.c:2153
>>>>>  worker_thread+0x181/0x13a0 kernel/workqueue.c:2296
>>>>>  kthread+0x345/0x410 kernel/kthread.c:240
>>>>>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>>>>>
>>>>> The buggy address belongs to the object at ffff8801b8da37c0
>>>>>  which belongs to the cache kmalloc-512 of size 512
>>>>> The buggy address is located 264 bytes inside of
>>>>>  512-byte region [ffff8801b8da37c0, ffff8801b8da39c0)
>>>>> The buggy address belongs to the page:
>>>>> page:ffffea0006e368c0 count:1 mapcount:0 mapping:ffff8801da800940 index:0xffff8801b8da3540
>>>>> flags: 0x2fffc0000000100(slab)
>>>>> raw: 02fffc0000000100 ffffea0007217b88 ffffea0006e30cc8 ffff8801da800940
>>>>> raw: ffff8801b8da3540 ffff8801b8da3040 0000000100000004 0000000000000000
>>>>> page dumped because: kasan: bad access detected
>>>>>
>>>>> Memory state around the buggy address:
>>>>>  ffff8801b8da3780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>>>>>  ffff8801b8da3800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb  
>>>>>> ffff8801b8da3880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb  
>>>>>                                               ^
>>>>>  ffff8801b8da3900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>>>  ffff8801b8da3980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>>>> ==================================================================
>>>>>
>>>>>
>>>>> ---
>>>>> This bug is generated by a bot. It may contain errors.
>>>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>>>
>>>>> syzbot will keep track of this bug report. See:
>>>>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
>>>>> syzbot can test patches for this bug, for details see:
>>>>> https://goo.gl/tpsmEJ#testing-patches  
>>>>
>>>>
>>>> What about something like :
>>>>
>>>>
>>>>
>>>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>>>> index 191b79948424f4b21b7aa120abc03801264bf0a6..1e525d70f83354e451b738ffb8e42d83b5fa932f 100644
>>>> --- a/kernel/bpf/devmap.c
>>>> +++ b/kernel/bpf/devmap.c
>>>> @@ -164,6 +164,9 @@ static void dev_map_free(struct bpf_map *map)
>>>>         bpf_clear_redirect_map(map);
>>>>         synchronize_rcu();
>>>>
>>>> +       /* Make sure prior __dev_map_entry_free() have completed. */
>>>> +       rcu_barrier();
>>>> +  
>>>
>>> Eric, Thank you for looking at it. The fix makes sense to me.
>>>
>>> Jesper, thoughts?
>>
>> First I though it looked strange to have a synchronize_rcu() followed
>> by a rcu_barrier().  But I think the fix is actually correct.  We do
>> need the rcu_barrier() call as it states "Wait until all in-flight
>> call_rcu() callbacks complete".   I wonder if we also/still need the
>> synchronize_rcu(), but I think so as it functions as a memory-barrier
>> across all CPUs (as in bpf_clear_redirect_map we visit all CPUs and
>> clear any left-over per_cpu_ptr redirect_info).
>>
>> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Eric, are you going to submit a proper patch for this? :)

Yes I will, I am back from vacation.

