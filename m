Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21011CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A1720873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qQKWf3Yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfJaPWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:22:17 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:38904 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfJaPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:22:17 -0400
Received: by mail-qt1-f174.google.com with SMTP id t26so9056408qtr.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 08:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHf/7h0QL5OhfBcJtCK2ixBlJvKxpdtqpgH/59EH/80=;
        b=qQKWf3YrTKA0PUr7+cD9eTIo48Omp58wJNksHECD8zgnI8xcgTGuCd7WOMYm2uFINt
         u8i0Tc9hbCZSNWnV3VHJDBUGX32XVlA4sPz1W0rVO8GfPr0V6ZQRA6TG0i3wAC577kNy
         8F7cAHF5YihC0RElDzt4+kdX+srnmRuIGLusetubL/DaFymAdssfh20xzlONPBBaY5yE
         HpO4v0GR7hVZF5iYjkJJLY85uLELixP6FkJiUaJmyKPhzI4nNUS71gVMQVCW3FkGTYFh
         GhNDiceuloDiqbLW92WEaOCGZ/WvoiaWBGMV2bErLg6wb8Ymlv0Ftuu9axM2rUfTD+9m
         EyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHf/7h0QL5OhfBcJtCK2ixBlJvKxpdtqpgH/59EH/80=;
        b=sMv3/UECQ4CCuwL8r93PY4x5gnRAzg8n7BgWhfxjc7SWq2rjmzuiN3xYwsjH6lS2p7
         Yb7EOKhwowdO5Kg7MmmhxMI9YocuP7JV6Z7H/b3iJilz1s28XOPau+RmDLsAN0zMS6Li
         5oB7xbUxn9e5w8MSQMeEK2qfgCPqhHL1kHadP72CfbKayMUYliuwjPjFz6LMrQMxJF44
         gjKlZukV4Xkan4EO2tVqPXvyA8ITYCRlj8kJNS8i0si4erLGxFVMCZhU0LGTdQonGiUK
         tCkrBJuJFdRqoDWzAY7YzOSin5xf9C8arpRK9cWTD2Wl1fIUX1QdB495IZprnMLKJuI3
         klXA==
X-Gm-Message-State: APjAAAUiume+xeFjDNhtLLPm3a9MfeUxA1giSTXh8zIlUKUXVmQD3Ngt
        jU6q/GfAycRuiMzXERbsGPNAmw==
X-Google-Smtp-Source: APXvYqy0aRObFzSo+VLFX+3uRUjbDu/MvyZBjW6+e0Ckl/vFFbHjcrWnpj4o67ZQPJSf7PEL7NgrwQ==
X-Received: by 2002:ac8:80f:: with SMTP id u15mr756774qth.193.1572535335002;
        Thu, 31 Oct 2019 08:22:15 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u27sm2535405qtj.5.2019.10.31.08.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 08:22:14 -0700 (PDT)
Message-ID: <1572535333.5937.114.camel@lca.pw>
Subject: Re: "Fix data race in tty_insert_flip_string_fixed_flag" triggers a
 lockdep warning
