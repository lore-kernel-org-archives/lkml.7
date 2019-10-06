Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2860CECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 00:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA33222CA
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 00:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Sm+NZ2X6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfJFA7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 20:59:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46395 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfJFA7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 20:59:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id u22so14083792qtq.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 17:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Ckmctxj4hdMiN7g6N+f4rilchYxdb35CRpBiUS3n2rA=;
        b=Sm+NZ2X6VNb83ItG4G7vokMOXtzx6JzK+H7NOdbk38zWOn7ihHowNAdrcF8WrkTdgr
         eGuOpYwasLC1nL5WOE/1Qz05lvS8GCYjRTRP2VcxYcdVseGer8FZju+NlT9Ig6dG4azO
         YaZGwXrbuvECSHwMFN/5iKdazWYfgWI4djIrbQJcP3mxqn9XmN6etzPAH45LsmQYZugk
         8wX8e5wiJAcxSU6QxcgyDxqmuY6ZlFv+Rug7eO3rZbtQnrNMRuY0CeobtNOJaHxSstGG
         sbM77dEsDdvU5g1nZLr9kw8qkSWyJsgM8Wd25HfSmfpZZ1abYUocbteIQ0U7NODX0tk5
         Pvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Ckmctxj4hdMiN7g6N+f4rilchYxdb35CRpBiUS3n2rA=;
        b=hvvK4U9BdX/0I8A0B0f21OAHdiCX4VpibmKFPy5Hs+298GM8N2wLo+u4GtI8+lix1Q
         69Y9YP7xgQ2VuERfEwu9SYZVhs58rEFCXPsFaBFxuLpm0bjU5dvSC6EWPpYKCdVna6Yf
         hoi8240E/0IEI60l6uTJXKMeHvWd7RoX5cPEShSDIbt59QfHJZO+q0iOmqS6iM1dX/nc
         ew1HNkkqSfxx10EYJ1WA6yWcPQeJD9rXoayqYm3dreAQFjn+lihL990mNPoLjnRwzDUv
         Nk8G2e/dtBwGonaSabQ1+YtQ6FAwkjV2tS3De3B9UNCYrVfHW2YVqXb3fOdcMW1mhD5q
         s8OA==
X-Gm-Message-State: APjAAAXGmKYiH5Hjw71yLbZuTfVtWg3k62wfpRdpshAN08x/GFt8pns0
        M9a2g0NCdDqkipfnzitd9qF+fnHZuh8RWg==
X-Google-Smtp-Source: APXvYqwu9W0RF+dQR925Y+e7txXz/IBjTTN8umd420ZQ2BuMRuUKtXHonwPTpHC8hkWrdvtSBgkBFg==
X-Received: by 2002:a0c:fca9:: with SMTP id h9mr21102387qvq.40.1570323561536;
        Sat, 05 Oct 2019 17:59:21 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e42sm7566530qte.26.2019.10.05.17.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2019 17:59:20 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_isolation: fix a deadlock with printk()
Date:   Sat, 5 Oct 2019 20:59:20 -0400
Message-Id: <AE4AA5A8-E77A-4750-8040-088654802CF4@lca.pw>
References: <20191005162942.b392b9336b860e245106faa2@linux-foundation.org>
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20191005162942.b392b9336b860e245106faa2@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 5, 2019, at 7:29 PM, Andrew Morton <akpm@linux-foundation.org> wrot=
e:
>=20
>> -> #2 (&(&zone->lock)->rlock){-.-.}:
>>       lock_acquire+0x21a/0x468
>>       _raw_spin_lock+0x54/0x68
>>       get_page_from_freelist+0x8b6/0x2d28
>>       __alloc_pages_nodemask+0x246/0x658
>>       __get_free_pages+0x34/0x78
>>       sclp_init+0x106/0x690
>>       sclp_register+0x2e/0x248
>>       sclp_rw_init+0x4a/0x70
>>       sclp_console_init+0x4a/0x1b8
>>       console_init+0x2c8/0x410
>>       start_kernel+0x530/0x6a0
>>       startup_continue+0x70/0xd0
>=20
> This appears to be the core of our problem?

There are more.

[  297.425908] WARNING: possible circular locking dependency detected
[  297.425908] 5.3.0-next-20190917 #8 Not tainted
[  297.425909] ------------------------------------------------------
[  297.425910] test.sh/8653 is trying to acquire lock:
[  297.425911] ffffffff865a4460 (console_owner){-.-.}, at:
console_unlock+0x207/0x750

