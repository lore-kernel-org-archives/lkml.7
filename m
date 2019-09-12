Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F9EC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775BC20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PHMbwRLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbfILMFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:05:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38795 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbfILMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:05:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id u186so426749qkc.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJZnkAph4eWPg2JY0OJg1uyo+AB/rygpeOgbYnQYg+A=;
        b=PHMbwRLUajgsxYGoU2VYPXeI6AnW1Z99q+4x3xNofXmvNs2ljAvg8S8jwF1DFzSSF5
         Dcxr5sZwDvNX9Ns/vcb0/H/v3n97nWNWMw9vTpeIwzhAI5ASHki3wI+CEsm2IJ0BoYZQ
         zY9QRBEUB48oaEXi+RIa+6xM2GU8qYbXrju78nCHFhcO+HayZ09qXAapbw+mkeUbFdQO
         39xwEsHgeKydQ7TQ3C9OI4Xxpvdr8RL0KILDuEdxjTkqaXdEIWhfMRPp23ML7yeQWGyJ
         rtuPDLKGeWVIVBQsYz8evpr/rZgdUxirJVLg2jNrOYgUTVajfWUoNsLDnEpidyBWxXkO
         2VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJZnkAph4eWPg2JY0OJg1uyo+AB/rygpeOgbYnQYg+A=;
        b=bQdOPRwI6NN7t22ulbFh7quIvjTuQbRI47NSgwmT2/5L+85u+EHLDphYaX07wwho/e
         yaHEK+bvo6jqDXU7ZkuhTiUM/1G2cRlfjk99tdEurv0tJF3wKf3yTmjqDeixZKR8EczM
         gS9PLX94De5PxaDTqHdNg5paLsRgVBC2QPKDBiN+sZO9IbFQmOEp7Rpm2/x7f/R0fT2s
         QE+1ZP5SYTa9NKz2VkHNNlzn0LRzxALqsK3rd4Sx3sisW7xLAH39VqcxWcOq9/o4e5SI
         gwZFg9obKL5J+kKMGPDPLkAeOz3uZZtK3/i09fFbiOKT30TsRDWiVWvYJqCo3/vK5uFe
         QWgA==
X-Gm-Message-State: APjAAAUrVVkuX7l5zzaznV6RNthE37g0bTJYb8DsV+2mH0r2LFj8U58d
        hD2o8pe2+/NWQX+D7rXAX/FqTQ==
X-Google-Smtp-Source: APXvYqzaQLexeJeISLu9NzxSj57E5Jb6rNfGitOWIjOeff65L1JgwmcD9OC+HHkRsZ7m0eytDZsaxA==
X-Received: by 2002:a37:7941:: with SMTP id u62mr37782509qkc.179.1568289944615;
        Thu, 12 Sep 2019 05:05:44 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z20sm11802903qtu.91.2019.09.12.05.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 05:05:43 -0700 (PDT)
Message-ID: <1568289941.5576.140.camel@lca.pw>
Subject: Re: page_alloc.shuffle=1 + CONFIG_PROVE_LOCKING=y = arm64 hang
From:   Qian Cai <cai@lca.pw>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu, 12 Sep 2019 08:05:41 -0400
In-Reply-To: <20190911011008.GA4420@jagdpanzerIV>
References: <1566509603.5576.10.camel@lca.pw>
         <1567717680.5576.104.camel@lca.pw> <1568128954.5576.129.camel@lca.pw>
         <20190911011008.GA4420@jagdpanzerIV>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-11 at 10:10 +0900, Sergey Senozhatsky wrote:
> Cc-ing Ted, Arnd, Greg
> 
> On (09/10/19 11:22), Qian Cai wrote:
> > [ 1078.283869][T43784] -> #3 (&(&port->lock)->rlock){-.-.}:
> > [ 1078.291350][T43784]        __lock_acquire+0x5c8/0xbb0
> > [ 1078.296394][T43784]        lock_acquire+0x154/0x428
> > [ 1078.301266][T43784]        _raw_spin_lock_irqsave+0x80/0xa0
> > [ 1078.306831][T43784]        tty_port_tty_get+0x28/0x68
> > [ 1078.311873][T43784]        tty_port_default_wakeup+0x20/0x40
> > [ 1078.317523][T43784]        tty_port_tty_wakeup+0x38/0x48
> > [ 1078.322827][T43784]        uart_write_wakeup+0x2c/0x50
> > [ 1078.327956][T43784]        pl011_tx_chars+0x240/0x260
> > [ 1078.332999][T43784]        pl011_start_tx+0x24/0xa8
> > [ 1078.337868][T43784]        __uart_start+0x90/0xa0
> > [ 1078.342563][T43784]        uart_write+0x15c/0x2c8
> > [ 1078.347261][T43784]        do_output_char+0x1c8/0x2b0
> > [ 1078.352304][T43784]        n_tty_write+0x300/0x668
> > [ 1078.357087][T43784]        tty_write+0x2e8/0x430
> > [ 1078.361696][T43784]        redirected_tty_write+0xcc/0xe8
> > [ 1078.367086][T43784]        do_iter_write+0x228/0x270
> > [ 1078.372041][T43784]        vfs_writev+0x10c/0x1c8
> > [ 1078.376735][T43784]        do_writev+0xdc/0x180
> > [ 1078.381257][T43784]        __arm64_sys_writev+0x50/0x60
> > [ 1078.386476][T43784]        el0_svc_handler+0x11c/0x1f0
> > [ 1078.391606][T43784]        el0_svc+0x8/0xc
> > [ 1078.395691][T43784] 
> 
> uart_port->lock  ->  tty_port->lock
> 
> This thing along is already a bit suspicious. We re-enter tty
> here: tty -> uart -> serial -> tty
> 
> And we re-enter tty under uart_port->lock.
> 
> > [ 1078.395691][T43784] -> #2 (&port_lock_key){-.-.}:
> > [ 1078.402561][T43784]        __lock_acquire+0x5c8/0xbb0
> > [ 1078.407604][T43784]        lock_acquire+0x154/0x428
> > [ 1078.412474][T43784]        _raw_spin_lock+0x68/0x88
> > [ 1078.417343][T43784]        pl011_console_write+0x2ac/0x318
> > [ 1078.422820][T43784]        console_unlock+0x3c4/0x898
> > [ 1078.427863][T43784]        vprintk_emit+0x2d4/0x460
> > [ 1078.432732][T43784]        vprintk_default+0x48/0x58
> > [ 1078.437688][T43784]        vprintk_func+0x194/0x250
> > [ 1078.442557][T43784]        printk+0xbc/0xec
> > [ 1078.446732][T43784]        register_console+0x4a8/0x580
> > [ 1078.451947][T43784]        uart_add_one_port+0x748/0x878
> > [ 1078.457250][T43784]        pl011_register_port+0x98/0x128
> > [ 1078.462639][T43784]        sbsa_uart_probe+0x398/0x480
> > [ 1078.467772][T43784]        platform_drv_probe+0x70/0x108
> > [ 1078.473075][T43784]        really_probe+0x15c/0x5d8
> > [ 1078.477944][T43784]        driver_probe_device+0x94/0x1d0
> > [ 1078.483335][T43784]        __device_attach_driver+0x11c/0x1a8
> > [ 1078.489072][T43784]        bus_for_each_drv+0xf8/0x158
> > [ 1078.494201][T43784]        __device_attach+0x164/0x240
> > [ 1078.499331][T43784]        device_initial_probe+0x24/0x30
> > [ 1078.504721][T43784]        bus_probe_device+0xf0/0x100
> > [ 1078.509850][T43784]        device_add+0x63c/0x960
> > [ 1078.514546][T43784]        platform_device_add+0x1ac/0x3b8
> > [ 1078.520023][T43784]        platform_device_register_full+0x1fc/0x290
> > [ 1078.526373][T43784]        acpi_create_platform_device.part.0+0x264/0x3a8
> > [ 1078.533152][T43784]        acpi_create_platform_device+0x68/0x80
> > [ 1078.539150][T43784]        acpi_default_enumeration+0x34/0x78
> > [ 1078.544887][T43784]        acpi_bus_attach+0x340/0x3b8
> > [ 1078.550015][T43784]        acpi_bus_attach+0xf8/0x3b8
> > [ 1078.555057][T43784]        acpi_bus_attach+0xf8/0x3b8
> > [ 1078.560099][T43784]        acpi_bus_attach+0xf8/0x3b8
> > [ 1078.565142][T43784]        acpi_bus_scan+0x9c/0x100
> > [ 1078.570015][T43784]        acpi_scan_init+0x16c/0x320
> > [ 1078.575058][T43784]        acpi_init+0x330/0x3b8
> > [ 1078.579666][T43784]        do_one_initcall+0x158/0x7ec
> > [ 1078.584797][T43784]        kernel_init_freeable+0x9a8/0xa70
> > [ 1078.590360][T43784]        kernel_init+0x18/0x138
> > [ 1078.595055][T43784]        ret_from_fork+0x10/0x1c
> > 
> > [ 1078.599835][T43784] -> #1 (console_owner){-...}:
> > [ 1078.606618][T43784]        __lock_acquire+0x5c8/0xbb0
> > [ 1078.611661][T43784]        lock_acquire+0x154/0x428
> > [ 1078.616530][T43784]        console_unlock+0x298/0x898
> > [ 1078.621573][T43784]        vprintk_emit+0x2d4/0x460
> > [ 1078.626442][T43784]        vprintk_default+0x48/0x58
> > [ 1078.631398][T43784]        vprintk_func+0x194/0x250
> > [ 1078.636267][T43784]        printk+0xbc/0xec
> > [ 1078.640443][T43784]        _warn_unseeded_randomness+0xb4/0xd0
> > [ 1078.646267][T43784]        get_random_u64+0x4c/0x100
> > [ 1078.651224][T43784]        add_to_free_area_random+0x168/0x1a0
> > [ 1078.657047][T43784]        free_one_page+0x3dc/0xd08
> > [ 1078.662003][T43784]        __free_pages_ok+0x490/0xd00
> > [ 1078.667132][T43784]        __free_pages+0xc4/0x118
> > [ 1078.671914][T43784]        __free_pages_core+0x2e8/0x428
> > [ 1078.677219][T43784]        memblock_free_pages+0xa4/0xec
> > [ 1078.682522][T43784]        memblock_free_all+0x264/0x330
> > [ 1078.687825][T43784]        mem_init+0x90/0x148
> > [ 1078.692259][T43784]        start_kernel+0x368/0x684
> 
> zone->lock --> uart_port->lock
> 
> Some debugging options/warnings/error print outs/etc introduce
> deadlock patterns.
> 
> This adds zone->lock --> uart_port->lock, which then brings in
> uart_port->lock --> tty_port->lock, which in turn brings
> tty_port->lock --> zone->lock.
> 
> > [ 1078.697126][T43784] -> #0 (&(&zone->lock)->rlock){-.-.}:
> > [ 1078.704604][T43784]        check_prev_add+0x120/0x1138
> > [ 1078.709733][T43784]        validate_chain+0x888/0x1270
> > [ 1078.714863][T43784]        __lock_acquire+0x5c8/0xbb0
> > [ 1078.719906][T43784]        lock_acquire+0x154/0x428
> > [ 1078.724776][T43784]        _raw_spin_lock+0x68/0x88
> > [ 1078.729645][T43784]        rmqueue_bulk.constprop.21+0xb0/0x1218
> > [ 1078.735643][T43784]        get_page_from_freelist+0x898/0x24a0
> > [ 1078.741467][T43784]        __alloc_pages_nodemask+0x2a8/0x1d08
> > [ 1078.747291][T43784]        alloc_pages_current+0xb4/0x150
> > [ 1078.752682][T43784]        allocate_slab+0xab8/0x2350
> > [ 1078.757725][T43784]        new_slab+0x98/0xc0
> > [ 1078.762073][T43784]        ___slab_alloc+0x66c/0xa30
> > [ 1078.767029][T43784]        __slab_alloc+0x68/0xc8
> > [ 1078.771725][T43784]        __kmalloc+0x3d4/0x658
> > [ 1078.776333][T43784]        __tty_buffer_request_room+0xd4/0x220
> > [ 1078.782244][T43784]        tty_insert_flip_string_fixed_flag+0x6c/0x128
> > [ 1078.788849][T43784]        pty_write+0x98/0x100
> > [ 1078.793370][T43784]        n_tty_write+0x2a0/0x668
> > [ 1078.798152][T43784]        tty_write+0x2e8/0x430
> > [ 1078.802760][T43784]        __vfs_write+0x5c/0xb0
> > [ 1078.807368][T43784]        vfs_write+0xf0/0x230
> > [ 1078.811890][T43784]        ksys_write+0xd4/0x180
> > [ 1078.816498][T43784]        __arm64_sys_write+0x4c/0x60
> > [ 1078.821627][T43784]        el0_svc_handler+0x11c/0x1f0
> > [ 1078.826756][T43784]        el0_svc+0x8/0xc
> 
> tty_port->lock --> zone->lock
> 
> > [ 1078.830842][T43784] other info that might help us debug this:
> > [ 1078.830842][T43784] 
> > [ 1078.840918][T43784] Chain exists of:
> > [ 1078.840918][T43784]   &(&zone->lock)->rlock --> &port_lock_key --> &(&port-> >lock)->rlock
> > [ 1078.840918][T43784] 
> > [ 1078.854731][T43784]  Possible unsafe locking scenario:
> > [ 1078.854731][T43784] 
> > [ 1078.862029][T43784]        CPU0                    CPU1
> > [ 1078.867243][T43784]        ----                    ----
> > [ 1078.872457][T43784]   lock(&(&port->lock)->rlock);
> > [ 1078.877238][T43784]                                lock(&port_lock_key);
> > [ 1078.883929][T43784]                                lock(&(&port->lock)->rlock);
> > [ 1078.891228][T43784]   lock(&(&zone->lock)->rlock);
> > [ 1078.896010][T43784] 
> > [ 1078.896010][T43784]  *** DEADLOCK ***
> 
> [..]
> > [ 1078.980932][T43784]  dump_backtrace+0x0/0x228
> > [ 1078.985279][T43784]  show_stack+0x24/0x30
> > [ 1078.989282][T43784]  dump_stack+0xe8/0x13c
> > [ 1078.993370][T43784]  print_circular_bug+0x334/0x3d8
> > [ 1078.998240][T43784]  check_noncircular+0x268/0x310
> > [ 1079.003022][T43784]  check_prev_add+0x120/0x1138
> > [ 1079.007631][T43784]  validate_chain+0x888/0x1270
> > [ 1079.012241][T43784]  __lock_acquire+0x5c8/0xbb0
> > [ 1079.016763][T43784]  lock_acquire+0x154/0x428
> > [ 1079.021111][T43784]  _raw_spin_lock+0x68/0x88
> > [ 1079.025460][T43784]  rmqueue_bulk.constprop.21+0xb0/0x1218
> > [ 1079.030937][T43784]  get_page_from_freelist+0x898/0x24a0
> > [ 1079.036240][T43784]  __alloc_pages_nodemask+0x2a8/0x1d08
> > [ 1079.041542][T43784]  alloc_pages_current+0xb4/0x150
> > [ 1079.046412][T43784]  allocate_slab+0xab8/0x2350
> > [ 1079.050934][T43784]  new_slab+0x98/0xc0
> > [ 1079.054761][T43784]  ___slab_alloc+0x66c/0xa30
> > [ 1079.059196][T43784]  __slab_alloc+0x68/0xc8
> > [ 1079.063371][T43784]  __kmalloc+0x3d4/0x658
> > [ 1079.067458][T43784]  __tty_buffer_request_room+0xd4/0x220
> > [ 1079.072847][T43784]  tty_insert_flip_string_fixed_flag+0x6c/0x128
> > [ 1079.078932][T43784]  pty_write+0x98/0x100
> > [ 1079.082932][T43784]  n_tty_write+0x2a0/0x668
> > [ 1079.087193][T43784]  tty_write+0x2e8/0x430
> > [ 1079.091280][T43784]  __vfs_write+0x5c/0xb0
> > [ 1079.095367][T43784]  vfs_write+0xf0/0x230
> > [ 1079.099368][T43784]  ksys_write+0xd4/0x180
> > [ 1079.103455][T43784]  __arm64_sys_write+0x4c/0x60
> > [ 1079.108064][T43784]  el0_svc_handler+0x11c/0x1f0
> > [ 1079.112672][T43784]  el0_svc+0x8/0xc
> 
> tty_port->lock --> zone->lock
> 
> For instance, I don't really like the re-entrant tty, at least not
> under uart_port->lock. This, maybe, can be one of the solutions.
> 
> Another one, a quick and dirty one, (and so many people will blame
> me for this) would be to break zone->{printk}->uart chain...
> 
> Something like this
> 
> ---
> 
>  drivers/char/random.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 9b54cdb301d3..975015857200 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1687,8 +1687,9 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
>  	print_once = true;
>  #endif
>  	if (__ratelimit(&unseeded_warning))
> -		pr_notice("random: %s called from %pS with crng_init=%d\n",
> -			  func_name, caller, crng_init);
> +		printk_deferred(KERN_NOTICE "random: %s called from %pS "
> +				"with crng_init=%d\n", func_name, caller,
> +				crng_init);
>  }
>  
>  /*
> @@ -2462,4 +2463,4 @@ void add_bootloader_randomness(const void *buf, unsigned int size)
>  	else
>  		add_device_randomness(buf, size);
>  }
> -EXPORT_SYMBOL_GPL(add_bootloader_randomness);
> \ No newline at end of file
> +EXPORT_SYMBOL_GPL(add_bootloader_randomness);

This will also fix the hang.

Sergey, do you plan to submit this Ted?
