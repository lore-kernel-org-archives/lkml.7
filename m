Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631A3C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187C120848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbkP7pZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfDNRdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 13:33:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46132 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNRdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 13:33:20 -0400
Received: by mail-io1-f67.google.com with SMTP id p23so12645992iol.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ot7oiR/0I5gGcMH7C7/6D5TcrNZO7HTLltt47TRGMbQ=;
        b=kbkP7pZXkqAxIyAmsFIbi9LRyeixt2QLP18pSbUpbc324zg2oEFP2hw51MJMEzTepi
         RLbHl7edWwI5vydk/NDXYdjQHIScZg4u+0W7GdUWOMyjaV7boA695aNqnGZmyY0BnwHK
         ua9tz+TojmOoNZLQ96wxsmYTmkWu2Qx/qEMKV+PM8yF6eI6j4xC4xJYzfdJj15O3z+f/
         cCgSDsWKFYBlZKDJUQ2dvsvGuxrRUShEFwm0Ki+aUKB3x7ApkQJSA2/9GiqC8MQeTabD
         kRPSbkD5zqkv8GUrv9CQstCa3eESVM3RZtkG2nPrI+pwHKtPgCMLPxltM9yMLVnh4jaH
         Lyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ot7oiR/0I5gGcMH7C7/6D5TcrNZO7HTLltt47TRGMbQ=;
        b=RTrhn/pi/5WD63pTqQ6NIislKn+bU5KCU7pnkJV1lupBqmnUhWl+yrpuQ6ubXTnODN
         xIahUpgj+stdWPayj6bZh6Dr4CGjZGuYaTS+HdOxgfPt9uXRPW8As3c538LxTEyZsv0w
         y1GRhJmB7qen9en5tN9jH5/zdlUpJZy32QMBc9Jr/kYRC1pAjxQ8WArT21Z+zH/y0eq6
         /P1wV0QxsNxzsIpVu+eRWbxBD66McBoZvhxBQ6NzbKyGIeOxr2Tg2SS9zfkyCWTqPWbu
         rw5YMlWDwRZdrDf8B7Fg6VH19eiRD0+y8rZV4THBetUNCQcRX7xZJ05UGLmqosLQC6bL
         9mqQ==
X-Gm-Message-State: APjAAAWWvCmT2h5x65CZ4HreXFQnh7Sj/J6hONI7vGXZIstKcB3Fdgl7
        /bOEBPKrlq2L6x26IRYfmYrVYrNh0ZiAXtdNIXS+FQfSFOdjwg==
X-Google-Smtp-Source: APXvYqw2lk2QiqUe/3N8lwen+Wn4XEL2TAzoLCfiuwdjqszFI1I2e0iwYVqfjJtxin53D5f9X8jc0oMgrygea/EG5dA=
X-Received: by 2002:a5e:8517:: with SMTP id i23mr44815253ioj.228.1555263198352;
 Sun, 14 Apr 2019 10:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsM8gjvh8x9QyzbrbnSb-NmWpmmEUJnFiFv5MaPkcG=Ubg@mail.gmail.com>
In-Reply-To: <CABXGCsM8gjvh8x9QyzbrbnSb-NmWpmmEUJnFiFv5MaPkcG=Ubg@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 14 Apr 2019 22:33:07 +0500
Message-ID: <CABXGCsMcS+H9jxEotmM3u8F28zhPobvT3+Hd_iWstFQN744v6Q@mail.gmail.com>
Subject: Re: [5.0.0 rc3 BUG] possible irq lock inversion dependency detected
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        thomas.lendacky@amd.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This bug is still present in 5.1 rc4
Why no one answered me?
Maybe I wrote something wrong?
Please help me.


