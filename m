Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCE6C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ADE20659
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="Iqgs8WMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfGTPIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 11:08:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41812 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGTPIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 11:08:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so15429206pff.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:openpgp:autocrypt:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/vt5JSUHt9gj2YVQVqOHNOyAmUtPtmX+sKdrWQ4M/tA=;
        b=Iqgs8WMBIzT33A0dsML5GjqQRx0dPqLm9L97UynlHrSzsO9ZA48riNSnTq/lh48SnE
         8XwFZQDDOyDC294cMvncMkafHicq/eVV1UBQpI1pPxlP9VKkkfwkmFxfueyUqrFmuw/A
         PcU7fjkSfp/o+2XrfKdxyE/cpkMwdtbqrvPSHVPaPSlIDP3NTlln2FZRLDpdxGrAvDvl
         dMsFntgccfjduSnw1f57QD/ONhYRH2nw0ut5SPXd1URH+8G7EXzf02vyh6ch5ykOXHdv
         Rh2Xopm9oIFueWiTyIVnPJE3NNhPMjVw4EMhMTCoItz3hNg7o8OTgn2UOsCRl58hLv5/
         bUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:openpgp:autocrypt:to:subject:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=/vt5JSUHt9gj2YVQVqOHNOyAmUtPtmX+sKdrWQ4M/tA=;
        b=HUI8CfeSPlBvpuCsZbDwYNmFQX2b9OcCkldDzH/XwQcKkD2OXRMXIq9nUzUetmHUlY
         ENIcpizxDmC14ZJENkQvNokh6ra7ixlEA/nVV/BBoQxiCQQZZG1sFxhDnWKmt+ZVf4q0
         7nFx2ECZf8NOrqmQv7HtDDEk1m46No8tVF7TwKfS2xIIE+joCktq96YukLQ5+J20+mlO
         hMyvj01SpVmXAwDXr9uYVvdDRTwt2UMHyIsdibWhudTLrHxHd1gozPoctmZ5SgmxDIVn
         1Jo9NuP3M3JM74up3jHnyDzV9g8deTAeDS3nCBx+6VomGMtGBjqb8YBeUtzlKkIc+WEg
         Sa9Q==
X-Gm-Message-State: APjAAAXyfQ+bbt4kELHCQTP7q3+GVowSFJDdGY4d6zxSz9zfGnS6x3G5
        JM50sPbyhFOIP1i+GapAJFBqM6hK
X-Google-Smtp-Source: APXvYqwaKiqM78DKFNrl0R+yHq3Nlyw6y+nE5uMcnGFaIajDs3sCJcUqWvIYN6wnd4oeiodVxasRGQ==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr64488903pjv.95.1563635283887;
        Sat, 20 Jul 2019 08:08:03 -0700 (PDT)
