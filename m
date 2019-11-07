Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E009C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31EE21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUS6ek03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbfKGMJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:09:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41028 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKGMJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:09:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so2727821wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+X5PB3/RS5wCFHmPJyZSxQgzB/KzYcqDr3Ujqj02UOU=;
        b=AUS6ek03A3OnuO/uZoLjncpiKumtxzkQ2kDR8lQjnQZZn7YWajlJb5Pf0pepBt0E0L
         fjGr0p9NCqqyX9GkLOIQpghHnczaYeFwlVy38iKSVIYTUZUCljhJvilHbeh4mRjzVPAe
         kr1qBTAVklesaGUngown0QrqBlU0CVEtJDUEK9SFrq5vg7irADLOnx0VerXvSycYDID9
         l0wDFHG8rM3zYDJ36ch7sYeJ122T74VRYVyk4jrFK2vkifh/wPy8sufEPm8qiOVppobt
         MuK8y7p1rlNevlrtWPh1OWYhKh8Ptbaw0Ny3s9QTVNRAwS9ZgKG7bbsdN648G1FnzxRP
         Llsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+X5PB3/RS5wCFHmPJyZSxQgzB/KzYcqDr3Ujqj02UOU=;
        b=nM534N/TJpHJZGHim7V0Tfzw71dV3XL2FGhc2Btv4+lQckSHObzCl9eWqepz2Afia6
         9rJsBwG2soHfaT5U9dBnmw1omLH4jo0jzmLkMK4sWTlfPZ4s5S/x/5HqwOjCFkJe8D7V
         QkVNZmnLnxSFIueLU9zoEvV7LMfiq8bt9MewLR+/PRfzCNH5tHzi3K0+eeEyjoTHbraL
         CBDddu8q6SbScmPDWq4gqEC9aKudXP1ih6k3hwOO+Rt7AtmVTK+fLTkojGonblpr4eAb
         oelNz/YQB4/f2sGmsNgLuhO+S06TclIUGaO/IwfAsc5k3ZhzCBUusFR4865Nn/KQfRpp
         P16Q==
X-Gm-Message-State: APjAAAVD4j4IIRP4HQkeOUdkbq9aUIbdP+2rSePsRg5Gfu0aPSm/t6x2
        VtTYhPeizzkcJz6y0AOQWmyWsA==
X-Google-Smtp-Source: APXvYqxKFNTXdLJBBbXJqwz0eq1z7m43VCuH7RGlkgfFABA1s6vtSmpLMSzmHfsTlmmmuRCJB4xzMQ==
X-Received: by 2002:adf:b686:: with SMTP id j6mr2560177wre.186.1573128567622;
        Thu, 07 Nov 2019 04:09:27 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id v16sm2615891wrc.84.2019.11.07.04.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:09:26 -0800 (PST)
Date:   Thu, 7 Nov 2019 12:09:22 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Aaron Lu <aaron.lwe@gmail.com>, Phil Auld <pauld@redhat.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org,
        kernel-team@android.com
Subject: Re: [sched] 10e7071b2f: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20191107120922.GA82729@google.com>
References: <20191107090808.GW29418@shao2-debian>
 <fc023bbd-e282-c986-b43b-18ac31b2e362@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc023bbd-e282-c986-b43b-18ac31b2e362@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Nov 2019 at 11:41:38 (+0000), Valentin Schneider wrote:
