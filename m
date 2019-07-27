Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E1C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08B02083B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2qbNLXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbfG0Qoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:44:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33763 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfG0Qoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:44:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so25830308plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Jfm/aBE/IQWtbnKLNAu3TBXSuVn8rmcb0yAWYmZJz70=;
        b=Y2qbNLXaITIN+pJqpskG4lBkcf3s6JRix7q2quN9UiexF0kCtFLbJWsOL7tm2TPvIX
         LcYW8VEvntkBngQJz+hvxhEt895AQw3SiyQPZYevO81+7NQs09b3WvtKXtpZN7a6O1vU
         JrI5yuc2r18XnuEikmKExXtzQiAb1odCXKqkz2z7Ekv5XNYl6vznzvpFIGfRTo6Y3CPA
         rzYFMb0PKvTqA3EK6GbQYXiQqbq9iOTtfIY1afY0L/gVzzvzK7KEsPp7QsYPwHUUSFXU
         rI0n+xP653XNctCoZmrsMTX/3Ej/xcnxdtqvndVM25AKAU0lkxrI1hSoTTV9M7d2NjtU
         x/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Jfm/aBE/IQWtbnKLNAu3TBXSuVn8rmcb0yAWYmZJz70=;
        b=Sy7ayZmdKz3tPED1UpVr4XgeuzeeuHQcKVaJn9J4NRebXpf+0AbGchJ2w3/QufnOsF
         A3Rg0Rao8DiGgs3/Kvm/0zl11ILi/KJS4vxknFI7lVL0XBu6297FYl9fdhNhqPUhnLjw
         TJbPz8oLxMro/E2b4mIGay4Nih9h7qKPz7erm13nZr98hBRCTv4nXBDBG8QvFCPi52Vm
         ZsvCZau4bJY3GE1/PVDx3FeNX1XltbSCY5lnbkwMlZlXsKbJXKOMrKgTwGoDlntgMuWM
         ySknPbBPfv6D+HlAqGV5kRhO38eyEdUC4fvvooHeiGiLvaKNYsEBiD07WPR8lOGDT86F
         hDSQ==
X-Gm-Message-State: APjAAAU5PGHAba3UocWaBEvnAMou60RuL1MGB07ZAHkB+2igMiJYM9pV
        EPES/aijXYMz383vzpG6NE0=
X-Google-Smtp-Source: APXvYqwVI7zzkuFRFweCmsovSeaGR8a6wKgtfBOn1hlCGLtbVZpzjtsZLBiXkUZCnKh887hd9Jm1UA==
X-Received: by 2002:a17:902:6a2:: with SMTP id 31mr96837839plh.296.1564245892926;
        Sat, 27 Jul 2019 09:44:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p68sm68289545pfb.80.2019.07.27.09.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 09:44:52 -0700 (PDT)
Date:   Sat, 27 Jul 2019 09:44:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: sched: Unexpected reschedule of offline CPU#2!
Message-ID: <20190727164450.GA11726@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see the following traceback (or similar tracebacks) once in a while
during my boot tests. In this specific case it is with mainline
(v5.3-rc1-195-g3ea54d9b0d65), but I have seen it with other branches
as well. This isn't a new problem; I have seen it for quite some time.
There is no specific action required to make it appear; just running
reboot loops is sufficient. The problem doesn't happen a lot;
non-scientifically I would say I see it maybe once every few hundred
boots.

No specific action requested or asked for; this is just informational.

A complete log is at:
https://kerneltests.org/builders/qemu-x86-master/builds/1285/steps/qemubuildcommand/logs/stdio

Guenter

