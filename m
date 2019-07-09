Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F996C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D49D2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nBGukRoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGIBuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:50:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44541 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGIBun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:50:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so16220182qtg.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/tmjMHoX1wUcOkmymLI5sM6bLLUZBMex7PzlSWYCm9A=;
        b=nBGukRoT769K6qqJA4oKQZbuzR+KQdXB9GChg36UkdeBxvpQDy6kPuWgQCbVVYUiLS
         dPgLGiZW8ZShDKZ5L7xi+v97hvLp8VLaLzuVHs29yvU+8gKhcH96m89AZWdZ3ofZRkaQ
         RlBSAAyDEIDs4nRr0DOxUokLcTQKVwc8nXLn8roZKjYfpRaLUQbC1j3q/KftXt5nMA5u
         AMBqZplG035mNv04PYhaeuJfTeSSk3P1ic0UYaUIbfRpHM/inMB+t3pIhiUfiy0UKE/r
         Zphbei3TQtjIxtAu9QpiiHkVN4bVHL3FHXFhIgxUiShvrAyWEPG/Up8J0QOoT4AAoT3y
         5JdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/tmjMHoX1wUcOkmymLI5sM6bLLUZBMex7PzlSWYCm9A=;
        b=sJ5EFhsrTQ3ZfcmXNy2GYql379xjUTquEw61V5YxgZCINS7KqzmYBzTumPjbgYIK/x
         tPMrDBEwVI/N8uA4nIOkvBAxourQW7mhOqlhABiiWc5zfatO//m9WCNetAhIT2nf7M6R
         HhqsHIqzS8d4oJfnQcr0vrYdPEH1uXpf4VBQycie7kGVbU80YrnZ4YNrEgnAXGKyGxyj
         M2C/9RQgeBZvfcSCZBOAKfdFZwCSWl8881WHIvrnud9WDGAV/26SzQmttirWp2qPrqaX
         6GOxw7TztrFt/KAiNUFP9wd8qL9D2/MuCc/l0hcr3Ea5NzSsTH5tr5DGgZ4dvEnbFyZB
         HfpA==
X-Gm-Message-State: APjAAAWQkAjskpeih9mwDCn4RG/WtH0Tf90WdE+CZTxWWd+xy4jZcFXs
        yzrMpja4L8bjsxoyYlf2RApB0z76ULd7dA==
X-Google-Smtp-Source: APXvYqzNWOCZIo0OBNc6XF18OReDz2JRlJAqh41equPD4E9o7De456nzK600wc11usfZY6MR3jxinA==
X-Received: by 2002:a05:6214:1312:: with SMTP id a18mr12611690qvv.241.1562637042479;
        Mon, 08 Jul 2019 18:50:42 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b202sm78362qkg.83.2019.07.08.18.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 18:50:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] locking/lockdep: Fix lock IRQ usage initialization bug
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAHttsrbQuHYEYYgx+c7-Q=ffPxoqRQ1PfZ5bhWNhuMAeR9LvuQ@mail.gmail.com>
Date:   Mon, 8 Jul 2019 21:50:40 -0400
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11BCE650-20B4-4956-B3CD-7E5F5A13409A@lca.pw>
References: <20190610055258.6424-1-duyuyang@gmail.com>
 <1562607152.8510.5.camel@lca.pw>
 <CAHttsrbQuHYEYYgx+c7-Q=ffPxoqRQ1PfZ5bhWNhuMAeR9LvuQ@mail.gmail.com>
To:     Yuyang Du <duyuyang@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 8, 2019, at 9:21 PM, Yuyang Du <duyuyang@gmail.com> wrote:
>=20
> The problem should have been fixed with this in that pull:
>=20
> locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS &&
> CONFIG_PROVE_LOCKING
>=20
> and this is a better fix than mine.

I don=E2=80=99t think so. That commit was included in today=E2=80=99s =
linux-next, but I can still reproduce the issue there.

[ 8872.727085] DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) !=3D=
 nr_unused)
[ 8872.727113] WARNING: CPU: 60 PID: 124801 at =
kernel/locking/lockdep_proc.c:249 lockdep_stats_show+0xe44/0x11e0
[ 8872.727157] Modules linked in: brd ext4 crc16 mbcache jbd2 loop =
i2c_opal i2c_core ip_tables x_tables xfs sd_mod ahci libahci tg3 =
firmware_class libata libphy dm_mirror dm_region_hash dm_log dm_mod =
[last unloaded: dummy_del_mod]
[ 8872.727213] CPU: 60 PID: 124801 Comm: proc01 Tainted: G        W  O   =
   5.2.0-next-20190708+ #1
