Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE52C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36362468D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbUO+xAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgACPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:10:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27861 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725890AbgACPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 10:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578064250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=n56Olc5aRhfrQ8MEcblzj9mfjUnzUxjTl6cJW4i4wG0=;
        b=LbUO+xAYWnARwoiFI2wq9Lx7zQjbhOs2x1jBkkuCFXhzVIpVK2uljspAqD9tAtPp/PdKAq
        dTARIxw+IimFYzwCvhNUwptMyWqu4Puj0r+EvZAuhrSCMEBLl7qhb1/lah6bLUzqWiFte+
        yDdr+ctMkhLnPke0cf3r9SNGv8GpvOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-mAVOfOsDPxiLIabYWidz0A-1; Fri, 03 Jan 2020 10:10:47 -0500
X-MC-Unique: mAVOfOsDPxiLIabYWidz0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85B70DB21;
        Fri,  3 Jan 2020 15:10:46 +0000 (UTC)
Received: from llong.com (ovpn-122-142.rdu2.redhat.com [10.10.122.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21168385;
        Fri,  3 Jan 2020 15:10:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] watchdog: Fix possible soft lockup warning at bootup
Date:   Fri,  3 Jan 2020 10:10:32 -0500
Message-Id: <20200103151032.19590-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that watchdog soft lockup warning was displayed on a Cavium
ThunderX2 Sabre arm64 system at bootup time:

 [   25.496379] watchdog: BUG: soft lockup - CPU#14 stuck for 22s!  [swapper/14:0]
 [   25.496381] Modules linked in:
 [   25.496386] CPU: 14 PID: 0 Comm: swapper/14 Tainted: G        W    L --------- -  - 4.18.0-rhel8.1+ #9
 [   25.496388] pstate: 60000009 (nZCv daif -PAN -UAO)
 [   25.496393] pc : arch_cpu_idle+0x34/0x140
 [   25.496395] lr : arch_cpu_idle+0x30/0x140
 [   25.496397] sp : ffff000021f4ff10
 [   25.496398] x29: ffff000021f4ff10 x28: 0000000000000000
 [   25.496401] x27: 0000000000000000 x26: ffff809f483c0000
 [   25.496404] x25: 0000000000000000 x24: ffff00001145c03c
 [   25.496407] x23: ffff00001110c9f8 x22: ffff000011453708
 [   25.496410] x21: ffff00001145bffc x20: 0000000000004000
 [   25.496413] x19: ffff0000110f0018 x18: 0000000000000010
 [   25.496416] x17: 0000000000000cc8 x16: 0000000000000000
 [   25.496419] x15: ffffffffffffffff x14: ffff000011453708
 [   25.496422] x13: ffff000091cc5caf x12: ffff000011cc5cb7
 [   25.496424] x11: 6572203030642072 x10: 0000000000000d10
 [   25.496427] x9 : ffff000021f4fe80 x8 : ffff809f483c0d70
 [   25.496430] x7 : 00000000b123f581 x6 : 00000000ffff8ae1
 [   25.496433] x5 : 00000000ffffffff x4 : 0000809f6ac90000
 [   25.496436] x3 : 4000000000000000 x2 : ffff809f7bd9e9c0
 [   25.496439] x1 : ffff0000110f0018 x0 : ffff000021f4ff10
 [   25.496441] Call trace:
 [   25.496444]  arch_cpu_idle+0x34/0x140
 [   25.496447]  do_idle+0x210/0x288
 [   25.496449]  cpu_startup_entry+0x2c/0x30
 [   25.496452]  secondary_start_kernel+0x124/0x138

Further analysis of the situation revealed that the smp_init() call
itself took more than 20s for that 2-socket 56-core and 224-thread
server.

 [    0.115632] CPU1: Booted secondary processor 0x0000000100 [0x431f0af1]
   :
 [   27.177282] CPU223: Booted secondary processor 0x0000011b03 [0x431f0af1]

By adding some instrumentation code, it was found that for cpu 14,
watchdog_enable() was called early with a timestamp of 1. That activates
the watchdog time checking logic. It was also found that the monotonic
time measured during the smp_init() phase runs much slower than the
real elapsed time as shown by the below debug printf output:

  [    1.138522] run_queues, watchdog_timer_fn: now = 170000000
  [   25.519391] run_queues, watchdog_timer_fn: now = 4170000000

In this particular case, it took about 24.4s of elapsed time for the
clock to advance 4s which is the soft expiration time that is required
to trigger the calling of watchdog_timer_fn(). That clock slowdown
stopped once the smp_init() call was done and the clock time ran at
the same rate as the elapsed time afterward.

On a comparable CN9980 system from HPE, there was also a bit of clock
slowdown but not as much as the Cavium system:

  [    1.177068] run_queues, watchdog_timer_fn: now = 1010000000
  [    5.577925] run_queues, watchdog_timer_fn: now = 5010000000

Similar clock slowdown was not obseved on x86-64 systems.

The clock slowdown in arm64 systems seems to be hardware specific.

Given the fact that the clock is less reliable during the smp_init()
call and that call can take a rather long time, one simple workaround
to avoid this soft lockup problem is to move lockup_detector_init()
call after smp_init() when the clock is reliable. This does fix the
soft lockup problem for that Cavium system and does not seem to affect
the operation of the watchdog. This is much easier than trying to fix
the clock slowdown problem in smp_init() as the watchdog timer is the
only timer function that can be active at such early boot stage anyway.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 1ecfd43ed464..82e231d69265 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1204,9 +1204,9 @@ static noinline void __init kernel_init_freeable(void)
 	init_mm_internals();
 
 	do_pre_smp_initcalls();
-	lockup_detector_init();
 
 	smp_init();
+	lockup_detector_init();
 	sched_init_smp();
 
 	page_alloc_init_late();
-- 
2.18.1