Received: from Etsukata.local (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id k5sm26528608pjl.32.2019.07.20.08.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 08:08:03 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
To:     tj@kernel.org, jiangshanlai@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: workqueue: possible deadlock when setting sysfs "debug_force_rr_cpu"
Message-ID: <ed974dc7-c56c-ad3c-5051-85b787f0b304@etsukata.com>
Date:   Sun, 21 Jul 2019 00:07:59 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This is just a report for someone who hit the same problem.
When setting 1 to sysfs debug_force_rr_cpu can trigger the
following LOCKDEP WARNING.

Reproducer:

  # ssh localhost // to use pty
  # echo 1 > /sys/module/workqueue/parameters/debug_force_rr_cpu


This problem is similar to the one which syzkaller previously found
and it had been discussed in the thread: 
  - https://lore.kernel.org/lkml/20180607051019.GA10406@jagdpanzerIV/T/#ec7d3d2bdb8ccdf0f063fd2e5b2a4d8fd45d8d9e5

Fundamental solution for the problem will be the on going printk() rework:
  - https://lore.kernel.org/lkml/20190607162349.18199-1-john.ogness@linutronix.de/

WARNING:

[   42.605235] ======================================================
[   42.605236] WARNING: possible circular locking dependency detected
[   42.605237] 5.2.0+ #63 Tainted: G     U           
[   42.605238] ------------------------------------------------------
[   42.605239] sysctl_fuzzer/2697 is trying to acquire lock:
[   42.605239] 00000000d28828ac (console_owner){-.-.}, at: console_unlock+0x23f/0x9a0
[   42.605243] 
[   42.605243] but task is already holding lock:
[   42.605244] 00000000f7c4cf7b (&(&port->lock)->rlock){-.-.}, at: pty_write+0xd5/0x1e0
[   42.605247] 
[   42.605248] which lock already depends on the new lock.
[   42.605248] 
[   42.605249] 
[   42.605250] the existing dependency chain (in reverse order) is:
[   42.605250] 
[   42.605251] -> #2 (&(&port->lock)->rlock){-.-.}:
[   42.605254]        _raw_spin_lock_irqsave+0x44/0x90
[   42.605255]        tty_port_tty_get+0x24/0x90
[   42.605255]        tty_port_default_wakeup+0x10/0x30
[   42.605256]        tty_port_tty_wakeup+0x5c/0x70
[   42.605257]        uart_write_wakeup+0x3c/0x50
[   42.605258]        serial8250_tx_chars+0x3d2/0xb10
[   42.605259]        serial8250_handle_irq.part.0+0x14a/0x240
[   42.605259]        serial8250_default_handle_irq+0x8c/0xf0
[   42.605260]        serial8250_interrupt+0xd6/0x150
[   42.605261]        __handle_irq_event_percpu+0x1c2/0x640
[   42.605262]        handle_irq_event_percpu+0x71/0x150
[   42.605263]        handle_irq_event+0xa7/0x134
[   42.605263]        handle_edge_irq+0x218/0xa50
[   42.605264]        handle_irq+0x46/0x60
[   42.605265]        do_IRQ+0xbc/0x250
[   42.605265]        ret_from_intr+0x0/0x1d
[   42.605266]        default_idle+0x2f/0x2d0
[   42.605267]        arch_cpu_idle+0x15/0x20
[   42.605268]        default_idle_call+0x40/0x60
[   42.605268]        do_idle+0x315/0x3c0
[   42.605269]        cpu_startup_entry+0x20/0x22
[   42.605270]        rest_init+0x1ea/0x333
[   42.605270]        arch_call_rest_init+0xe/0x1b
[   42.605271]        start_kernel+0x6e0/0x71b
[   42.605272]        x86_64_start_reservations+0x24/0x26
[   42.605273]        x86_64_start_kernel+0x75/0x79
[   42.605273]        secondary_startup_64+0xa4/0xb0
[   42.605274] 
[   42.605275] -> #1 (&port_lock_key){-.-.}:
[   42.605277]        _raw_spin_lock_irqsave+0x44/0x90
[   42.605278]        serial8250_console_write+0x142/0x730
[   42.605279]        univ8250_console_write+0x6c/0xa0
[   42.605280]        console_unlock+0x5cf/0x9a0
[   42.605280]        register_console+0x559/0xa10
[   42.605281]        univ8250_console_init+0x23/0x2d
[   42.605282]        console_init+0x339/0x4b9
[   42.605283]        start_kernel+0x43d/0x71b
[   42.605283]        x86_64_start_reservations+0x24/0x26
[   42.605284]        x86_64_start_kernel+0x75/0x79
[   42.605285]        secondary_startup_64+0xa4/0xb0
[   42.605286] 
[   42.605286] -> #0 (console_owner){-.-.}:
[   42.605289]        __lock_acquire+0x2921/0x56a0
[   42.605290]        lock_acquire+0x151/0x380
[   42.605290]        console_unlock+0x29c/0x9a0
[   42.605291]        vprintk_emit+0xee/0x2b0
[   42.605292]        vprintk_default+0x1f/0x30
[   42.605292]        vprintk_func+0x50/0x1df
[   42.605293]        printk+0xb2/0xe3
[   42.605294]        __queue_work.cold+0x79/0xc3
[   42.605295]        queue_work_on+0x72/0x80
[   42.605295]        tty_flip_buffer_push+0xbf/0x120
[   42.605296]        pty_write+0x164/0x1e0
[   42.605297]        n_tty_write+0x368/0x10e0
[   42.605298]        tty_write+0x381/0x710
[   42.605298]        __vfs_write+0x65/0x110
[   42.605299]        vfs_write+0x171/0x4b0
[   42.605300]        ksys_write+0x122/0x220
[   42.605301]        __x64_sys_write+0x73/0xb0
[   42.605302]        do_syscall_64+0x9a/0x450
[   42.605303]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   42.605304] 
[   42.605305] other info that might help us debug this:
[   42.605306] 
[   42.605307] Chain exists of:
[   42.605308]   console_owner --> &port_lock_key --> &(&port->lock)->rlock
[   42.605314] 
[   42.605316]  Possible unsafe locking scenario:
[   42.605316] 
[   42.605318]        CPU0                    CPU1
[   42.605319]        ----                    ----
[   42.605320]   lock(&(&port->lock)->rlock);
[   42.605323]                                lock(&port_lock_key);
[   42.605326]                                lock(&(&port->lock)->rlock);
[   42.605329]   lock(console_owner);
[   42.605332] 
[   42.605334]  *** DEADLOCK ***
[   42.605335] 
[   42.605336] 7 locks held by sysctl_fuzzer/2697:
[   42.605337]  #0: 0000000060a0e6d1 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40
[   42.605343]  #1: 0000000038316e97 (&tty->atomic_write_lock){+.+.}, at: tty_write_lock+0x1d/0x50
[   42.605348]  #2: 000000000e2d59d0 (&o_tty->termios_rwsem/1){++++}, at: n_tty_write+0x17e/0x10e0
[   42.605356]  #3: 0000000039ef394c (&ldata->output_lock){+.+.}, at: n_tty_write+0x44c/0x10e0
[   42.605361]  #4: 00000000f7c4cf7b (&(&port->lock)->rlock){-.-.}, at: pty_write+0xd5/0x1e0
[   42.605364]  #5: 0000000017933ff3 (rcu_read_lock){....}, at: __queue_work+0xeb/0x1000
[   42.605367]  #6: 0000000088e0121a (console_lock){+.+.}, at: vprintk_emit+0xe5/0x2b0
[   42.605370] 
[   42.605371] stack backtrace:
[   42.605372] CPU: 1 PID: 2697 Comm: sysctl_fuzzer Tainted: G     U            5.2.0+ #63
[   42.605373] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
[   42.605374] Call Trace:
[   42.605374]  dump_stack+0x86/0xca
[   42.605375]  print_circular_bug.cold+0x163/0x172
[   42.605376]  check_noncircular+0x330/0x3d0
[   42.605376]  ? print_circular_bug+0x1b0/0x1b0
[   42.605377]  ? graph_lock+0x7a/0x180
[   42.605378]  ? check_chain_key+0x590/0x590
[   42.605379]  __lock_acquire+0x2921/0x56a0
[   42.605379]  ? register_lock_class+0x1640/0x1640
[   42.605380]  lock_acquire+0x151/0x380
[   42.605381]  ? console_unlock+0x23f/0x9a0
[   42.605382]  console_unlock+0x29c/0x9a0
[   42.605382]  ? console_unlock+0x23f/0x9a0
[   42.605383]  ? __down_trylock_console_sem+0x89/0xa0
[   42.605384]  vprintk_emit+0xee/0x2b0
[   42.605384]  vprintk_default+0x1f/0x30
[   42.605385]  vprintk_func+0x50/0x1df
[   42.605386]  ? debug_object_activate+0x20e/0x490
[   42.605387]  printk+0xb2/0xe3
[   42.605387]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[   42.605388]  ? lock_acquire+0x151/0x380
[   42.605389]  ? __queue_work+0xeb/0x1000
[   42.605389]  ? kasan_check_read+0x11/0x20
[   42.605390]  ? rcu_dynticks_curr_cpu_in_eqs+0x87/0x100
[   42.605391]  __queue_work.cold+0x79/0xc3
[   42.605392]  ? lockdep_hardirqs_off+0x1f4/0x2e0
[   42.605392]  queue_work_on+0x72/0x80
[   42.605393]  tty_flip_buffer_push+0xbf/0x120
[   42.605394]  pty_write+0x164/0x1e0
[   42.605395]  n_tty_write+0x368/0x10e0
[   42.605395]  ? n_tty_open+0x160/0x160
[   42.605396]  ? do_wait_intr_irq+0x350/0x350
[   42.605397]  ? kasan_check_write+0x14/0x20
[   42.605397]  tty_write+0x381/0x710
[   42.605398]  ? n_tty_open+0x160/0x160
[   42.605399]  __vfs_write+0x65/0x110
[   42.605399]  vfs_write+0x171/0x4b0
[   42.605400]  ksys_write+0x122/0x220
[   42.605401]  ? __ia32_sys_read+0xb0/0xb0
[   42.605402]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   42.605402]  ? lockdep_hardirqs_on+0x35b/0x5d0
[   42.605403]  __x64_sys_write+0x73/0xb0
[   42.605404]  do_syscall_64+0x9a/0x450
[   42.605405]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   42.605405] RIP: 0033:0x7fe9c296d0f8
[   42.605407] Code: 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 25 96 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 60 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[   42.605408] RSP: 002b:00007fff1abc6f68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   42.605409] RAX: ffffffffffffffda RBX: 000000000000003a RCX: 00007fe9c296d0f8
[   42.605410] RDX: 000000000000003a RSI: 00007fff1abc7140 RDI: 0000000000000001
[   42.605411] RBP: 00007fff1abc7140 R08: 00007fe9c2a48500 R09: 000000000000003a
[   42.605412] R10: 000000000051c920 R11: 0000000000000246 R12: 000000000000003a
[   42.605414] R13: 00007fe9c2a42780 R14: 000000000000003a R15: 00007fe9c2a3d740
[   42.792367] ------------[ cut here ]------------