[  297.425914] but task is already holding lock:
[  297.425915] ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x179/0x3e0

[  297.425919] which lock already depends on the new lock.


[  297.425920] the existing dependency chain (in reverse order) is:

[  297.425922] -> #3 (&(&zone->lock)->rlock){-.-.}:
[  297.425925]        __lock_acquire+0x5b3/0xb40
[  297.425925]        lock_acquire+0x126/0x280
[  297.425926]        _raw_spin_lock+0x2f/0x40
[  297.425927]        rmqueue_bulk.constprop.21+0xb6/0x1160
[  297.425928]        get_page_from_freelist+0x898/0x22c0
[  297.425928]        __alloc_pages_nodemask+0x2f3/0x1cd0
[  297.425929]        alloc_pages_current+0x9c/0x110
[  297.425930]        allocate_slab+0x4c6/0x19c0
[  297.425931]        new_slab+0x46/0x70
[  297.425931]        ___slab_alloc+0x58b/0x960
[  297.425932]        __slab_alloc+0x43/0x70
[  297.425933]        __kmalloc+0x3ad/0x4b0
[  297.425933]        __tty_buffer_request_room+0x100/0x250
[  297.425934]        tty_insert_flip_string_fixed_flag+0x67/0x110
[  297.425935]        pty_write+0xa2/0xf0
[  297.425936]        n_tty_write+0x36b/0x7b0
[  297.425936]        tty_write+0x284/0x4c0
[  297.425937]        __vfs_write+0x50/0xa0
[  297.425938]        vfs_write+0x105/0x290
[  297.425939]        redirected_tty_write+0x6a/0xc0
[  297.425939]        do_iter_write+0x248/0x2a0
[  297.425940]        vfs_writev+0x106/0x1e0
[  297.425941]        do_writev+0xd4/0x180
[  297.425941]        __x64_sys_writev+0x45/0x50
[  297.425942]        do_syscall_64+0xcc/0x76c
[  297.425943]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  297.425944] -> #2 (&(&port->lock)->rlock){-.-.}:
[  297.425946]        __lock_acquire+0x5b3/0xb40
[  297.425947]        lock_acquire+0x126/0x280
[  297.425948]        _raw_spin_lock_irqsave+0x3a/0x50
[  297.425949]        tty_port_tty_get+0x20/0x60
[  297.425949]        tty_port_default_wakeup+0xf/0x30
[  297.425950]        tty_port_tty_wakeup+0x39/0x40
[  297.425951]        uart_write_wakeup+0x2a/0x40
[  297.425952]        serial8250_tx_chars+0x22e/0x440
[  297.425952]        serial8250_handle_irq.part.8+0x14a/0x170
[  297.425953]        serial8250_default_handle_irq+0x5c/0x90
[  297.425954]        serial8250_interrupt+0xa6/0x130
[  297.425955]        __handle_irq_event_percpu+0x78/0x4f0
[  297.425955]        handle_irq_event_percpu+0x70/0x100
[  297.425956]        handle_irq_event+0x5a/0x8b
[  297.425957]        handle_edge_irq+0x117/0x370
[  297.425958]        do_IRQ+0x9e/0x1e0
[  297.425958]        ret_from_intr+0x0/0x2a
[  297.425959]        cpuidle_enter_state+0x156/0x8e0
[  297.425960]        cpuidle_enter+0x41/0x70
[  297.425960]        call_cpuidle+0x5e/0x90
[  297.425961]        do_idle+0x333/0x370
[  297.425962]        cpu_startup_entry+0x1d/0x1f
[  297.425962]        start_secondary+0x290/0x330
[  297.425963]        secondary_startup_64+0xb6/0xc0

