Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F212083D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfCUMkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:40:36 -0400
Received: from foss.arm.com ([217.140.101.70]:55456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbfCUMkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:40:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E170FEBD;
        Thu, 21 Mar 2019 05:40:35 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23A273F614;
        Thu, 21 Mar 2019 05:40:35 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
Subject: [WARNING] tick_handle_oneshot_broadcast() on !online CPU
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <7fe83094-6821-dd94-f91e-6beb658bc7e6@arm.com>
Date:   Thu, 21 Mar 2019 12:40:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hit this while running some hotplug stress tests on my HiKey960 with:

  babf09c3837f ("Merge tag 'tag-chrome-platform-fixes-for-v5.1-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux")

[   13.181753] WARNING: CPU: 4 PID: 29 at kernel/time/tick-broadcast.c:647 tick_handle_oneshot_broadcast+0x1b4/0x1d0
[   13.192342] Modules linked in:
[   13.195428] CPU: 4 PID: 29 Comm: migration/4 Tainted: G S                5.1.0-rc1-00015-gbabf09c3837f #23
[   13.205140] Hardware name: HiKey960 (DT)
[   13.209089] pstate: 00000085 (nzcv daIf -PAN -UAO)
[   13.213918] pc : tick_handle_oneshot_broadcast+0x1b4/0x1d0
[   13.219440] lr : tick_handle_oneshot_broadcast+0x148/0x1d0
[   13.224958] sp : ffff000010023b50
[   13.228294] x29: ffff000010023b50 x28: ffff8000ba12a000
[   13.233642] x27: ffff000012352c70 x26: ffff000011706e80
[   13.238989] x25: ffff0000114fa000 x24: 00000002fdabdc71
[   13.244335] x23: ffff000012352ce0 x22: ffff000011504080
[   13.249681] x21: ffff000012352cb0 x20: 0000000000000000
[   13.255027] x19: 7fffffffffffffff x18: 0000000000000000
[   13.260373] x17: 0000000000000000 x16: 0000000000000000
[   13.265719] x15: 000000000000043b x14: 0000000000000000
[   13.271064] x13: 0000000000000000 x12: ffff00001176e9f8
[   13.276409] x11: 00000000000000f3 x10: 0000000000000040
[   13.281755] x9 : 0000000000000000 x8 : ffff000011503808
[   13.287101] x7 : ffff000011506000 x6 : 0000000000000004
[   13.292446] x5 : 0000000000000020 x4 : 0000000000000010
[   13.297792] x3 : 0000000000000000 x2 : 0000000000000100
[   13.303138] x1 : ffff000011504080 x0 : 0000000000000000
[   13.308485] Call trace:
[   13.310951]  tick_handle_oneshot_broadcast+0x1b4/0x1d0
[   13.316130]  sp804_timer_interrupt+0x30/0x40
[   13.320432]  __handle_irq_event_percpu+0xb8/0x460
[   13.325165]  handle_irq_event_percpu+0x34/0x88
[   13.329636]  handle_irq_event+0x48/0x78
[   13.333501]  handle_fasteoi_irq+0xb4/0x188
[   13.337626]  generic_handle_irq+0x24/0x38
[   13.341661]  __handle_domain_irq+0x5c/0xb0
[   13.345789]  gic_handle_irq+0x58/0xa8
[   13.349475]  el1_irq+0xbc/0x180
[   13.352636]  __do_softirq+0xcc/0x574
[   13.356239]  irq_exit+0x13c/0x148
[   13.359577]  __handle_domain_irq+0x60/0xb0
[   13.363698]  gic_handle_irq+0x58/0xa8
[   13.367383]  el1_irq+0xbc/0x180
[   13.370549]  multi_cpu_stop+0xf8/0x170
[   13.374323]  cpu_stopper_thread+0xac/0x120
[   13.378451]  smpboot_thread_fn+0x16c/0x270
[   13.382575]  kthread+0x11c/0x120
[   13.385826]  ret_from_fork+0x10/0x18
[   13.389424] irq event stamp: 533
[   13.392676] hardirqs last  enabled at (532): [<ffff000010081c74>] __do_softirq+0xc4/0x574
[   13.400907] hardirqs last disabled at (533): [<ffff000010083c7c>] el1_irq+0x7c/0x180
[   13.408702] softirqs last  enabled at (526): [<ffff000010082024>] __do_softirq+0x474/0x574
[   13.417021] softirqs last disabled at (531): [<ffff0000100f276c>] irq_exit+0x13c/0x148
[   13.424987] ---[ end trace c9d39afcc503fe70 ]---
[   13.429773] CPU2: shutdown
[   13.437515] psci: CPU2 killed.

I stared at the code and did a bit of tracing, the sequence seems to be:

---
echo 0 > /sys/devices/system/cpu/cpu2/online

takedown_cpu()
  take_cpu_down()
     __cpu_disable() (clears CPU in cpu_online_mask & cpu_active_mask)

  [...] <warn happens here>

  tick_cleanup_dead_cpu()
    tick_shutdown_broadcast_oneshot() (removes cpu from the tick_broadcast_* masks)
---

In that case we always have

  tick_broadcast_force_mask=[CPU2]
  cpu_online_mask=[CPU4]

So tick_handle_oneshot_broadcast::tmpmask becomes [CPU2] and we hit the warn.



I was thinking of guarding the setting of tmpmask with cpu_online(cpu), but
AFAICT nothing saves us from __cpu_disable() happening *after* those checks
(and even potentially after the WARN_ON_ONCE). Do we want some extra lock
in here, or is that a benign issue?



Appended is my reproducer - it comes from a longer script that serves as a
hotplug torture test, but these few lines are enough to trigger the above.

-----8<-----

#!/bin/bash

echo 0 > /sys/devices/system/cpu/cpu1/online
sleep 0.085
echo 0 > /sys/devices/system/cpu/cpu5/online
sleep 0.08
echo 0 > /sys/devices/system/cpu/cpu2/online
sleep 0.018
echo 0 > /sys/devices/system/cpu/cpu3/online
sleep 0.05
echo 0 > /sys/devices/system/cpu/cpu0/online
sleep 0.049
echo 1 > /sys/devices/system/cpu/cpu2/online
sleep 0.064
echo 0 > /sys/devices/system/cpu/cpu6/online
sleep 0.037
echo 0 > /sys/devices/system/cpu/cpu7/online
sleep 0.033
echo 0 > /sys/devices/system/cpu/cpu2/online
sleep 0.025
echo 1 > /sys/devices/system/cpu/cpu2/online
sleep 0.018
echo 1 > /sys/devices/system/cpu/cpu7/online
sleep 0.069
echo 0 > /sys/devices/system/cpu/cpu7/online
sleep 0.036
echo 0 > /sys/devices/system/cpu/cpu4/online
sleep 0.06
echo 1 > /sys/devices/system/cpu/cpu3/online
sleep 0.067
echo 1 > /sys/devices/system/cpu/cpu4/online
sleep 0.055
echo 1 > /sys/devices/system/cpu/cpu1/online
sleep 0.052
echo 1 > /sys/devices/system/cpu/cpu6/online
sleep 0.035
echo 1 > /sys/devices/system/cpu/cpu7/online
sleep 0.053
