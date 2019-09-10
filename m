Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9FBC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 20:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB0D2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 20:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="K4jwnlhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfIJUfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 16:35:55 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41359 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfIJUfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 16:35:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so472523qkg.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+ctATGShTnI3aa8mmeu+Uf4im+jSOqyh28o5pmP4A8=;
        b=K4jwnlhZ+SLAjnKNXG4GlQtO/WLPgMtR2BbVrVukJKCrRve8SUz2nPDxiIUZ2V2Bbf
         Ti+iiQyJix7XlckVRGtQfb7+IsOuoDxmU0jwZFN9NBVMKFTwV5qZ5sp24/r7/+egQcTC
         VPN0Q3EY2AvEpnl8CEQ1wI0qglFPley+E0kPggpTh7FAzYxo3pv4ZeMIgknch3CBN81A
         jo6Pipl+W75ddf2+mkjicmPm/XljKTJRFlG6FFwHPDaHfAVcBHDDYrT/KqlfEIyrPa9l
         mAmZyyrTstIHGjQeKxxZRLc+tYm5iKhjchQ6Fu4Oufmu2VJrfkOkIHb9+eMVzo2qq3SS
         L69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+ctATGShTnI3aa8mmeu+Uf4im+jSOqyh28o5pmP4A8=;
        b=EgRtjHtu1AJDZMugoMCde74t3gV15SMfZSnj6xFKeMVakVGwntKORqOvg/uLcyiuvN
         SdNOLKeVz7X/UqiQ2nOhL8zv5Zjd4xLNNLrAamd01YhWn6D5EDkU0E+4S2aOlA+FmAt4
         +dksOg95YX5gnFap7PVFaoMTDj/sS91kEwUQ18T8Th19WljQS/59SIAsvEWRlJCbi6k1
         BAr4nar5gFsN1IsEVEEA+1NISeW91/rwtKchtmS5i7kWl+9tTEOwS+ALjIz/bXNm1d+A
         lKpZVkZkG6d0WXy1Gmzf0oMwBtaZXmuRAOZMN7hzYbvmVE2rOlrf0NE80xGC+KmPH6km
         XLMA==
X-Gm-Message-State: APjAAAXDiomDy9hw7Q1vNYybfU9ATZPuQFyaQCluBX6Lywab64M/ZXs9
        VU9FNqU6TOKx9G9xNMVhXRjXjw==
X-Google-Smtp-Source: APXvYqzWch6DPEUv+Ur4U9oOyn1WBBKEyjv1QXP6CwUNTdiHfT7c4bbww+lP1uAX722Ma5V30rOzDA==
X-Received: by 2002:a05:620a:126f:: with SMTP id b15mr31652452qkl.483.1568147753178;
        Tue, 10 Sep 2019 13:35:53 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c29sm12451025qtc.89.2019.09.10.13.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 13:35:52 -0700 (PDT)
Message-ID: <1568147750.5576.134.camel@lca.pw>
Subject: Re: page_alloc.shuffle=1 + CONFIG_PROVE_LOCKING=y = arm64 hang
From:   Qian Cai <cai@lca.pw>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 10 Sep 2019 16:35:50 -0400
In-Reply-To: <1568128954.5576.129.camel@lca.pw>
References: <1566509603.5576.10.camel@lca.pw>
         <1567717680.5576.104.camel@lca.pw> <1568128954.5576.129.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-10 at 11:22 -0400, Qian Cai wrote:
> On Thu, 2019-09-05 at 17:08 -0400, Qian Cai wrote:
> > Another data point is if change CONFIG_DEBUG_OBJECTS_TIMERS from =y to =n, it
> > will also fix it.
> > 
> > On Thu, 2019-08-22 at 17:33 -0400, Qian Cai wrote:
> > > https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> > > 
> > > Booting an arm64 ThunderX2 server with page_alloc.shuffle=1 [1] +
> > > CONFIG_PROVE_LOCKING=y results in hanging.
> > > 
> > > [1] https://lore.kernel.org/linux-mm/154899811208.3165233.17623209031065121886.s
> > > tgit@dwillia2-desk3.amr.corp.intel.com/
> > > 
> > > ...
> > > [  125.142689][    T1] arm-smmu-v3 arm-smmu-v3.2.auto: option mask 0x2
> > > [  125.149687][    T1] arm-smmu-v3 arm-smmu-v3.2.auto: ias 44-bit, oas 44-bit
> > > (features 0x0000170d)
> > > [  125.165198][    T1] arm-smmu-v3 arm-smmu-v3.2.auto: allocated 524288 entries
> > > for cmdq
> > > [  125.239425][ [  125.251484][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: option
> > > mask 0x2
> > > [  125.258233][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: ias 44-bit, oas 44-bit
> > > (features 0x0000170d)
> > > [  125.282750][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 524288 entries
> > > for cmdq
> > > [  125.320097][    T1] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 524288 entries
> > > for evtq
> > > [  125.332667][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: option mask 0x2
> > > [  125.339427][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: ias 44-bit, oas 44-bit
> > > (features 0x0000170d)
> > > [  125.354846][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 524288 entries
> > > for cmdq
> > > [  125.375295][    T1] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 524288 entries
> > > for evtq
> > > [  125.387371][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x2
> > > [  125.393955][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: ias 44-bit, oas 44-bit
> > > (features 0x0000170d)
> > > [  125.522605][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 entries
> > > for cmdq
> > > [  125.543338][    T1] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 524288 entries
> > > for evtq
> > > [  126.694742][    T1] EFI Variables Facility v0.08 2004-May-17
> > > [  126.799291][    T1] NET: Registered protocol family 17
> > > [  126.978632][    T1] zswap: loaded using pool lzo/zbud
> > > [  126.989168][    T1] kmemleak: Kernel memory leak detector initialized
> > > [  126.989191][ T1577] kmemleak: Automatic memory scanning thread started
> > > [  127.044079][ T1335] pcieport 0000:0f:00.0: Adding to iommu group 0
> > > [  127.388074][    T1] Freeing unused kernel memory: 22528K
> > > [  133.527005][    T1] Checked W+X mappings: passed, no W+X pages found
> > > [  133.533474][    T1] Run /init as init process
> > > [  133.727196][    T1] systemd[1]: System time before build time, advancing
> > > clock.
> > > [  134.576021][ T1587] modprobe (1587) used greatest stack depth: 27056 bytes
> > > left
> > > [  134.764026][    T1] systemd[1]: systemd 239 running in system mode. (+PAM
> > > +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT
> > > +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-
> > > hierarchy=legacy)
> > > [  134.799044][    T1] systemd[1]: Detected architecture arm64.
> > > [  134.804818][    T1] systemd[1]: Running in initial RAM disk.
> > > <...hang...>
> > > 
> > > Fix it by either set page_alloc.shuffle=0 or CONFIG_PROVE_LOCKING=n which allow
> > > it to continue successfully.
> > > 
> > > 
> > > [  121.093846][    T1] systemd[1]: Set hostname to <hpe-apollo-cn99xx>.
> > > [  123.157524][    T1] random: systemd: uninitialized urandom read (16 bytes
> > > read)
> > > [  123.168562][    T1] systemd[1]: Listening on Journal Socket.
> > > [  OK  ] Listening on Journal Socket.
> > > [  123.203932][    T1] random: systemd: uninitialized urandom read (16 bytes
> > > read)
> > > [  123.212813][    T1] systemd[1]: Listening on udev Kernel Socket.
> > > [  OK  ] Listening on udev Kernel Socket.
> > > ...
> 
> Not sure if the arm64 hang is just an effect of the potential console deadlock
> below. The lockdep splat can be reproduced by set,
> 
> CONFIG_DEBUG_OBJECTS_TIMER=n (=y will lead to the hang above)
> CONFIG_PROVE_LOCKING=y
> CONFIG_SLAB_FREELIST_RANDOM=y (with page_alloc.shuffle=1)
> 
> while compiling kernels,

This is more than likely, as this debug patch alone will fix the hang,

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9b54cdb301d3..4d5c38035f03 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2323,7 +2323,7 @@ u64 get_random_u64(void)
            return ret;
 #endif
 
-       warn_unseeded_randomness(&previous);
+       //warn_unseeded_randomness(&previous);
 
        batch = raw_cpu_ptr(&batched_entropy_u64);
        spin_lock_irqsave(&batch->batch_lock, flags);

which mostly indicates that the additional printk() from this path due to
"page_alloc.shuffle=1" causes a real deadlock,

allocate_slab
  shuffle_freelist
    get_random_u64
      warn_unseeded_randomness
        printk

> 
> [ 1078.214683][T43784] WARNING: possible circular locking dependency detected
> [ 1078.221550][T43784] 5.3.0-rc7-next-20190904 #14 Not tainted
> [ 1078.227112][T43784] ------------------------------------------------------
> [ 1078.233976][T43784] vi/43784 is trying to acquire lock:
> [ 1078.239192][T43784] ffff008b7cff9290 (&(&zone->lock)->rlock){-.-.}, at:
> rmqueue_bulk.constprop.21+0xb0/0x1218
> [ 1078.249111][T43784] 
> [ 1078.249111][T43784] but task is already holding lock:
> [ 1078.256322][T43784] ffff00938db47d40 (&(&port->lock)->rlock){-.-.}, at:
> pty_write+0x78/0x100
> [ 1078.264760][T43784] 
> [ 1078.264760][T43784] which lock already depends on the new lock.
> [ 1078.264760][T43784] 
> [ 1078.275008][T43784] 
> [ 1078.275008][T43784] the existing dependency chain (in reverse order) is:
> [ 1078.283869][T43784] 
> [ 1078.283869][T43784] -> #3 (&(&port->lock)->rlock){-.-.}:
> [ 1078.291350][T43784]        __lock_acquire+0x5c8/0xbb0
> [ 1078.296394][T43784]        lock_acquire+0x154/0x428
> [ 1078.301266][T43784]        _raw_spin_lock_irqsave+0x80/0xa0
> [ 1078.306831][T43784]        tty_port_tty_get+0x28/0x68
> [ 1078.311873][T43784]        tty_port_default_wakeup+0x20/0x40
> [ 1078.317523][T43784]        tty_port_tty_wakeup+0x38/0x48
> [ 1078.322827][T43784]        uart_write_wakeup+0x2c/0x50
> [ 1078.327956][T43784]        pl011_tx_chars+0x240/0x260
> [ 1078.332999][T43784]        pl011_start_tx+0x24/0xa8
> [ 1078.337868][T43784]        __uart_start+0x90/0xa0
> [ 1078.342563][T43784]        uart_write+0x15c/0x2c8
> [ 1078.347261][T43784]        do_output_char+0x1c8/0x2b0
> [ 1078.352304][T43784]        n_tty_write+0x300/0x668
> [ 1078.357087][T43784]        tty_write+0x2e8/0x430
> [ 1078.361696][T43784]        redirected_tty_write+0xcc/0xe8
> [ 1078.367086][T43784]        do_iter_write+0x228/0x270
> [ 1078.372041][T43784]        vfs_writev+0x10c/0x1c8
> [ 1078.376735][T43784]        do_writev+0xdc/0x180
> [ 1078.381257][T43784]        __arm64_sys_writev+0x50/0x60
> [ 1078.386476][T43784]        el0_svc_handler+0x11c/0x1f0
> [ 1078.391606][T43784]        el0_svc+0x8/0xc
> [ 1078.395691][T43784] 
> [ 1078.395691][T43784] -> #2 (&port_lock_key){-.-.}:
> [ 1078.402561][T43784]        __lock_acquire+0x5c8/0xbb0
> [ 1078.407604][T43784]        lock_acquire+0x154/0x428
> [ 1078.412474][T43784]        _raw_spin_lock+0x68/0x88
> [ 1078.417343][T43784]        pl011_console_write+0x2ac/0x318
> [ 1078.422820][T43784]        console_unlock+0x3c4/0x898
> [ 1078.427863][T43784]        vprintk_emit+0x2d4/0x460
> [ 1078.432732][T43784]        vprintk_default+0x48/0x58
> [ 1078.437688][T43784]        vprintk_func+0x194/0x250
> [ 1078.442557][T43784]        printk+0xbc/0xec
> [ 1078.446732][T43784]        register_console+0x4a8/0x580
> [ 1078.451947][T43784]        uart_add_one_port+0x748/0x878
> [ 1078.457250][T43784]        pl011_register_port+0x98/0x128
> [ 1078.462639][T43784]        sbsa_uart_probe+0x398/0x480
> [ 1078.467772][T43784]        platform_drv_probe+0x70/0x108
> [ 1078.473075][T43784]        really_probe+0x15c/0x5d8
> [ 1078.477944][T43784]        driver_probe_device+0x94/0x1d0
> [ 1078.483335][T43784]        __device_attach_driver+0x11c/0x1a8
> [ 1078.489072][T43784]        bus_for_each_drv+0xf8/0x158
> [ 1078.494201][T43784]        __device_attach+0x164/0x240
> [ 1078.499331][T43784]        device_initial_probe+0x24/0x30
> [ 1078.504721][T43784]        bus_probe_device+0xf0/0x100
> [ 1078.509850][T43784]        device_add+0x63c/0x960
> [ 1078.514546][T43784]        platform_device_add+0x1ac/0x3b8
> [ 1078.520023][T43784]        platform_device_register_full+0x1fc/0x290
> [ 1078.526373][T43784]        acpi_create_platform_device.part.0+0x264/0x3a8
> [ 1078.533152][T43784]        acpi_create_platform_device+0x68/0x80
> [ 1078.539150][T43784]        acpi_default_enumeration+0x34/0x78
> [ 1078.544887][T43784]        acpi_bus_attach+0x340/0x3b8
> [ 1078.550015][T43784]        acpi_bus_attach+0xf8/0x3b8
> [ 1078.555057][T43784]        acpi_bus_attach+0xf8/0x3b8
> [ 1078.560099][T43784]        acpi_bus_attach+0xf8/0x3b8
> [ 1078.565142][T43784]        acpi_bus_scan+0x9c/0x100
> [ 1078.570015][T43784]        acpi_scan_init+0x16c/0x320
> [ 1078.575058][T43784]        acpi_init+0x330/0x3b8
> [ 1078.579666][T43784]        do_one_initcall+0x158/0x7ec
> [ 1078.584797][T43784]        kernel_init_freeable+0x9a8/0xa70
> [ 1078.590360][T43784]        kernel_init+0x18/0x138
> [ 1078.595055][T43784]        ret_from_fork+0x10/0x1c
> [ 1078.599835][T43784] 
> [ 1078.599835][T43784] -> #1 (console_owner){-...}:
> [ 1078.606618][T43784]        __lock_acquire+0x5c8/0xbb0
> [ 1078.611661][T43784]        lock_acquire+0x154/0x428
> [ 1078.616530][T43784]        console_unlock+0x298/0x898
> [ 1078.621573][T43784]        vprintk_emit+0x2d4/0x460
> [ 1078.626442][T43784]        vprintk_default+0x48/0x58
> [ 1078.631398][T43784]        vprintk_func+0x194/0x250
> [ 1078.636267][T43784]        printk+0xbc/0xec
> [ 1078.640443][T43784]        _warn_unseeded_randomness+0xb4/0xd0
> [ 1078.646267][T43784]        get_random_u64+0x4c/0x100
> [ 1078.651224][T43784]        add_to_free_area_random+0x168/0x1a0
> [ 1078.657047][T43784]        free_one_page+0x3dc/0xd08
> [ 1078.662003][T43784]        __free_pages_ok+0x490/0xd00
> [ 1078.667132][T43784]        __free_pages+0xc4/0x118
> [ 1078.671914][T43784]        __free_pages_core+0x2e8/0x428
> [ 1078.677219][T43784]        memblock_free_pages+0xa4/0xec
> [ 1078.682522][T43784]        memblock_free_all+0x264/0x330
> [ 1078.687825][T43784]        mem_init+0x90/0x148
> [ 1078.692259][T43784]        start_kernel+0x368/0x684
> [ 1078.697126][T43784] 
> [ 1078.697126][T43784] -> #0 (&(&zone->lock)->rlock){-.-.}:
> [ 1078.704604][T43784]        check_prev_add+0x120/0x1138
> [ 1078.709733][T43784]        validate_chain+0x888/0x1270
> [ 1078.714863][T43784]        __lock_acquire+0x5c8/0xbb0
> [ 1078.719906][T43784]        lock_acquire+0x154/0x428
> [ 1078.724776][T43784]        _raw_spin_lock+0x68/0x88
> [ 1078.729645][T43784]        rmqueue_bulk.constprop.21+0xb0/0x1218
> [ 1078.735643][T43784]        get_page_from_freelist+0x898/0x24a0
> [ 1078.741467][T43784]        __alloc_pages_nodemask+0x2a8/0x1d08
> [ 1078.747291][T43784]        alloc_pages_current+0xb4/0x150
> [ 1078.752682][T43784]        allocate_slab+0xab8/0x2350
> [ 1078.757725][T43784]        new_slab+0x98/0xc0
> [ 1078.762073][T43784]        ___slab_alloc+0x66c/0xa30
> [ 1078.767029][T43784]        __slab_alloc+0x68/0xc8
> [ 1078.771725][T43784]        __kmalloc+0x3d4/0x658
> [ 1078.776333][T43784]        __tty_buffer_request_room+0xd4/0x220
> [ 1078.782244][T43784]        tty_insert_flip_string_fixed_flag+0x6c/0x128
> [ 1078.788849][T43784]        pty_write+0x98/0x100
> [ 1078.793370][T43784]        n_tty_write+0x2a0/0x668
> [ 1078.798152][T43784]        tty_write+0x2e8/0x430
> [ 1078.802760][T43784]        __vfs_write+0x5c/0xb0
> [ 1078.807368][T43784]        vfs_write+0xf0/0x230
> [ 1078.811890][T43784]        ksys_write+0xd4/0x180
> [ 1078.816498][T43784]        __arm64_sys_write+0x4c/0x60
> [ 1078.821627][T43784]        el0_svc_handler+0x11c/0x1f0
> [ 1078.826756][T43784]        el0_svc+0x8/0xc
> [ 1078.830842][T43784] 
> [ 1078.830842][T43784] other info that might help us debug this:
> [ 1078.830842][T43784] 
> [ 1078.840918][T43784] Chain exists of:
> [ 1078.840918][T43784]   &(&zone->lock)->rlock --> &port_lock_key --> &(&port-
> > lock)->rlock
> 
> [ 1078.840918][T43784] 
> [ 1078.854731][T43784]  Possible unsafe locking scenario:
> [ 1078.854731][T43784] 
> [ 1078.862029][T43784]        CPU0                    CPU1
> [ 1078.867243][T43784]        ----                    ----
> [ 1078.872457][T43784]   lock(&(&port->lock)->rlock);
> [ 1078.877238][T43784]                                lock(&port_lock_key);
> [ 1078.883929][T43784]                                lock(&(&port->lock)-
> > rlock);
> 
> [ 1078.891228][T43784]   lock(&(&zone->lock)->rlock);
> [ 1078.896010][T43784] 
> [ 1078.896010][T43784]  *** DEADLOCK ***
> [ 1078.896010][T43784] 
> [ 1078.904004][T43784] 5 locks held by vi/43784:
> [ 1078.908351][T43784]  #0: ffff000c36240890 (&tty->ldisc_sem){++++}, at:
> ldsem_down_read+0x44/0x50
> [ 1078.917133][T43784]  #1: ffff000c36240918 (&tty->atomic_write_lock){+.+.},
> at: tty_write_lock+0x24/0x60
> [ 1078.926521][T43784]  #2: ffff000c36240aa0 (&o_tty->termios_rwsem/1){++++},
> at: n_tty_write+0x108/0x668
> [ 1078.935823][T43784]  #3: ffffa0001e0b2360 (&ldata->output_lock){+.+.}, at:
> n_tty_write+0x1d0/0x668
> [ 1078.944777][T43784]  #4: ffff00938db47d40 (&(&port->lock)->rlock){-.-.}, at:
> pty_write+0x78/0x100
> [ 1078.953644][T43784] 
> [ 1078.953644][T43784] stack backtrace:
> [ 1078.959382][T43784] CPU: 97 PID: 43784 Comm: vi Not tainted 5.3.0-rc7-next-
> 20190904 #14
> [ 1078.967376][T43784] Hardware name: HPE Apollo
> 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
> [ 1078.977799][T43784] Call trace:
> [ 1078.980932][T43784]  dump_backtrace+0x0/0x228
> [ 1078.985279][T43784]  show_stack+0x24/0x30
> [ 1078.989282][T43784]  dump_stack+0xe8/0x13c
> [ 1078.993370][T43784]  print_circular_bug+0x334/0x3d8
> [ 1078.998240][T43784]  check_noncircular+0x268/0x310
> [ 1079.003022][T43784]  check_prev_add+0x120/0x1138
> [ 1079.007631][T43784]  validate_chain+0x888/0x1270
> [ 1079.012241][T43784]  __lock_acquire+0x5c8/0xbb0
> [ 1079.016763][T43784]  lock_acquire+0x154/0x428
> [ 1079.021111][T43784]  _raw_spin_lock+0x68/0x88
> [ 1079.025460][T43784]  rmqueue_bulk.constprop.21+0xb0/0x1218
> [ 1079.030937][T43784]  get_page_from_freelist+0x898/0x24a0
> [ 1079.036240][T43784]  __alloc_pages_nodemask+0x2a8/0x1d08
> [ 1079.041542][T43784]  alloc_pages_current+0xb4/0x150
> [ 1079.046412][T43784]  allocate_slab+0xab8/0x2350
> [ 1079.050934][T43784]  new_slab+0x98/0xc0
> [ 1079.054761][T43784]  ___slab_alloc+0x66c/0xa30
> [ 1079.059196][T43784]  __slab_alloc+0x68/0xc8
> [ 1079.063371][T43784]  __kmalloc+0x3d4/0x658
> [ 1079.067458][T43784]  __tty_buffer_request_room+0xd4/0x220
> [ 1079.072847][T43784]  tty_insert_flip_string_fixed_flag+0x6c/0x128
> [ 1079.078932][T43784]  pty_write+0x98/0x100
> [ 1079.082932][T43784]  n_tty_write+0x2a0/0x668
> [ 1079.087193][T43784]  tty_write+0x2e8/0x430
> [ 1079.091280][T43784]  __vfs_write+0x5c/0xb0
> [ 1079.095367][T43784]  vfs_write+0xf0/0x230
> [ 1079.099368][T43784]  ksys_write+0xd4/0x180
> [ 1079.103455][T43784]  __arm64_sys_write+0x4c/0x60
> [ 1079.108064][T43784]  el0_svc_handler+0x11c/0x1f0
> [ 1079.112672][T43784]  el0_svc+0x8/0xc
