Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3038EC32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED942084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="PyXYUjjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfHOAkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:40:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46891 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfHOAkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:40:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so453137pgt.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8D/mgYwB1cSDaJo6hqPv0wHPE/wolrDPlQIzqU0/Zw=;
        b=PyXYUjjfu/j92jamVXgn2nFS8ShzzsHWO8oRMP7HqCWBjvlMHRS5IyzRgLSWFXkLJm
         n40XyOEpOapDpzyEkVEOaGKFGwNnqPPQC1mGFIVGD7yN1i+ewISggkI/PmfnzjbRNsAh
         CJiqoMuJ4enAW74XJfo/Tj0uN/sEDM4VasvRmNzlMNLx9TvNUd3XPZ7WjeaZw1gH3rNE
         NVcv/DFCACYagxnlVTrYxBmxZDnOT3WLj5NImmmXMibzBU8l4d9JndDz/1OKoaKbs6zb
         M1uvGDOWJsawPRLDn/dpqK/C5g/O06nwqtJt8ds9HWESx7MLscuwuVsaCwu4G/H8l37Y
         XvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8D/mgYwB1cSDaJo6hqPv0wHPE/wolrDPlQIzqU0/Zw=;
        b=l127a4rVa2GgyoPoP/63T4vRw679dLZMnMBgpLdjXD/zI+LNY+EOLh+UhmYkkZJXHF
         xIyL2z0NpMDEq2DUTDcOZPEnHoZ+/65T4WFeZg9tnSB0cZBZtq+P3ZU3nVtBSNiMhw6A
         pCbWhrnb7II2hCwmS+5gMtrn+cohVPKgiNGLBpNQgBhwqqzl7P9SlM8oY85/fEVvCPkW
         D/Nr1XymK9fAjXr3xVJLnijMpALpmiN+xDmmV7tPmxH4JoajDjTikOEJj9WfZrT1DZyr
         Y5XdvK/K2rkcTmm8WdJM1QZ2ZLMqNXD5diqXluEVYrfmDyPK2/DXJ4HxBp0hfkjXLEJf
         OmnQ==
X-Gm-Message-State: APjAAAVpWbzDnQTTLGYcEw6TzQCvnzNdquGIXdCRNtyA4CbZSgI1CE/v
        nPGOaKzIwSEa6nMY6xjsg7Wqaw==
X-Google-Smtp-Source: APXvYqxUltO7G+usJOiiLTfp+VI0nxechFoX7ANxlU8rqxgdCn43VIGKE91zBN+eFu3X5bcXfHReeQ==
X-Received: by 2002:aa7:8a0a:: with SMTP id m10mr2855361pfa.100.1565829621485;
        Wed, 14 Aug 2019 17:40:21 -0700 (PDT)
Received: from santosiv.in.ibm.com ([49.205.218.176])
        by smtp.gmail.com with ESMTPSA id g8sm815917pgk.1.2019.08.14.17.40.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 17:40:20 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v10 6/7] powerpc/mce: Handle UE event for memcpy_mcsafe
Date:   Thu, 15 Aug 2019 06:09:40 +0530
Message-Id: <20190815003941.18655-7-santosh@fossix.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815003941.18655-1-santosh@fossix.org>
References: <20190815003941.18655-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balbir Singh <bsingharora@gmail.com>

If we take a UE on one of the instructions with a fixup entry, set nip
to continue execution at the fixup entry. Stop processing the event
further or print it.

Co-developed-by: Reza Arbab <arbab@linux.ibm.com>
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
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

