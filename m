Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BITCOIN_SPAM_02,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3663C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B312F2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfDQElk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:41:40 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:61497 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDQEli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:41:38 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hGcNb-0004Xr-U5 from Jiada_Wang@mentor.com ; Tue, 16 Apr 2019 21:41:03 -0700
Received: from [134.86.193.85] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 16 Apr
 2019 21:40:58 -0700
Subject: Re: [PATCH v1 1/1] thermal: rcar_gen3_thermal: request IRQ after
 device initialization
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Dien Pham <dien.pham.ry@renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
References: <20190416174741.GA26470@vmlxhi-102.adit-jv.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <07a6287c-5f0c-5350-7120-6d5bf4e5b964@mentor.com>
Date:   Wed, 17 Apr 2019 13:40:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416174741.GA26470@vmlxhi-102.adit-jv.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniu

thanks for your test & comments and adding more people for review

I will add necessary backtrace information to description and
rephrase commit summary in V2 patch

Thanks,
Jiada

On 2019/04/17 2:48, Eugeniu Rosca wrote:
> Hi Jiada,
> 
> Adding below people, since they've made recent contributions to the
> driver and might be interested in your patch:
> 
> git log master --since="1 year" -- drivers/thermal/rcar_gen3_thermal.c \
>      | grep -o "\-by:.*" | sed 's/\-by: //' | sort | uniq -c | sort -rn
>        7 Eduardo Valentin <edubezval@gmail.com>
>        6 Simon Horman <horms+renesas@verge.net.au>
>        5 Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>        2 Geert Uytterhoeven <geert+renesas@glider.be>
>        1 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>        1 Marek Vasut <marek.vasut+renesas@gmail.com>
>        1 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>        1 Hien Dang <hien.dang.eb@renesas.com>
>        1 Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>        1 Dien Pham <dien.pham.ry@renesas.com>
>        1 Daniel Lezcano <daniel.lezcano@linaro.org>
>        1 Biju Das <biju.das@bp.renesas.com>
> 
> I confirm that loading and unloading the rcar3 thermal driver in a
> loop produces soft lockup using v5.1-rc5-10-g618d919cae2f on
> H3-ES2.0-Salvator-X.
> 
> Full log and .config can be found here:
> https://gist.github.com/erosca/1f76b6dd897cdc39581fca475155e363
> 
> I post an excerpt from the above [1] (why not including it in the
> description?). Also, why not rephrasing the commit summary line in such
> a way that everybody understands this patch fixes a severe issue, e.g.
> "thermal: rcar_gen3_thermal: Fix soft lockup on probe" ?
> 
> BTW, with this patch applied I left the thermal driver being
> loaded/unloaded on the target for over one hour w/o seeing the issue
> reproduced. So, while there might be slight variations in how the final
> solution looks like, I think the patch already deserves a:
> 
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> 
> [1] Soft lockup reproduced with v5.1-rc5-10-g618d919cae2f
> 
> root@rcar-gen3:~# while true; do rmmod rcar_gen3_thermal; modprobe rcar_gen3_thermal; done
> [   43.439043] rcar_gen3_thermal e6198000.thermal: TSC0: Loaded 0 trip points
> [   43.451670] rcar_gen3_thermal e6198000.thermal: TSC1: Loaded 0 trip points
> [   43.463974] rcar_gen3_thermal e6198000.thermal: TSC2: Loaded 0 trip points
> 
> [..]
> 
> [  553.966104] rcar_gen3_thermal e6198000.thermal: TSC0: Loaded 0 trip points
> [  553.978759] rcar_gen3_thermal e6198000.thermal: TSC1: Loaded 0 trip points
> [  553.991058] rcar_gen3_thermal e6198000.thermal: TSC2: Loaded 0 trip points
> [  562.235306] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting for hardware interrupt (CMD25)
> [  567.353336] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting for hardware interrupt (CMD13)
> [  572.473318] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting for hardware interrupt (CMD13)
> [  577.593328] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting for hardware interrupt (CMD12)
> [  579.189148] rcu: INFO: rcu_preempt self-detected stall on CPU
> [  579.195329] rcu:     0-....: (1 GPs behind) idle=b76/1/0x4000000000000004 softirq=263851/263851 fqs=6251 last_accelerate: e095/4240, Nonlazy posted: ...
> [  579.209711] rcu:      (t=25008 jiffies g=346801 q=468)
> [  579.214801] Task dump for CPU 0:
> [  579.218178] modprobe        R  running task        0  6337   1420 0x0000002a
> [  579.225514] Call trace:
> [  579.228103]  dump_backtrace+0x0/0x1dc
> [  579.231934]  show_stack+0x24/0x30
> [  579.235410]  sched_show_task+0x31c/0x36c
> [  579.239507]  dump_cpu_task+0xb0/0xc0
> [  579.243248]  rcu_dump_cpu_stacks+0x220/0x238
> [  579.247702]  rcu_sched_clock_irq+0x8a4/0x141c
> [  579.252249]  update_process_times+0x34/0x64
> [  579.256617]  tick_sched_handle+0x80/0x98
> [  579.260714]  tick_sched_timer+0x64/0xbc
> [  579.264722]  __hrtimer_run_queues+0x5c0/0xb84
> [  579.269266]  hrtimer_interrupt+0x1ec/0x454
> [  579.273547]  arch_timer_handler_phys+0x40/0x58
> [  579.278185]  handle_percpu_devid_irq+0x174/0x6e8
> [  579.282999]  generic_handle_irq+0x3c/0x54
> [  579.287185]  __handle_domain_irq+0x114/0x118
> [  579.291639]  gic_handle_irq+0x70/0xac
> [  579.295465]  el1_irq+0xbc/0x180
> [  579.298756]  __asan_load8+0x8c/0x9c
> [  579.302403]  rcu_is_watching+0x80/0x8c
> [  579.306322]  rebalance_domains+0x12c/0x584
> [  579.310599]  run_rebalance_domains+0x1f4/0x298
> [  579.315231]  __do_softirq+0x4c0/0xab8
> [  579.319061]  irq_exit+0x148/0x1d8
> [  579.322530]  __handle_domain_irq+0xc0/0x118
> [  579.326894]  gic_handle_irq+0x70/0xac
> [  579.330720]  el1_irq+0xbc/0x180
> [  579.334012]  lock_is_held_type+0xec/0x144
> [  579.338201]  rcu_read_lock_sched_held+0x90/0x98
> [  579.342927]  kmem_cache_alloc+0x328/0x3e0
> [  579.347114]  create_object+0x5c/0x39c
> [  579.350944]  kmemleak_alloc+0x54/0x88
> [  579.354774]  __kmalloc_track_caller+0x1c8/0x434
> [  579.359499]  devres_alloc_node+0x40/0x8c
> [  579.363597]  __devm_request_region+0x48/0xc8
> [  579.368055]  devm_ioremap_resource+0xcc/0x148
> [  579.372626]  rcar_gen3_thermal_probe+0x288/0x618 [rcar_gen3_thermal]
> [  579.379231]  platform_drv_probe+0x70/0xe4
> [  579.383420]  really_probe+0x2d8/0x3d8
> [  579.387249]  driver_probe_device+0x154/0x164
> [  579.391705]  device_driver_attach+0x98/0xa0
> [  579.396070]  __driver_attach+0xf0/0xf4
> [  579.399987]  bus_for_each_dev+0x114/0x13c
> [  579.404173]  driver_attach+0x38/0x44
> [  579.407912]  bus_add_driver+0x234/0x288
> [  579.411919]  driver_register+0x148/0x190
> [  579.416015]  __platform_driver_register+0x84/0x90
> [  579.420931]  rcar_gen3_thermal_driver_init+0x28/0x1000 [rcar_gen3_thermal]
> [  579.428074]  do_one_initcall+0x124/0x68c
> [  579.432173]  do_init_module+0xb4/0x300
> [  579.436090]  load_module+0x2c90/0x2f18
> [  579.440008]  __se_sys_finit_module+0x128/0x148
> [  579.444642]  __arm64_sys_finit_module+0x4c/0x5c
> [  579.449367]  el0_svc_common+0xd0/0x16c
> [  579.453283]  el0_svc_handler+0x94/0xa0
> [  579.457200]  el0_svc+0x8/0xc
> [  582.713314] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting for hardware interrupt (CMD12)
> [  587.833305] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting for hardware interrupt (CMD12)
> [  592.953323] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting for hardware interrupt (CMD12)
> [  598.073430] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting for hardware interrupt (CMD12)
> [  603.193306] renesas_sdhi_internal_dmac ee100000.sd: timeout waiting for hardware interrupt (CMD12)
> [  604.242120] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [modprobe:6337]
> [..]
> 
> Best regards,
> Eugeniu.
> 