[  297.425964] -> #1 (&port_lock_key){-.-.}:
[  297.425967]        __lock_acquire+0x5b3/0xb40
[  297.425967]        lock_acquire+0x126/0x280
[  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
[  297.425969]        serial8250_console_write+0x3e4/0x450
[  297.425970]        univ8250_console_write+0x4b/0x60
[  297.425970]        console_unlock+0x501/0x750
[  297.425971]        vprintk_emit+0x10d/0x340
[  297.425972]        vprintk_default+0x1f/0x30
[  297.425972]        vprintk_func+0x44/0xd4
[  297.425973]        printk+0x9f/0xc5
[  297.425974]        register_console+0x39c/0x520
[  297.425975]        univ8250_console_init+0x23/0x2d
[  297.425975]        console_init+0x338/0x4cd
[  297.425976]        start_kernel+0x534/0x724
[  297.425977]        x86_64_start_reservations+0x24/0x26
[  297.425977]        x86_64_start_kernel+0xf4/0xfb
[  297.425978]        secondary_startup_64+0xb6/0xc0

[  297.425979] -> #0 (console_owner){-.-.}:
[  297.425982]        check_prev_add+0x107/0xea0
[  297.425982]        validate_chain+0x8fc/0x1200
[  297.425983]        __lock_acquire+0x5b3/0xb40
[  297.425984]        lock_acquire+0x126/0x280
[  297.425984]        console_unlock+0x269/0x750
[  297.425985]        vprintk_emit+0x10d/0x340
[  297.425986]        vprintk_default+0x1f/0x30
[  297.425987]        vprintk_func+0x44/0xd4
[  297.425987]        printk+0x9f/0xc5
[  297.425988]        __offline_isolated_pages.cold.52+0x2f/0x30a
[  297.425989]        offline_isolated_pages_cb+0x17/0x30
[  297.425990]        walk_system_ram_range+0xda/0x160
[  297.425990]        __offline_pages+0x79c/0xa10
[  297.425991]        offline_pages+0x11/0x20
[  297.425992]        memory_subsys_offline+0x7e/0xc0
[  297.425992]        device_offline+0xd5/0x110
[  297.425993]        state_store+0xc6/0xe0
[  297.425994]        dev_attr_store+0x3f/0x60
[  297.425995]        sysfs_kf_write+0x89/0xb0
[  297.425995]        kernfs_fop_write+0x188/0x240
[  297.425996]        __vfs_write+0x50/0xa0
[  297.425997]        vfs_write+0x105/0x290
[  297.425997]        ksys_write+0xc6/0x160
[  297.425998]        __x64_sys_write+0x43/0x50
[  297.425999]        do_syscall_64+0xcc/0x76c
[  297.426000]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  297.426001] other info that might help us debug this:

[  297.426002] Chain exists of:
[  297.426002]   console_owner --> &(&port->lock)->rlock --> &(&zone->lock)-=

>rlock

[  297.426007]  Possible unsafe locking scenario:

[  297.426008]        CPU0                    CPU1
[  297.426009]        ----                    ----
[  297.426009]   lock(&(&zone->lock)->rlock);
[  297.426011]                                lock(&(&port->lock)->rlock);
[  297.426013]                                lock(&(&zone->lock)->rlock);
[  297.426014]   lock(console_owner);

[  297.426016]  *** DEADLOCK ***

[  297.426017] 9 locks held by test.sh/8653:
[  297.426018]  #0: ffff88839ba7d408 (sb_writers#4){.+.+}, at:
vfs_write+0x25f/0x290
[  297.426021]  #1: ffff888277618880 (&of->mutex){+.+.}, at:
kernfs_fop_write+0x128/0x240
[  297.426024]  #2: ffff8898131fc218 (kn->count#115){.+.+}, at:
kernfs_fop_write+0x138/0x240
[  297.426028]  #3: ffffffff86962a80 (device_hotplug_lock){+.+.}, at:
lock_device_hotplug_sysfs+0x16/0x50
[  297.426031]  #4: ffff8884374f4990 (&dev->mutex){....}, at:
device_offline+0x70/0x110
[  297.426034]  #5: ffffffff86515250 (cpu_hotplug_lock.rw_sem){++++}, at:
__offline_pages+0xbf/0xa10
[  297.426037]  #6: ffffffff867405f0 (mem_hotplug_lock.rw_sem){++++}, at:
percpu_down_write+0x87/0x2f0
[  297.426040]  #7: ffff88883fff3c58 (&(&zone->lock)->rlock){-.-.}, at:
__offline_isolated_pages+0x179/0x3e0
[  297.426043]  #8: ffffffff865a4920 (console_lock){+.+.}, at:
vprintk_emit+0x100/0x340

[  297.426047] stack backtrace:
[  297.426048] CPU: 1 PID: 8653 Comm: test.sh Not tainted 5.3.0-next-2019091=
7 #8
[  297.426049] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10,=

