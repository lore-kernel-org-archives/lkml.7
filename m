Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CD5CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F67920830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqN/bKWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbfJ2F25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 01:28:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23287 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728312AbfJ2F25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572326934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFd2Bl9e+kdHwn6Jb/1ywBIhlMiwzG512GuG+Pa19cA=;
        b=hqN/bKWIyZCfU2/MUtH0syiBNDn4czx/xUhbCL5uNh6gjW3xluJgf4EEGNOx208eT8e+Cg
        tjqMrZounjH15nMnEuB7jRosKq6f0hAFEcOp70PucXy4CgJMzoxqqbnE5I0TZA5eIlmO73
        y7L8NZmZbb+50sPVyGGeZKwxfyiK6go=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-t1c6jkXuOPi7SXrPPUDeEA-1; Tue, 29 Oct 2019 01:28:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 578A7801E64;
        Tue, 29 Oct 2019 05:28:49 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 581635C1B2;
        Tue, 29 Oct 2019 05:28:45 +0000 (UTC)
Date:   Tue, 29 Oct 2019 13:28:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2 v7] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Message-ID: <20191029052842.GA7616@MiWiFi-R3L-srv>
References: <20191029021059.22070-1-lijiang@redhat.com>
 <20191029021059.22070-2-lijiang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191029021059.22070-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: t1c6jkXuOPi7SXrPPUDeEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/19 at 10:10am, Lianbo Jiang wrote:
> Kdump kernel will reuse the first 640k region because the real mode
> trampoline has to work in this area. When the vmcore is dumped, the
> old memory in this area may be accessed, therefore, kernel has to
> copy the contents of the first 640k area to a backup region so that
> kdump kernel can read the old memory from the backup area of the
> first 640k area, which is done in the purgatory().
>=20
> But, the current handling of copying the first 640k area runs into
> problems when SME is enabled, kernel does not properly copy these
> old memory to the backup area in the purgatory(), thereby, kdump
> kernel reads out the encrypted contents, because the kdump kernel
> must access the first kernel's memory with the encryption bit set
> when SME is enabled in the first kernel. Please refer to this link:
>=20
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204793
>=20
> Finally, it causes the following errors, and the crash tool gets
> invalid pointers when parsing the vmcore.
>=20
> crash> kmem -s|grep -i invalid
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac0=
99f0c5a4
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac0=
99f0c5a4
> crash>
>=20
> To avoid the above errors, when the crashkernel option is specified,
> lets reserve the remaining low 1MiB memory(after reserving real mode
> memory) so that the allocated memory does not fall into the low 1MiB
> area, which makes us not to copy the first 640k content to a backup
> region in purgatory(). This indicates that it does not need to be
> included in crash dumps or used for anything except the processor
> trampolines that must live in the low 1MiB.
>=20
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/include/asm/crash.h |  6 ++++++
>  arch/x86/kernel/crash.c      | 15 +++++++++++++++
>  arch/x86/realmode/init.c     |  2 ++
>  3 files changed, 23 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
> index 0acf5ee45a21..3e966a3dc823 100644
> --- a/arch/x86/include/asm/crash.h
> +++ b/arch/x86/include/asm/crash.h
> @@ -8,4 +8,10 @@ int crash_setup_memmap_entries(struct kimage *image,
>  =09=09struct boot_params *params);
>  void crash_smp_send_stop(void);
> =20
> +#ifdef CONFIG_KEXEC_CORE
> +void __init kexec_reserve_low_1MiB(void);
> +#else
> +static inline void __init kexec_reserve_low_1MiB(void) { }
> +#endif
> +
>  #endif /* _ASM_X86_CRASH_H */
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index eb651fbde92a..144f519aef29 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -24,6 +24,7 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <linux/memblock.h>
> =20
>  #include <asm/processor.h>
>  #include <asm/hardirq.h>
> @@ -39,6 +40,7 @@
>  #include <asm/virtext.h>
>  #include <asm/intel_pt.h>
>  #include <asm/crash.h>
> +#include <asm/cmdline.h>
> =20
>  /* Used while preparing memory map entries for second kernel */
>  struct crash_memmap_data {
> @@ -68,6 +70,19 @@ static inline void cpu_crash_vmclear_loaded_vmcss(void=
)
>  =09rcu_read_unlock();
>  }
> =20
> +/*
> + * When the crashkernel option is specified, only use the low
> + * 1MiB for the real mode trampoline.
> + */
> +void __init kexec_reserve_low_1MiB(void)

Thanks for the effort, Lianbo. I believe everyone is confident with this
solution and fix.

I have a tiny concern, why the function name is
kexec_reserve_low_1MiB(), but not kexec_reserve_low_1M()?
I searched in kernel code with below filter, didn't see MiB appearing in
a function name. I am not sure about it either, just ask.

git grep "_[1-9]*M " arch/ kernel/ mm include/ drivers/ net/ init fs crypto=
/ certs/ ipc lib

Thanks
Baoquan

> +{
> +=09if (cmdline_find_option(boot_command_line, "crashkernel",
> +=09=09=09=09NULL, 0) > 0) {
> +=09=09memblock_reserve(0, 1<<20);
> +=09=09pr_info("Reserving the low 1MiB of memory for crashkernel\n");
> +=09}
> +}
> +
>  #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
> =20
>  static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 7dce39c8c034..b8bbd0017ca8 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -8,6 +8,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/realmode.h>
>  #include <asm/tlbflush.h>
> +#include <asm/crash.h>
> =20
>  struct real_mode_header *real_mode_header;
>  u32 *trampoline_cr4_features;
> @@ -34,6 +35,7 @@ void __init reserve_real_mode(void)
> =20
>  =09memblock_reserve(mem, size);
>  =09set_real_mode_mem(mem);
> +=09kexec_reserve_low_1MiB();
>  }
> =20
>  static void __init setup_real_mode(void)
> --=20
> 2.17.1
>=20

