Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F74C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2352166E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520060;
	bh=qONlitSrMg/KdcPLAt0yizWuwMCNALHE+k/dQ5GPIws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HpWQ5K75cotDyBsln1p9Erct8njAT1gys9ab+1rgtCsaqNq7nEOr4jDn4dEFt27tR
	 glG1LY14QiBFcppzOHDu8wKdw+EtOSPI7uSZ/7LCtr8Du867snCD2aTrbLD8HkSvKo
	 vxV5BZiNNCed9WT1P0NsTm4sLaCmavBUKvwgGqeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfLPSOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:32988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731184AbfLPSOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:14:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D3820CC7;
        Mon, 16 Dec 2019 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520047;
        bh=qONlitSrMg/KdcPLAt0yizWuwMCNALHE+k/dQ5GPIws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0dBeumuSG4/x3smzfq0z1dm9bJvUsstJtv/dbyo/k3tdy/KxZHgR9QBLXrgvbGvhp
         J+aFB1ePdGQZ8zHVj0uxQZjY+DhWfgXuVhZuT2spkjRpinMjqnrfUbAXW3mqGJdFIM
         76N+A2BiF9eNVxF7qt7LL3eV1ZzCzv5M565ZB2fM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.3 176/180] s390/kaslr: store KASLR offset for early dumps
Date:   Mon, 16 Dec 2019 18:50:16 +0100
Message-Id: <20191216174848.194661636@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

commit a9f2f6865d784477e1c7b59269d3a384abafd9ca upstream.

The KASLR offset is added to vmcoreinfo in arch_crash_save_vmcoreinfo(),
so that it can be found by crash when processing kernel dumps.

However, arch_crash_save_vmcoreinfo() is called during a subsys_initcall,
so if the kernel crashes before that, we have no vmcoreinfo and no KASLR
offset.

Fix this by storing the KASLR offset in the lowcore, where the vmcore_info
pointer will be stored, and where it can be found by crash. In order to
make it distinguishable from a real vmcore_info pointer, mark it as uneven
(KASLR offset itself is aligned to THREAD_SIZE).

When arch_crash_save_vmcoreinfo() stores the real vmcore_info pointer in
the lowcore, it overwrites the KASLR offset. At that point, the KASLR
offset is not yet added to vmcoreinfo, so we also need to move the
mem_assign_absolute() behind the vmcoreinfo_append_str().

Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/boot/startup.c         |    5 +++++
 arch/s390/kernel/machine_kexec.c |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -164,6 +164,11 @@ void startup_kernel(void)
 		handle_relocs(__kaslr_offset);
 
 	if (__kaslr_offset) {
+		/*
+		 * Save KASLR offset for early dumps, before vmcore_info is set.
+		 * Mark as uneven to distinguish from real vmcore_info pointer.
+		 */
+		S390_lowcore.vmcore_info = __kaslr_offset | 0x1UL;
 		/* Clear non-relocated kernel */
 		if (IS_ENABLED(CONFIG_KERNEL_UNCOMPRESSED))
 			memset(img, 0, vmlinux.image_size);
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -254,10 +254,10 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_SYMBOL(lowcore_ptr);
 	VMCOREINFO_SYMBOL(high_memory);
 	VMCOREINFO_LENGTH(lowcore_ptr, NR_CPUS);
-	mem_assign_absolute(S390_lowcore.vmcore_info, paddr_vmcoreinfo_note());
 	vmcoreinfo_append_str("SDMA=%lx\n", __sdma);
 	vmcoreinfo_append_str("EDMA=%lx\n", __edma);
 	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
+	mem_assign_absolute(S390_lowcore.vmcore_info, paddr_vmcoreinfo_note());
 }
 
 void machine_shutdown(void)


