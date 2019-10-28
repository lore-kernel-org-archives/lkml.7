Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C57CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E929421783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPVI1VrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfJ1Cq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:46:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29659 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbfJ1Cq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572230786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1A4WvM/+efPnW0gf1girT+O5yDgadCemq6g6mmqhFw=;
        b=FPVI1VrSsH69TANPmW5uuT/Dy2NBWk8EaG1s0MTNuB8YFmvOH4GWwqpafqIZpCJzK1Nxi0
        xzoKOwPKo8T9UIJVudsqreycXPXI8UIYOkgMDjDA3QaCEB9Y6Efd+mexqIJO+Sy3HbxqkK
        f+Dt6aitebh3/h2gwKGfA90osBSLvR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-FNtD5yZ4OsyXJ6EQy234nw-1; Sun, 27 Oct 2019 22:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05F65107AD28;
        Mon, 28 Oct 2019 02:46:20 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ACEA60A9F;
        Mon, 28 Oct 2019 02:46:09 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
Subject: [PATCH 1/2 v6] x86/kdump: always reserve the low 1MiB when the crashkernel option is specified
Date:   Mon, 28 Oct 2019 10:45:50 +0800
Message-Id: <20191028024551.4278-2-lijiang@redhat.com>
In-Reply-To: <20191028024551.4278-1-lijiang@redhat.com>
References: <20191028024551.4278-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: FNtD5yZ4OsyXJ6EQy234nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kdump kernel will reuse the first 640k region because the real mode
trampoline has to work in this area. When the vmcore is dumped, the
old memory in this area may be accessed, therefore, kernel has to
copy the contents of the first 640k area to a backup region so that
kdump kernel can read the old memory from the backup area of the
first 640k area, which is done in the purgatory().

But, the current handling of copying the first 640k area runs into
problems when SME is enabled, kernel does not properly copy these
old memory to the backup area in the purgatory(), thereby, kdump
kernel reads out the encrypted contents, because the kdump kernel
must access the first kernel's memory with the encryption bit set
when SME is enabled in the first kernel. Please refer to this link:

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204793

Finally, it causes the following errors, and the crash tool gets
invalid pointers when parsing the vmcore.

crash> kmem -s|grep -i invalid
kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099=
f0c5a4
kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099=
f0c5a4
crash>

To avoid the above errors, when the crashkernel option is specified,
lets reserve the remaining low 1MiB memory(after reserving real mode
memory) so that the allocated memory does not fall into the low 1MiB
area, which makes us not to copy the first 640k content to a backup
region in purgatory(). This indicates that it does not need to be
included in crash dumps or used for anything except the processor
trampolines that must live in the low 1MiB.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
BTW:I also tried to fix the above problem in purgatory(), but there
are too many restricts in purgatory() context, for example: i can't
allocate new memory to create the identity mapping page table for
SME situation.

Currently, there are two places where the first 640k area is needed,
the first one is in the find_trampoline_placement(), another one is
in the reserve_real_mode(), and their content doesn't matter.

In addition, also need to clean all the code related to the backup
region later.

 arch/x86/kernel/machine_kexec_64.c | 15 +++++++++++++++
 arch/x86/realmode/init.c           |  2 ++
 include/linux/kexec.h              |  2 ++
 kernel/kexec_core.c                |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_k=
exec_64.c
index 5dcd438ad8f2..42d7c15c45f1 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
 #include <linux/efi.h>
+#include <linux/memblock.h>
=20
 #include <asm/init.h>
 #include <asm/pgtable.h>
@@ -27,6 +28,7 @@
 #include <asm/kexec-bzimage64.h>
 #include <asm/setup.h>
 #include <asm/set_memory.h>
+#include <asm/cmdline.h>
=20
 #ifdef CONFIG_ACPI
 /*
@@ -687,3 +689,16 @@ void arch_kexec_pre_free_pages(void *vaddr, unsigned i=
nt pages)
 =09 */
 =09set_memory_encrypted((unsigned long)vaddr, pages);
 }
+
+/*
+ * When the crashkernel option is specified, only use the low
+ * 1MiB for the real mode trampoline.
+ */
+void __init kexec_reserve_low_1MiB(void)
+{
+=09if (cmdline_find_option(boot_command_line, "crashkernel",
+=09=09=09=09NULL, 0) > 0) {
+=09=09memblock_reserve(0, 1<<20);
+=09=09pr_info("Reserving the low 1MiB of memory for crashkernel\n");
+=09}
+}
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 7dce39c8c034..064cc79a015d 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/mem_encrypt.h>
+#include <linux/kexec.h>
=20
 #include <asm/set_memory.h>
 #include <asm/pgtable.h>
@@ -34,6 +35,7 @@ void __init reserve_real_mode(void)
=20
 =09memblock_reserve(mem, size);
 =09set_real_mode_mem(mem);
+=09kexec_reserve_low_1MiB();
 }
=20
 static void __init setup_real_mode(void)
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 1776eb2e43a4..988bf2de51a7 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -306,6 +306,7 @@ extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 int kexec_crash_loaded(void);
+void __init kexec_reserve_low_1MiB(void);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
=20
@@ -397,6 +398,7 @@ static inline void __crash_kexec(struct pt_regs *regs) =
{ }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline void __init kexec_reserve_low_1MiB(void) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
=20
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 15d70a90b50d..8856047bcdc8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1213,3 +1213,6 @@ void __weak arch_kexec_protect_crashkres(void)
=20
 void __weak arch_kexec_unprotect_crashkres(void)
 {}
+
+void __init __weak kexec_reserve_low_1MiB(void)
+{}
--=20
2.17.1

