Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EDDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4332075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QShuPA8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfC0Npk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:45:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38534 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfC0Npi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:45:38 -0400
Received: by mail-io1-f67.google.com with SMTP id v4so14089646ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBCqGDrXQ2SSJuuafs7KNWTZO+/B0+c35AYdYoCtgDU=;
        b=QShuPA8uTYHrbydsPp5XVSf1WjtsCcz1gKM7lYLZvPBm341Z9ZyHOyadpyoSFIctZZ
         KRfnnOtxu80ORWil8pXk0YuU/Q1+267LufuZZYlwSYJU67FGlpKzAKUSmXaJctxT2oc2
         zxzIuf9Lkl50RMIaAhJ3Th7ow83NJmfbM77wQYCP+jjTg5gvkjE9KF0vEFabR3vD4wb1
         Y0dRRN0EMfneFHmItDcdMJdpDFUyA6+uOh+ndRpzH3bFNJKL14Kb9KJYUHKtQ9BFJVmF
         FprOZIo2PYP+U57UgnD8OOHaTo5oawQW3lRp5ZFe4Y03byAqXDgTyn2V6IYLJeujiXbG
         tylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBCqGDrXQ2SSJuuafs7KNWTZO+/B0+c35AYdYoCtgDU=;
        b=rrdUkkEA8UxiAb61jiVpzcfw4U1yZa3bNIqlk8hwPka5Vbtecmh5lRVqedcolCAuFo
         QEHx8XJdcxfhaYG0WpC485lUmpq69A/4zeKoJUlAwyy7y0kV3o0/9f0U/44WQ4dPibNA
         SFi8NRBs4R281oX02E/HusuiIvCialkOb4auzfPkrCaXtpbLu6omPJKeho9ppMVgVGgx
         mJ/M61wE6v/RXZv0cjJsUlKqkrvV7hLW5KbVfdd80jrs9EPdZiAKsDf61cNcaL2iv0F+
         lrMaqrrbDQQ5qxdzS8A3D3H4FxVK0zSNux3VmSBTmN6cq48+lSYIeQTreurvL0s2bJym
         qg5Q==
X-Gm-Message-State: APjAAAXceY8qxvRSJcbJh8F8PWTbxYAPIQNRpFEUdJucXJ/4rK2CkskW
        TniqSbwrbW0owS+dtz1qUcM8JXtl7cUeY0GkD2qPnA==
X-Google-Smtp-Source: APXvYqwdkNiylXQ+OWvoYIG1HuiPbqrETwh9xED+H4lZdzVFxN2UJ5mfZ6c7S+TF2UswKIslUxRH5XZxT8YON0NSKwE=
X-Received: by 2002:a5d:9457:: with SMTP id x23mr8565564ior.271.1553694336420;
 Wed, 27 Mar 2019 06:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000639f6a0584d11b82@google.com> <20190327132805.GG32571@zn.tnic>
In-Reply-To: <20190327132805.GG32571@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Mar 2019 14:45:24 +0100
Message-ID: <CACT4Y+bHd938t-w++LBO-yHMWP1cXpn+U=AVL+8mMfTBYk86=g@mail.gmail.com>
Subject: Re: WARNING in arch_install_hw_breakpoint
To:     Borislav Petkov <bp@alien8.de>
Cc:     syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 2:28 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Mar 23, 2019 at 11:22:06PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    fd1f297b Merge tag 'drm-fixes-2019-03-22' of git://anongit..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1574f56d200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
> > dashboard link: https://syzkaller.appspot.com/bug?extid=370a6b0f11867bf13515
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1157b7cf200000
> >
> > Bisection is inconclusive: the bug happens on the oldest tested release.
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ca39b3200000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=12ca39b3200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14ca39b3200000
>
> So I've tried running your .config in both an AMD and an Intel guest
> like this:
>
> ./syz-execprog -repeat=0 repro.syz
>
> and killed it after 30K executed programs without success infd1f297b794c7
> reproducing.
>
> Either I'm missing something and my environment doesn't match yours -
> because looking at your console output it happens almost immediately
> after starting - or it has been fixed in the meantime...

