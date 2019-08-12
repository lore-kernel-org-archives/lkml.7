Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B91C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA8620820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="TfmBWJHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfHLJXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:23:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33422 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfHLJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:23:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so49406792pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZbEOkLqgl3yWnVGvEl30tzn4ogJP7mHVwqyT8ZzCF8=;
        b=TfmBWJHQipDETIoPgn8KAWzkiAHtLT7aia5NTCKRVFRlD8xne6stn2O7nvdX2QF1+J
         TLcP5BNhttY5id4QCYLZU5aN3f7Byf4dvLINlb2ESnAKQ50znhfxPJ/We9h8V/08HJ7i
         RlkpUIBjVEz7qOlkZNX8k3JG/wauHopv0PBByOs9Rd5F420/JwJXGpiUGYcTQG72Ddzn
         B+paiHSAsNNlmL1wxnlh2Iv8qGWnkVswwGS3C/JGn57372tZV7QmKvKG7l+AKsEqS4Sz
         a8ocQsIyg6E6qs5hLlPFGYoSj1t9btYOI4IGo2i+8oQ5GcgmM6doA6JfQ3S4wW/syabW
         a7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZbEOkLqgl3yWnVGvEl30tzn4ogJP7mHVwqyT8ZzCF8=;
        b=HGrNioOPW9SKjob5MW1TOe8diP10d2JFoCOMhyiImRO40ALVDgNw5um9gZDXm8bwf3
         MjQmqKmtBZZ/OnX2fawT6zqHHPntbR97+pFAR2q0XKTxBPXEGPC/q8sUb/hNmkbhaabn
         0hePirKHKnj6gORluox9WsYZ4Tpsw8NnS/0Jewnm06gGpRjC4+8HCgqwsI9eNna80mTK
         K9krIeTJx9dknGdKtRWt5g1/arxO4C+O7OWrZ020DIpSi+lfqMs7HfubMKZ8c63kTcdx
         Qqp78zYW87/snoxr4LaBiDMDp7J37PfGoc9yS5ILo9wsSFtS1f0bpDmzkP9RcpcU9ZgC
         +8qA==
X-Gm-Message-State: APjAAAXWPR6Q6oKrpBVC0kZPjTMnQ7exDopO5vEzaluVeedjZaFoYxAR
        R5Ux3+Z+pJndJCVx6vstDzUGJg==
X-Google-Smtp-Source: APXvYqz87tyseXx2w4NwgaprCO2D9pm2Nz4BPdHpYdBhQPEzx2Q1qmqWChCLh5nD3oCkMTNeQIADjw==
X-Received: by 2002:a17:90a:8591:: with SMTP id m17mr22942314pjn.100.1565601793757;
        Mon, 12 Aug 2019 02:23:13 -0700 (PDT)
Received: from santosiv.in.ibm.com ([129.41.84.75])
        by smtp.gmail.com with ESMTPSA id y188sm10543517pfb.115.2019.08.12.02.23.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 02:23:13 -0700 (PDT)
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
Subject: [PATCH v9 6/7] powerpc/mce: Handle UE event for memcpy_mcsafe
Date:   Mon, 12 Aug 2019 14:52:35 +0530
Message-Id: <20190812092236.16648-7-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812092236.16648-1-santosh@fossix.org>
References: <20190812092236.16648-1-santosh@fossix.org>
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
 arch/powerpc/kernel/mce.c       | 16 ++++++++++++++++
 arch/powerpc/kernel/mce_power.c | 15 +++++++++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

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
index a3b122a685a5..ec4b3e1087be 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -149,6 +149,7 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		if (phys_addr != ULONG_MAX) {
 			mce->u.ue_error.physical_address_provided = true;
 			mce->u.ue_error.physical_address = phys_addr;
+			mce->u.ue_error.ignore_event = mce_err->ignore_event;
 			machine_check_ue_event(mce);
 		}
 	}
@@ -266,8 +267,17 @@ static void machine_process_ue_event(struct work_struct *work)
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
 
@@ -301,6 +311,12 @@ static void machine_check_process_queued_event(struct irq_work *work)
 	while (__this_cpu_read(mce_queue_count) > 0) {
 		index = __this_cpu_read(mce_queue_count) - 1;
 		evt = this_cpu_ptr(&mce_event_queue[index]);
+
+		if (evt->error_type == MCE_ERROR_TYPE_UE &&
+		    evt->u.ue_error.ignore_event) {
+			__this_cpu_dec(mce_queue_count);
+			continue;
+		}
 		machine_check_print_event_info(evt, false, false);
 		__this_cpu_dec(mce_queue_count);
 	}
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index e74816f045f8..1dd87f6f5186 100644
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
@@ -559,9 +561,18 @@ static int mce_handle_derror(struct pt_regs *regs,
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
@@ -594,7 +605,7 @@ static long mce_handle_error(struct pt_regs *regs,
 				&phys_addr);
 
 	if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
-		handled = mce_handle_ue_error(regs);
+		handled = mce_handle_ue_error(regs, &mce_err);
 
 	save_mce_event(regs, handled, &mce_err, regs->nip, addr, phys_addr);
 
-- 
2.21.0

