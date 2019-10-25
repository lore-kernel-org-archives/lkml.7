Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90375CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1EC21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1lYxeAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437873AbfJYIxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:53:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30354 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437271AbfJYIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571993602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQrk6OLVhPcjkhSKChmWeNmbh5o1KSL0MTHhKDkF+0Y=;
        b=L1lYxeArVY48QwCbwrtDVc1sqGPJrqveb2enK2lqXapn6l8qU1qceWwBeJALm+Inp056h3
        oSoNjjr8QWoqAhGt5T3tTwaR2zlpdSPXkeC1/7Jwek5ODyzYeUD56o12xCFIQC0bw6pmlK
        mSM1BrX+yIQ+a6PK602P0z5BaXozfjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-yX8zK2g7N4eEB9MXdyiWXA-1; Fri, 25 Oct 2019 04:53:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFE1D80183D;
        Fri, 25 Oct 2019 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D73510013A1;
        Fri, 25 Oct 2019 08:53:00 +0000 (UTC)
Subject: Re: [PATCH 1/2 v5] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        Simon Horman <horms@verge.net.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "Thomas.Lendacky@amd.com" <Thomas.Lendacky@amd.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>
References: <20191023141912.29110-1-lijiang@redhat.com>
 <20191023141912.29110-2-lijiang@redhat.com>
 <20191024100719.GC11441@verge.net.au>
 <4c1c4b78-23f0-a2b9-4be7-5bab0335f10a@redhat.com>
 <6da13645-c5e9-6c95-1f2d-bede177f9863@redhat.com>
 <OSBPR01MB40062E08DFAEDA628FDC945895650@OSBPR01MB4006.jpnprd01.prod.outlook.com>
 <2020bbf9-67b2-52e8-756f-b595414b4c02@redhat.com>
 <875zkdtrw0.fsf@x220.int.ebiederm.org>
From:   lijiang <lijiang@redhat.com>
Message-ID: <021215d1-af6e-d032-6d37-fcc2cf30c613@redhat.com>
Date:   Fri, 25 Oct 2019 16:52:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <875zkdtrw0.fsf@x220.int.ebiederm.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yX8zK2g7N4eEB9MXdyiWXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B410=E6=9C=8825=E6=97=A5 11:39, Eric W. Biederman =E5=
=86=99=E9=81=93:
> lijiang <lijiang@redhat.com> writes:
>=20
>>  * Returns the length of the argument (regardless of if it was
>>  * truncated to fit in the buffer), or -1 on not found.
>>  */
>> static int
>> __cmdline_find_option(const char *cmdline, int max_cmdline_size,
>>                       const char *option, char *buffer, int bufsize)
>>
>>
>> According to the above code comment, it should be better like this:
>>
>> +       if (cmdline_find_option(boot_command_line, "crashkernel",
>> +                               NULL, 0) > 0) {
>>
>> After i test, i will post again.
>>
>=20
> This seems reasonable as we are dealing with x86 only code.
>=20
When we compile the non-x86 kernel, that could cause the the compile error
because the cmdline_find_option() won't be defined on non-x86 architecture.
So i will define a weak function in the kernel/kexec_core.c like this:
+
+void __init __weak kexec_reserve_low_1MiB(void)
+{}

and implement the kexec_reserve_low_1MiB() in the arch/x86/kernel/machine_k=
exec_64.c.

+/*
+ * When the crashkernel option is specified, only use the low
+ * 1MiB for the real mode trampoline.
+ */
+void __init kexec_reserve_low_1MiB(void)
+{
+       if (cmdline_find_option(boot_command_line, "crashkernel",
+                               NULL, 0) > 0) {
+               memblock_reserve(0, 1<<20);
+               pr_info("Reserving the low 1MiB of memory for crashkernel\n=
");
+       }
+}=20

That will solve the compile error on the non-x86 kernel, and it also works =
well on
the x86 kernel.

BTW: i pasted the code at the end, please refer to it.

> It wound be nice if someone could generalize cmdline_find_option to be
> arch independent so that crash_core.c:parse_crashkernel could use it.

Good point, that could be done in the future.

> I don't think for this patchset, but it looks like an overdue cleanup.
>=20
> We run the risk with parse_crashkernel using strstr and this using
> another algorithm of having different kernel command line parsers
> giving different results and disagreeing if "crashkernel=3D" is present
> or not on the kernel command line.
>=20
Indeed, but sometimes, the crashkernel has a complicated syntax, maybe
that could be a reason.

Thanks.
Lianbo

> Eric
>=20
>=20

---
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

