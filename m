Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE61AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E71D20409
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DDcMeDEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfLCSqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:46:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40807 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCSqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:46:05 -0500
Received: by mail-qk1-f195.google.com with SMTP id a137so4480042qkc.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZxhFMEShM8jh67Lp633UJO9JyQTNyfmyIx3th3IgO2E=;
        b=DDcMeDEschtyWx/kYAOn0FUoZJ4QzmBohvw6N8/bd8A9B2qnCm/CYktZhSfe2kUSTH
         LrAuS+4qZYgveY8U8UltVC93hU0r1UdObE7BDihjZWmuAuH4TeLGC41V5k2xilRSy1km
         cAFfRUgNZ8C9Op2n3c1Ryat410q1K+cF6lPcCBm34XOlE9f7tfJWJKk4/euIm5xIUd/M
         f1WqsuQ+5yXMLsX1ISSF1VcZwW0jowfXfuNLpYJPOkZs12UV8NDu8A9/R9Ub1Uay6ySJ
         gPN6rQByz3G6bSyJIwrtWSI93P8Lx0Gl1MID058rWZXTK4Qy0WSNGIhadyUXbyaTOIkV
         Hk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZxhFMEShM8jh67Lp633UJO9JyQTNyfmyIx3th3IgO2E=;
        b=my2Jy2Kv9rrwpUXjX/dRcv2hYr7NdkQsmaycGkVUqTy/60RruTOxBgbebiN/xHPdjR
         r1ZaBi9LpLl+DEsfWfvCQU65rlif6wMQ0ccZ+bAtA4NamjMU5cDHcSFztlvtqJFCsVr+
         ktu1vrJ/QoEZAjHF4POLi0BzjlLO1zzXp5KyL9e723X5ED6syABvJ1bITArxx2U7Kkj6
         9RMGydIeDfnErxOzviUDZ9maSzf9KeLAx61ms824tDRI/NEPqMc1fdVaUCdhzIjFLvkR
         zzMePrvkwXX2EN4r3BaZJU4MrNyt3TNGuOlgZoBFLO+zfz2yPaq5upfBKJ6egjTG/25z
         yOgw==
X-Gm-Message-State: APjAAAVA5OTgx+cnf1xJm6AFbNVxb8VY2IEIG+YdES8ZEJhv2SNOM6zx
        Vkph+ntCc9bjESGe8sQCDk2TPQ==
X-Google-Smtp-Source: APXvYqzAiVxXQc7+lRS+BSs6APg/0I+Uz5F9GNXBs7iNsde7RAG5lIxVmyFHwpv9ERA8mJvJ3A2QOQ==
X-Received: by 2002:a37:7005:: with SMTP id l5mr6480962qkc.334.1575398763693;
        Tue, 03 Dec 2019 10:46:03 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c20sm2328828qtc.13.2019.12.03.10.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 10:46:02 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] char/random: silence a lockdep splat with printk()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <1573679785-21068-1-git-send-email-cai@lca.pw>
Date:   Tue, 3 Dec 2019 13:46:01 -0500
Cc:     Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
        will@kernel.org, dan.j.williams@intel.com, peterz@infradead.org,
        longman@redhat.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <637027D4-BBDD-4AA6-B03C-556060988957@lca.pw>
References: <1573679785-21068-1-git-send-email-cai@lca.pw>
To:     tytso@mit.edu
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 13, 2019, at 4:16 PM, Qian Cai <cai@lca.pw> wrote:
>=20
> From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
>=20
> Sergey didn't like the locking order,
>=20
> uart_port->lock  ->  tty_port->lock
>=20
> uart_write (uart_port->lock)
>  __uart_start
>    pl011_start_tx
>      pl011_tx_chars
>        uart_write_wakeup
>          tty_port_tty_wakeup
>            tty_port_default
>              tty_port_tty_get (tty_port->lock)
>=20
> but those code is so old, and I have no clue how to de-couple it after
> checking other locks in the splat. There is an onging effort to make =
all
> printk() as deferred, so until that happens, workaround it for now as =
a
> short-term fix.

