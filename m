Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7D6C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6644206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDEfImop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439438AbfIWKVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:21:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45447 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439425AbfIWKVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:21:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id 4so7749586pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CXvbstD2m08lCzQh36duEA5ws0bxBPn6LqTdvVcfkS4=;
        b=IDEfImopZM+uhUkTwx6z6NBrJo2aMW0JluC4He2eeVrx3Enr+nqtwDcFdQ90gDWTN7
         f5dKe1J5zyEesLT/TIMB4N9k8Aznfh1hRu0K2ice0sEUQzsNEF7ABYH54cBkC2nMXvCW
         sOEWLqL9bIDP0KhdmDg8oMuztPgg2t0TBvAvacpuoYYybqc7ifYt0XYAu6L+Zyd3z5kW
         AZtM2lEo9LHDl2+lBZtV8y9kTSYWg7XUzBemMsMa829ubhzUNkhxh6GFy4h8boT+hRpI
         Y9IKxnj2RBhQ1dlbaypEXmmru6Jm0bnYfcFZfEa/fq9AXS7EE/PczhtK5F/PBdR0hzAB
         9rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CXvbstD2m08lCzQh36duEA5ws0bxBPn6LqTdvVcfkS4=;
        b=ehuSGyYH3cB8dqOKWTnfNjQmWelJckAlYTeKjKce5/4QjztAKWW+/NOZ/seSv5qZVa
         ICEeeoBtyOZqRfXXpZkRKcQdaEIPQ6EDceiWl11VEfrn7jRBPkGHvuQyLF/zXGTD+9n2
         qiBwIeABHZwHHTw9AH1yB/PtazsemrpM1K//2L9gbV7kxgjHNmw7hDthCb/OqUXuziA7
         QcDKYpWskKqBAGd7w5h0FuVXo05SKEvSz0e0bK7FbdpuC0A1KmCBOrM9OQm8NARCKn5a
         Z8Rn2NPN/KN2/Cw5DPbDznH7/lbE/kfh9avVFEv3y/odV1/PylaTXu2uhCh8JwOyJz3/
         nHTw==
X-Gm-Message-State: APjAAAWVVuw++5FscFliqxRGlz+7TATIbYxrHwQjHCptxCdpL9ayhFvE
        2ui1uIVQPJ2NHvu/YoMHZgs=
X-Google-Smtp-Source: APXvYqwgTjx/Ho05abUBRZtOqhFdPYqvJK1KmpHYQN3e+VYW1sen0LuZHG10cGI6bBC7ftaWS4s/8w==
X-Received: by 2002:a62:8702:: with SMTP id i2mr32616605pfe.187.1569234065362;
        Mon, 23 Sep 2019 03:21:05 -0700 (PDT)
Received: from localhost ([110.70.15.104])
        by smtp.gmail.com with ESMTPSA id q71sm11380351pjb.26.2019.09.23.03.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:21:04 -0700 (PDT)
Date:   Mon, 23 Sep 2019 19:21:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Subject: Re: printk() + memory offline deadlock (WAS Re: page_alloc.shuffle=1
 + CONFIG_PROVE_LOCKING=y = arm64 hang)
Message-ID: <20190923102100.GA1171@jagdpanzerIV>
References: <1566509603.5576.10.camel@lca.pw>
 <1567717680.5576.104.camel@lca.pw>
 <1568128954.5576.129.camel@lca.pw>
 <20190911011008.GA4420@jagdpanzerIV>
 <1568289941.5576.140.camel@lca.pw>
 <20190916104239.124fc2e5@gandalf.local.home>
 <1568817579.5576.172.camel@lca.pw>
 <20190918155059.GA158834@tigerII.localdomain>
 <1568823006.5576.178.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568823006.5576.178.camel@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/19 12:10), Qian Cai wrote:
[..]
> > So you have debug objects enabled. Right? This thing does not behave
> > when it comes to printing. debug_objects are slightly problematic.
> 
> Yes, but there is an also a similar splat without the debug_objects. It looks
> like anything try to allocate memory in that path will trigger it anyway.

Appears to be different, yet somehow very familiar.

