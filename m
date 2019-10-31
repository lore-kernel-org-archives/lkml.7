Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC1ACA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 03:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA84420873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 03:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKaH+cLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfJaDf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 23:35:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55819 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725909AbfJaDf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 23:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572492956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJC5t06JahhCtNsi5Js82YI4UuV2sEyzBjJGLOof/bQ=;
        b=UKaH+cLkJw9yH4xrlO/Xg8lbv10iZpeUfVlCbJBOuWaw9iQtH44ztiIip4/xMGbeRTf8XD
        VVxoa1F7BfarpdQH2x1rG1DviRGUty4C+Q96BS8QAhzj+rLZKdcuMZF7xI7QZ/uHUSLDtQ
        s1lkkeUDAzOa05c6etYwwUzDa8Q/+ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-Pnaqk5M_Mi631K-3295cvQ-1; Wed, 30 Oct 2019 23:35:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4E3C8017E0;
        Thu, 31 Oct 2019 03:35:51 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB2AE5C1BB;
        Thu, 31 Oct 2019 03:35:40 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
Subject: [PATCH 1/2 RESEND v8] x86/kdump: always reserve the low 1M when the crashkernel option is specified
Date:   Thu, 31 Oct 2019 11:35:16 +0800
Message-Id: <20191031033517.11282-2-lijiang@redhat.com>
In-Reply-To: <20191031033517.11282-1-lijiang@redhat.com>
References: <20191031033517.11282-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Pnaqk5M_Mi631K-3295cvQ-1
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
lets reserve the remaining low 1M memory(after reserving real mode
memory) so that the allocated memory does not fall into the low 1M
area, which makes us not to copy the first 640k content to a backup
region in purgatory(). This indicates that it does not need to be
included in crash dumps or used for anything except the processor
trampolines that must live in the low 1M.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 arch/x86/include/asm/crash.h |  8 ++++++++
 arch/x86/kernel/crash.c      | 15 +++++++++++++++
 arch/x86/realmode/init.c     |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 0acf5ee45a21..88eadd08ad70 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -2,10 +2,18 @@
 #ifndef _ASM_X86_CRASH_H
 #define _ASM_X86_CRASH_H
=20
+struct kimage;
+
 int crash_load_segments(struct kimage *image);
 int crash_copy_backup_region(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
 =09=09struct boot_params *params);
 void crash_smp_send_stop(void);
=20
+#ifdef CONFIG_KEXEC_CORE
+void __init crash_reserve_low_1M(void);
+#else
+static inline void __init crash_reserve_low_1M(void) { }
+#endif
+
 #endif /* _ASM_X86_CRASH_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index eb651fbde92a..db2301afade5 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/memblock.h>
=20
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -39,6 +40,7 @@
 #include <asm/virtext.h>
 #include <asm/intel_pt.h>
 #include <asm/crash.h>
+#include <asm/cmdline.h>
=20
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
@@ -68,6 +70,19 @@ static inline void cpu_crash_vmclear_loaded_vmcss(void)
 =09rcu_read_unlock();
 }
=20
+/*
+ * When the crashkernel option is specified, only use the low
+ * 1M for the real mode trampoline.
+ */
+void __init crash_reserve_low_1M(void)
+{
+=09if (cmdline_find_option(boot_command_line, "crashkernel",
+=09=09=09=09NULL, 0) > 0) {
+=09=09memblock_reserve(0, 1<<20);
+=09=09pr_info("Reserving the low 1M of memory for crashkernel\n");
+=09}
+}
+
 #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
=20
 static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 7dce39c8c034..262f83cad355 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -8,6 +8,7 @@
 #include <asm/pgtable.h>
 #include <asm/realmode.h>
 #include <asm/tlbflush.h>
+#include <asm/crash.h>
=20
 struct real_mode_header *real_mode_header;
 u32 *trampoline_cr4_features;
@@ -34,6 +35,7 @@ void __init reserve_real_mode(void)
=20
 =09memblock_reserve(mem, size);
 =09set_real_mode_mem(mem);
+=09crash_reserve_low_1M();
 }
=20
 static void __init setup_real_mode(void)
--=20
2.17.1