$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname -r`/vmlinux
speculation_ctrl_update+0x164
speculation_ctrl_update+0x164/0x1d0:
amd_set_core_ssb_state at arch/x86/kernel/process.c:383
(inlined by) __speculation_ctrl_update at arch/x86/kernel/process.c:439
(inlined by) speculation_ctrl_update at arch/x86/kernel/process.c:482


--
Best Regards,
Mike Gavrilov.


On Sat, 2 Feb 2019 at 23:33, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi folks.
> I at last year already caught bug with same signature at kvm subsystem
> in 4.18.0 rc8 kernel. It happened when I started virtual machine. And
> then Thomas was fixed this bug [1].
> But now it happened when I changed DPI in ProtocaseDesigner (this is
> java application which helps design computer cases). And it not
> harmless issue because application stuck and I could  terminate
> ProtocaseDesigner only with `kill -9`.
>
> Can anyone tell me which mailing list is more relevant to this bug? I
> suppose this can be linux-smp or may be linux-x86_64.
>
>
> [ 3534.478386] ========================================================
> [ 3534.478387] WARNING: possible irq lock inversion dependency detected
> [ 3534.478390] 5.0.0-0.rc4.git3.2.fc30.x86_64 #1 Tainted: G         C
> [ 3534.478392] --------------------------------------------------------
> [ 3534.478393] java/13935 just changed the state of lock:
> [ 3534.478395] 000000007eda2fa7 (&st->lock){+...}, at:
> speculation_ctrl_update+0x164/0x1d0
> [ 3534.478401] but this lock was taken by another, HARDIRQ-safe lock
> in the past:
> [ 3534.478402]  (&(&sighand->siglock)->rlock){-.-.}
> [ 3534.478403]
>
>                and interrupts could create inverse lock ordering between them.
>
> [ 3534.478405]
>                other info that might help us debug this:
> [ 3534.478406]  Possible interrupt unsafe locking scenario:
>
> [ 3534.478407]        CPU0                    CPU1
> [ 3534.478408]        ----                    ----
> [ 3534.478408]   lock(&st->lock);
> [ 3534.478410]                                local_irq_disable();
> [ 3534.478411]                                lock(&(&sighand->siglock)->rlock);
> [ 3534.478412]                                lock(&st->lock);
> [ 3534.478413]   <Interrupt>
> [ 3534.478414]     lock(&(&sighand->siglock)->rlock);
> [ 3534.478415]
>                 *** DEADLOCK ***
>
> [ 3534.478417] no locks held by java/13935.
> [ 3534.478417]
>                the shortest dependencies between 2nd lock and 1st lock:
> [ 3534.478420]  -> (&(&sighand->siglock)->rlock){-.-.} {
> [ 3534.478422]     IN-HARDIRQ-W at:
> [ 3534.478426]                       _raw_spin_lock_irqsave+0x49/0x83
> [ 3534.478429]                       __lock_task_sighand+0x85/0x180
> [ 3534.478431]                       do_send_sig_info+0x35/0x90
> [ 3534.478432]                       kill_pid_info+0x83/0x150
> [ 3534.478435]                       it_real_fn+0x39/0xf0
> [ 3534.478437]                       __hrtimer_run_queues+0x110/0x450
> [ 3534.478439]                       hrtimer_interrupt+0x10e/0x240
> [ 3534.478441]                       smp_apic_timer_interrupt+0x83/0x230
> [ 3534.478443]                       apic_timer_interrupt+0xf/0x20
> [ 3534.478446]                       cpuidle_enter_state+0xbf/0x470
> [ 3534.478448]                       do_idle+0x1ec/0x280
> [ 3534.478450]                       cpu_startup_entry+0x19/0x20
> [ 3534.478452]                       start_secondary+0x1b3/0x200
> [ 3534.478455]                       secondary_startup_64+0xa4/0xb0
> [ 3534.478456]     IN-SOFTIRQ-W at:
> [ 3534.478458]                       _raw_spin_lock_irqsave+0x49/0x83
> [ 3534.478460]                       __lock_task_sighand+0x85/0x180
> [ 3534.478461]                       do_send_sig_info+0x35/0x90
> [ 3534.478463]                       kill_pid_info+0x83/0x150
> [ 3534.478465]                       it_real_fn+0x39/0xf0
> [ 3534.478466]                       __hrtimer_run_queues+0x110/0x450
> [ 3534.478468]                       hrtimer_interrupt+0x10e/0x240
> [ 3534.478470]                       smp_apic_timer_interrupt+0x83/0x230
> [ 3534.478472]                       apic_timer_interrupt+0xf/0x20
> [ 3534.478474]                       _raw_spin_unlock_irqrestore+0x50/0x60
> [ 3534.478476]                       run_rebalance_domains+0x70/0xa0
> [ 3534.478478]                       __do_softirq+0xe2/0x46a
> [ 3534.478480]                       irq_exit+0x119/0x120
> [ 3534.478482]                       smp_apic_timer_interrupt+0xa4/0x230
> [ 3534.478484]                       apic_timer_interrupt+0xf/0x20
> [ 3534.478486]                       cpuidle_enter_state+0xbf/0x470
> [ 3534.478488]                       do_idle+0x1ec/0x280
> [ 3534.478489]                       cpu_startup_entry+0x19/0x20
> [ 3534.478492]                       start_kernel+0x52a/0x548
> [ 3534.478494]                       secondary_startup_64+0xa4/0xb0
> [ 3534.478495]     INITIAL USE at:
> [ 3534.478497]                      _raw_spin_lock_irq+0x3d/0x80
> [ 3534.478498]                      calculate_sigpending+0x22/0x40
> [ 3534.478500]                      ret_from_fork+0x8/0x50
> [ 3534.478501]   }
> [ 3534.478504]   ... key      at: [<ffffffff8e257290>] __key.68419+0x0/0x8
> [ 3534.478505]   ... acquired at:
> [ 3534.478507]    speculation_ctrl_update+0x164/0x1d0
> [ 3534.478509]    speculation_ctrl_update_current+0x22/0x30
> [ 3534.478511]    ssb_prctl_set.part.0+0x1a/0x20
> [ 3534.478513]    arch_seccomp_spec_mitigate+0x25/0x50
> [ 3534.478515]    do_seccomp+0x8f1/0x960
> [ 3534.478517]    do_syscall_64+0x60/0x1e0
> [ 3534.478519]    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> [ 3534.478521] -> (&st->lock){+...} {
> [ 3534.478523]    HARDIRQ-ON-W at:
> [ 3534.478525]                     _raw_spin_lock+0x31/0x80
> [ 3534.478526]                     speculation_ctrl_update+0x164/0x1d0
> [ 3534.478528]                     speculation_ctrl_update_current+0x22/0x30
> [ 3534.478530]                     arch_prctl_spec_ctrl_set+0xe5/0x110
> [ 3534.478532]                     __x64_sys_prctl+0xce/0x53c
> [ 3534.478533]                     do_syscall_64+0x60/0x1e0
> [ 3534.478535]                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 3534.478536]    INITIAL USE at:
> [ 3534.478538]                    _raw_spin_lock+0x31/0x80
> [ 3534.478540]                    speculation_ctrl_update+0x164/0x1d0
> [ 3534.478542]                    speculation_ctrl_update_current+0x22/0x30
> [ 3534.478543]                    ssb_prctl_set.part.0+0x1a/0x20
> [ 3534.478545]                    arch_seccomp_spec_mitigate+0x25/0x50
> [ 3534.478547]                    do_seccomp+0x8f1/0x960
> [ 3534.478549]                    do_syscall_64+0x60/0x1e0
> [ 3534.478551]                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 3534.478552]  }
> [ 3534.478554]  ... key      at: [<ffffffff8e1f69c8>] __key.60805+0x0/0x8
> [ 3534.478555]  ... acquired at:
> [ 3534.478558]    __lock_acquire+0x544/0x1660
> [ 3534.478559]    lock_acquire+0xa2/0x1b0
> [ 3534.478561]    _raw_spin_lock+0x31/0x80
> [ 3534.478563]    speculation_ctrl_update+0x164/0x1d0
> [ 3534.478564]    speculation_ctrl_update_current+0x22/0x30
> [ 3534.478566]    arch_prctl_spec_ctrl_set+0xe5/0x110
> [ 3534.478567]    __x64_sys_prctl+0xce/0x53c
> [ 3534.478569]    do_syscall_64+0x60/0x1e0
> [ 3534.478571]    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> [ 3534.478572]
>                stack backtrace:
> [ 3534.478575] CPU: 10 PID: 13935 Comm: java Tainted: G         C
>   5.0.0-0.rc4.git3.2.fc30.x86_64 #1
> [ 3534.478577] Hardware name: System manufacturer System Product
> Name/ROG STRIX X470-I GAMING, BIOS 1103 11/16/2018
> [ 3534.478578] Call Trace:
> [ 3534.478582]  dump_stack+0x85/0xc0
> [ 3534.478584]  check_usage_backwards.cold+0x1d/0x26
> [ 3534.478588]  mark_lock+0x188/0x600
> [ 3534.478590]  ? print_shortest_lock_dependencies+0x40/0x40
> [ 3534.478592]  __lock_acquire+0x544/0x1660
> [ 3534.478595]  ? sched_clock+0x5/0x10
> [ 3534.478597]  ? sched_clock_cpu+0xc/0xc0
> [ 3534.478600]  lock_acquire+0xa2/0x1b0
> [ 3534.478602]  ? speculation_ctrl_update+0x164/0x1d0
> [ 3534.478604]  _raw_spin_lock+0x31/0x80
> [ 3534.478606]  ? speculation_ctrl_update+0x164/0x1d0
> [ 3534.478608]  speculation_ctrl_update+0x164/0x1d0
> [ 3534.478610]  speculation_ctrl_update_current+0x22/0x30
> [ 3534.478612]  arch_prctl_spec_ctrl_set+0xe5/0x110
> [ 3534.478614]  __x64_sys_prctl+0xce/0x53c
> [ 3534.478616]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [ 3534.478619]  do_syscall_64+0x60/0x1e0
> [ 3534.478621]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 3534.478623] RIP: 0033:0x7fb593d6b25e
> [ 3534.478625] Code: 48 8b 0d 2d 3c 0c 00 f7 d8 64 89 01 48 83 c8 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 9d 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fa 3b 0c 00 f7 d8 64 89
> 01 48
> [ 3534.478627] RSP: 002b:00007fff7fe07f78 EFLAGS: 00000246 ORIG_RAX:
> 000000000000009d
> [ 3534.478629] RAX: ffffffffffffffda RBX: 00007fb593b2f088 RCX: 00007fb593d6b25e
> [ 3534.478630] RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000035
> [ 3534.478632] RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
> [ 3534.478633] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff7fe0c688
> [ 3534.478634] R13: 00007fff7fe0c6b8 R14: 00007fb593b2f158 R15: 0000000000000000
>
> $ eu-addr2line -e
> /lib/debug/lib/modules/5.0.0-0.rc4.git3.2.fc30.x86_64/vmlinux
> speculation_ctrl_update+0x164
> arch/x86/kernel/process.c:371:10
>
> Thanks.
>
> [1] https://www.spinics.net/lists/kvm/msg173197.html
>
> --
> Best Regards,
> Mike Gavrilov.