[ 8872.727253] NIP:  c0000000001a97b4 LR: c0000000001a97b0 CTR: =
c0000000008c4660
[ 8872.727293] REGS: c000001c2e84f8e0 TRAP: 0700   Tainted: G        W  =
O       (5.2.0-next-20190708+)
[ 8872.727326] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: =
28888402  XER: 20040000
[ 8872.727371] CFAR: c00000000011a0d4 IRQMASK: 0=20
               GPR00: c0000000001a97b0 c000001c2e84fb70 c0000000016f8b00 =
0000000000000044=20
               GPR04: c00000000172c258 c0000000001b9288 4e5241575f534b43 =
75626564284e4f5f=20
               GPR08: 0000001ffdd10000 0000000000000000 0000000000000000 =
212029736b636f6c=20
               GPR12: 756e755f726e203d c000001ffffce400 0000000000000000 =
c0000000015bd610=20
               GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000dfd=20
               GPR20: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
               GPR24: 0000000000000000 0000000000000000 0000000000000000 =
c000001fb7d0f0a8=20
               GPR28: 0000000000000000 c00000000172c278 c00000000172c4c4 =
c00000000172ba18=20
[ 8872.727698] NIP [c0000000001a97b4] lockdep_stats_show+0xe44/0x11e0
[ 8872.727742] LR [c0000000001a97b0] lockdep_stats_show+0xe40/0x11e0
[ 8872.727775] Call Trace:
[ 8872.727800] [c000001c2e84fb70] [c0000000001a97b0] =
lockdep_stats_show+0xe40/0x11e0 (unreliable)
[ 8872.727831] [c000001c2e84fca0] [c000000000492434] =
seq_read+0x1d4/0x620
[ 8872.727886] [c000001c2e84fd30] [c000000000515520] =
proc_reg_read+0x90/0x130
[ 8872.727938] [c000001c2e84fd60] [c000000000452d6c] =
__vfs_read+0x3c/0x70
[ 8872.727989] [c000001c2e84fd80] [c000000000452e5c] vfs_read+0xbc/0x1a0
[ 8872.728033] [c000001c2e84fdd0] [c0000000004532ec] =
ksys_read+0x7c/0x140
[ 8872.728073] [c000001c2e84fe20] [c00000000000ae08] =
system_call+0x5c/0x70
[ 8872.728126] Instruction dump:
[ 8872.728161] 419ef3b0 3d220003 392974fc 81290000 2f890000 409ef39c =
3c82ff33 3c62ff33=20
[ 8872.728194] 38841af8 386308e8 4bf708c1 60000000 <0fe00000> 4bfff37c =
60000000 39200000=20
[ 8872.728251] ---[ end trace 42d16c13415f9f32 ]---

