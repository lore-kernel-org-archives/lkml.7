Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F9C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3269F2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWqxQrtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgABPmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:42:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47125 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728561AbgABPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577979762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=jevQ9iHcSxfMefHmgrSNs3tZM3isA+KU98flLyBWKTU=;
        b=cWqxQrtb3sTKUhZFMVvi2R8UOYeUub+XD0qY71BMhCU1GUPmEnoWOkqjTZQCuew1sS6yeV
        sLMnklFUBA5gBHoz6rgULV3/KvHFMYj7YzgVcGEmh5EWuYecTfHjbMmDqyQ8AVdsXD1Pw6
        NJcRnrX8BeYKfFOVYNu/IMoCUnckpOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-Kcp3GlKyMIS4AReOdWF6Ag-1; Thu, 02 Jan 2020 10:42:39 -0500
X-MC-Unique: Kcp3GlKyMIS4AReOdWF6Ag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD640107ACC9;
        Thu,  2 Jan 2020 15:42:37 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B846808EE;
        Thu,  2 Jan 2020 15:42:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] watchdog: Fix possible soft lockup warning at bootup
Date:   Thu,  2 Jan 2020 10:41:49 -0500
Message-Id: <20200102154149.7564-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that watchdog soft lockup warning was displayed on some
arm64 server systems at bootup time:

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
watchdog_enable() was called early with a timestamp of 1. The first
watchdog timer callback for that cpu, however, happened really late at
the above 25s timestamp mark causing the watchdog logic to treat the
delay as a soft lockup.

On another arm64 system that doesn't show the soft lockup warning, the
watchdog timer callback happened earlier at the 5s timestamp mark with
the watchdog thread invoked shortly after that.

The reason why there was such a delay in the first watchdog timer
callback for that particular system wasn't fully known yet. Given
the fact that smp_init() can run for a long time on some systems,
it is probably more appropriate to enable the watchdog function after
smp_init() instead of before it.

Another way is to leave watchdog_touch_ts at 0 in watchdog_enable()
while the system is at the booting stage. Either one of those should
be able to eliminate the soft lockup warning on bootup.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 init/main.c       | 2 +-
 kernel/watchdog.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f41334ef0971..8acb97372831 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -496,7 +496,9 @@ static void watchdog_enable(unsigned int cpu)
 		      HRTIMER_MODE_REL_PINNED_HARD);
 
 	/* Initialize timestamp */
-	__touch_watchdog();
+	if (system_state != SYSTEM_BOOTING)
+		__touch_watchdog();
+
 	/* Enable the perf event */
 	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
 		watchdog_nmi_enable(cpu);
-- 
2.18.1