Sergey, could we have a ACK from you so Ted might be able to merge?

>=20
> LTP: starting iogen01 (export LTPROOT; rwtest -N iogen01 -i 120s -s
> read,write -Da -Dv -n 2 500b:$TMPDIR/doio.f1.$$
> 1000b:$TMPDIR/doio.f2.$$)
> WARNING: possible circular locking dependency detected
> ------------------------------------------------------
> doio/49441 is trying to acquire lock:
> ffff008b7cff7290 (&(&zone->lock)->rlock){..-.}, at: =
rmqueue+0x138/0x2050
>=20
> but task is already holding lock:
> 60ff000822352818 (&pool->lock/1){-.-.}, at: =
start_flush_work+0xd8/0x3f0
>=20
>  which lock already depends on the new lock.
>=20
>  the existing dependency chain (in reverse order) is:
>=20
>  -> #4 (&pool->lock/1){-.-.}:
>       lock_acquire+0x320/0x360
>       _raw_spin_lock+0x64/0x80
>       __queue_work+0x4b4/0xa10
>       queue_work_on+0xac/0x11c
>       tty_schedule_flip+0x84/0xbc
>       tty_flip_buffer_push+0x1c/0x28
>       pty_write+0x98/0xd0
>       n_tty_write+0x450/0x60c
>       tty_write+0x338/0x474
>       __vfs_write+0x88/0x214
>       vfs_write+0x12c/0x1a4
>       redirected_tty_write+0x90/0xdc
>       do_loop_readv_writev+0x140/0x180
>       do_iter_write+0xe0/0x10c
>       vfs_writev+0x134/0x1cc
>       do_writev+0xbc/0x130
>       __arm64_sys_writev+0x58/0x8c
>       el0_svc_handler+0x170/0x240
>       el0_sync_handler+0x150/0x250
>       el0_sync+0x164/0x180
>=20
>  -> #3 (&(&port->lock)->rlock){-.-.}:
>       lock_acquire+0x320/0x360
>       _raw_spin_lock_irqsave+0x7c/0x9c
>       tty_port_tty_get+0x24/0x60
>       tty_port_default_wakeup+0x1c/0x3c
>       tty_port_tty_wakeup+0x34/0x40
>       uart_write_wakeup+0x28/0x44
>       pl011_tx_chars+0x1b8/0x270
>       pl011_start_tx+0x24/0x70
>       __uart_start+0x5c/0x68
>       uart_write+0x164/0x1c8
>       do_output_char+0x33c/0x348
>       n_tty_write+0x4bc/0x60c
>       tty_write+0x338/0x474
>       redirected_tty_write+0xc0/0xdc
>       do_loop_readv_writev+0x140/0x180
>       do_iter_write+0xe0/0x10c
>       vfs_writev+0x134/0x1cc
>       do_writev+0xbc/0x130
>       __arm64_sys_writev+0x58/0x8c
>       el0_svc_handler+0x170/0x240
>       el0_sync_handler+0x150/0x250
>       el0_sync+0x164/0x180
>=20
>  -> #2 (&port_lock_key){-.-.}:
>       lock_acquire+0x320/0x360
>       _raw_spin_lock+0x64/0x80
>       pl011_console_write+0xec/0x2cc
>       console_unlock+0x794/0x96c
>       vprintk_emit+0x260/0x31c
>       vprintk_default+0x54/0x7c
>       vprintk_func+0x218/0x254
>       printk+0x7c/0xa4
>       register_console+0x734/0x7b0
>       uart_add_one_port+0x734/0x834
>       pl011_register_port+0x6c/0xac
>       sbsa_uart_probe+0x234/0x2ec
>       platform_drv_probe+0xd4/0x124
>       really_probe+0x250/0x71c
>       driver_probe_device+0xb4/0x200
>       __device_attach_driver+0xd8/0x188
>       bus_for_each_drv+0xbc/0x110
>       __device_attach+0x120/0x220
>       device_initial_probe+0x20/0x2c
>       bus_probe_device+0x54/0x100
>       device_add+0xae8/0xc2c
>       platform_device_add+0x278/0x3b8
>       platform_device_register_full+0x238/0x2ac
>       acpi_create_platform_device+0x2dc/0x3a8
>       acpi_bus_attach+0x390/0x3cc
>       acpi_bus_attach+0x108/0x3cc
>       acpi_bus_attach+0x108/0x3cc
>       acpi_bus_attach+0x108/0x3cc
>       acpi_bus_scan+0x7c/0xb0
>       acpi_scan_init+0xe4/0x304
>       acpi_init+0x100/0x114
>       do_one_initcall+0x348/0x6a0
>       do_initcall_level+0x190/0x1fc
>       do_basic_setup+0x34/0x4c
>       kernel_init_freeable+0x19c/0x260
>       kernel_init+0x18/0x338
>       ret_from_fork+0x10/0x18
>=20
>  -> #1 (console_owner){-...}:
>       lock_acquire+0x320/0x360
>       console_lock_spinning_enable+0x6c/0x7c
>       console_unlock+0x4f8/0x96c
>       vprintk_emit+0x260/0x31c
>       vprintk_default+0x54/0x7c
>       vprintk_func+0x218/0x254
>       printk+0x7c/0xa4
>       get_random_u64+0x1c4/0x1dc
>       shuffle_pick_tail+0x40/0xac
>       __free_one_page+0x424/0x710
>       free_one_page+0x70/0x120
>       __free_pages_ok+0x61c/0xa94
>       __free_pages_core+0x1bc/0x294
>       memblock_free_pages+0x38/0x48
>       __free_pages_memory+0xcc/0xfc
>       __free_memory_core+0x70/0x78
>       free_low_memory_core_early+0x148/0x18c
>       memblock_free_all+0x18/0x54
>       mem_init+0xb4/0x17c
>       mm_init+0x14/0x38
>       start_kernel+0x19c/0x530
>=20
>  -> #0 (&(&zone->lock)->rlock){..-.}:
>       validate_chain+0xf6c/0x2e2c
>       __lock_acquire+0x868/0xc2c
>       lock_acquire+0x320/0x360
>       _raw_spin_lock+0x64/0x80
>       rmqueue+0x138/0x2050
>       get_page_from_freelist+0x474/0x688
>       __alloc_pages_nodemask+0x3b4/0x18dc
>       alloc_pages_current+0xd0/0xe0
>       alloc_slab_page+0x2b4/0x5e0
>       new_slab+0xc8/0x6bc
>       ___slab_alloc+0x3b8/0x640
>       kmem_cache_alloc+0x4b4/0x588
>       __debug_object_init+0x778/0x8b4
>       debug_object_init_on_stack+0x40/0x50
>       start_flush_work+0x16c/0x3f0
>       __flush_work+0xb8/0x124
>       flush_work+0x20/0x30
>       xlog_cil_force_lsn+0x88/0x204 [xfs]
>       xfs_log_force_lsn+0x128/0x1b8 [xfs]
>       xfs_file_fsync+0x3c4/0x488 [xfs]
>       vfs_fsync_range+0xb0/0xd0
>       generic_write_sync+0x80/0xa0 [xfs]
>       xfs_file_buffered_aio_write+0x66c/0x6e4 [xfs]
>       xfs_file_write_iter+0x1a0/0x218 [xfs]
>       __vfs_write+0x1cc/0x214
>       vfs_write+0x12c/0x1a4
>       ksys_write+0xb0/0x120
>       __arm64_sys_write+0x54/0x88
>       el0_svc_handler+0x170/0x240
>       el0_sync_handler+0x150/0x250
>       el0_sync+0x164/0x180
>=20
>       other info that might help us debug this:
>=20
> Chain exists of:
>   &(&zone->lock)->rlock --> &(&port->lock)->rlock --> &pool->lock/1
>=20
> Possible unsafe locking scenario:
>=20
>       CPU0                    CPU1
>       ----                    ----
>  lock(&pool->lock/1);
>                               lock(&(&port->lock)->rlock);
>                               lock(&pool->lock/1);
>  lock(&(&zone->lock)->rlock);
>=20
>                *** DEADLOCK ***
>=20
> 4 locks held by doio/49441:
> #0: a0ff00886fc27408 (sb_writers#8){.+.+}, at: vfs_write+0x118/0x1a4
> #1: 8fff00080810dfe0 (&xfs_nondir_ilock_class){++++}, at:
> xfs_ilock+0x2a8/0x300 [xfs]
> #2: ffff9000129f2390 (rcu_read_lock){....}, at:
> rcu_lock_acquire+0x8/0x38
> #3: 60ff000822352818 (&pool->lock/1){-.-.}, at:
> start_flush_work+0xd8/0x3f0
>=20
>               stack backtrace:
> CPU: 48 PID: 49441 Comm: doio Tainted: G        W
> Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS
> L50_5.13_1.11 06/18/2019
> Call trace:
> dump_backtrace+0x0/0x248
> show_stack+0x20/0x2c
> dump_stack+0xe8/0x150
> print_circular_bug+0x368/0x380
> check_noncircular+0x28c/0x294
> validate_chain+0xf6c/0x2e2c
> __lock_acquire+0x868/0xc2c
> lock_acquire+0x320/0x360
> _raw_spin_lock+0x64/0x80
> rmqueue+0x138/0x2050
> get_page_from_freelist+0x474/0x688
> __alloc_pages_nodemask+0x3b4/0x18dc
> alloc_pages_current+0xd0/0xe0
> alloc_slab_page+0x2b4/0x5e0
> new_slab+0xc8/0x6bc
> ___slab_alloc+0x3b8/0x640
> kmem_cache_alloc+0x4b4/0x588
> __debug_object_init+0x778/0x8b4
> debug_object_init_on_stack+0x40/0x50
> start_flush_work+0x16c/0x3f0
> __flush_work+0xb8/0x124
> flush_work+0x20/0x30
> xlog_cil_force_lsn+0x88/0x204 [xfs]
> xfs_log_force_lsn+0x128/0x1b8 [xfs]
> xfs_file_fsync+0x3c4/0x488 [xfs]
> vfs_fsync_range+0xb0/0xd0
> generic_write_sync+0x80/0xa0 [xfs]
> xfs_file_buffered_aio_write+0x66c/0x6e4 [xfs]
> xfs_file_write_iter+0x1a0/0x218 [xfs]
> __vfs_write+0x1cc/0x214
> vfs_write+0x12c/0x1a4
> ksys_write+0xb0/0x120
> __arm64_sys_write+0x54/0x88
> el0_svc_handler+0x170/0x240
> el0_sync_handler+0x150/0x250
> el0_sync+0x164/0x180
>=20
> [cai@lca.pw: add a commit log.]
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>=20
> Sergey, please let us know if you are fine with the Signed-off-by.
>=20
> drivers/char/random.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 46afd14facb7..b90086c9836f 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1688,8 +1688,9 @@ static void _warn_unseeded_randomness(const char =
*func_name, void *caller,
> 	print_once =3D true;
> #endif
> 	if (__ratelimit(&unseeded_warning))
> -		pr_notice("random: %s called from %pS with =
crng_init=3D%d\n",
> -			  func_name, caller, crng_init);
> +		printk_deferred(KERN_NOTICE "random: %s called from %pS =
"
> +				"with crng_init=3D%d\n", func_name, =
caller,
> +				crng_init);
> }
>=20
> /*
> --=20
> 1.8.3.1
>=20

