Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DACCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826E42067D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VVipEdgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfJ3Vkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:40:39 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:33386 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3Vkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:40:37 -0400
Received: by mail-qk1-f170.google.com with SMTP id 71so4540364qkl.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 14:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=F5cnJFX5I6tq847NeaIV2AJdBrpUD3Xz4JzPYMazgrE=;
        b=VVipEdgkw5d9mnEXkf6qlw2vPpZ5nuFaLlpXqXvd8D1OS55lxer+2ybMPGW4YoUInT
         j+/RI8osCm4k+H3D8/erKNZUB7LJRp4lYn5Zx3+qIOX9WjU3JcEcmoFV5+1vI39Pq2+9
         o7x+toiTYmcdOUtrsr9ug5XM/NRgg0nISFU3fYUdIdCtvqzSGMcKVkPzAVT/BZxLcvTn
         3b5U8norNEERp2LJz+fioMI1eDbjm8qBmuALS9MBJKzUot/55NlCvQmMhYabi3N4wWlR
         3QOa7x/Z7f+Y256R+gWyY5P+SSW2ASbHBy30S7TjnPxerwq4NvqTxBnm614HSwfKGFPb
         vSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=F5cnJFX5I6tq847NeaIV2AJdBrpUD3Xz4JzPYMazgrE=;
        b=q+R5HyBpFiN0rv/6T5WT9m+z3q+4ThAlsFgps7yXZT8ivcVsgzN4CM0+tTVxyaP4r3
         ycbgze68ijliF7a9/NVrrRdzzZbd6K1in92Sz8PWuUb+dwHlAoV86lXEuc+HPY80HIb4
         2lU6TOP1AOUGX8vV96xd6zhxYgs5TZoIx7pHXs4CVK66WghsUmFU2Fa8nk8KBfgJEgWO
         WdUDzjzWoalU4A+rRWwAn8B2axPHkUTqP4y+jCRtJc2uNxo/bx5oUVnv3yWE1PMjev4R
         i3C+/JBCHaQiTYPltDmec53Gzt9PqH8kHTIO7r8b2kaFsrMct4kRRpEN2n3lALw/6Cge
         uFwA==
X-Gm-Message-State: APjAAAUpF9aS9WjmF6dRh1ii9qAkLR1gml1FpDFw14ptGwcJlvD7Zvx7
        9qrMfkMpJ8qQfesWWiy/D01QMw==
X-Google-Smtp-Source: APXvYqzfnWXrGUtV0WzdYE24ePJpoOenjZmg4NxsZoddVsSBVw9FeQYZpKbdTvAMwLa3c3zWtKO9fQ==
X-Received: by 2002:a37:9507:: with SMTP id x7mr2148864qkd.346.1572471636325;
        Wed, 30 Oct 2019 14:40:36 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g27sm1069316qtk.49.2019.10.30.14.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 14:40:35 -0700 (PDT)
Message-ID: <1572471633.5937.112.camel@lca.pw>
Subject: "Fix data race in tty_insert_flip_string_fixed_flag" triggers a
 lockdep warning
