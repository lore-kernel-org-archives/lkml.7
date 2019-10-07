Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F2ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7635206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfJGRNK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:13:10 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38255 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:13:09 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iHWZD-0003Yx-EL; Mon, 07 Oct 2019 11:13:03 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iHWZB-0006FD-OE; Mon, 07 Oct 2019 11:13:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     lijiang <lijiang@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com, vgoyal@redhat.com,
        kexec@lists.infradead.org
References: <20191007070844.15935-1-lijiang@redhat.com>
        <20191007093338.GA4710@dhcp-128-65.nay.redhat.com>
        <e179c616-f427-769f-aa5b-058c63040015@redhat.com>
Date:   Mon, 07 Oct 2019 12:12:17 -0500
In-Reply-To: <e179c616-f427-769f-aa5b-058c63040015@redhat.com> (lijiang's
        message of "Mon, 7 Oct 2019 19:53:57 +0800")
Message-ID: <87bluseaz2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iHWZB-0006FD-OE;;;mid=<87bluseaz2.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+gQMszSm+ZkbXzH79qaWxb0n7iQC2kol4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] x86/kdump: Fix 'kmem -s' reported an invalid freepointer when SME was active
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lijiang <lijiang@redhat.com> writes:

> 在 2019年10月07日 17:33, Dave Young 写道:
>> Hi Lianbo,
>> On 10/07/19 at 03:08pm, Lianbo Jiang wrote:
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793
>>>
>>> Kdump kernel will reuse the first 640k region because of some reasons,
>>> for example: the trampline and conventional PC system BIOS region may
>>> require to allocate memory in this area. Obviously, kdump kernel will
>>> also overwrite the first 640k region, therefore, kernel has to copy
>>> the contents of the first 640k area to a backup area, which is done in
>>> purgatory(), because vmcore may need the old memory. When vmcore is
>>> dumped, kdump kernel will read the old memory from the backup area of
>>> the first 640k area.
>>>
>>> Basically, the main reason should be clear, kernel does not correctly
>>> handle the first 640k region when SME is active, which causes that
>>> kernel does not properly copy these old memory to the backup area in
>>> purgatory(). Therefore, kdump kernel reads out the incorrect contents
>>> from the backup area when dumping vmcore. Finally, the phenomenon is
>>> as follow:
>>>
>>> [root linux]$ crash vmlinux /var/crash/127.0.0.1-2019-09-19-08\:31\:27/vmcore
>>> WARNING: kernel relocated [240MB]: patching 97110 gdb minimal_symbol values
>>>
>>>       KERNEL: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmlinux
>>>     DUMPFILE: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmcore  [PARTIAL DUMP]
>>>         CPUS: 128
>>>         DATE: Thu Sep 19 08:31:18 2019
>>>       UPTIME: 00:01:21
>>> LOAD AVERAGE: 0.16, 0.07, 0.02
>>>        TASKS: 1343
>>>     NODENAME: amd-ethanol
>>>      RELEASE: 5.3.0-rc7+
>>>      VERSION: #4 SMP Thu Sep 19 08:14:00 EDT 2019
>>>      MACHINE: x86_64  (2195 Mhz)
>>>       MEMORY: 127.9 GB
>>>        PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>>>          PID: 9789
>>>      COMMAND: "bash"
>>>         TASK: "ffff89711894ae80  [THREAD_INFO: ffff89711894ae80]"
>>>          CPU: 83
>>>        STATE: TASK_RUNNING (PANIC)
>>>
>>> crash> kmem -s|grep -i invalid
>>> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
>>> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
>>> crash>
>>>
>>> BTW: I also tried to fix the above problem in purgatory(), but there
>>> are too many restricts in purgatory() context, for example: i can't
>>> allocate new memory to create the identity mapping page table for SME
>>> situation.
>>>
>>> Currently, there are two places where the first 640k area is needed,
>>> the first one is in the find_trampoline_placement(), another one is
>>> in the reserve_real_mode(), and their content doesn't matter. To avoid
>>> the above error, lets occupy the remain memory of the first 640k region
>>> (expect for the trampoline and real mode) so that the allocated memory
>>> does not fall into the first 640k area when SME is active, which makes
>>> us not to worry about whether kernel can correctly copy the contents of
>>> the first 640k area to a backup region in the purgatory().
>>>
>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>> ---
>>> Changes since v1:
>>> 1. Improve patch log
>>> 2. Change the checking condition from sme_active() to sme_active()
>>>    && strstr(boot_command_line, "crashkernel=")
>>>
>>>  arch/x86/kernel/setup.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>>> index 77ea96b794bd..bdb1a02a84fd 100644
>>> --- a/arch/x86/kernel/setup.c
>>> +++ b/arch/x86/kernel/setup.c
>>> @@ -1148,6 +1148,9 @@ void __init setup_arch(char **cmdline_p)
>>>  
>>>  	reserve_real_mode();
>>>  
>>> +	if (sme_active() && strstr(boot_command_line, "crashkernel="))
>>> +		memblock_reserve(0, 640*1024);
>>> +
>> 
>> Seems you missed the comment about "unconditionally do it", only check
>> crashkernel param looks better.
>> 
> If so, it means that copying the first 640k to a backup region is no longer needed, and
> i should post a patch series to remove the copy_backup_region(). Any idea?
>
>> Also I noticed reserve_crashkernel is called after initmem_init, I'm not
>> sure if memblock_reserve is good enough in early code before
>> initmem_init. 
>>
> The first zero page and real mode are also reserved before the initmem_init(),
> and seems that they work well until now.
>
> Thanks.
> Lianbo