---
[   61.248329] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   61.268277] e1000e: EEE TX LPI TIMER: 00000000
[   61.311435] reboot: Restarting system
[   61.312321] reboot: machine restart
[   61.342193] ------------[ cut here ]------------
[   61.342660] sched: Unexpected reschedule of offline CPU#2!
ILLOPC: ce241f83: 0f 0b
[   61.344323] WARNING: CPU: 1 PID: 15 at arch/x86/kernel/smp.c:126 native_smp_send_reschedule+0x33/0x40
[   61.344836] Modules linked in:
[   61.345694] CPU: 1 PID: 15 Comm: ksoftirqd/1 Not tainted 5.3.0-rc1+ #1
[   61.345998] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   61.346569] EIP: native_smp_send_reschedule+0x33/0x40
[   61.347099] Code: cf 73 1c 8b 15 60 54 2b cf 8b 4a 18 ba fd 00 00 00 e8 05 65 c7 00 c9 c3 8d b4 26 00 00 00 00 50 68 04 ca 1a cf e8 fe e3 01 00 <0f> 0b 58 5a c9 c3 8d b4 26 00 00 00 00 55 89 e5 56 53 83 ec 0c 65
[   61.347726] EAX: 0000002e EBX: 00000002 ECX: 00000000 EDX: cdd64140
[   61.347977] ESI: 00000002 EDI: 00000000 EBP: cdd73c88 ESP: cdd73c80
[   61.348234] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000096
[   61.348514] CR0: 80050033 CR2: b7ee7048 CR3: 0c28f000 CR4: 000006d0
[   61.348866] Call Trace:
[   61.349392]  kick_ilb+0x90/0xa0
[   61.349629]  trigger_load_balance+0xf0/0x5c0
[   61.349859]  ? check_preempt_wakeup+0x1b0/0x1b0
[   61.350057]  scheduler_tick+0xa7/0xd0
[   61.350266]  update_process_times+0x4a/0x60
[   61.350467]  tick_sched_handle+0x3e/0x50
[   61.350650]  tick_sched_timer+0x37/0x90
[   61.350847]  __hrtimer_run_queues+0xf7/0x440
[   61.351056]  ? tick_sched_do_timer+0x70/0x70
[   61.351281]  hrtimer_interrupt+0x10e/0x260
[   61.351541]  smp_apic_timer_interrupt+0x68/0x210
[   61.351750]  apic_timer_interrupt+0x106/0x10c
[   61.352040] EIP: _raw_spin_unlock_irqrestore+0x47/0x50
[   61.352254] Code: 66 40 ff f6 c7 02 75 1b 53 9d e8 c4 67 49 ff 64 ff 0d 84 27 50 cf 5b 5e 5d c3 8d b4 26 00 00 00 00 66 90 e8 ab 69 49 ff 53 9d <eb> e3 8d b4 26 00 00 00 00 55 64 ff 05 84 27 50 cf 89 e5 53 89 c3
[   61.352810] EAX: cdd64140 EBX: 00000282 ECX: 00000003 EDX: 00000002
[   61.353041] ESI: cdc01940 EDI: 00000001 EBP: cdd73e08 ESP: cdd73e00
[   61.353273] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000282
[   61.353705]  ? _raw_spin_unlock_irqrestore+0x47/0x50
[   61.362142]  free_debug_processing+0x199/0x220
[   61.362413]  __slab_free+0x220/0x3b0
[   61.362599]  ? irq_kobj_release+0x1c/0x20
[   61.362845]  ? kfree+0x1ad/0x270
[   61.363002]  ? kfree+0x1ad/0x270
[   61.363162]  kfree+0x264/0x270
[   61.363305]  ? kfree+0x264/0x270
[   61.363458]  ? irq_kobj_release+0x1c/0x20
[   61.363624]  ? irq_kobj_release+0x1c/0x20
[   61.363824]  irq_kobj_release+0x1c/0x20
[   61.364018]  kobject_put+0x58/0xc0
[   61.364211]  ? hwirq_show+0x50/0x50
[   61.364439]  delayed_free_desc+0xb/0x10
[   61.364621]  rcu_core+0x288/0xb50
[   61.364805]  ? __do_softirq+0x7e/0x3bb
[   61.365042]  rcu_core_si+0x8/0x10
[   61.365209]  __do_softirq+0xa9/0x3bb
[   61.365445]  run_ksoftirqd+0x25/0x50
[   61.365615]  smpboot_thread_fn+0xef/0x1d0
[   61.365834]  kthread+0xf2/0x110
[   61.365986]  ? sort_range+0x20/0x20
[   61.366156]  ? kthread_create_on_node+0x20/0x20
[   61.366360]  ret_from_fork+0x2e/0x38
[   61.366818] irq event stamp: 1267
[   61.367115] hardirqs last  enabled at (1266): [<ceeb37f5>] _raw_spin_unlock_irqrestore+0x45/0x50
[   61.367448] hardirqs last disabled at (1267): [<ce20178a>] trace_hardirqs_off_thunk+0xc/0x12
[   61.367769] softirqs last  enabled at (1232): [<ceeb7a45>] __do_softirq+0x2c5/0x3bb
[   61.368057] softirqs last disabled at (1237): [<ce267605>] run_ksoftirqd+0x25/0x50
[   61.368389] ---[ end trace 3465d631a21844b8 ]---