Hi Boris,

There are two C reproducers available as well for this bug:
https://syzkaller.appspot.com/bug?extid=370a6b0f11867bf13515
syzbot failed to mail them because of that mess with duplicate email storm.

I was able to reproduce it now in a qemu. syzbot used GCE VMs, so it
should not depend on exact hardware too much.

I've checked out fd1f297b794c7
Took this config: https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
Build with gcc 7.3.0, different from syzbot, so probably does not matter much.
Started qemu as:

qemu-system-x86_64 -hda wheezy.img -net
user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net nic -nographic -kernel
arch/x86/boot/bzImage -append "kvm-intel.nested=1
kvm-intel.unrestricted_guest=1 kvm-intel.ept=1
kvm-intel.flexpriority=1 kvm-intel.vpid=1
kvm-intel.emulate_invalid_guest_state=1 kvm-intel.eptad=1
kvm-intel.enable_shadow_vmcs=1 kvm-intel.pml=1
kvm-intel.enable_apicv=1 console=ttyS0 root=/dev/sda
earlyprintk=serial slub_debug=UZ vsyscall=native rodata=n oops=panic
panic_on_warn=1 panic=86400 ima_policy=tcb" -enable-kvm -pidfile
vm_pid -m 2G -smp 4 -cpu host

The image is available here (but probably does not matter much too):
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce

And run this program:
https://syzkaller.appspot.com/text?tag=ReproC&x=15439f27200000

After few seconds I got:

