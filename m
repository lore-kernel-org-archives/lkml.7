Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7969CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414292063F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710762;
	bh=1P05lgw3nwfgKDCbbNsCajN1K7ZgUaDU0RtR/HuuWJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zxUfx8obujrtPhtYkbR+FHV4sQ2Y9IwVvQKhSwerR8f9U6CqhpiZv/ZjTECMvumZn
	 bNcrpA6DWe7HQ2k/VMFdpaU86sjc72oS3G9g+FE3OqQwOvYAaG+rXWtB/VEv3Qn0N8
	 OPXf/3s+jXkPGpKnTENlr8gG5J9NuNGssCdjBcO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390703AbfC0STV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390133AbfC0STT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:19:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1098420449;
        Wed, 27 Mar 2019 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710757;
        bh=1P05lgw3nwfgKDCbbNsCajN1K7ZgUaDU0RtR/HuuWJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5O9gY8xS1jd4tzXNbpcZ2s70urUkuWl5ecJeQGgeymYB/oHvSdFjia5Pm3wScHFO
         NsOU2lgfTQaUIbfzc4aQbdOjM4uH8ShPTBBieeISCf7cnLLqDS2z12IQDIVYtGi8iW
         r++JA3AUq3kIEzPudatCp7s/UCf/7YahsFRxmbY8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>, Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 089/123] efi/arm/arm64: Allow SetVirtualAddressMap() to be omitted
Date:   Wed, 27 Mar 2019 14:15:53 -0400
Message-Id: <20190327181628.15899-89-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit 4e46c2a956215482418d7b315749fb1b6c6bc224 ]

The UEFI spec revision 2.7 errata A section 8.4 has the following to
say about the virtual memory runtime services:

  "This section contains function definitions for the virtual memory
  support that may be optionally used by an operating system at runtime.
  If an operating system chooses to make EFI runtime service calls in a
  virtual addressing mode instead of the flat physical mode, then the
  operating system must use the services in this section to switch the
  EFI runtime services from flat physical addressing to virtual
  addressing."

So it is pretty clear that calling SetVirtualAddressMap() is entirely
optional, and so there is no point in doing so unless it achieves
anything useful for us.

This is not the case for 64-bit ARM. The identity mapping used by the
firmware is arbitrarily converted into another permutation of userland
addresses (i.e., bits [63:48] cleared), and the runtime code could easily
deal with the original layout in exactly the same way as it deals with
the converted layout. However, due to constraints related to page size
differences if the OS is not running with 4k pages, and related to
systems that may expose the individual sections of PE/COFF runtime
modules as different memory regions, creating the virtual layout is a
bit fiddly, and requires us to sort the memory map and reason about
adjacent regions with identical memory types etc etc.

So the obvious fix is to stop calling SetVirtualAddressMap() altogether
on arm64 systems. However, to avoid surprises, which are notoriously
hard to diagnose when it comes to OS<->firmware interactions, let's
start by making it an opt-out feature, and implement support for the
'efi=novamap' kernel command line parameter on ARM and arm64 systems.

( Note that 32-bit ARM generally does require SetVirtualAddressMap() to be
  used, given that the physical memory map and the kernel virtual address
  map are not guaranteed to be non-overlapping like on arm64. However,
  having support for efi=novamap,noruntime on 32-bit ARM, combined with
  the recently proposed support for earlycon=efifb, is likely to be useful
  to diagnose boot issues on such systems if they have no accessible serial
  port. )

Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Jones <pjones@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190202094119.13230-8-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c        |  5 +++++
 drivers/firmware/efi/libstub/efi-stub-helper.c | 10 ++++++++++
 drivers/firmware/efi/libstub/efistub.h         |  1 +
 drivers/firmware/efi/libstub/fdt.c             |  3 +++
 4 files changed, 19 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 01a9d78ee415..3b1e1dc3fb46 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -364,6 +364,11 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		paddr = in->phys_addr;
 		size = in->num_pages * EFI_PAGE_SIZE;
 
+		if (novamap()) {
+			in->virt_addr = in->phys_addr;
+			continue;
+		}
+
 		/*
 		 * Make the mapping compatible with 64k pages: this allows
 		 * a 4k page size kernel to kexec a 64k page size kernel and
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 50a9cab5a834..39f87e6dac5c 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -34,6 +34,7 @@ static unsigned long __chunk_size = EFI_READ_CHUNK_SIZE;
 
 static int __section(.data) __nokaslr;
 static int __section(.data) __quiet;
+static int __section(.data) __novamap;
 
 int __pure nokaslr(void)
 {
@@ -43,6 +44,10 @@ int __pure is_quiet(void)
 {
 	return __quiet;
 }
+int __pure novamap(void)
+{
+	return __novamap;
+}
 
 #define EFI_MMAP_NR_SLACK_SLOTS	8
 
@@ -454,6 +459,11 @@ efi_status_t efi_parse_options(char const *cmdline)
 			__chunk_size = -1UL;
 		}
 
+		if (!strncmp(str, "novamap", 7)) {
+			str += strlen("novamap");
+			__novamap = 1;
+		}
+
 		/* Group words together, delimited by "," */
 		while (*str && *str != ' ' && *str != ',')
 			str++;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index f59564b72ddc..2adde22b4a9f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -27,6 +27,7 @@
 
 extern int __pure nokaslr(void);
 extern int __pure is_quiet(void);
+extern int __pure novamap(void);
 
 #define pr_efi(sys_table, msg)		do {				\
 	if (!is_quiet()) efi_printk(sys_table, "EFI stub: "msg);	\
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 0c0d2312f4a8..dba296a44f4e 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -327,6 +327,9 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	if (status == EFI_SUCCESS) {
 		efi_set_virtual_address_map_t *svam;
 
+		if (novamap())
+			return EFI_SUCCESS;
+
 		/* Install the new virtual address map */
 		svam = sys_table->runtime->set_virtual_address_map;
 		status = svam(runtime_entry_count * desc_size, desc_size,
-- 
2.19.1

