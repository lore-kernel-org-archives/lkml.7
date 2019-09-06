Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FFD2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SyDw8rI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392819AbfIFXSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:18:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35936 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbfIFXSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:18:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id o12so9187420qtf.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEHvhDCiSNySF2s6HQz4q9U2jEp8Cpol0sbtQ3rHoEc=;
        b=SyDw8rI4aN90GaPzgaFpy7QlVzoQ/N11Bsk92xEvYdSj0f1M8LB3p8GDLi/NHmjK5s
         FCZcnEbNfy9qlbtL64QjYXjtm3ImVvB0V1EtJZOxm31i5ZSq4rNHn6X20S3pjSP6PVmS
         5iMRGR+lgdHP8/p1kEgfQmy/yHUkcjodhpcnryBzHZM9Q62mm8DK9n/lQGAg3fy4yknf
         vz0Wa3IvDMWKB+8OKkN9wG3NiJp1/oZrQtHZHIAyu4aumFHgfBwWfXiRTwTGbjgBtG/v
         LKrpW5pN3LEZz7rfg3iezOlPvgM6EsZn4FcJPD1w2nIrLrjJjd3dbq7FW8Uxmho00HZj
         qpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEHvhDCiSNySF2s6HQz4q9U2jEp8Cpol0sbtQ3rHoEc=;
        b=a8SCjsiWe+jZneHyomZp1ssg0slni6EoaUHV22Oi5NxRAPdaqGWBiATpZor153EXdn
         xUcaXfZcwoeNe9Pse1HKeQ6E5iiuk9z8wIMWF4O6OM+DXIuzt2BycvlQioWPwM31Yo0r
         9pjNLDF2kg+DazFWcoi7pMGmSmU62AFSQXjGX/URXjB97LAJTi5etzuMS93FqlrcoDq8
         G/VAqkTRpE0xH5PTimIZMIVKYjhcU7jraE6j3Lu7KwzkktWglc3ddn8alXLn8xDKq9sQ
         PmAMWaw1u+1i5jnR24XUcDuVc3cZckPvNZmST8ub7N2uv26pG99lnAuviWVb7ijP8Dif
         axPQ==
X-Gm-Message-State: APjAAAVKoHp2RXzIV/UMUfD2D4HfJ6X3ImiXMZ4XokjKm4uxIQHDubQX
        9Jb3H7ELo47Kv5N9BBUwMqJheg==
X-Google-Smtp-Source: APXvYqzJAgVBT0XCTnjsN+YHyEu+mU7vz4KirkwxE6DaxZZIsM/TO4gy05d4hmXLUpbFd0Oy3D7VrQ==
X-Received: by 2002:ac8:4796:: with SMTP id k22mr11361795qtq.333.1567811886260;
        Fri, 06 Sep 2019 16:18:06 -0700 (PDT)
Received: from Qians-MBP.fios-router (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o26sm3147034qkm.0.2019.09.06.16.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:18:05 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     peterz@infradead.org, mingo@kernel.org, bvanassche@acm.org,
        arnd@arndb.de, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] powerpc/lockdep: fix a false positive warning
Date:   Fri,  6 Sep 2019 19:17:54 -0400
Message-Id: <20190906231754.830-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 108c14858b9e ("locking/lockdep: Add support for dynamic
keys") introduced a boot warning on powerpc below, because since the
commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
kvm_tmp[] into the .bss section and then free the rest of unused spaces
back to the page allocator.

kernel_init
  kvm_guest_init
    kvm_free_tmp
      free_reserved_area
        free_unref_page
          free_unref_page_prepare

Later, alloc_workqueue() happens to allocate some pages from there and
trigger the warning at,

if (WARN_ON_ONCE(static_obj(key)))

Fix it by adding a generic helper arch_is_bss_hole() to skip those areas
in static_obj(). Since kvm_free_tmp() is only done early during the
boot, just go lockless to make the implementation simple for now.

WARNING: CPU: 0 PID: 13 at kernel/locking/lockdep.c:1120
Workqueue: events work_for_cpu_fn
Call Trace:
  lockdep_register_key+0x68/0x200
  wq_init_lockdep+0x40/0xc0
  trunc_msg+0x385f9/0x4c30f (unreliable)
  wq_init_lockdep+0x40/0xc0
  alloc_workqueue+0x1e0/0x620
  scsi_host_alloc+0x3d8/0x490
  ata_scsi_add_hosts+0xd0/0x220 [libata]
  ata_host_register+0x178/0x400 [libata]
  ata_host_activate+0x17c/0x210 [libata]
  ahci_host_activate+0x84/0x250 [libahci]
  ahci_init_one+0xc74/0xdc0 [ahci]
  local_pci_probe+0x78/0x100
  work_for_cpu_fn+0x40/0x70
  process_one_work+0x388/0x750
  process_scheduled_works+0x50/0x90
  worker_thread+0x3d0/0x570
  kthread+0x1b8/0x1e0
  ret_from_kernel_thread+0x5c/0x7c

Fixes: 108c14858b9e ("locking/lockdep: Add support for dynamic keys")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: No need to actually define arch_is_bss_hole() powerpc64 only.

 arch/powerpc/include/asm/sections.h | 11 +++++++++++
 arch/powerpc/kernel/kvm.c           |  5 +++++
 include/asm-generic/sections.h      |  7 +++++++
 kernel/locking/lockdep.c            |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 4a1664a8658d..4f5d69c42017 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -5,8 +5,19 @@
 
 #include <linux/elf.h>
 #include <linux/uaccess.h>
+
+#define arch_is_bss_hole arch_is_bss_hole
+
 #include <asm-generic/sections.h>
 
+extern void *bss_hole_start, *bss_hole_end;
+
+static inline int arch_is_bss_hole(unsigned long addr)
+{
+	return addr >= (unsigned long)bss_hole_start &&
+	       addr < (unsigned long)bss_hole_end;
+}
+
 extern char __head_end[];
 
 #ifdef __powerpc64__
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index b7b3a5e4e224..89e0e522e125 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -66,6 +66,7 @@
 static bool kvm_patching_worked = true;
 char kvm_tmp[1024 * 1024];
 static int kvm_tmp_index;
+void *bss_hole_start, *bss_hole_end;
 
 static inline void kvm_patch_ins(u32 *inst, u32 new_inst)
 {
@@ -707,6 +708,10 @@ static __init void kvm_free_tmp(void)
 	 */
 	kmemleak_free_part(&kvm_tmp[kvm_tmp_index],
 			   ARRAY_SIZE(kvm_tmp) - kvm_tmp_index);
+
+	bss_hole_start = &kvm_tmp[kvm_tmp_index];
+	bss_hole_end = &kvm_tmp[ARRAY_SIZE(kvm_tmp)];
+
 	free_reserved_area(&kvm_tmp[kvm_tmp_index],
 			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
 }
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d1779d442aa5..4d8b1f2c5fd9 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -91,6 +91,13 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
 }
 #endif
 
+#ifndef arch_is_bss_hole
+static inline int arch_is_bss_hole(unsigned long addr)
+{
+	return 0;
+}
+#endif
+
 /**
  * memory_contains - checks if an object is contained within a memory region
  * @begin: virtual address of the beginning of the memory region
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4861cf8e274b..cd75b51f15ce 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -675,6 +675,9 @@ static int static_obj(const void *obj)
 	if (arch_is_kernel_initmem_freed(addr))
 		return 0;
 
+	if (arch_is_bss_hole(addr))
+		return 0;
+
 	/*
 	 * static variable?
 	 */
-- 
2.20.1 (Apple Git-117)

