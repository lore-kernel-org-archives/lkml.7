Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB89C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EE4218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407222AbfITDxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 23:53:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403998AbfITDxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 23:53:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BA453082149;
        Fri, 20 Sep 2019 03:53:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18A7D60606;
        Fri, 20 Sep 2019 03:53:29 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com
Subject: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer when SME was active
Date:   Fri, 20 Sep 2019 11:53:26 +0800
Message-Id: <20190920035326.27212-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 20 Sep 2019 03:53:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793

Kdump kernel will reuse the first 640k region because of some reasons,
for example: the trampline and conventional PC system BIOS region may
require to allocate memory in this area. Obviously, kdump kernel will
also overwrite the first 640k region, therefore, kernel has to copy
the contents of the first 640k area to a backup area, which is done in
purgatory(), because vmcore may need the old memory. When vmcore is
dumped, kdump kernel will read the old memory from the backup area of
the first 640k area.

Basically, the main reason should be clear, kernel does not correctly
handle the first 640k region when SME is active, which causes that
kernel does not properly copy these old memory to the backup area in
purgatory(). Therefore, kdump kernel reads out the incorrect contents
from the backup area when dumping vmcore. Finally, the phenomenon is
as follow:

[root linux]$ crash vmlinux /var/crash/127.0.0.1-2019-09-19-08\:31\:27/vmcore
WARNING: kernel relocated [240MB]: patching 97110 gdb minimal_symbol values

      KERNEL: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmlinux
    DUMPFILE: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmcore  [PARTIAL DUMP]
        CPUS: 128
        DATE: Thu Sep 19 08:31:18 2019
      UPTIME: 00:01:21
LOAD AVERAGE: 0.16, 0.07, 0.02
       TASKS: 1343
    NODENAME: amd-ethanol
     RELEASE: 5.3.0-rc7+
     VERSION: #4 SMP Thu Sep 19 08:14:00 EDT 2019
     MACHINE: x86_64  (2195 Mhz)
      MEMORY: 127.9 GB
       PANIC: "Kernel panic - not syncing: sysrq triggered crash"
         PID: 9789
     COMMAND: "bash"
        TASK: "ffff89711894ae80  [THREAD_INFO: ffff89711894ae80]"
         CPU: 83
       STATE: TASK_RUNNING (PANIC)

crash> kmem -s|grep -i invalid
kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
crash>

In order to avoid such problem, lets occupy the first 640k region when
SME is active, which will ensure that the allocated memory does not fall
into the first 640k area. So, no need to worry about whether kernel can
correctly copy the contents of the first 640K area to a backup region in
purgatory().

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b794bd..5bfb2c83bb6c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1148,6 +1148,9 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_real_mode();
 
+	if (sme_active())
+		memblock_reserve(0, 640*1024);
+
 	trim_platform_memory_ranges();
 	trim_low_memory_range();
 
-- 
2.17.1

