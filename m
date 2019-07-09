Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA149C73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32E7216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="emMR6dBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfGIMQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:16:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41690 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIMQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:16:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so9357674pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62HM2vq6tYD24jSG4prB86KqqNJmUygRjGMJaSfwLY4=;
        b=emMR6dBlBkE4Jv1qP9rgX/blh+CxtnFKjdxACA6vogdi+c0r1UmojQ0W4JDgQuO5o/
         SinF/XmZjpblp9NGZohGA+OYJzrb1ohgudKzxgdmHkuoOe46I2jfSCQpb/N3VYslWhfA
         AhurRSIBcGbEU2HdSo4tZwd+nWf628gX01L5+s4wCCXFRByRzsBTWKi4irdzhMFsA6FU
         qbvyg0xhBNjL99sReY/mKCrOtVEyFFlJV5QzwLmY27Wpyal1deG3GS10Z+eEfrUNtaTA
         LCdwbjB/A/MFz0iudfYDxGgmPgYYfUgxtXLZPZE/dLku75rOpe579nhkp4KEz3GmOVZo
         pasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62HM2vq6tYD24jSG4prB86KqqNJmUygRjGMJaSfwLY4=;
        b=nTrJ426DgMzvdbbpdnxIf5rkOKP3DyZegd5bbfeVoTh8TL8Gok8/JPipnCMxNGpwqp
         USigCi+ZhJIkFFzsR7KldHLMkKhmlzhBTOoSjVjza9ke8hBPttqSEjVfcQzeIAIZmizv
         7fTvIUywXursWXrvqxqFkrMfxepJ4h2hk1VN+cMeA+P0lx4TVZqJ632vJjIQLKXoS5kQ
         NnQAT7tztAuhTeswrfHb5zdTG7QrDctdlyoOxeLZqsYH1T2oEUbsXs2A+mi8XpSqoYaa
         r8uUfp7x6EGS4cuV3gXa34SIN8eli4DPMgYNKIT6XFOd2iO1sUXD7/xU8jTor1TdRN4q
         kTdw==
X-Gm-Message-State: APjAAAVZxs1LYr2SWUj9qVMd2NjA/Jx5xxpNVY/0s3qQk6Tvp3WDBPLt
        1MFEieEjQa1ZuDnx5xXt3423kQ==
X-Google-Smtp-Source: APXvYqyFc6JsuXYQGzcr2Z8+Og5MviTLjlV/G1/wixU9eskEO7AczpYsY6pnwPNTZJ3kXPRYVd0x7A==
X-Received: by 2002:a63:f4e:: with SMTP id 14mr30451043pgp.58.1562674568932;
        Tue, 09 Jul 2019 05:16:08 -0700 (PDT)
Received: from santosiv.in.ibm.com ([223.186.121.175])
        by smtp.gmail.com with ESMTPSA id o15sm21243933pgj.18.2019.07.09.05.16.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 05:16:08 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
Subject: [v5 5/6] powerpc/mce: Handle UE event for memcpy_mcsafe
Date:   Tue,  9 Jul 2019 17:45:23 +0530
Message-Id: <20190709121524.18762-6-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709121524.18762-1-santosh@fossix.org>
References: <20190709121524.18762-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we take a UE on one of the instructions with a fixup entry, set nip
to continue execution at the fixup entry. Stop processing the event
further or print it.

Based-on-patch-by: Reza Arbab <arbab@linux.ibm.com>
Cc: Reza Arbab <arbab@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/include/asm/mce.h  |  4 +++-
 arch/powerpc/kernel/mce.c       | 12 +++++++++++-
 arch/powerpc/kernel/mce_power.c | 15 +++++++++++++--
 3 files changed, 27 insertions(+), 4 deletions(-)

Nick, I didn't add has_fixup_handler in mce_event structure; if we do so we wil
have to access the mce_event from ue_handler code also. That is because Mahesh
did not want mce_event to be accessed outside of save_mce_event, get_mce_event
and remove_mce_event; that is why I added ignore_event in mce_err also.

I have added the comment you mentioned in your reply.

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 94888a7025b3..f74257eb013b 100644
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
index e78c4f18ea0a..092e6bbc603f 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -144,7 +144,9 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		if (phys_addr != ULONG_MAX) {
 			mce->u.ue_error.physical_address_provided = true;
 			mce->u.ue_error.physical_address = phys_addr;
-			machine_check_ue_event(mce);
+			mce->u.ue_error.ignore_event = mce_err->ignore_event;
+			if (!mce->u.ue_error.ignore_event)
+				machine_check_ue_event(mce);
 		}
 	}
 	return;
@@ -230,6 +232,14 @@ void machine_check_queue_event(void)
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
 		return;
 
+	/*
+	 * Don't report this machine check because the caller has a asked us
+	 * to ignore the event, it has a fixup handler which will do the
+	 * appropriate error handling and reporting.
+	 */
+	if (evt.error_type == MCE_ERROR_TYPE_UE && evt.u.ue_error.ignore_event)
+		return;
+
 	index = __this_cpu_inc_return(mce_queue_count) - 1;
 	/* If queue is full, just return for now. */
 	if (index >= MAX_MC_EVT) {
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 04666c0b40a8..582a22b1acfb 100644
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
  * Convert an address related to an mm to a PFN. NOTE: we are in real
@@ -565,9 +567,18 @@ static int mce_handle_derror(struct pt_regs *regs,
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
@@ -600,7 +611,7 @@ static long mce_handle_error(struct pt_regs *regs,
 				&phys_addr);
 
 	if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
-		handled = mce_handle_ue_error(regs);
+		handled = mce_handle_ue_error(regs, &mce_err);
 
 	save_mce_event(regs, handled, &mce_err, regs->nip, addr, phys_addr);
 
-- 
2.20.1

