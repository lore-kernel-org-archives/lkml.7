Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1B9218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfGCIy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:54:57 -0400
Received: from mail5.windriver.com ([192.103.53.11]:54076 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfGCIy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:54:57 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x638oNPH007150
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 3 Jul 2019 01:50:43 -0700
Received: from pek-lpggp3.wrs.com (128.224.153.76) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.439.0; Wed, 3 Jul 2019
 01:50:13 -0700
From:   Song liwei <liwei.song@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@suse.de>,
        Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        Guo Ren <ren_guo@c-sky.com>, Joseph Lo <josephl@nvidia.com>,
        Hoan Tran <Hoan@os.amperecomputing.com>,
        "Anju T Sudhakar" <anju@linux.vnet.ibm.com>,
        Rafael J <rafael.j.wysocki@intel.com>,
        liwei <liwei.song@windriver.com>
Subject: [PATCH] x86/microcode, cpuhotplug: move microcode hotplug callback after cpu teardown
Date:   Wed, 3 Jul 2019 04:48:48 -0400
Message-ID: <1562143728-78052-1-git-send-email-liwei.song@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liwei Song <liwei.song@windriver.com>

Fix the following BUG:

[  236.599792] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:255
[  236.599796] in_atomic(): 1, irqs_disabled(): 1, pid: 14, name: migration/1
[  236.599798] Preemption disabled at:
[  236.599807] [<ffffffffb3998fa1>] cpu_stopper_thread+0x71/0x100
[  236.599816] Call Trace:
[  236.599826]  dump_stack+0x4f/0x6a
[  236.599830]  ? cpu_stopper_thread+0x71/0x100
[  236.599836]  ___might_sleep.cold+0xd1/0xe2
[  236.599841]  __might_sleep+0x4b/0x80
[  236.599847]  mutex_lock+0x21/0x50
[  236.599852]  kernfs_find_and_get_ns+0x24/0x60
[  236.599857]  sysfs_remove_group+0x2a/0x80
[  236.599862]  ? mc_device_remove+0x50/0x50
[  236.599866]  mc_cpu_down_prep+0x1d/0x30
[  236.599871]  cpuhp_invoke_callback+0x98/0x670
[  236.599876]  ? cpu_disable_common+0x26a/0x280
[  236.599882]  take_cpu_down+0x70/0xb0
[  236.599886]  multi_cpu_stop+0x64/0xc0
[  236.599890]  ? cpu_stop_queue_work+0x110/0x110
[  236.599894]  cpu_stopper_thread+0x79/0x100
[  236.599899]  ? smpboot_thread_fn+0x2d/0x290
[  236.599904]  smpboot_thread_fn+0x1e7/0x290
[  236.599910]  kthread+0x112/0x150
[  236.599914]  ? sort_range+0x30/0x30
[  236.599918]  ? kthread_park+0x90/0x90
[  236.599922]  ret_from_fork+0x35/0x40
[  236.599965] smpboot: CPU 1 is now offline

After CPUHP_TEARDOWN_CPU callback was invoked, the context will become
atomic and IRQ disabled, while mc_cpu_down_prep will called
kernfs_find_and_get_ns which will try to acquire mutext lock which may
sleep.

Adjust CPUHP_AP_MICROCODE_LOADER callback function run before
CPUHP_TEARDOWN_CPU to fix this bug.

Fixes: 78f4e932f776 ("x86/microcode, cpuhotplug: Add a microcode loader CPU hotplug callback")
Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 include/linux/cpuhotplug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 5c6062206760..6724bc8a17cd 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -101,7 +101,6 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
-	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
 	CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
@@ -143,6 +142,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
+	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_ONLINE_IDLE,
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
-- 
2.7.4

