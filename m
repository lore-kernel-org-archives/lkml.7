Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5452C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8CF20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OiDWg1Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439683AbfIWNJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:09:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33751 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394628AbfIWNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:09:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so17052269qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSzz5XQvxgflxT/FvAaiUFnx8up/v7Hpnevvf+GpZPc=;
        b=OiDWg1KuS5OTuo5GyVXTLl82icpVWt8MK9+WQaTDDjbyN6Gc3uTgcTRRjDMOM4HaSq
         xKJ+TxAmW2u5SqPkttXWIJUf5QRndHlT1zVIVqzUBeoM/xv9tGq5rbpxXQ5aStAYds/G
         iu8Zao+D2nm8vLXTXzuzsaLwqAU8acaMihp3xEl9I7/fQQTi1tQKKwGDbLm5pQuVo3Hr
         cqG+wtbHegw4VV8s35qMZYbk8/KH+kDDBGwhDpDqoxonsO2fa07m2ixn3VEdws7efEWK
         g2jgKudAlmfVDyZ5ENAqTahl5KnpjuVxjPptNf9HD8drzPtx4Q8/YYe1FlgzIyC2szcO
         1hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSzz5XQvxgflxT/FvAaiUFnx8up/v7Hpnevvf+GpZPc=;
        b=hqtpfqWz46sN0iXmgMem/C7OCUyQbs4xVPRsHGPMQSNOk7aEm9q7yMjy6N/kzjUxkv
         f+bNP7C5Y2Md/TOkxXSZ5xvjhKlJUrAcahemdHbSg45+eK6p+ma0C/OQOsqP7oEq8bqD
         bQIfJMzvfCmruPji9rsNQexnyGOlwkTHPm6WCfz8QeCeAoe0ZuIPF/kTlitufflgi2NF
         Q+iQG/eQWhPPS1LxRZY1K0ltKKo3ihUbPoBYe6/Ft4E4i7P9HdxMB9TrWigFn+7D9m6Q
         jDmDlg0ngLOpZUvs7W98uoc/KbakdpTxoHjmup9HcaL5zLBQgLg0DRudsX6uBYdcvfL9
         677A==
X-Gm-Message-State: APjAAAVE8KquUyOW//A/tvw3ct5gbnKw6DEHzQVgswXTEet7elmCcKl5
        2ecgGNFaxIiGRfJSZUu28DGd1Q==
X-Google-Smtp-Source: APXvYqwh14TKUCZ9URbPOIgMpTyzkBS8i/KA8u2wP08g+3gEm8WjkqF4VRDm3ew76GGGq7EpSHOjNQ==
X-Received: by 2002:ac8:7644:: with SMTP id i4mr17370824qtr.62.1569244163320;
        Mon, 23 Sep 2019 06:09:23 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q49sm6718786qta.60.2019.09.23.06.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 06:09:22 -0700 (PDT)
Message-ID: <1569244161.5576.207.camel@lca.pw>
Subject: Re: printk() + memory offline deadlock (WAS Re:
 page_alloc.shuffle=1 + CONFIG_PROVE_LOCKING=y = arm64 hang)
From:   Qian Cai <cai@lca.pw>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 23 Sep 2019 09:09:21 -0400
In-Reply-To: <20190923102100.GA1171@jagdpanzerIV>
References: <1566509603.5576.10.camel@lca.pw>
         <1567717680.5576.104.camel@lca.pw> <1568128954.5576.129.camel@lca.pw>
         <20190911011008.GA4420@jagdpanzerIV> <1568289941.5576.140.camel@lca.pw>
         <20190916104239.124fc2e5@gandalf.local.home>
         <1568817579.5576.172.camel@lca.pw>
         <20190918155059.GA158834@tigerII.localdomain>
         <1568823006.5576.178.camel@lca.pw> <20190923102100.GA1171@jagdpanzerIV>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-23 at 19:21 +0900, Sergey Senozhatsky wrote:
> On (09/18/19 12:10), Qian Cai wrote:
> [..]
> > > So you have debug objects enabled. Right? This thing does not behave
> > > when it comes to printing. debug_objects are slightly problematic.
> > 
> > Yes, but there is an also a similar splat without the debug_objects. It looks
> > like anything try to allocate memory in that path will trigger it anyway.
> 
> Appears to be different, yet somehow very familiar.
> 
> > [  297.425908] WARNING: possible circular locking dependency detected
> > [  297.425908] 5.3.0-next-20190917 #8 Not tainted
> > [  297.425909] ------------------------------------------------------
> > [  297.425910] test.sh/8653 is trying to acquire lock:
> > [  297.425911] ffffffff865a4460 (console_owner){-.-.}, at:
> > console_unlock+0x207/0x750
> > 
> > [  297.425914] but task is already holding lock:
> > [  297.425915] ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
> > __offline_isolated_pages+0x179/0x3e0
> > 
> > [  297.425919] which lock already depends on the new lock.
> > 
> > 
> > [  297.425920] the existing dependency chain (in reverse order) is:
> > 
> > [  297.425922] -> #3 (&(&zone->lock)->rlock){-.-.}:
> > [  297.425925]        __lock_acquire+0x5b3/0xb40
> > [  297.425925]        lock_acquire+0x126/0x280
> > [  297.425926]        _raw_spin_lock+0x2f/0x40
> > [  297.425927]        rmqueue_bulk.constprop.21+0xb6/0x1160
> > [  297.425928]        get_page_from_freelist+0x898/0x22c0
> > [  297.425928]        __alloc_pages_nodemask+0x2f3/0x1cd0
> > [  297.425929]        alloc_pages_current+0x9c/0x110
> > [  297.425930]        allocate_slab+0x4c6/0x19c0
> > [  297.425931]        new_slab+0x46/0x70
> > [  297.425931]        ___slab_alloc+0x58b/0x960
> > [  297.425932]        __slab_alloc+0x43/0x70
> > [  297.425933]        __kmalloc+0x3ad/0x4b0
> > [  297.425933]        __tty_buffer_request_room+0x100/0x250
> > [  297.425934]        tty_insert_flip_string_fixed_flag+0x67/0x110
> > [  297.425935]        pty_write+0xa2/0xf0
> > [  297.425936]        n_tty_write+0x36b/0x7b0
> > [  297.425936]        tty_write+0x284/0x4c0
> > [  297.425937]        __vfs_write+0x50/0xa0
> > [  297.425938]        vfs_write+0x105/0x290
> > [  297.425939]        redirected_tty_write+0x6a/0xc0
> > [  297.425939]        do_iter_write+0x248/0x2a0
> > [  297.425940]        vfs_writev+0x106/0x1e0
> > [  297.425941]        do_writev+0xd4/0x180
> > [  297.425941]        __x64_sys_writev+0x45/0x50
> > [  297.425942]        do_syscall_64+0xcc/0x76c
> > [  297.425943]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > [  297.425944] -> #2 (&(&port->lock)->rlock){-.-.}:
> > [  297.425946]        __lock_acquire+0x5b3/0xb40
> > [  297.425947]        lock_acquire+0x126/0x280
> > [  297.425948]        _raw_spin_lock_irqsave+0x3a/0x50
> > [  297.425949]        tty_port_tty_get+0x20/0x60
> > [  297.425949]        tty_port_default_wakeup+0xf/0x30
> > [  297.425950]        tty_port_tty_wakeup+0x39/0x40
> > [  297.425951]        uart_write_wakeup+0x2a/0x40
> > [  297.425952]        serial8250_tx_chars+0x22e/0x440
> > [  297.425952]        serial8250_handle_irq.part.8+0x14a/0x170
> > [  297.425953]        serial8250_default_handle_irq+0x5c/0x90
> > [  297.425954]        serial8250_interrupt+0xa6/0x130
> > [  297.425955]        __handle_irq_event_percpu+0x78/0x4f0
> > [  297.425955]        handle_irq_event_percpu+0x70/0x100
> > [  297.425956]        handle_irq_event+0x5a/0x8b
> > [  297.425957]        handle_edge_irq+0x117/0x370
> > [  297.425958]        do_IRQ+0x9e/0x1e0
> > [  297.425958]        ret_from_intr+0x0/0x2a
> > [  297.425959]        cpuidle_enter_state+0x156/0x8e0
> > [  297.425960]        cpuidle_enter+0x41/0x70
> > [  297.425960]        call_cpuidle+0x5e/0x90
> > [  297.425961]        do_idle+0x333/0x370
> > [  297.425962]        cpu_startup_entry+0x1d/0x1f
> > [  297.425962]        start_secondary+0x290/0x330
> > [  297.425963]        secondary_startup_64+0xb6/0xc0
> > 
> > [  297.425964] -> #1 (&port_lock_key){-.-.}:
> > [  297.425967]        __lock_acquire+0x5b3/0xb40
> > [  297.425967]        lock_acquire+0x126/0x280
> > [  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
> > [  297.425969]        serial8250_console_write+0x3e4/0x450
> > [  297.425970]        univ8250_console_write+0x4b/0x60
> > [  297.425970]        console_unlock+0x501/0x750
> > [  297.425971]        vprintk_emit+0x10d/0x340
> > [  297.425972]        vprintk_default+0x1f/0x30
> > [  297.425972]        vprintk_func+0x44/0xd4
> > [  297.425973]        printk+0x9f/0xc5
> > [  297.425974]        register_console+0x39c/0x520
> > [  297.425975]        univ8250_console_init+0x23/0x2d
> > [  297.425975]        console_init+0x338/0x4cd
> > [  297.425976]        start_kernel+0x534/0x724
> > [  297.425977]        x86_64_start_reservations+0x24/0x26
> > [  297.425977]        x86_64_start_kernel+0xf4/0xfb
> > [  297.425978]        secondary_startup_64+0xb6/0xc0
> > 
> > [  297.425979] -> #0 (console_owner){-.-.}:
> > [  297.425982]        check_prev_add+0x107/0xea0
> > [  297.425982]        validate_chain+0x8fc/0x1200
> > [  297.425983]        __lock_acquire+0x5b3/0xb40
> > [  297.425984]        lock_acquire+0x126/0x280
> > [  297.425984]        console_unlock+0x269/0x750
> > [  297.425985]        vprintk_emit+0x10d/0x340
> > [  297.425986]        vprintk_default+0x1f/0x30
> > [  297.425987]        vprintk_func+0x44/0xd4
> > [  297.425987]        printk+0x9f/0xc5
> > [  297.425988]        __offline_isolated_pages.cold.52+0x2f/0x30a
> > [  297.425989]        offline_isolated_pages_cb+0x17/0x30
> > [  297.425990]        walk_system_ram_range+0xda/0x160
> > [  297.425990]        __offline_pages+0x79c/0xa10
> > [  297.425991]        offline_pages+0x11/0x20
> > [  297.425992]        memory_subsys_offline+0x7e/0xc0
> > [  297.425992]        device_offline+0xd5/0x110
> > [  297.425993]        state_store+0xc6/0xe0
> > [  297.425994]        dev_attr_store+0x3f/0x60
> > [  297.425995]        sysfs_kf_write+0x89/0xb0
> > [  297.425995]        kernfs_fop_write+0x188/0x240
> > [  297.425996]        __vfs_write+0x50/0xa0
> > [  297.425997]        vfs_write+0x105/0x290
> > [  297.425997]        ksys_write+0xc6/0x160
> > [  297.425998]        __x64_sys_write+0x43/0x50
> > [  297.425999]        do_syscall_64+0xcc/0x76c
> > [  297.426000]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> I suppose you run with CONFIG_DEBUG_VM...
> 
> So we have
> 
> port->lock -> MM -> zone->lock
> 	// from pty_write()->__tty_buffer_request_room()->kmalloc()
> 
> vs
> 
> zone->lock -> printk() -> port->lock
> 	// from __offline_pages()->__offline_isolated_pages()->printk()
> 
> 
> A number of debugging options make the kernel less stable.
> Sad but true.

I am afraid it does not matter, as it still trigger a splat without either
CONFIG_DEBUG_VM and debug objects because offline_pages() will still call
printk() while holding zone->lock in a different path.

offline_pages()
  start_isolate_page_range()
    set_migratetype_isolate()
      has_unmovable_pages()
        dump_page()
          printk()

[  377.525562] WARNING: possible circular locking dependency detected
[  377.525563] 5.3.0-next-20190920+ #9 Not tainted
[  377.525564] ------------------------------------------------------
[  377.525565] test.sh/8876 is trying to acquire lock:
[  377.525565] ffffffffa2da1b80 (console_owner){-.-.}, at:
console_unlock+0x207/0x750

[  377.525569] but task is already holding lock:
[  377.525569] ffff88883fff4318 (&(&zone->lock)->rlock){-.-.}, at:
start_isolate_page_range+0x1ea/0x540

[  377.525573] which lock already depends on the new lock.


[  377.525575] the existing dependency chain (in reverse order) is:

[  377.525576] -> #3 (&(&zone->lock)->rlock){-.-.}:
[  377.525579]        __lock_acquire+0x5b3/0xb40
[  377.525579]        lock_acquire+0x126/0x280
[  377.525580]        _raw_spin_lock+0x2f/0x40
[  377.525581]        rmqueue_bulk.constprop.21+0xb6/0xf70
[  377.525582]        get_page_from_freelist+0x89a/0x20d0
[  377.525582]        __alloc_pages_nodemask+0x2b1/0x1c80
[  377.525583]        alloc_pages_current+0x9c/0x110
[  377.525584]        allocate_slab+0xa8f/0x16d0
[  377.525585]        new_slab+0x46/0x70
[  377.525586]        ___slab_alloc+0x424/0x630
[  377.525586]        __slab_alloc+0x43/0x70
[  377.525587]        __kmalloc+0x3e3/0x490
[  377.525588]        __tty_buffer_request_room+0x100/0x250
[  377.525589]        tty_insert_flip_string_fixed_flag+0x67/0x110
[  377.525590]        pty_write+0xa2/0xf0
[  377.525591]        n_tty_write+0x36b/0x7b0
[  377.525592]        tty_write+0x284/0x4c0
[  377.525593]        __vfs_write+0x50/0xa0
[  377.525593]        vfs_write+0x105/0x290
[  377.525595]        ksys_write+0xc6/0x160
[  377.525596]        __x64_sys_write+0x43/0x50
[  377.525596]        do_syscall_64+0xcc/0x76c
[  377.525597]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  377.525598] -> #2 (&(&port->lock)->rlock){-.-.}:
[  377.525601]        __lock_acquire+0x5b3/0xb40
[  377.525601]        lock_acquire+0x126/0x280
[  377.525602]        _raw_spin_lock_irqsave+0x3a/0x50
[  377.525603]        tty_port_tty_get+0x20/0x60
[  377.525604]        tty_port_default_wakeup+0xf/0x30
[  377.525605]        tty_port_tty_wakeup+0x39/0x40
[  377.525606]        uart_write_wakeup+0x2a/0x40
[  377.525607]        serial8250_tx_chars+0x22e/0x440
[  377.525607]        serial8250_handle_irq.part.8+0x14a/0x170
[  377.525608]        serial8250_default_handle_irq+0x5c/0x90
[  377.525609]        serial8250_interrupt+0xa6/0x130
[  377.525610]        __handle_irq_event_percpu+0x78/0x4f0
[  377.525611]        handle_irq_event_percpu+0x70/0x100
[  377.525612]        handle_irq_event+0x5a/0x8b
[  377.525613]        handle_edge_irq+0x117/0x370
[  377.525614]        do_IRQ+0x9e/0x1e0
[  377.525614]        ret_from_intr+0x0/0x2a
[  377.525615]        cpuidle_enter_state+0x156/0x8e0
[  377.525616]        cpuidle_enter+0x41/0x70
[  377.525616]        call_cpuidle+0x5e/0x90
[  377.525617]        do_idle+0x333/0x370
[  377.525618]        cpu_startup_entry+0x1d/0x1f
[  377.525619]        start_secondary+0x290/0x330
[  377.525619]        secondary_startup_64+0xb6/0xc0