From:   Qian Cai <cai@lca.pw>
To:     DaeRyong Jeong <threeearcat@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Date:   Wed, 30 Oct 2019 17:40:33 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit b6da31b2c07c ("tty: Fix data race in
tty_insert_flip_string_fixed_flag") creates a locking order,

&(&port->lock)->rlock --> &(&zone->lock)->rlock

which will trigger a lockdep warning below.

[  489.312784] WARNING: possible circular locking dependency detected
[  489.319655] 5.4.0-rc5-next-20191030+ #2 Tainted: G        W    L   
[  489.326610] ------------------------------------------------------
[  489.333479] sshd/5541 is trying to acquire lock:
[  489.338785] ffff008b7cff9290 (&(&zone->lock)->rlock){..-.}, at:
rmqueue+0xfe8/0x2274
[  489.347230] 
               but task is already holding lock:
[  489.354444] 1cff0009e39c0540 (&(&port->lock)->rlock){-.-.}, at:
pty_write+0x60/0xd0
[  489.362799] 
               which lock already depends on the new lock.

[  489.373052] 
               the existing dependency chain (in reverse order) is:
[  489.381916] 
               -> #3 (&(&port->lock)->rlock){-.-.}:
[  489.389403]        lock_acquire+0x320/0x360
[  489.394279]        _raw_spin_lock_irqsave+0x7c/0x9c
[  489.399849]        tty_port_tty_get+0x24/0x60
[  489.404896]        tty_port_default_wakeup+0x1c/0x3c
[  489.410551]        tty_port_tty_wakeup+0x34/0x40
[  489.415859]        uart_write_wakeup+0x28/0x44
[  489.420993]        pl011_tx_chars+0x1b8/0x270
[  489.426040]        pl011_start_tx+0x24/0x70
[  489.430913]        __uart_start+0x5c/0x68
[  489.435612]        uart_write+0x164/0x1c8
[  489.440312]        do_output_char+0x33c/0x348
[  489.445358]        n_tty_write+0x4bc/0x60c
[  489.450143]        tty_write+0x338/0x474
[  489.454755]        redirected_tty_write+0xc0/0xdc
[  489.460150]        do_loop_readv_writev+0x140/0x180
[  489.465718]        do_iter_write+0xe0/0x10c
[  489.470590]        vfs_writev+0x134/0x1cc
[  489.475289]        do_writev+0xbc/0x130
[  489.479815]        __arm64_sys_writev+0x58/0x8c
[  489.485038]        el0_svc_handler+0x170/0x240
[  489.490173]        el0_sync_handler+0x150/0x250
[  489.495393]        el0_sync+0x164/0x180
[  489.499915] 
               -> #2 (&port_lock_key){-.-.}:
[  489.506793]        lock_acquire+0x320/0x360
[  489.511666]        _raw_spin_lock+0x64/0x80
[  489.516540]        pl011_console_write+0xec/0x2cc
[  489.521934]        console_unlock+0x794/0x96c
[  489.526981]        vprintk_emit+0x260/0x31c
[  489.531854]        vprintk_default+0x54/0x7c
[  489.536813]        vprintk_func+0x218/0x254
[  489.541687]        printk+0x7c/0xa4

               -> #1 (console_owner){-...}:
[  489.703613]        lock_acquire+0x320/0x360
[  489.708486]        console_lock_spinning_enable+0x6c/0x7c
[  489.714575]        console_unlock+0x4f8/0x96c
[  489.719622]        vprintk_emit+0x260/0x31c
[  489.724495]        vprintk_default+0x54/0x7c
[  489.729454]        vprintk_func+0x218/0x254
[  489.734327]        printk+0x7c/0xa4
[  489.810371] 
               -> #0 (&(&zone->lock)->rlock){..-.}:
[  489.817854]        validate_chain+0xf6c/0x2e2c
[  489.822988]        __lock_acquire+0x868/0xc2c
[  489.828035]        lock_acquire+0x320/0x360
[  489.832909]        _raw_spin_lock_irqsave+0x7c/0x9c
[  489.838475]        rmqueue+0xfe8/0x2274
[  489.843002]        get_page_from_freelist+0x474/0x688
[  489.848743]        __alloc_pages_nodemask+0x3b8/0x1928
[  489.854573]        alloc_pages_current+0xd0/0xe0
[  489.859882]        stack_depot_save+0x300/0x440
[  489.865103]        __kasan_kmalloc+0x198/0x1e0
[  489.870236]        kasan_slab_alloc+0x18/0x20
[  489.875284]        slab_post_alloc_hook+0x48/0x9c
[  489.880677]        kmem_cache_alloc+0x2e8/0x588
[  489.885898]        create_object+0x60/0x698
[  489.890771]        kmemleak_alloc+0x78/0xb8
[  489.895644]        slab_post_alloc_hook+0x64/0x9c
[  489.901038]        __kmalloc+0x328/0x490
[  489.905652]        __tty_buffer_request_room+0x118/0x1f8
[  489.911654]        tty_insert_flip_string_fixed_flag+0x6c/0x144
[  489.918263]        pty_write+0x80/0xd0
[  489.922701]        n_tty_write+0x450/0x60c
[  489.927486]        tty_write+0x338/0x474
[  489.932098]        __vfs_write+0x88/0x214
[  489.936796]        vfs_write+0x12c/0x1a4
[  489.941411]        ksys_write+0xb0/0x120
[  489.946027]        __arm64_sys_write+0x54/0x88
[  489.951161]        el0_svc_handler+0x170/0x240
[  489.956294]        el0_sync_handler+0x150/0x250
[  489.961514]        el0_sync+0x164/0x180
[  489.966038] 
               other info that might help us debug this:

[  489.976117] Chain exists of:
                 &(&zone->lock)->rlock --> &port_lock_key --> &(&port->lock)-
>rlock

[  489.989937]  Possible unsafe locking scenario:

[  489.997239]        CPU0                    CPU1
[  490.002456]        ----                    ----
[  490.007673]   lock(&(&port->lock)->rlock);
[  490.012459]                                lock(&port_lock_key);
[  490.019155]                                lock(&(&port->lock)->rlock);
[  490.026458]   lock(&(&zone->lock)->rlock);
[  490.031244] 
                *** DEADLOCK ***

[  490.039241] 5 locks held by sshd/5541:
[  490.043677]  #0: 12ff0009eb0c6890 (&tty->ldisc_sem){++++}, at:
ldsem_down_read+0x3c/0x48
[  490.052465]  #1: 12ff0009eb0c6918 (&tty->atomic_write_lock){+.+.}, at:
tty_write+0x12c/0x474
[  490.061599]  #2: 12ff0009eb0c6aa0 (&o_tty->termios_rwsem/1){++++}, at:
n_tty_write+0x10c/0x60c
[  490.070908]  #3: ffff90001f852360 (&ldata->output_lock){+.+.}, at:
n_tty_write+0x278/0x60c
[  490.079868]  #4: 1cff0009e39c0540 (&(&port->lock)->rlock){-.-.}, at:
pty_write+0x60/0xd0
[  490.088654] 
               stack backtrace:
[  490.094398] CPU: 31 PID: 5541 Comm: sshd Tainted: G        W    L    5.4.0-
rc5-next-20191030+ #2
[  490.103871] Hardware name: HPE Apollo 70             /C01_APACHE_MB         ,
BIOS L50_5.13_1.11 06/18/2019
[  490.114300] Call trace:
[  490.117438]  dump_backtrace+0x0/0x248
[  490.121791]  show_stack+0x20/0x2c
[  490.125798]  dump_stack+0xc8/0x130
[  490.129890]  print_circular_bug+0x368/0x380
[  490.134764]  check_noncircular+0x28c/0x294
[  490.139550]  validate_chain+0xf6c/0x2e2c
[  490.144164]  __lock_acquire+0x868/0xc2c
[  490.148691]  lock_acquire+0x320/0x360
[  490.153044]  _raw_spin_lock_irqsave+0x7c/0x9c
[  490.158090]  rmqueue+0xfe8/0x2274
[  490.162097]  get_page_from_freelist+0x474/0x688
[  490.167317]  __alloc_pages_nodemask+0x3b8/0x1928
[  490.172625]  alloc_pages_current+0xd0/0xe0
[  490.177412]  stack_depot_save+0x300/0x440
[  490.182112]  __kasan_kmalloc+0x198/0x1e0
[  490.186723]  kasan_slab_alloc+0x18/0x20
[  490.191249]  slab_post_alloc_hook+0x48/0x9c
[  490.196121]  kmem_cache_alloc+0x2e8/0x588
[  490.200820]  create_object+0x60/0x698
[  490.205173]  kmemleak_alloc+0x78/0xb8
[  490.209525]  slab_post_alloc_hook+0x64/0x9c
[  490.214398]  __kmalloc+0x328/0x490
[  490.218491]  __tty_buffer_request_room+0x118/0x1f8
[  490.223972]  tty_insert_flip_string_fixed_flag+0x6c/0x144
[  490.230059]  pty_write+0x80/0xd0
[  490.233977]  n_tty_write+0x450/0x60c
[  490.238241]  tty_write+0x338/0x474
[  490.242333]  __vfs_write+0x88/0x214
[  490.246511]  vfs_write+0x12c/0x1a4
[  490.250601]  ksys_write+0xb0/0x120
[  490.254693]  __arm64_sys_write+0x54/0x88
[  490.259305]  el0_svc_handler+0x170/0x240
[  490.263918]  el0_sync_handler+0x150/0x250
[  490.268617]  el0_sync+0x164/0x180