This has only been boot tested but I think this is about what we need.

I feel like I haven't found and deleted all of the backup region code.

I think it is important to have the reservation code in reseve_real_mode
as the logic is fundamentally intertwined.

Eric


From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 7 Oct 2019 11:57:24 -0500
Subject: [PATCH] x86/kexec: Always reserve the low 1MiB

When the crashkernel kernel command line option is specified always
reserve the low 1MiB.    That way it does not need to be included
in crash dumps or used for anything execept the processor trampolines
that must live in the low 1MiB.

The current handling of copying the low 1MiB runs into problems when
SME is active.  So just simplify everything and make it unnecessary
to do anything with the low 1MiB.

This comes at a cost of 640KiB.  But when crash kernels need 32MiB or
more to run this isn't much more, and it makes everything much more
reliable.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/include/asm/kexec.h   |  4 ----
 arch/x86/kernel/crash.c        | 19 -------------------
 arch/x86/purgatory/purgatory.c | 15 ---------------
 arch/x86/realmode/init.c       | 10 ++++++++++
 4 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5e7d6b46de97..e36307ac324d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -66,10 +66,6 @@ struct kimage;
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
 #endif
 
-/* Memory to backup during crash kdump */
-#define KEXEC_BACKUP_SRC_START	(0UL)
-#define KEXEC_BACKUP_SRC_END	(640 * 1024UL - 1)	/* 640K */
-
 /*
  * This function is responsible for capturing register states if coming
  * via panic otherwise just fix up the ss and sp if coming via kernel
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index eb651fbde92a..dc4773d2f4a6 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -409,31 +409,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	return ret;
 }
 
-static int determine_backup_region(struct resource *res, void *arg)
-{
-	struct kimage *image = arg;
-
-	image->arch.backup_src_start = res->start;
-	image->arch.backup_src_sz = resource_size(res);
-
-	/* Expecting only one range for backup region */
-	return 1;
-}
-
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
-	/*
-	 * Determine and load a segment for backup area. First 640K RAM
-	 * region is backup source
-	 */
-
-	ret = walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
-				image, determine_backup_region);
-
 	/* Zero or postive return values are ok */
 	if (ret < 0)
 		return ret;
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 3b95410ff0f8..448de04703ba 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -22,20 +22,6 @@ u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(.kexec-purgatory);
 
 struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX] __section(.kexec-purgatory);
 
-/*
- * On x86, second kernel requries first 640K of memory to boot. Copy
- * first 640K to a backup region in reserved memory range so that second
- * kernel can use first 640K.
- */
-static int copy_backup_region(void)
-{
-	if (purgatory_backup_dest) {
-		memcpy((void *)purgatory_backup_dest,
-		       (void *)purgatory_backup_src, purgatory_backup_sz);
-	}
-	return 0;
-}
-
 static int verify_sha256_digest(void)
 {
 	struct kexec_sha_region *ptr, *end;
@@ -66,7 +52,6 @@ void purgatory(void)
 		for (;;)
 			;
 	}
-	copy_backup_region();
 }
 
 /*
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 7dce39c8c034..76c680ad23a1 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -34,6 +34,16 @@ void __init reserve_real_mode(void)
 
 	memblock_reserve(mem, size);
 	set_real_mode_mem(mem);
+
+#ifdef CONFIG_KEXEC_CORE
+	/* When crashkernel is specified only use the low 1MiB for the
+	 * real mode trampolines.
+	 */
+	if (strstr(boot_command_line, "crashkernel=")) {
+		memblock_reserve(0, 1<<20);
+		pr_info("Reserving low 1MiB of memory for crashkernel\n");
+	}
+#endif /* CONFIG_KEXEC_CORE */
 }
 
 static void __init setup_real_mode(void)
-- 
2.20.1