root@syzkaller:~# ./a.out
[   32.485532][ T9863] ------------[ cut here ]------------
[   32.487554][ T9863] Can't find any breakpoint slot
[   32.487588][ T9863] WARNING: CPU: 0 PID: 9863 at
arch/x86/kernel/hw_breakpoint.c:121
arch_install_hw_breakpoint+0x2f5/0x3a0
[   32.490993][ T9863] Kernel panic - not syncing: panic_on_warn set ...
[   32.492379][ T9863] CPU: 0 PID: 9863 Comm: a.out Not tainted 5.1.0-rc1+ #1
[   32.493865][ T9863] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.10.2-1 04/01/2014
[   32.495839][ T9863] Call Trace:
[   32.496550][ T9863]  dump_stack+0x154/0x1c5
[   32.497465][ T9863]  panic+0x25e/0x52c
[   32.498070][ T9863]  ? refcount_error_report+0x214/0x214
[   32.498915][ T9863]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[   32.499763][ T9863]  ? __probe_kernel_read+0x168/0x1c0
[   32.500598][ T9863]  ? __warn+0x1cf/0x200
[   32.501253][ T9863]  ? arch_install_hw_breakpoint+0x2f5/0x3a0
[   32.502173][ T9863]  __warn+0x1ea/0x200
[   32.502794][ T9863]  ? arch_install_hw_breakpoint+0x2f5/0x3a0
[   32.503755][ T9863]  report_bug+0x1f4/0x2b0
[   32.504446][ T9863]  fixup_bug.part.12+0x37/0x80
[   32.505198][ T9863]  do_error_trap+0x155/0x180
[   32.505918][ T9863]  do_invalid_op+0x36/0x40
[   32.506614][ T9863]  ? arch_install_hw_breakpoint+0x2f5/0x3a0
[   32.507542][ T9863]  invalid_op+0x14/0x20
[   32.508213][ T9863] RIP: 0010:arch_install_hw_breakpoint+0x2f5/0x3a0
[   32.509227][ T9863] Code: ff ff 40 88 75 c8 e8 7a 0b 78 00 0f b6 75
c8 e9 0c ff ff ff 48 c7 c7 80 ca 04 87 89 45 d4 c6 05 0f 05 cb 07 01
e8 9b 3c 1a 00 <0f> 0b 8b 45 d4 e9 a0 fd ff ff 48 89 df 48 89 75 c0 e8
a5 0b 78 00
[   32.512254][ T9863] RSP: 0018:ffff88805f6f76f0 EFLAGS: 00010086
[   32.513196][ T9863] RAX: 0000000000000000 RBX: ffff88806c81ec98
RCX: ffffffff8155e8c8
[   32.514428][ T9863] RDX: 0000000040000000 RSI: 0000000000000004
RDI: 0000000000000000
[   32.515664][ T9863] RBP: ffff88805f6f7730 R08: fffffbfff10728b1
R09: fffffbfff10728b1
[   32.516903][ T9863] R10: ffff88805f6f7760 R11: fffffbfff10728b0
R12: ffff888063b6b1c0
[   32.518177][ T9863] R13: 000000000001eca0 R14: 0000000000000004
R15: dffffc0000000000
[   32.519402][ T9863]  ? vprintk_func+0x68/0x190
[   32.520111][ T9863]  hw_breakpoint_add+0x8d/0x110
[   32.520866][ T9863]  event_sched_in.isra.99+0x323/0xb20
[   32.521698][ T9863]  group_sched_in+0xd3/0x3b0
[   32.522404][ T9863]  flexible_sched_in+0x58d/0x900
[   32.523163][ T9863]  visit_groups_merge+0x2f7/0x560
[   32.523936][ T9863]  ? pinned_sched_in+0x940/0x940
[   32.524699][ T9863]  ? perf_mux_hrtimer_restart+0x250/0x250
[   32.525591][ T9863]  ctx_sched_in+0x2a9/0x630
[   32.526285][ T9863]  ? visit_groups_merge+0x560/0x560
[   32.527088][ T9863]  perf_event_sched_in+0x6d/0xa0
[   32.527865][ T9863]  __perf_event_task_sched_in+0x6ae/0x820
[   32.528741][ T9863]  ? perf_sched_cb_inc+0x230/0x230
[   32.529531][ T9863]  ? rcu_read_lock_sched_held+0x108/0x120
[   32.530408][ T9863]  ? __switch_to+0xdd3/0x1170
[   32.531123][ T9863]  ? __switch_to_asm+0x34/0x70
[   32.531851][ T9863]  ? __switch_to_asm+0x40/0x70
[   32.532580][ T9863]  finish_task_switch+0x474/0x780
[   32.533370][ T9863]  ? __switch_to_asm+0x34/0x70
[   32.534100][ T9863]  ? __switch_to_asm+0x40/0x70
[   32.534789][ T9863]  __schedule+0x8d1/0x1f80
[   32.535418][ T9863]  ? __sched_text_start+0x8/0x8
[   32.536104][ T9863]  ? lock_downgrade+0x8f0/0x8f0
[   32.536801][ T9863]  schedule+0x7f/0x180
[   32.537382][ T9863]  ptrace_stop+0x3de/0x8d0
[   32.538030][ T9863]  get_signal+0xe54/0x19e0
[   32.538671][ T9863]  ? _raw_spin_unlock_irqrestore+0x6a/0xe0
[   32.539541][ T9863]  do_signal+0x87/0x1ab0
[   32.540180][ T9863]  ? lock_downgrade+0x8f0/0x8f0
[   32.540902][ T9863]  ? debug_smp_processor_id+0x2f/0x240
[   32.541719][ T9863]  ? kasan_check_read+0x11/0x20
[   32.542444][ T9863]  ? setup_sigcontext+0x7d0/0x7d0
[   32.543189][ T9863]  ? do_send_specific+0x122/0x1b0
[   32.543934][ T9863]  ? do_rt_tgsigqueueinfo+0x7d/0xc0
[   32.544722][ T9863]  ? lockdep_hardirqs_on+0x424/0x5c0
[   32.545536][ T9863]  ? trace_hardirqs_on+0x52/0x1d0
[   32.546299][ T9863]  exit_to_usermode_loop+0x1ee/0x260
[   32.547127][ T9863]  do_syscall_64+0x490/0x570
[   32.547867][ T9863]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   32.548790][ T9863] RIP: 0033:0x43f399
[   32.549379][ T9863] Code: e8 8c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00
00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b cd fc ff c3 66 2e 0f 1f 84
00 00 00 00
[   32.552296][ T9863] RSP: 002b:00007fa8f1e49d78 EFLAGS: 00000217
ORIG_RAX: 0000000000000129
[   32.553486][ T9863] RAX: 0000000000000000 RBX: 0000000000000000
RCX: 000000000043f399
[   32.554608][ T9863] RDX: 0000000000000016 RSI: 0000000000002687
RDI: 0000000000002687
[   32.555729][ T9863] RBP: 00007fa8f1e49da0 R08: 0000000000000000
R09: 0000000000000000
[   32.556901][ T9863] R10: 0000000020000100 R11: 0000000000000217
R12: 0000000000000000
[   32.558088][ T9863] R13: 00007fffc60836af R14: 00007fa8f1e4a700
R15: 0000000000000000
[   32.559268][ T9863]
[   32.559271][ T9863] ======================================================
[   32.559272][ T9863] WARNING: possible circular locking dependency detected
[   32.559273][ T9863] 5.1.0-rc1+ #1 Not tainted
[   32.559275][ T9863] ------------------------------------------------------
[   32.559277][ T9863] a.out/9863 is trying to acquire lock:
[   32.559278][ T9863] 000000005cd47422 ((console_sem).lock){-.-.},
at: down_trylock+0x13/0x70
[   32.559282][ T9863]
[   32.559283][ T9863] but task is already holding lock:
[   32.559284][ T9863] 000000009ed979ab (&ctx->lock){....}, at:
__perf_event_task_sched_in+0x4e5/0x820
[   32.559289][ T9863]
[   32.559290][ T9863] which lock already depends on the new lock.
[   32.559291][ T9863]
[   32.559292][ T9863]
[   32.559293][ T9863] the existing dependency chain (in reverse order) is:
[   32.559294][ T9863]
[   32.559295][ T9863] -> #3 (&ctx->lock){....}:
[   32.559299][ T9863]        lock_acquire+0x174/0x400
[   32.559300][ T9863]        _raw_spin_lock+0x2d/0x40
[   32.559302][ T9863]        __perf_event_task_sched_out+0x70a/0x1390
[   32.559303][ T9863]        __schedule+0xcf9/0x1f80
[   32.559305][ T9863]        preempt_schedule_common+0x35/0xe0
[   32.559306][ T9863]        preempt_schedule+0x23/0x30
[   32.559307][ T9863]        ___preempt_schedule+0x16/0x18
[   32.559309][ T9863]        _raw_spin_unlock_irqrestore+0xbf/0xe0
[   32.559310][ T9863]        try_to_wake_up+0xc4/0x1030
[   32.559311][ T9863]        wake_up_q+0x8a/0xe0
[   32.559312][ T9863]        futex_wake+0x3b0/0x450
[   32.559314][ T9863]        do_futex+0x4fb/0x1910
[   32.559315][ T9863]        __x64_sys_futex+0x2c9/0x3c0
[   32.559316][ T9863]        do_syscall_64+0xe7/0x570
[   32.559318][ T9863]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   32.559318][ T9863]
[   32.559319][ T9863] -> #2 (&rq->lock){-.-.}:
[   32.559323][ T9863]        lock_acquire+0x174/0x400
[   32.559325][ T9863]        _raw_spin_lock+0x2d/0x40
[   32.559326][ T9863]        task_fork_fair+0x67/0x4c0
[   32.559327][ T9863]        sched_fork+0x3a8/0x8d0
[   32.559328][ T9863]        copy_process.part.34+0x18d7/0x6df0
[   32.559330][ T9863]        _do_fork+0x1b8/0xd10
[   32.559331][ T9863]        kernel_thread+0x34/0x40
[   32.559332][ T9863]        rest_init+0x26/0x300
[   32.559333][ T9863]        arch_call_rest_init+0xe/0x1b
[   32.559335][ T9863]        start_kernel+0x777/0x7b1
[   32.559336][ T9863]        x86_64_start_reservations+0x2a/0x2c
[   32.559337][ T9863]        x86_64_start_kernel+0x77/0x7a
[   32.559339][ T9863]        secondary_startup_64+0xa4/0xb0
[   32.559339][ T9863]
[   32.559340][ T9863] -> #1 (&p->pi_lock){-.-.}:
[   32.559344][ T9863]        lock_acquire+0x174/0x400
[   32.559346][ T9863]        _raw_spin_lock_irqsave+0x99/0xd0
[   32.559347][ T9863]        try_to_wake_up+0x8b/0x1030
[   32.559348][ T9863]        wake_up_process+0x10/0x20
[   32.559350][ T9863]        __up.isra.0+0x138/0x1a0
[   32.559351][ T9863]        up+0x95/0xe0
[   32.559352][ T9863]        __up_console_sem+0xb2/0x1a0
[   32.559353][ T9863]        console_unlock+0x62d/0xd00
[   32.559355][ T9863]        do_con_write.part.24+0x1068/0x1c20
[   32.559356][ T9863]        con_write+0xb2/0xc0
[   32.559357][ T9863]        n_tty_write+0x539/0xe20
[   32.559358][ T9863]        tty_write+0x3f8/0x840
[   32.559359][ T9863]        __vfs_write+0x87/0x110
[   32.559361][ T9863]        vfs_write+0x189/0x4d0
[   32.559362][ T9863]        ksys_write+0xd8/0x1b0
[   32.559363][ T9863]        __x64_sys_write+0x73/0xb0
[   32.559364][ T9863]        do_syscall_64+0xe7/0x570
[   32.559366][ T9863]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   32.559367][ T9863]
[   32.559367][ T9863] -> #0 ((console_sem).lock){-.-.}:
[   32.559372][ T9863]        __lock_acquire+0x2cb0/0x3d10
[   32.559373][ T9863]        lock_acquire+0x174/0x400
[   32.559374][ T9863]        _raw_spin_lock_irqsave+0x99/0xd0
[   32.559376][ T9863]        down_trylock+0x13/0x70
[   32.559377][ T9863]        __down_trylock_console_sem+0xa2/0x1e0
[   32.559378][ T9863]        console_trylock+0x15/0x70
[   32.559380][ T9863]        vprintk_emit+0x1b0/0x640
[   32.559381][ T9863]        vprintk_default+0x28/0x30
[   32.559382][ T9863]        vprintk_func+0x61/0x190
[   32.559383][ T9863]        printk+0xb2/0xdd
[   32.559384][ T9863]        __warn_printk+0x96/0xf0
[   32.559386][ T9863]        arch_install_hw_breakpoint+0x2f5/0x3a0
[   32.559387][ T9863]        hw_breakpoint_add+0x8d/0x110
[   32.559389][ T9863]        event_sched_in.isra.99+0x323/0xb20
[   32.559390][ T9863]        group_sched_in+0xd3/0x3b0
[   32.559391][ T9863]        flexible_sched_in+0x58d/0x900
[   32.559393][ T9863]        visit_groups_merge+0x2f7/0x560
[   32.559394][ T9863]        ctx_sched_in+0x2a9/0x630
[   32.559395][ T9863]        perf_event_sched_in+0x6d/0xa0
[   32.559397][ T9863]        __perf_event_task_sched_in+0x6ae/0x820
[   32.559398][ T9863]        finish_task_switch+0x474/0x780
[   32.559400][ T9863]        __schedule+0x8d1/0x1f80
[   32.559401][ T9863]        schedule+0x7f/0x180
[   32.559402][ T9863]        ptrace_stop+0x3de/0x8d0
[   32.559403][ T9863]        get_signal+0xe54/0x19e0
[   32.559404][ T9863]        do_signal+0x87/0x1ab0
[   32.559406][ T9863]        exit_to_usermode_loop+0x1ee/0x260
[   32.559407][ T9863]        do_syscall_64+0x490/0x570
[   32.559409][ T9863]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   32.559409][ T9863]
[   32.559411][ T9863] other info that might help us debug this:
[   32.559411][ T9863]
[   32.559412][ T9863] Chain exists of:
[   32.559413][ T9863]   (console_sem).lock --> &rq->lock --> &ctx->lock
[   32.559418][ T9863]
[   32.559420][ T9863]  Possible unsafe locking scenario:
[   32.559420][ T9863]
[   32.559422][ T9863]        CPU0                    CPU1
[   32.559423][ T9863]        ----                    ----
[   32.559424][ T9863]   lock(&ctx->lock);
[   32.559427][ T9863]                                lock(&rq->lock);
[   32.559429][ T9863]                                lock(&ctx->lock);
[   32.559432][ T9863]   lock((console_sem).lock);
[   32.559434][ T9863]
[   32.559435][ T9863]  *** DEADLOCK ***
[   32.559436][ T9863]
[   32.559437][ T9863] 2 locks held by a.out/9863:
[   32.559438][ T9863]  #0: 0000000019eb1b5c (&cpuctx_lock){....}, at:
__perf_event_task_sched_in+0x4c4/0x820
[   32.559443][ T9863]  #1: 000000009ed979ab (&ctx->lock){....}, at:
__perf_event_task_sched_in+0x4e5/0x820
[   32.559448][ T9863]
[   32.559449][ T9863] stack backtrace:
[   32.559451][ T9863] CPU: 0 PID: 9863 Comm: a.out Not tainted 5.1.0-rc1+ #1
[   32.559453][ T9863] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.10.2-1 04/01/2014
[   32.559454][ T9863] Call Trace:
[   32.559455][ T9863]  dump_stack+0x154/0x1c5
[   32.559457][ T9863]  print_circular_bug.isra.37+0x2a0/0x350
[   32.559458][ T9863]  ? save_trace+0xe0/0x2b0
[   32.559459][ T9863]  check_prev_add.constprop.49+0x1932/0x29c0
[   32.559460][ T9863]  ? check_usage+0xaf0/0xaf0
[   32.559462][ T9863]  ? check_prev_add.constprop.49+0x1617/0x29c0
[   32.559463][ T9863]  ? graph_lock+0x7b/0x1f0
[   32.559464][ T9863]  ? add_lock_to_list.isra.28+0x400/0x400
[   32.559466][ T9863]  ? perf_event_bpf_output+0x250/0x250
[   32.559467][ T9863]  __lock_acquire+0x2cb0/0x3d10
[   32.559468][ T9863]  ? __lock_acquire+0x2cb0/0x3d10
[   32.559470][ T9863]  ? add_lock_to_list.isra.28+0x400/0x400
[   32.559471][ T9863]  ? mark_held_locks+0xf0/0xf0
[   32.559472][ T9863]  ? kvm_sched_clock_read+0x9/0x20
[   32.559473][ T9863]  ? sched_clock+0x31/0x40
[   32.559474][ T9863]  lock_acquire+0x174/0x400
[   32.559476][ T9863]  ? down_trylock+0x13/0x70
[   32.559477][ T9863]  ? vprintk_emit+0x1b0/0x640
[   32.559478][ T9863]  ? vprintk_emit+0x1b0/0x640
[   32.559479][ T9863]  _raw_spin_lock_irqsave+0x99/0xd0
[   32.559480][ T9863]  ? down_trylock+0x13/0x70
[   32.559482][ T9863]  down_trylock+0x13/0x70
[   32.559483][ T9863]  ? vprintk_emit+0x1b0/0x640
[   32.559484][ T9863]  __down_trylock_console_sem+0xa2/0x1e0
[   32.559485][ T9863]  console_trylock+0x15/0x70
[   32.559486][ T9863]  vprintk_emit+0x1b0/0x640
[   32.559487][ T9863]  vprintk_default+0x28/0x30
[   32.559489][ T9863]  vprintk_func+0x61/0x190
[   32.559490][ T9863]  printk+0xb2/0xdd
[   32.559491][ T9863]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[   32.559492][ T9863]  ? __warn_printk+0x8a/0xf0
[   32.559493][ T9863]  __warn_printk+0x96/0xf0
[   32.559495][ T9863]  ? test_taint+0x20/0x20
[   32.559496][ T9863]  arch_install_hw_breakpoint+0x2f5/0x3a0
[   32.559497][ T9863]  hw_breakpoint_add+0x8d/0x110
[   32.559499][ T9863]  event_sched_in.isra.99+0x323/0xb20
[   32.559500][ T9863]  group_sched_in+0xd3/0x3b0
[   32.559501][ T9863]  flexible_sched_in+0x58d/0x900
[   32.559502][ T9863]  visit_groups_merge+0x2f7/0x560
[   32.559503][ T9863]  ? pinned_sched_in+0x940/0x940
[   32.559505][ T9863]  ? perf_mux_hrtimer_restart+0x250/0x250
[   32.559506][ T9863]  ctx_sched_in+0x2a9/0x630
[   32.559507][ T9863]  ? visit_groups_merge+0x560/0x560
[   32.559508][ T9863]  perf_event_sched_in+0x6d/0xa0
[   32.559510][ T9863]  __perf_event_task_sched_in+0x6ae/0x820
[   32.559511][ T9863]  ? perf_sched_cb_inc+0x230/0x230
[   32.559512][ T9863]  ? rcu_read_lock_sched_held+0x108/0x120
[   32.559514][ T9863]  ? __switch_to+0xdd3/0x1170
[   32.559515][ T9863]  ? __switch_to_asm+0x34/0x70
[   32.559516][ T9863]  ? __switch_to_asm+0x40/0x70
[   32.559517][ T9863]  finish_task_switch+0x474/0x780
[   32.559519][ T9863]  ? __switch_to_asm+0x34/0x70
[   32.559520][ T9863]  ? __switch_to_asm+0x40/0x70
[   32.559521][ T9863]  __schedule+0x8d1/0x1f80
[   32.559522][ T9863]  ? __sched_text_start+0x8/0x8
[   32.559523][ T9863]  ? lock_downgrade+0x8f0/0x8f0
[   32.559524][ T9863]  schedule+0x7f/0x180
[   32.559525][ T9863]  ptrace_stop+0x3de/0x8d0
[   32.559527][ T9863]  get_signal+0xe54/0x19e0
[   32.559528][ T9863]  ? _raw_spin_unlock_irqrestore+0x6a/0xe0
[   32.559529][ T9863]  do_signal+0x87/0x1ab0
[   32.559530][ T9863]  ? lock_downgrade+0x8f0/0x8f0
[   32.559532][ T9863]  ? debug_smp_processor_id+0x2f/0x240
[   32.559533][ T9863]  ? kasan_check_read+0x11/0x20
[   32.559534][ T9863]  ? setup_sigcontext+0x7d0/0x7d0
[   32.559535][ T9863]  ? do_send_specific+0x122/0x1b0
[   32.559537][ T9863]  ? do_rt_tgsigqueueinfo+0x7d/0xc0
[   32.559538][ T9863]  ? lockdep_hardirqs_on+0x424/0x5c0
[   32.559539][ T9863]  ? trace_hardirqs_on+0x52/0x1d0
[   32.559541][ T9863]  exit_to_usermode_loop+0x1ee/0x260
[   32.559542][ T9863]  do_syscall_64+0x490/0x570
[   32.559543][ T9863]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   32.559544][ T9863] RIP: 0033:0x43f399
[   32.559548][ T9863] Code: e8 8c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00
00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b cd fc ff c3 66 2e 0f 1f 84
00 00 00 00
[   32.559550][ T9863] RSP: 002b:00007fa8f1e49d78 EFLAGS: 00000217
ORIG_RAX: 0000000000000129
[   32.559553][ T9863] RAX: 0000000000000000 RBX: 0000000000000000
RCX: 000000000043f399
[   32.559554][ T9863] RDX: 0000000000000016 RSI: 0000000000002687
RDI: 0000000000002687
[   32.559556][ T9863] RBP: 00007fa8f1e49da0 R08: 0000000000000000
R09: 0000000000000000
[   32.559558][ T9863] R10: 0000000020000100 R11: 0000000000000217
R12: 0000000000000000
[   32.559560][ T9863] R13: 00007fffc60836af R14: 00007fa8f1e4a700
R15: 0000000000000000
[   33.631694][ T9863] Shutting down cpus with NMI
[   33.759774][ T9863] Kernel Offset: disabled
[   33.760308][ T9863] Rebooting in 86400 seconds..
