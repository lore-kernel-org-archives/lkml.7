Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C65BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1717B22293
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="b0aXc0w5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbfHGO5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:57:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45635 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387915AbfHGO5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:57:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so41229984plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYVCSXCSdVKrlJTyrQE0sJPomWsj6zAZ24kY6kld5ow=;
        b=b0aXc0w5stpFdykuQNDC5VQpPGT3qxFcUifm+BiUpXOcuzjhi78KYvYxmM7e3NiaIW
         ugPbv/PxCrpQoCB6bjehh5ZT/GJm1JmDwAmj6UnulltPLyIuFUo2Bo24TMF9t3dsxIFL
         at7vWvVw3QTErYni0u9+0Uq3RDpGd4VE2hQ4tM46QtjQTjD2FYx3sjtus1fQ2liM/QPl
         tO5zsn2vlJjmjPNRR6KSKWdWx/v7gzTNoQKYqwmJOHLekRzntyWGu3uM/Bo0mLZ4lO0M
         4u/VgDdlr34tTxF08FpW3DOeHyXVienujBoZuh3bjIicpK0GpTM0YfmspiL0vimfpHKa
         PgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYVCSXCSdVKrlJTyrQE0sJPomWsj6zAZ24kY6kld5ow=;
        b=mnQgL9e4XvIb/hSKCQGrOMpLZKaK3o0S+q9AeNI0zDIAuxHvbY1/JDhhRHAg8/sOAN
         vAIZihlIgFnqnAK3wLH5BYBtplP/xmeYsEBfu0ssCRAMaeogbSSLFUZruEWJPkNEo+V6
         NzrQwAiFpu3YTVohtP8/9wrwucaqaOr0l395BquPiXM6qTgbIk+VdIdlAxDxLL2MIqHo
         dVQxkFcjYX1RpxxXQlvfE6kMdhPtHP4VTm8K+UmxC6IQgL4MlMoJkwoC6EPL7FPpNhvb
         WGJFCSAx5sfaRhJuy6/9eVvPjNpfx7Crhyq00DyucmW1GBcWAIMJ8Z7v0ogvxUVTZdvm
         aN4A==
X-Gm-Message-State: APjAAAW95vK7EqGLlc6kKUhYwOsU53ZNZFRZkWdq5ew5SgHO3GyfY+uA
        I7XgoXVGCxkdsn9o3xZ3SUPswA==
X-Google-Smtp-Source: APXvYqyy6n15n9uyciKbyZ07hqJqM7inNEfqtIlB9emfF84MHuXKb7+0JoNpDtD2bpriyb+/ceoX/A==
X-Received: by 2002:aa7:8555:: with SMTP id y21mr9779082pfn.104.1565189855509;
        Wed, 07 Aug 2019 07:57:35 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([183.82.17.96])
        by smtp.gmail.com with ESMTPSA id l4sm93617475pff.50.2019.08.07.07.57.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 07:57:35 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 6/7] powerpc/mce: Handle UE event for memcpy_mcsafe
Date:   Wed,  7 Aug 2019 20:26:59 +0530
Message-Id: <20190807145700.25599-7-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807145700.25599-1-santosh@fossix.org>
References: <20190807145700.25599-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we take a UE on one of the instructions with a fixup entry, set nip
to continue execution at the fixup entry. Stop processing the event
further or print it.

Co-developed-by: Reza Arbab <arbab@linux.ibm.com>
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/include/asm/mce.h  |  4 +++-
 arch/powerpc/kernel/mce.c       | 18 ++++++++++++++++--
 arch/powerpc/kernel/mce_power.c | 15 +++++++++++++--
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index f3a6036b6bc0..e1931c8c2743 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -122,7 +122,8 @@ struct machine_check_event {
 			enum MCE_UeErrorType ue_error_type:8;
 			u8		effective_address_provided;
 			u8		physical_address_provided;
-			u8		reserved_1[5];
+			u8		ignore_event;
+			u8		reserved_1[4];
 			u64		effective_address;
 			u64		physical_address;
 			u8		reserved_2[8];
@@ -193,6 +194,7 @@ struct mce_error_info {
 	enum MCE_Initiator	initiator:8;
 	enum MCE_ErrorClass	error_class:8;
 	bool			sync_error;
+	bool			ignore_event;
 };
 
 #define MAX_MC_EVT	100
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 8c0b471658a7..a80f5d6ef166 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -33,7 +33,6 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
 					mce_ue_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
-static void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
 static struct irq_work mce_event_process_work = {
@@ -144,6 +143,7 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		if (phys_addr != ULONG_MAX) {
 			mce->u.ue_error.physical_address_provided = true;
 			mce->u.ue_error.physical_address = phys_addr;
+			mce->u.ue_error.ignore_event = mce_err->ignore_event;
 		}
 	}
 	return;
@@ -256,8 +256,17 @@ static void machine_process_ue_event(struct work_struct *work)
 		/*
 		 * This should probably queued elsewhere, but
 		 * oh! well
+		 *
+		 * Don't report this machine check because the caller has a
+		 * asked us to ignore the event, it has a fixup handler which
+		 * will do the appropriate error handling and reporting.
 		 */
 		if (evt->error_type == MCE_ERROR_TYPE_UE) {
+			if (evt->u.ue_error.ignore_event) {
+				__this_cpu_dec(mce_ue_count);
+				continue;
+			}
+
 			if (evt->u.ue_error.physical_address_provided) {
 				unsigned long pfn;
 
@@ -291,8 +300,13 @@ static void machine_check_process_queued_event(struct irq_work *work)
 		index = __this_cpu_read(mce_queue_count) - 1;
 		evt = this_cpu_ptr(&mce_event_queue[index]);
 
-		if (evt->error_type == MCE_ERROR_TYPE_UE)
+		if (evt->error_type == MCE_ERROR_TYPE_UE) {
 			machine_check_ue_event(evt);
+			if (evt->u.ue_error.ignore_event) {
+				__this_cpu_dec(mce_queue_count);
+				continue;
+			}
+		}
 
 		machine_check_print_event_info(evt, false, false);
 		__this_cpu_dec(mce_queue_count);
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index bed38a8e2e50..36ca45bbb273 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/extable.h>
 #include <asm/mmu.h>
 #include <asm/mce.h>
 #include <asm/machdep.h>
@@ -18,6 +19,7 @@
 #include <asm/pte-walk.h>
 #include <asm/sstep.h>
 #include <asm/exception-64s.h>
+#include <asm/extable.h>
 
 /*
  * Convert an address related to an mm to a physical address.
@@ -558,9 +560,18 @@ static int mce_handle_derror(struct pt_regs *regs,
 	return 0;
 }
 
-static long mce_handle_ue_error(struct pt_regs *regs)
+static long mce_handle_ue_error(struct pt_regs *regs,
+				struct mce_error_info *mce_err)
 {
 	long handled = 0;
+	const struct exception_table_entry *entry;
+
+	entry = search_kernel_exception_table(regs->nip);
+	if (entry) {
+		mce_err->ignore_event = true;
+		regs->nip = extable_fixup(entry);
+		return 1;
+	}
 
 	/*
 	 * On specific SCOM read via MMIO we may get a machine check
@@ -593,7 +604,7 @@ static long mce_handle_error(struct pt_regs *regs,
 				&phys_addr);
 
 	if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
-		handled = mce_handle_ue_error(regs);
+		handled = mce_handle_ue_error(regs, &mce_err);
 
 	save_mce_event(regs, handled, &mce_err, regs->nip, addr, phys_addr);
 
-- 
2.20.1

