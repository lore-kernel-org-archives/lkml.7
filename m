Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C96C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 01:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E34C20672
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 01:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKRBYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 20:24:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:33200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfKRBYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 20:24:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3043EAC53;
        Mon, 18 Nov 2019 01:24:31 +0000 (UTC)
Subject: Re: [PATCH v3 3/8] ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        James Tai <james.tai@realtek.com>
References: <20191117072109.20402-1-afaerber@suse.de>
 <20191117072109.20402-4-afaerber@suse.de> <20191117104726.2b1fccb8@why>
 <61bf74ad-b4a1-f443-bf99-be354b4d942b@suse.de> <86a78ujwwd.wl-maz@kernel.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <25965de3-cc82-7fe6-6b3d-5754c329ac07@suse.de>
Date:   Mon, 18 Nov 2019 02:24:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <86a78ujwwd.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.11.19 um 17:22 schrieb Marc Zyngier:
> On Sun, 17 Nov 2019 15:40:59 +0000,
> Andreas Färber <afaerber@suse.de> wrote:
>> Am 17.11.19 um 11:47 schrieb Marc Zyngier:
>>> On Sun, 17 Nov 2019 08:21:04 +0100
>>> Andreas Färber <afaerber@suse.de> wrote:
>>>> +	timer {
>>>> +		compatible = "arm,armv7-timer";
>>>> +		interrupts = <GIC_PPI 13
>>>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>>>> +			     <GIC_PPI 14
>>>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>>>> +			     <GIC_PPI 11
>>>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>>>> +			     <GIC_PPI 10
>>>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>>>> +		clock-frequency = <27000000>;
>>>
>>> This is 2019, and yet it feels like 2011. This should be setup in the
>>> bootloader, not in DT...
>>
>> What exactly - the whole node, the GIC CPU mask, the
>> clock-frequency?
> 
> The clock frequency. Having to rely on such hacks 8 years down the
> line makes me feel like we've achieved nothing...
> </depressed>

Unfortunately I can confirm that without clock-frequency property I get:

[    0.000000] arch_timer: frequency not available
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:38
cev_delta2ns+0x148/0x170
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.4.0-rc7-next-20191115+ #213
[    0.000000] Hardware name: Realtek RTD1195
[    0.000000] [<c022f304>] (unwind_backtrace) from [<c022c0d0>]
(show_stack+0x10/0x14)
[    0.000000] [<c022c0d0>] (show_stack) from [<c09113e4>]
(dump_stack+0x84/0x98)
[    0.000000] [<c09113e4>] (dump_stack) from [<c023c928>]
(__warn+0xbc/0xd8)
[    0.000000] [<c023c928>] (__warn) from [<c023c9a8>]
(warn_slowpath_fmt+0x64/0xc4)
[    0.000000] [<c023c9a8>] (warn_slowpath_fmt) from [<c02ab910>]
(cev_delta2ns+0x148/0x170)
[    0.000000] [<c02ab910>] (cev_delta2ns) from [<c02abf60>]
(clockevents_config.part.0+0x54/0x74)
[    0.000000] [<c02abf60>] (clockevents_config.part.0) from
[<c02abfa0>] (clockevents_config_and_register+0x20/0x2c)
[    0.000000] [<c02abfa0>] (clockevents_config_and_register) from
[<c0789904>] (arch_timer_starting_cpu+0xcc/0x208)
[    0.000000] [<c0789904>] (arch_timer_starting_cpu) from [<c023d7dc>]
(cpuhp_issue_call+0x110/0x130)
[    0.000000] [<c023d7dc>] (cpuhp_issue_call) from [<c023d984>]
(__cpuhp_setup_state_cpuslocked+0x10c/0x2b4)
[    0.000000] [<c023d984>] (__cpuhp_setup_state_cpuslocked) from
[<c023e180>] (__cpuhp_setup_state+0x98/0x14c)
[    0.000000] [<c023e180>] (__cpuhp_setup_state) from [<c0e1f224>]
(arch_timer_of_init+0x2a8/0x34c)
[    0.000000] [<c0e1f224>] (arch_timer_of_init) from [<c0e1ecb4>]
(timer_probe+0x74/0xec)
[    0.000000] [<c0e1ecb4>] (timer_probe) from [<c0e00c74>]
(start_kernel+0x310/0x488)
[    0.000000] [<c0e00c74>] (start_kernel) from [<00000000>] (0x0)
[    0.000000] ---[ end trace c2db367029c1ec1a ]---
[    0.000000] arch_timer: cp15 timer(s) running at 0.00MHz (virt).
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
 5.4.0-rc7-next-20191115+ #213
[    0.000000] Hardware name: Realtek RTD1195
[    0.000000] [<c022f304>] (unwind_backtrace) from [<c022c0d0>]
(show_stack+0x10/0x14)
[    0.000000] [<c022c0d0>] (show_stack) from [<c09113e4>]
(dump_stack+0x84/0x98)
[    0.000000] [<c09113e4>] (dump_stack) from [<c090eb2c>]
(Ldiv0_64+0x8/0x18)
[    0.000000] [<c090eb2c>] (Ldiv0_64) from [<c02a43dc>]
(clocks_calc_max_nsecs+0x24/0x80)
[    0.000000] [<c02a43dc>] (clocks_calc_max_nsecs) from [<c02a4568>]
(__clocksource_update_freq_scale+0x130/0x1ec)
[    0.000000] [<c02a4568>] (__clocksource_update_freq_scale) from
[<c02a4638>] (__clocksource_register_scale+0x14/0xc0)
[    0.000000] [<c02a4638>] (__clocksource_register_scale) from
[<c0e1ef30>] (arch_timer_common_init+0x198/0x1e4)
[    0.000000] [<c0e1ef30>] (arch_timer_common_init) from [<c0e1ecb4>]
(timer_probe+0x74/0xec)
[    0.000000] [<c0e1ecb4>] (timer_probe) from [<c0e00c74>]
(start_kernel+0x310/0x488)
[    0.000000] [<c0e00c74>] (start_kernel) from [<00000000>] (0x0)
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x0, max_idle_ns: 0 ns
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
 5.4.0-rc7-next-20191115+ #213
[    0.000000] Hardware name: Realtek RTD1195
[    0.000000] [<c022f304>] (unwind_backtrace) from [<c022c0d0>]
(show_stack+0x10/0x14)
[    0.000000] [<c022c0d0>] (show_stack) from [<c09113e4>]
(dump_stack+0x84/0x98)
[    0.000000] [<c09113e4>] (dump_stack) from [<c090eb2c>]
(Ldiv0_64+0x8/0x18)
[    0.000000] [<c090eb2c>] (Ldiv0_64) from [<c02a418c>]
(clocks_calc_mult_shift+0xec/0x10c)
[    0.000000] [<c02a418c>] (clocks_calc_mult_shift) from [<c0e0bb74>]
(sched_clock_register+0x80/0x278)
[    0.000000] [<c0e0bb74>] (sched_clock_register) from [<c0e1ef68>]
(arch_timer_common_init+0x1d0/0x1e4)
[    0.000000] [<c0e1ef68>] (arch_timer_common_init) from [<c0e1ecb4>]
(timer_probe+0x74/0xec)
[    0.000000] [<c0e1ecb4>] (timer_probe) from [<c0e00c74>]
(start_kernel+0x310/0x488)
[    0.000000] [<c0e00c74>] (start_kernel) from [<00000000>] (0x0)
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
 5.4.0-rc7-next-20191115+ #213
[    0.000000] Hardware name: Realtek RTD1195
[    0.000000] [<c022f304>] (unwind_backtrace) from [<c022c0d0>]
(show_stack+0x10/0x14)
[    0.000000] [<c022c0d0>] (show_stack) from [<c09113e4>]
(dump_stack+0x84/0x98)
[    0.000000] [<c09113e4>] (dump_stack) from [<c090eb2c>]
(Ldiv0_64+0x8/0x18)
[    0.000000] [<c090eb2c>] (Ldiv0_64) from [<c02a43dc>]
(clocks_calc_max_nsecs+0x24/0x80)
[    0.000000] [<c02a43dc>] (clocks_calc_max_nsecs) from [<c0e0bbb0>]
(sched_clock_register+0xbc/0x278)
[    0.000000] [<c0e0bbb0>] (sched_clock_register) from [<c0e1ef68>]
(arch_timer_common_init+0x1d0/0x1e4)
[    0.000000] [<c0e1ef68>] (arch_timer_common_init) from [<c0e1ecb4>]
(timer_probe+0x74/0xec)
[    0.000000] [<c0e1ecb4>] (timer_probe) from [<c0e00c74>]
(start_kernel+0x310/0x488)
[    0.000000] [<c0e00c74>] (start_kernel) from [<00000000>] (0x0)
[    0.000000] sched_clock: 56 bits at 0 Hz, resolution 0ns, wraps every 0ns
[    0.000000] Failed to initialize '/timer': -6
[    0.000000] timer_probe: no matching timers found

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