From:   Qian Cai <cai@lca.pw>
To:     DaeRyong Jeong <threeearcat@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Date:   Thu, 31 Oct 2019 11:22:13 -0400
In-Reply-To: <1572471633.5937.112.camel@lca.pw>
References: <1572471633.5937.112.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-30 at 17:40 -0400, Qian Cai wrote:
> The commit b6da31b2c07c ("tty: Fix data race in
> tty_insert_flip_string_fixed_flag") creates a locking order,
> 
> &(&port->lock)->rlock --> &(&zone->lock)->rlock
> 
> which will trigger a lockdep warning below.
> 
> [  489.312784] WARNING: possible circular locking dependency detected
> [  489.319655] 5.4.0-rc5-next-20191030+ #2 Tainted: G        W    L   
> [  489.326610] ------------------------------------------------------
> [  489.333479] sshd/5541 is trying to acquire lock:
> [  489.338785] ffff008b7cff9290 (&(&zone->lock)->rlock){..-.}, at:
> rmqueue+0xfe8/0x2274
> [  489.347230] 
>                but task is already holding lock:
> [  489.354444] 1cff0009e39c0540 (&(&port->lock)->rlock){-.-.}, at:
> pty_write+0x60/0xd0
> [  489.362799] 
>                which lock already depends on the new lock.
> 
> [  489.373052] 
>                the existing dependency chain (in reverse order) is:
> [  489.381916] 
>                -> #3 (&(&port->lock)->rlock){-.-.}:
> [  489.389403]        lock_acquire+0x320/0x360
> [  489.394279]        _raw_spin_lock_irqsave+0x7c/0x9c
> [  489.399849]        tty_port_tty_get+0x24/0x60
> [  489.404896]        tty_port_default_wakeup+0x1c/0x3c
> [  489.410551]        tty_port_tty_wakeup+0x34/0x40
> [  489.415859]        uart_write_wakeup+0x28/0x44
> [  489.420993]        pl011_tx_chars+0x1b8/0x270
> [  489.426040]        pl011_start_tx+0x24/0x70
> [  489.430913]        __uart_start+0x5c/0x68
> [  489.435612]        uart_write+0x164/0x1c8
> [  489.440312]        do_output_char+0x33c/0x348
> [  489.445358]        n_tty_write+0x4bc/0x60c
> [  489.450143]        tty_write+0x338/0x474
> [  489.454755]        redirected_tty_write+0xc0/0xdc
> [  489.460150]        do_loop_readv_writev+0x140/0x180
> [  489.465718]        do_iter_write+0xe0/0x10c
> [  489.470590]        vfs_writev+0x134/0x1cc
> [  489.475289]        do_writev+0xbc/0x130
> [  489.479815]        __arm64_sys_writev+0x58/0x8c
> [  489.485038]        el0_svc_handler+0x170/0x240
> [  489.490173]        el0_sync_handler+0x150/0x250
> [  489.495393]        el0_sync+0x164/0x180
> [  489.499915] 
>                -> #2 (&port_lock_key){-.-.}:
> [  489.506793]        lock_acquire+0x320/0x360
> [  489.511666]        _raw_spin_lock+0x64/0x80
> [  489.516540]        pl011_console_write+0xec/0x2cc
> [  489.521934]        console_unlock+0x794/0x96c
> [  489.526981]        vprintk_emit+0x260/0x31c
> [  489.531854]        vprintk_default+0x54/0x7c
> [  489.536813]        vprintk_func+0x218/0x254
> [  489.541687]        printk+0x7c/0xa4
> 
>                -> #1 (console_owner){-...}:
> [  489.703613]        lock_acquire+0x320/0x360
> [  489.708486]        console_lock_spinning_enable+0x6c/0x7c
> [  489.714575]        console_unlock+0x4f8/0x96c
> [  489.719622]        vprintk_emit+0x260/0x31c
> [  489.724495]        vprintk_default+0x54/0x7c
> [  489.729454]        vprintk_func+0x218/0x254
> [  489.734327]        printk+0x7c/0xa4
> [  489.810371] 

Correction -- the call traces of the locking order from,

&(&zone->lock)->rlock --> console_owner:

               -> #1 (console_owner){-...}:
[  489.703613]        lock_acquire+0x320/0x360
[  489.708486]        console_lock_spinning_enable+0x6c/0x7c
[  489.714575]        console_unlock+0x4f8/0x96c
[  489.719622]        vprintk_emit+0x260/0x31c
[  489.724495]        vprintk_default+0x54/0x7c
[  489.729454]        vprintk_func+0x218/0x254
[  489.734327]        printk+0x7c/0xa4
[  489.738506]        get_random_u64+0x1c4/0x1dc
[  489.743552]        add_to_free_area_random+0x50/0x16c
[  489.749292]        __free_one_page+0x374/0x6a0
[  489.754425]        free_one_page+0x6c/0x11c
[  489.810371] 

Should b6da31b2c07c ("tty: Fix data race in tty_insert_flip_string_fixed_flag")
be reverted first while taking time to rework?

>                -> #0 (&(&zone->lock)->rlock){..-.}:
> [  489.817854]        validate_chain+0xf6c/0x2e2c
> [  489.822988]        __lock_acquire+0x868/0xc2c
> [  489.828035]        lock_acquire+0x320/0x360
> [  489.832909]        _raw_spin_lock_irqsave+0x7c/0x9c
> [  489.838475]        rmqueue+0xfe8/0x2274
> [  489.843002]        get_page_from_freelist+0x474/0x688
> [  489.848743]        __alloc_pages_nodemask+0x3b8/0x1928
> [  489.854573]        alloc_pages_current+0xd0/0xe0
> [  489.859882]        stack_depot_save+0x300/0x440
> [  489.865103]        __kasan_kmalloc+0x198/0x1e0
> [  489.870236]        kasan_slab_alloc+0x18/0x20
> [  489.875284]        slab_post_alloc_hook+0x48/0x9c
> [  489.880677]        kmem_cache_alloc+0x2e8/0x588
> [  489.885898]        create_object+0x60/0x698
> [  489.890771]        kmemleak_alloc+0x78/0xb8
> [  489.895644]        slab_post_alloc_hook+0x64/0x9c
> [  489.901038]        __kmalloc+0x328/0x490
> [  489.905652]        __tty_buffer_request_room+0x118/0x1f8
> [  489.911654]        tty_insert_flip_string_fixed_flag+0x6c/0x144
> [  489.918263]        pty_write+0x80/0xd0
> [  489.922701]        n_tty_write+0x450/0x60c
> [  489.927486]        tty_write+0x338/0x474
> [  489.932098]        __vfs_write+0x88/0x214
> [  489.936796]        vfs_write+0x12c/0x1a4
> [  489.941411]        ksys_write+0xb0/0x120
> [  489.946027]        __arm64_sys_write+0x54/0x88
> [  489.951161]        el0_svc_handler+0x170/0x240
> [  489.956294]        el0_sync_handler+0x150/0x250
> [  489.961514]        el0_sync+0x164/0x180
> [  489.966038] 
>                other info that might help us debug this:
> 
> [  489.976117] Chain exists of:
>                  &(&zone->lock)->rlock --> &port_lock_key --> &(&port->lock)-
> > rlock
> 
> [  489.989937]  Possible unsafe locking scenario:
> 
> [  489.997239]        CPU0                    CPU1
> [  490.002456]        ----                    ----
> [  490.007673]   lock(&(&port->lock)->rlock);
> [  490.012459]                                lock(&port_lock_key);
> [  490.019155]                                lock(&(&port->lock)->rlock);
> [  490.026458]   lock(&(&zone->lock)->rlock);
> [  490.031244] 
>                 *** DEADLOCK ***
> 
> [  490.039241] 5 locks held by sshd/5541:
> [  490.043677]  #0: 12ff0009eb0c6890 (&tty->ldisc_sem){++++}, at:
> ldsem_down_read+0x3c/0x48
> [  490.052465]  #1: 12ff0009eb0c6918 (&tty->atomic_write_lock){+.+.}, at:
> tty_write+0x12c/0x474
> [  490.061599]  #2: 12ff0009eb0c6aa0 (&o_tty->termios_rwsem/1){++++}, at:
> n_tty_write+0x10c/0x60c
> [  490.070908]  #3: ffff90001f852360 (&ldata->output_lock){+.+.}, at:
> n_tty_write+0x278/0x60c
> [  490.079868]  #4: 1cff0009e39c0540 (&(&port->lock)->rlock){-.-.}, at:
> pty_write+0x60/0xd0
> [  490.088654] 
>                stack backtrace:
> [  490.094398] CPU: 31 PID: 5541 Comm: sshd Tainted: G        W    L    5.4.0-
> rc5-next-20191030+ #2
> [  490.103871] Hardware name: HPE Apollo 70             /C01_APACHE_MB         ,
> BIOS L50_5.13_1.11 06/18/2019
> [  490.114300] Call trace:
> [  490.117438]  dump_backtrace+0x0/0x248
> [  490.121791]  show_stack+0x20/0x2c
> [  490.125798]  dump_stack+0xc8/0x130
> [  490.129890]  print_circular_bug+0x368/0x380
> [  490.134764]  check_noncircular+0x28c/0x294
> [  490.139550]  validate_chain+0xf6c/0x2e2c
> [  490.144164]  __lock_acquire+0x868/0xc2c
> [  490.148691]  lock_acquire+0x320/0x360
> [  490.153044]  _raw_spin_lock_irqsave+0x7c/0x9c
> [  490.158090]  rmqueue+0xfe8/0x2274
> [  490.162097]  get_page_from_freelist+0x474/0x688
> [  490.167317]  __alloc_pages_nodemask+0x3b8/0x1928
> [  490.172625]  alloc_pages_current+0xd0/0xe0
> [  490.177412]  stack_depot_save+0x300/0x440
> [  490.182112]  __kasan_kmalloc+0x198/0x1e0
> [  490.186723]  kasan_slab_alloc+0x18/0x20
> [  490.191249]  slab_post_alloc_hook+0x48/0x9c
> [  490.196121]  kmem_cache_alloc+0x2e8/0x588
> [  490.200820]  create_object+0x60/0x698
> [  490.205173]  kmemleak_alloc+0x78/0xb8
> [  490.209525]  slab_post_alloc_hook+0x64/0x9c
> [  490.214398]  __kmalloc+0x328/0x490
> [  490.218491]  __tty_buffer_request_room+0x118/0x1f8
> [  490.223972]  tty_insert_flip_string_fixed_flag+0x6c/0x144
> [  490.230059]  pty_write+0x80/0xd0
> [  490.233977]  n_tty_write+0x450/0x60c
> [  490.238241]  tty_write+0x338/0x474
> [  490.242333]  __vfs_write+0x88/0x214
> [  490.246511]  vfs_write+0x12c/0x1a4
> [  490.250601]  ksys_write+0xb0/0x120
> [  490.254693]  __arm64_sys_write+0x54/0x88
> [  490.259305]  el0_svc_handler+0x170/0x240
> [  490.263918]  el0_sync_handler+0x150/0x250
> [  490.268617]  el0_sync+0x164/0x180