BIOS U34 05/21/2019
[  297.426049] Call Trace:
[  297.426050]  dump_stack+0x86/0xca
[  297.426051]  print_circular_bug.cold.31+0x243/0x26e
[  297.426051]  check_noncircular+0x29e/0x2e0
[  297.426052]  ? stack_trace_save+0x87/0xb0
[  297.426053]  ? print_circular_bug+0x120/0x120
[  297.426053]  check_prev_add+0x107/0xea0
[  297.426054]  validate_chain+0x8fc/0x1200
[  297.426055]  ? check_prev_add+0xea0/0xea0
[  297.426055]  __lock_acquire+0x5b3/0xb40
[  297.426056]  lock_acquire+0x126/0x280
[  297.426057]  ? console_unlock+0x207/0x750
[  297.426057]  ? __kasan_check_read+0x11/0x20
[  297.426058]  console_unlock+0x269/0x750
[  297.426059]  ? console_unlock+0x207/0x750
[  297.426059]  vprintk_emit+0x10d/0x340
[  297.426060]  vprintk_default+0x1f/0x30
[  297.426061]  vprintk_func+0x44/0xd4
[  297.426061]  ? do_raw_spin_lock+0x118/0x1d0
[  297.426062]  printk+0x9f/0xc5
[  297.426063]  ? kmsg_dump_rewind_nolock+0x64/0x64
[  297.426064]  ? __offline_isolated_pages+0x179/0x3e0
[  297.426064]  __offline_isolated_pages.cold.52+0x2f/0x30a
[  297.426065]  ? online_memory_block+0x20/0x20
[  297.426066]  offline_isolated_pages_cb+0x17/0x30
[  297.426067]  walk_system_ram_range+0xda/0x160
[  297.426067]  ? walk_mem_res+0x30/0x30
[  297.426068]  ? dissolve_free_huge_page+0x1e/0x2b0
[  297.426069]  __offline_pages+0x79c/0xa10
[  297.426069]  ? __add_memory+0xc0/0xc0
[  297.426070]  ? __kasan_check_write+0x14/0x20
[  297.426071]  ? __mutex_lock+0x344/0xcd0
[  297.426071]  ? _raw_spin_unlock_irqrestore+0x49/0x50
[  297.426072]  ? device_offline+0x70/0x110
[  297.426073]  ? klist_next+0x1c1/0x1e0
[  297.426073]  ? __mutex_add_waiter+0xc0/0xc0
[  297.426074]  ? klist_next+0x10b/0x1e0
[  297.426075]  ? klist_iter_exit+0x16/0x40
[  297.426076]  ? device_for_each_child+0xd0/0x110
[  297.426076]  offline_pages+0x11/0x20
[  297.426077]  memory_subsys_offline+0x7e/0xc0
[  297.426078]  device_offline+0xd5/0x110
[  297.426078]  ? auto_online_blocks_show+0x70/0x70
[  297.426079]  state_store+0xc6/0xe0
[  297.426080]  dev_attr_store+0x3f/0x60
[  297.426080]  ? device_match_name+0x40/0x40
[  297.426081]  sysfs_kf_write+0x89/0xb0
[  297.426082]  ? sysfs_file_ops+0xa0/0xa0
[  297.426082]  kernfs_fop_write+0x188/0x240
[  297.426083]  __vfs_write+0x50/0xa0
[  297.426084]  vfs_write+0x105/0x290
[  297.426084]  ksys_write+0xc6/0x160
[  297.426085]  ? __x64_sys_read+0x50/0x50
[  297.426086]  ? do_syscall_64+0x79/0x76c
[  297.426086]  ? do_syscall_64+0x79/0x76c
[  297.426087]  __x64_sys_write+0x43/0x50
[  297.426088]  do_syscall_64+0xcc/0x76c
[  297.426088]  ? trace_hardirqs_on_thunk+0x1a/0x20
[  297.426089]  ? syscall_return_slowpath+0x210/0x210
[  297.426090]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[  297.426091]  ? trace_hardirqs_off_caller+0x3a/0x150
[  297.426092]  ? trace_hardirqs_off_thunk+0x1a/0x20
[  297.426092]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  297.426093] RIP: 0033:0x7fd7336b4e18
[  297.426095] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f=
3 0f
1e fa 48 8d 05 05 59 2d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00=
 f0
ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[  297.426096] RSP: 002b:00007ffc58c7b258 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  297.426098] RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007fd7336b=
4e18
[  297.426098] RDX: 0000000000000008 RSI: 000055ad6d519c70 RDI: 000000000000=
0001
[  297.426099] RBP: 000055ad6d519c70 R08: 000000000000000a R09: 00007fd73374=
6300
[  297.426100] R10: 000000000000000a R11: 0000000000000246 R12: 00007fd73398=
6780
[  297.426101] R13: 0000000000000008 R14: 00007fd733981740 R15: 000000000000=
0008