>=20
> Thanks,
> Yuyang
>=20
> On Tue, 9 Jul 2019 at 01:32, Qian Cai <cai@lca.pw> wrote:
>>=20
>> I saw Ingo send a pull request to Linus for 5.3 [1] includes the =
offensive
>> commit "locking/lockdep: Consolidate lock usage bit initialization" =
but did not
>> include this patch.
>>=20
>> [1] https://lore.kernel.org/lkml/20190708093516.GA57558@gmail.com/
>>=20
>> On Mon, 2019-06-10 at 13:52 +0800, Yuyang Du wrote:
>>> The commit:
>>>=20
>>>  091806515124b20 ("locking/lockdep: Consolidate lock usage bit
>>> initialization")
>>>=20
>>> misses marking LOCK_USED flag at IRQ usage initialization when
>>> CONFIG_TRACE_IRQFLAGS
>>> or CONFIG_PROVE_LOCKING is not defined. Fix it.
>>>=20
>>> Reported-by: Qian Cai <cai@lca.pw>
>>> Signed-off-by: Yuyang Du <duyuyang@gmail.com>
>>> ---
>>> kernel/locking/lockdep.c | 110 =
+++++++++++++++++++++++-----------------------
>>> -
>>> 1 file changed, 53 insertions(+), 57 deletions(-)
>>>=20
>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>> index 48a840a..c3db987 100644
>>> --- a/kernel/locking/lockdep.c
>>> +++ b/kernel/locking/lockdep.c
>>> @@ -3460,9 +3460,61 @@ void trace_softirqs_off(unsigned long ip)
>>>              debug_atomic_inc(redundant_softirqs_off);
>>> }
>>>=20
>>> +static inline unsigned int task_irq_context(struct task_struct =
*task)
>>> +{
>>> +     return 2 * !!task->hardirq_context + !!task->softirq_context;
>>> +}
>>> +
>>> +static int separate_irq_context(struct task_struct *curr,
>>> +             struct held_lock *hlock)
>>> +{
>>> +     unsigned int depth =3D curr->lockdep_depth;
>>> +
>>> +     /*
>>> +      * Keep track of points where we cross into an interrupt =
context:
>>> +      */
>>> +     if (depth) {
>>> +             struct held_lock *prev_hlock;
>>> +
>>> +             prev_hlock =3D curr->held_locks + depth-1;
>>> +             /*
>>> +              * If we cross into another context, reset the
>>> +              * hash key (this also prevents the checking and the
>>> +              * adding of the dependency to 'prev'):
>>> +              */
>>> +             if (prev_hlock->irq_context !=3D hlock->irq_context)
>>> +                     return 1;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +#else /* defined(CONFIG_TRACE_IRQFLAGS) && =
defined(CONFIG_PROVE_LOCKING) */
>>> +
>>> +static inline
>>> +int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
>>> +             enum lock_usage_bit new_bit)
>>> +{
>>> +     WARN_ON(1); /* Impossible innit? when we don't have =
TRACE_IRQFLAG */
>>> +     return 1;
>>> +}
>>> +
>>> +static inline unsigned int task_irq_context(struct task_struct =
*task)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>> +static inline int separate_irq_context(struct task_struct *curr,
>>> +             struct held_lock *hlock)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>> +#endif /* defined(CONFIG_TRACE_IRQFLAGS) && =
defined(CONFIG_PROVE_LOCKING) */
>>> +
>>> static int
>>> mark_usage(struct task_struct *curr, struct held_lock *hlock, int =
check)
>>> {
>>> +#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
>>>      if (!check)
>>>              goto lock_used;
>>>=20
>>> @@ -3510,6 +3562,7 @@ void trace_softirqs_off(unsigned long ip)
>>>      }
>>>=20
>>> lock_used:
>>> +#endif
>>>      /* mark it as used: */
>>>      if (!mark_lock(curr, hlock, LOCK_USED))
>>>              return 0;
>>> @@ -3517,63 +3570,6 @@ void trace_softirqs_off(unsigned long ip)
>>>      return 1;
>>> }
>>>=20
>>> -static inline unsigned int task_irq_context(struct task_struct =
*task)
>>> -{
>>> -     return 2 * !!task->hardirq_context + !!task->softirq_context;
>>> -}
>>> -
>>> -static int separate_irq_context(struct task_struct *curr,
>>> -             struct held_lock *hlock)
>>> -{
>>> -     unsigned int depth =3D curr->lockdep_depth;
>>> -
>>> -     /*
>>> -      * Keep track of points where we cross into an interrupt =
context:
>>> -      */
>>> -     if (depth) {
>>> -             struct held_lock *prev_hlock;
>>> -
>>> -             prev_hlock =3D curr->held_locks + depth-1;
>>> -             /*
>>> -              * If we cross into another context, reset the
>>> -              * hash key (this also prevents the checking and the
>>> -              * adding of the dependency to 'prev'):
>>> -              */
>>> -             if (prev_hlock->irq_context !=3D hlock->irq_context)
>>> -                     return 1;
>>> -     }
>>> -     return 0;
>>> -}
>>> -
>>> -#else /* defined(CONFIG_TRACE_IRQFLAGS) && =
defined(CONFIG_PROVE_LOCKING) */
>>> -
>>> -static inline
>>> -int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
>>> -             enum lock_usage_bit new_bit)
>>> -{
>>> -     WARN_ON(1); /* Impossible innit? when we don't have =
TRACE_IRQFLAG */
>>> -     return 1;
>>> -}
>>> -
>>> -static inline int
>>> -mark_usage(struct task_struct *curr, struct held_lock *hlock, int =
check)
>>> -{
>>> -     return 1;
>>> -}
>>> -
>>> -static inline unsigned int task_irq_context(struct task_struct =
*task)
>>> -{
>>> -     return 0;
>>> -}
>>> -
>>> -static inline int separate_irq_context(struct task_struct *curr,
>>> -             struct held_lock *hlock)
>>> -{
>>> -     return 0;
>>> -}
>>> -
>>> -#endif /* defined(CONFIG_TRACE_IRQFLAGS) && =
defined(CONFIG_PROVE_LOCKING) */
>>> -
>>> /*
>>>  * Mark a lock with a usage bit, and validate the state transition:
>>>  */