[  377.525620] -> #1 (&port_lock_key){-.-.}:
[  377.525623]        __lock_acquire+0x5b3/0xb40
[  377.525623]        lock_acquire+0x126/0x280
[  377.525624]        _raw_spin_lock_irqsave+0x3a/0x50
[  377.525625]        serial8250_console_write+0x3e4/0x450
[  377.525626]        univ8250_console_write+0x4b/0x60
[  377.525627]        console_unlock+0x501/0x750
[  377.525627]        vprintk_emit+0x10d/0x340
[  377.525628]        vprintk_default+0x1f/0x30
[  377.525629]        vprintk_func+0x44/0xd4
[  377.525629]        printk+0x9f/0xc5
[  377.525630]        register_console+0x39c/0x520
[  377.525631]        univ8250_console_init+0x23/0x2d
[  377.525632]        console_init+0x338/0x4cd
[  377.525632]        start_kernel+0x52a/0x71a
[  377.525633]        x86_64_start_reservations+0x24/0x26
[  377.525634]        x86_64_start_kernel+0xf4/0xfb
[  377.525635]        secondary_startup_64+0xb6/0xc0

[  377.525636] -> #0 (console_owner){-.-.}:
[  377.525638]        check_prev_add+0x107/0xea0
[  377.525639]        validate_chain+0x8fc/0x1200
[  377.525640]        __lock_acquire+0x5b3/0xb40
[  377.525641]        lock_acquire+0x126/0x280
[  377.525641]        console_unlock+0x269/0x750
[  377.525642]        vprintk_emit+0x10d/0x340
[  377.525643]        vprintk_default+0x1f/0x30
[  377.525643]        vprintk_func+0x44/0xd4
[  377.525644]        printk+0x9f/0xc5
[  377.525645]        __dump_page.cold.0+0x73/0x20a
[  377.525645]        dump_page+0x12/0x46
[  377.525646]        has_unmovable_pages+0x2ff/0x360
[  377.525647]        start_isolate_page_range+0x3bb/0x540
[  377.525648]        __offline_pages+0x258/0xfc0
[  377.525649]        offline_pages+0x11/0x20
[  377.525649]        memory_subsys_offline+0x7e/0xc0
[  377.525650]        device_offline+0xd5/0x110
[  377.525651]        state_store+0xc6/0xe0
[  377.525651]        dev_attr_store+0x3f/0x60
[  377.525652]        sysfs_kf_write+0x89/0xb0
[  377.525653]        kernfs_fop_write+0x188/0x240
[  377.525654]        __vfs_write+0x50/0xa0
[  377.525654]        vfs_write+0x105/0x290
[  377.525655]        ksys_write+0xc6/0x160
[  377.525656]        __x64_sys_write+0x43/0x50
[  377.525656]        do_syscall_64+0xcc/0x76c
[  377.525657]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  377.525658] other info that might help us debug this:

[  377.525660] Chain exists of:
[  377.525660]   console_owner --> &(&port->lock)->rlock --> &(&zone->lock)-
>rlock

[  377.525664]  Possible unsafe locking scenario:

[  377.525665]        CPU0                    CPU1
[  377.525666]        ----                    ----
[  377.525667]   lock(&(&zone->lock)->rlock);
[  377.525669]                                lock(&(&port->lock)->rlock);
[  377.525671]                                lock(&(&zone->lock)->rlock);
[  377.525672]   lock(console_owner);

[  377.525675]  *** DEADLOCK ***

[  377.525676] 9 locks held by test.sh/8876:
[  377.525677]  #0: ffff8883bca59408 (sb_writers#4){.+.+}, at:
vfs_write+0x25f/0x290
[  377.525681]  #1: ffff888eefb58880 (&of->mutex){+.+.}, at:
kernfs_fop_write+0x128/0x240
[  377.525684]  #2: ffff889feb6dcc40 (kn->count#115){.+.+}, at:
kernfs_fop_write+0x138/0x240
[  377.525687]  #3: ffffffffa30f7e60 (device_hotplug_lock){+.+.}, at:
lock_device_hotplug_sysfs+0x16/0x50
[  377.525690]  #4: ffff88981f55c990 (&dev->mutex){....}, at:
device_offline+0x70/0x110
[  377.525693]  #5: ffffffffa2d12d70 (cpu_hotplug_lock.rw_sem){++++}, at:
__offline_pages+0xdb/0xfc0
[  377.525696]  #6: ffffffffa2f007b0 (mem_hotplug_lock.rw_sem){++++}, at:
percpu_down_write+0x87/0x2f0
[  377.525699]  #7: ffff88883fff4318 (&(&zone->lock)->rlock){-.-.}, at:
start_isolate_page_range+0x1ea/0x540
[  377.525703]  #8: ffffffffa2da2040 (console_lock){+.+.}, at:
vprintk_emit+0x100/0x340
[  377.525706] stack backtrace:
[  377.525707] CPU: 10 PID: 8876 Comm: test.sh Not tainted 5.3.0-next-20190920+
#9
[  377.525708] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10,
BIOS U34 05/21/2019
[  377.525709] Call Trace:
[  377.525710]  dump_stack+0x86/0xca
[  377.525710]  print_circular_bug.cold.31+0x243/0x26e
[  377.525711]  check_noncircular+0x29e/0x2e0
[  377.525712]  ? stack_trace_save+0x87/0xb0
[  377.525712]  ? print_circular_bug+0x120/0x120
[  377.525713]  check_prev_add+0x107/0xea0
[  377.525714]  validate_chain+0x8fc/0x1200
[  377.525714]  ? check_prev_add+0xea0/0xea0
[  377.525715]  __lock_acquire+0x5b3/0xb40
[  377.525716]  lock_acquire+0x126/0x280
[  377.525717]  ? console_unlock+0x207/0x750
[  377.525717]  ? __kasan_check_read+0x11/0x20
[  377.525718]  console_unlock+0x269/0x750
[  377.525719]  ? console_unlock+0x207/0x750
[  377.525719]  vprintk_emit+0x10d/0x340
[  377.525720]  vprintk_default+0x1f/0x30
[  377.525721]  vprintk_func+0x44/0xd4
[  377.525721]  printk+0x9f/0xc5
[  377.525722]  ? kmsg_dump_rewind_nolock+0x64/0x64
[  377.525723]  ? lockdep_hardirqs_off+0x74/0x140
[  377.525723]  __dump_page.cold.0+0x73/0x20a
[  377.525724]  dump_page+0x12/0x46
[  377.525725]  has_unmovable_pages+0x2ff/0x360
[  377.525725]  start_isolate_page_range+0x3bb/0x540
[  377.525726]  ? unset_migratetype_isolate+0x260/0x260
[  377.525727]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  377.525728]  __offline_pages+0x258/0xfc0
[  377.525728]  ? __lock_acquire+0x670/0xb40
[  377.525729]  ? __add_memory+0xc0/0xc0
[  377.525730]  ? lock_acquire+0x126/0x280
[  377.525730]  ? device_offline+0x70/0x110
[  377.525731]  ? __kasan_check_write+0x14/0x20
[  377.525732]  ? __mutex_lock+0x344/0xcd0
[  377.525732]  ? _raw_spin_unlock_irqrestore+0x49/0x50
[  377.525733]  ? device_offline+0x70/0x110
[  377.525734]  ? klist_next+0x1c1/0x1e0
[  377.525735]  ? __mutex_add_waiter+0xc0/0xc0
[  377.525735]  ? __device_link_free_srcu+0x80/0x80
[  377.525736]  ? klist_next+0x10b/0x1e0
[  377.525737]  ? klist_iter_exit+0x16/0x40
[  377.525737]  ? device_for_each_child+0xd0/0x110
[  377.525738]  offline_pages+0x11/0x20
[  377.525739]  memory_subsys_offline+0x7e/0xc0
[  377.525739]  device_offline+0xd5/0x110
[  377.525740]  ? auto_online_blocks_show+0x70/0x70
[  377.525741]  state_store+0xc6/0xe0
[  377.525741]  dev_attr_store+0x3f/0x60
[  377.525742]  ? device_match_name+0x40/0x40
[  377.525743]  sysfs_kf_write+0x89/0xb0
[  377.525744]  ? sysfs_file_ops+0xa0/0xa0
[  377.525745]  kernfs_fop_write+0x188/0x240
[  377.525745]  __vfs_write+0x50/0xa0
[  377.525746]  vfs_write+0x105/0x290
[  377.525747]  ksys_write+0xc6/0x160
[  377.525748]  ? __x64_sys_read+0x50/0x50
[  377.525748]  ? do_syscall_64+0x79/0x76c
[  377.525749]  ? do_syscall_64+0x79/0x76c
[  377.525750]  __x64_sys_write+0x43/0x50
[  377.525751]  do_syscall_64+0xcc/0x76c
[  377.525752]  ? trace_hardirqs_on_thunk+0x1a/0x20
[  377.525753]  ? syscall_return_slowpath+0x210/0x210
[  377.525754]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[  377.525754]  ? trace_hardirqs_off_caller+0x3a/0x150
[  377.525755]  ? trace_hardirqs_off_thunk+0x1a/0x20
[  377.525756]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