>  At initialization time,
> the sclp driver registers an inappropriate dependency with lockdep.  It
> does this by calling into the page allocator while holding sclp_lock.=20
> But we don't *want* to teach lockdep that sclp_lock nests outside
> zone->lock.  We want the opposite.
>=20
> So can we address this class of problem by declaring "thou shalt not
> call the page allocator while holding a lock which can be taken on the
> prink path?".  And then declare sclp to be defective.
>=20
>=20
> And I think sclp is kinda buggy-but-lucky anyway: if console output is
> directed to sclp device #0 and we're then trying to initialize sclp
> device #1 then any printk which happens during that initialization will
> deadlock.  The driver escapes this by only

printk() is such a beast that basically any lock taken after console_lock he=
ld  like sclp_lock, port_lock, rq_lock or even indirectly like pi_lock as in=
 below,

console_lock -> rq_lock -> pi_lock

would have a same problem where if another CPU take one of those locks in a d=
ifferent path and call printk() could trigger a deadlock.

[  763.659221][    C6] -> #2 (&rq->lock){-.-.}:
[  763.659222][    C6]        __lock_acquire+0x44e/0x8c0
[  763.659223][    C6]        lock_acquire+0xc0/0x1c0
[  763.659223][    C6]        _raw_spin_lock+0x2f/0x40
[  763.659223][    C6]        task_fork_fair+0x37/0x150
[  763.659224][    C6]        sched_fork+0x126/0x230
[  763.659224][    C6]        copy_process+0xafc/0x1e90
[  763.659224][    C6]        _do_fork+0x89/0x720
[  763.659225][    C6]        kernel_thread+0x58/0x70
[  763.659225][    C6]        rest_init+0x28/0x302
[  763.659225][    C6]        arch_call_rest_init+0xe/0x1b
[  763.659226][    C6]        start_kernel+0x581/0x5a0
[  763.659226][    C6]        x86_64_start_reservations+0x24/0x26
[  763.659227][    C6]        x86_64_start_kernel+0xef/0xf6
[  763.659227][    C6]        secondary_startup_64+0xb6/0xc0
[  763.659227][    C6]=20
[  763.659227][    C6] -> #1 (&p->pi_lock){-.-.}:
[  763.659229][    C6]        __lock_acquire+0x44e/0x8c0
[  763.659229][    C6]        lock_acquire+0xc0/0x1c0
[  763.659230][    C6]        _raw_spin_lock_irqsave+0x3a/0x50
[  763.659230][    C6]        try_to_wake_up+0x5c/0xbc0
[  763.659230][    C6]        wake_up_process+0x15/0x20
[  763.659231][    C6]        __up+0x4a/0x50
[  763.659231][    C6]        up+0x45/0x50
[  763.659231][    C6]        __up_console_sem+0x37/0x60
[  763.659232][    C6]        console_unlock+0x357/0x600
[  763.659232][    C6]        vprintk_emit+0x101/0x320
[  763.659232][    C6]        vprintk_default+0x1f/0x30
[  763.659233][    C6]        vprintk_func+0x44/0xd4
[  763.659233][    C6]        printk+0x58/0x6f
[  763.659234][    C6]        do_exit+0xd73/0xd80
[  763.659234][    C6]        do_group_exit+0x41/0xd0
[  763.659234][    C6]        __x64_sys_exit_group+0x18/0x20
[  763.659235][    C6]        do_syscall_64+0x6d/0x488
[  763.659235][    C6]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

> supporting a single device
> system-wide but it's not a model which drivers should generally follow.
>=20
> (And if sclp will only ever support a single device system-wide, why
> the heck does it need to take sclp_lock() on the device initialization
> path??)
