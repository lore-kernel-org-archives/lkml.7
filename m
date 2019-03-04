Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14814C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD712070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UuZ5LcxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfCDSNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:13:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33327 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfCDSNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:13:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so3592517pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yK4O72k1lpjFQ6iyWXFqL29mhGE0xTvTivIKFf6aeD4=;
        b=UuZ5LcxYztVO+Bq8z4ttuBRpc+f3bYvD/cvQ/nbR8IROPj77S1KblxHoTcUrmHaGK8
         xBJ8C2d97WBcd4SQrP8YpVl9/Q6Rc+yqXLvp5qQYNaKbZ6zLjrhAWFNj+1myGKrbpXLw
         1jZbQzFHmc9OuqoN6JI8p7Z28Lru8Y7clG3E9A+VZKAY9F5qCZ4i/Vm2+7c7g6Za6Xbq
         7idziAFQzb0N59Ly3lj0KwIUEbSDTqmy4dfr9TkWfKdx/RfddJOZk8vv12kHTN8lyDNG
         HvhRGAiVf2M+eZbQvSRk2aOafZsPf0eLPpAjOs7XnBzAZP+gb2BczUmeuwt85r28Hbn9
         GUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=yK4O72k1lpjFQ6iyWXFqL29mhGE0xTvTivIKFf6aeD4=;
        b=j/5/TSGHt41EkMnInOw/tAe6COmZClmNUxBquS6P01YaU3BN14mQGCQwiy6iKABwxW
         1sJ4Z7pWqVCQNL7Hx0IWzpygzDS4erylUmIOKCOCJdLTpAIBRXqdsgvKAnehEfE6qD0K
         E77ahprLz9RwmzbR7Wgubud9xkw1D1uzh8pAy1nx1zlT4N9eoKOSlY63bvuyYUzQYkr4
         37P6Pyc+6f/qmJEPCyn/lnQf31Q6cvtmqoExzgqEbgmLT1CJ3fcljZrPM0MPd/FolVb7
         0Zhce6eTxFyjNr9hRhCxFApE0p80vLR6/iqneF3xWuTzNB9kfWiVq9kR7ZmtS1nVFRaM
         /7Qw==
X-Gm-Message-State: APjAAAVuw+A502o8mbr4XCxKYrFZY+grOGCa228rlKVqBiPtrcd5mxOd
        Hc9vc0zixakEsAodvPwQlH/h2/vppcw=
X-Google-Smtp-Source: APXvYqwcQ7cLfkuxKjQbGkqVPHGvMfEmKet4NiVStdsRiwqLCxzg8FeUJfDZT8p1L36U7BQOpM33Hg==
X-Received: by 2002:a17:902:2702:: with SMTP id c2mr21398944plb.239.1551723232061;
        Mon, 04 Mar 2019 10:13:52 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id l2sm9266204pgj.64.2019.03.04.10.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 10:13:50 -0800 (PST)
From:   bsegall@google.com
To:     Phil Auld <pauld@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
References: <20190301145209.GA9304@pauld.bos.csb>
Date:   Mon, 04 Mar 2019 10:13:49 -0800
In-Reply-To: <20190301145209.GA9304@pauld.bos.csb> (Phil Auld's message of
        "Fri, 1 Mar 2019 09:52:09 -0500")