> [  297.425908] WARNING: possible circular locking dependency detected
> [  297.425908] 5.3.0-next-20190917 #8 Not tainted
> [  297.425909] ------------------------------------------------------
> [  297.425910] test.sh/8653 is trying to acquire lock:
> [  297.425911] ffffffff865a4460 (console_owner){-.-.}, at:
> console_unlock+0x207/0x750
> 
> [  297.425914] but task is already holding lock:
> [  297.425915] ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
> __offline_isolated_pages+0x179/0x3e0
> 
> [  297.425919] which lock already depends on the new lock.
> 
> 
> [  297.425920] the existing dependency chain (in reverse order) is:
> 
> [  297.425922] -> #3 (&(&zone->lock)->rlock){-.-.}:
> [  297.425925]        __lock_acquire+0x5b3/0xb40
> [  297.425925]        lock_acquire+0x126/0x280
> [  297.425926]        _raw_spin_lock+0x2f/0x40
> [  297.425927]        rmqueue_bulk.constprop.21+0xb6/0x1160
> [  297.425928]        get_page_from_freelist+0x898/0x22c0
> [  297.425928]        __alloc_pages_nodemask+0x2f3/0x1cd0
> [  297.425929]        alloc_pages_current+0x9c/0x110
> [  297.425930]        allocate_slab+0x4c6/0x19c0
> [  297.425931]        new_slab+0x46/0x70
> [  297.425931]        ___slab_alloc+0x58b/0x960
> [  297.425932]        __slab_alloc+0x43/0x70
> [  297.425933]        __kmalloc+0x3ad/0x4b0
> [  297.425933]        __tty_buffer_request_room+0x100/0x250
> [  297.425934]        tty_insert_flip_string_fixed_flag+0x67/0x110
> [  297.425935]        pty_write+0xa2/0xf0
> [  297.425936]        n_tty_write+0x36b/0x7b0
> [  297.425936]        tty_write+0x284/0x4c0
> [  297.425937]        __vfs_write+0x50/0xa0
> [  297.425938]        vfs_write+0x105/0x290
> [  297.425939]        redirected_tty_write+0x6a/0xc0
> [  297.425939]        do_iter_write+0x248/0x2a0
> [  297.425940]        vfs_writev+0x106/0x1e0
> [  297.425941]        do_writev+0xd4/0x180
> [  297.425941]        __x64_sys_writev+0x45/0x50
> [  297.425942]        do_syscall_64+0xcc/0x76c
> [  297.425943]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> [  297.425944] -> #2 (&(&port->lock)->rlock){-.-.}:
> [  297.425946]        __lock_acquire+0x5b3/0xb40
> [  297.425947]        lock_acquire+0x126/0x280
> [  297.425948]        _raw_spin_lock_irqsave+0x3a/0x50
> [  297.425949]        tty_port_tty_get+0x20/0x60
> [  297.425949]        tty_port_default_wakeup+0xf/0x30
> [  297.425950]        tty_port_tty_wakeup+0x39/0x40
> [  297.425951]        uart_write_wakeup+0x2a/0x40
> [  297.425952]        serial8250_tx_chars+0x22e/0x440
> [  297.425952]        serial8250_handle_irq.part.8+0x14a/0x170
> [  297.425953]        serial8250_default_handle_irq+0x5c/0x90
> [  297.425954]        serial8250_interrupt+0xa6/0x130
> [  297.425955]        __handle_irq_event_percpu+0x78/0x4f0
> [  297.425955]        handle_irq_event_percpu+0x70/0x100
> [  297.425956]        handle_irq_event+0x5a/0x8b
> [  297.425957]        handle_edge_irq+0x117/0x370
> [  297.425958]        do_IRQ+0x9e/0x1e0
> [  297.425958]        ret_from_intr+0x0/0x2a
> [  297.425959]        cpuidle_enter_state+0x156/0x8e0
> [  297.425960]        cpuidle_enter+0x41/0x70
> [  297.425960]        call_cpuidle+0x5e/0x90
> [  297.425961]        do_idle+0x333/0x370
> [  297.425962]        cpu_startup_entry+0x1d/0x1f
> [  297.425962]        start_secondary+0x290/0x330
> [  297.425963]        secondary_startup_64+0xb6/0xc0
> 
> [  297.425964] -> #1 (&port_lock_key){-.-.}:
> [  297.425967]        __lock_acquire+0x5b3/0xb40
> [  297.425967]        lock_acquire+0x126/0x280
> [  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
> [  297.425969]        serial8250_console_write+0x3e4/0x450
> [  297.425970]        univ8250_console_write+0x4b/0x60
> [  297.425970]        console_unlock+0x501/0x750
> [  297.425971]        vprintk_emit+0x10d/0x340
> [  297.425972]        vprintk_default+0x1f/0x30
> [  297.425972]        vprintk_func+0x44/0xd4
> [  297.425973]        printk+0x9f/0xc5
> [  297.425974]        register_console+0x39c/0x520
> [  297.425975]        univ8250_console_init+0x23/0x2d
> [  297.425975]        console_init+0x338/0x4cd
> [  297.425976]        start_kernel+0x534/0x724
> [  297.425977]        x86_64_start_reservations+0x24/0x26
> [  297.425977]        x86_64_start_kernel+0xf4/0xfb
> [  297.425978]        secondary_startup_64+0xb6/0xc0
> 
> [  297.425979] -> #0 (console_owner){-.-.}:
> [  297.425982]        check_prev_add+0x107/0xea0
> [  297.425982]        validate_chain+0x8fc/0x1200
> [  297.425983]        __lock_acquire+0x5b3/0xb40
> [  297.425984]        lock_acquire+0x126/0x280
> [  297.425984]        console_unlock+0x269/0x750
> [  297.425985]        vprintk_emit+0x10d/0x340
> [  297.425986]        vprintk_default+0x1f/0x30
> [  297.425987]        vprintk_func+0x44/0xd4
> [  297.425987]        printk+0x9f/0xc5
> [  297.425988]        __offline_isolated_pages.cold.52+0x2f/0x30a
> [  297.425989]        offline_isolated_pages_cb+0x17/0x30
> [  297.425990]        walk_system_ram_range+0xda/0x160
> [  297.425990]        __offline_pages+0x79c/0xa10
> [  297.425991]        offline_pages+0x11/0x20
> [  297.425992]        memory_subsys_offline+0x7e/0xc0
> [  297.425992]        device_offline+0xd5/0x110
> [  297.425993]        state_store+0xc6/0xe0
> [  297.425994]        dev_attr_store+0x3f/0x60
> [  297.425995]        sysfs_kf_write+0x89/0xb0
> [  297.425995]        kernfs_fop_write+0x188/0x240
> [  297.425996]        __vfs_write+0x50/0xa0
> [  297.425997]        vfs_write+0x105/0x290
> [  297.425997]        ksys_write+0xc6/0x160
> [  297.425998]        __x64_sys_write+0x43/0x50
> [  297.425999]        do_syscall_64+0xcc/0x76c
> [  297.426000]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

I suppose you run with CONFIG_DEBUG_VM...

So we have

port->lock -> MM -> zone->lock
	// from pty_write()->__tty_buffer_request_room()->kmalloc()

vs

zone->lock -> printk() -> port->lock
	// from __offline_pages()->__offline_isolated_pages()->printk()


A number of debugging options make the kernel less stable.
Sad but true.

	-ss