> On 07/11/2019 09:08, kernel test robot wrote:
> > [   84.432464] BUG: kernel NULL pointer dereference, address: 0000000000000064
> > [   84.433700] #PF: supervisor read access in kernel mode
> > [   84.434589] #PF: error_code(0x0000) - not-present page
> > [   84.435499] PGD 0 P4D 0 
> > [   84.435933] Oops: 0000 [#1] SMP PTI
> > [   84.436581] CPU: 1 PID: 15 Comm: migration/1 Not tainted 5.3.0-rc1-00086-g10e7071b2f491 #1
> > [   84.438004] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > [   84.439461] RIP: 0010:pick_next_task_dl+0xe/0xf0
> > [   84.440266] Code: ed bd 70 01 01 e8 42 2d fb ff 0f 0b e9 6b ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 55 53 48 89 fb 48 83 ec 10 <8b> 46 64 85 c0 78 73 48 81 7e 78 a0 3f e2 a7 74 57 48 83 bb 10 09
> > [   84.443485] RSP: 0000:ffffa5518008bd40 EFLAGS: 00010082
> > [   84.444423] RAX: ffffffffa6eeeae0 RBX: ffff98ebbfd2b0c0 RCX: ffff98ebbfd2d040
> > [   84.445641] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff98ebbfd2b0c0
> > [   84.446877] RBP: ffffa5518008bdc0 R08: 0000001ac1016512 R09: 0000000000000001
> > [   84.448128] R10: ffffffffa863e640 R11: 0000000000000003 R12: ffff98ebbfd2b0c0
> > [   84.449349] R13: ffffffffa7e23fa0 R14: ffffffffa7e24060 R15: 0000000000000000
> > [   84.450603] FS:  0000000000000000(0000) GS:ffff98ebbfd00000(0000) knlGS:0000000000000000
> > [   84.452007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   84.453022] CR2: 0000000000000064 CR3: 00000001aab84000 CR4: 00000000000406e0
> > [   84.454244] Call Trace:
> > [   84.455263]  ? update_rq_clock+0x6d/0xe0
> > [   84.456081]  sched_cpu_dying+0x104/0x380
> > [   84.456777]  ? sched_cpu_starting+0xf0/0xf0
> > [   84.457510]  cpuhp_invoke_callback+0x86/0x5d0
> > [   84.458279]  ? cpu_disable_common+0x292/0x2b0
> > [   84.459047]  take_cpu_down+0x60/0xb0
> > [   84.459649]  multi_cpu_stop+0x6b/0x100
> > [   84.460339]  ? stop_machine_yield+0x10/0x10
> > [   84.461078]  cpu_stopper_thread+0x9e/0x110
> > [   84.461809]  ? smpboot_thread_fn+0x2f/0x1e0
> > [   84.462539]  ? smpboot_thread_fn+0x74/0x1e0
> > [   84.463280]  ? smpboot_thread_fn+0x14e/0x1e0
> > [   84.464024]  smpboot_thread_fn+0x149/0x1e0
> > [   84.464768]  ? sort_range+0x20/0x20
> > [   84.465389]  kthread+0x11e/0x140
> > [   84.465961]  ? kthread_park+0xa0/0xa0
> > [   84.466605]  ret_from_fork+0x35/0x40
> > [   84.467236] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver binfmt_misc intel_rapl_msr intel_rapl_common sr_mod crct10dif_pclmul cdrom crc32_pclmul sg crc32c_intel ghash_clmulni_intel ata_generic pata_acpi ppdev bochs_drm drm_vram_helper ttm drm_kms_helper syscopyarea sysfillrect snd_pcm sysimgblt fb_sys_fops drm aesni_intel snd_timer ata_piix crypto_simd snd cryptd glue_helper libata soundcore pcspkr joydev serio_raw parport_pc i2c_piix4 parport floppy ip_tables
> > [   84.474471] CR2: 0000000000000064
> > [   84.475066] ---[ end trace af8f1919a81ca744 ]---
> > 
> 
> It would be really nice if the lkpbot could feed this through
> scripts/decode_stracktrace.sh too.
> 
> 
> AFAICT this is dying in __pick_migrate_task(), where we have a 
> pick_next_task()/put_prev_task() dance. Sounds oddly familiar :-)

Argh, indeed :( For context, this has been reported too:

  https://lore.kernel.org/lkml/20191028174603.GA246917@google.com/

> However I don't think we have an issue with the lock being released when
> we reach pick_next_task_fair() - if we ever reach the newidle_balance()
> in there it means we didn't have any CFS task to play with in the first
> place.
>
> We *may* e.g. go through sched_move_task() on a task we'll end up picking
> via active balance, but AFAICT that would be harmless:

sched_move_task() follows what Peter called the 'change' pattern, so I'm
thinking this is most likely the same issue. Dropping the lock causes an
unmitigated race between sched_move_task() and pick_next_task_dl(), so
hilarity ensues (set_next_task() being called twice for instance).

> __pick_migrate_task()
>   ...
>   pick_next_task_fair()
>     newidle_balance()
>       drop lock
>                                   sched_move_task()
>                                     put_prev_task()
>                                     set_next_task()
>   active balance
>   ...
>   put_prev_task()
>
> On top of that, the deathpoint seems to be select_task_rq_dl() which would
> happen way before we reach fair. I don't see anything obvious by staring
> at the old fake task pick loop vs __pick_migrate_task(). Lemme try to
> reproduce.


> 
> > 
> > To reproduce:
> > 
> >         # build kernel
> > 	cd linux
> > 	cp config-5.3.0-rc1-00086-g10e7071b2f491 .config
> > 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> > 
> > 
> > 
> > Thanks,
> > lkp
> > 