Message-ID: <xm26ef7mzew2.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> Hi,
>
> I have a reproducible case of this: 
>
> [  217.264946] NMI watchdog: Watchdog detected hard LOCKUP on cpu 24
> [  217.264948] Modules linked in: sunrpc iTCO_wdt gpio_ich iTCO_vendor_support intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel ipmi_si intel_cstate joydev ipmi_devintf pcspkr hpilo intel_uncore sg hpwdt ipmi_msghandler acpi_power_meter i7core_edac lpc_ich acpi_cpufreq ip_tables xfs libcrc32c sr_mod sd_mod cdrom ata_generic radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ata_piix drm serio_raw crc32c_intel hpsa myri10ge libata dca scsi_transport_sas netxen_nic dm_mirror dm_region_hash dm_log dm_mod
> [  217.264964] CPU: 24 PID: 46684 Comm: myapp Not tainted 5.0.0-rc7+ #25
> [  217.264965] Hardware name: HP ProLiant DL580 G7, BIOS P65 08/16/2015
> [  217.264965] RIP: 0010:tg_nop+0x0/0x10
> [  217.264966] Code: 83 c9 08 f0 48 0f b1 0f 48 39 c2 74 0e 48 89 c2 f7 c2 00 00 20 00 75 dc 31 c0 c3 b8 01 00 00 00 c3 66 0f 1f 84 00 00 00 00 00 <66> 66 66 66 90 31 c0 c3 0f 1f 84 00 00 00 00 00 66 66 66 66 90 8b
> [  217.264967] RSP: 0000:ffff976a7f703e48 EFLAGS: 00000087
> [  217.264967] RAX: ffff976a7c7c8f00 RBX: ffff976a6f4fad00 RCX: ffff976a7c7c90f0
> [  217.264968] RDX: ffff976a6f4faee0 RSI: ffff976a7f961f00 RDI: ffff976a6f4fad00
> [  217.264968] RBP: ffff976a7f961f00 R08: 0000000000000002 R09: ffffffad2c9b3331
> [  217.264969] R10: 0000000000000000 R11: 0000000000000000 R12: ffff976a7c7c8f00
> [  217.264969] R13: ffffffffb2305c00 R14: 0000000000000000 R15: ffffffffb22f8510
> [  217.264970] FS:  00007f6240678740(0000) GS:ffff976a7f700000(0000) knlGS:0000000000000000
> [  217.264970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  217.264971] CR2: 00000000006dee20 CR3: 000000bf2bffc005 CR4: 00000000000206e0
> [  217.264971] Call Trace:
> [  217.264971]  <IRQ>
> [  217.264972]  walk_tg_tree_from+0x29/0xb0
> [  217.264972]  unthrottle_cfs_rq+0xe0/0x1a0
> [  217.264972]  distribute_cfs_runtime+0xd3/0xf0
> [  217.264973]  sched_cfs_period_timer+0xcb/0x160
> [  217.264973]  ? sched_cfs_slack_timer+0xd0/0xd0
> [  217.264973]  __hrtimer_run_queues+0xfb/0x270
> [  217.264974]  hrtimer_interrupt+0x122/0x270
> [  217.264974]  smp_apic_timer_interrupt+0x6a/0x140
> [  217.264975]  apic_timer_interrupt+0xf/0x20
> [  217.264975]  </IRQ>
> [  217.264975] RIP: 0033:0x7f6240125fe5
> [  217.264976] Code: 44 17 d0 f3 44 0f 7f 47 30 f3 44 0f 7f 44 17 c0 48 01 fa 48 83 e2 c0 48 39 d1 74 a3 66 0f 1f 84 00 00 00 00 00 66 44 0f 7f 01 <66> 44 0f 7f 41 10 66 44 0f 7f 41 20 66 44 0f 7f 41 30 48 83 c1 40
> ...
>
> There's more but this is the juicy part. 
>
> The reproducer involves a large number of cgroups in a hierarchy and a very low cfs_period_us 
> setting. 
>
> The guts of sched_cfs_period_timer is this forever loop:
>
> 	raw_spin_lock(&cfs_b->lock);
> 	for (;;) {
> 		overrun = hrtimer_forward_now(timer, cfs_b->period);
> 		if (!overrun)
> 			break;
>
> 		idle = do_sched_cfs_period_timer(cfs_b, overrun);
> 	}
> 	if (idle)
> 		cfs_b->period_active = 0;
> 	raw_spin_unlock(&cfs_b->lock);
>
>
> There's no guarantee that hrtimer_forward_now() will ever return 0 and also 
> do_sched_cfs_period_timer() will drop and re-acquire the cfs_b->lock to call 
> distribute_cfs_runtime. 
>
> I considered code to tune the period and quota up (proportionally so they have the same 
> relative effect) but I did not like that because of the above statement and the fact that 
> it would be changing the valid values the user configured. I have two versions that do that 
> differently but they both still call out for protection from the forever loop. I think they 
> add complexity for no real gain.
>
> For my current testing I'm using a more direct but less elegant approach of simply limiting 
> the number of times the loop can execute. This has the potential to skip handling a period 
> I think but will prevent the problem reliably. I'm not sure how many iterations this loop 
> was expected to take. I'm seeing numbers in the low thousands at times.

I mean the answer should be "do_sched_cfs_period_timer runs once" the
vast majority of the time; if it's not then your machine/setup can't
handle whatever super low period you've set, or there's some bad
behavior somewhere in the period timer handling.
CFS_PERIOD_TIMER_EXIT_COUNT could reasonably be like 2 or 3 - this would
mean that you've already spent an entire period inside the handler.

>
> A more complete fix to make sure do_sched_cfs_period_timer never takes longer than period 
> would be good but I'm not sure what that would be and we still have this potential forever
> loop. 
>
> Below is the bandaid version. 
>   
> Thoughts? 
>
>
> Cheers,
> Phil
>
> ---
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 310d0637fe4b..33e55620f891 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4859,12 +4859,16 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>         return HRTIMER_NORESTART;
>  }
>  
> +/* This is pretty arbitrary just to escape the "forever" loop before the watchdog
> + * kills us as there is no guarantee hrtimer_forward_now ever returns 0. */
> +#define CFS_PERIOD_TIMER_EXIT_COUNT 100
>  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  {
>         struct cfs_bandwidth *cfs_b =
>                 container_of(timer, struct cfs_bandwidth, period_timer);
>         int overrun;
>         int idle = 0;
> +       int count = 0;
>  
>         raw_spin_lock(&cfs_b->lock);
>         for (;;) {
> @@ -4872,6 +4876,14 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>                 if (!overrun)
>                         break;
>  
> +               if (++count > CFS_PERIOD_TIMER_EXIT_COUNT) {
> +                       pr_warn_ratelimited("cfs_period_timer(%d): too many overruns. Consider raising cfs_period_us (%lld)\n",
> +                               smp_processor_id(), cfs_b->period/NSEC_PER_USEC);
> +                       // Make sure we restart the timer.
> +                       idle = 0;
> +                       break;
> +               }
> +
>                 idle = do_sched_cfs_period_timer(cfs_b, overrun);
>         }
>         if (idle)
