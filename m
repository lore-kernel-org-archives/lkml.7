Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9515C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCC620881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WKDI7fIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEOAaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:30:14 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:38828 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbfEOAaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:12 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4A762C0A63;
        Wed, 15 May 2019 00:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557880202; bh=RoccKNAJvfR7aO06ihmHoprPEDJVe9pUK1rEpE7cTA4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WKDI7fIfSmaOO0nu5LtbmO7YIFy0DRhPpjNaYmstTeATTprbl/orhFgQZBf4l6gU8
         3o0dJYDKaZhse+x7iumnQxyu08Dz4FTGc+fgax27Ea054X9lEtdUww/w1Kj9Ue4p1f
         jkRd30SP9qtFH+4LPcuPzlc0j1WT2Legu+9vZMkPkKU9jWIf4YFxDEG4HjpbXlLFHa
         HbzQx+4VL8efP/AEwqZEC3Z+KqEysDL0B+U7kbEXziA9JtVoIKPjh/cX9tmsTA4yzt
         3UVFJDsaS9nhYHE5xHxjQWrYyTpvu2p4/7EOzjTwCEKNwgQrYQ0SkOozNpe1JHWEt7
         zEqemSynABAeg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B68F5A023C;
        Wed, 15 May 2019 00:30:11 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 May 2019 17:30:10 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:08 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.13.182.230) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:19 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <paltsev@snyopsys.com>, <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 5/9] ARC: mm: do_page_fault refactor #4: consolidate retry related logic
Date:   Tue, 14 May 2019 17:29:32 -0700
Message-ID: <1557880176-24964-6-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
References: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.182.230]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stats update code can now elide "retry" check and additional level of
indentation since all retry handling is done ahead of it already

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/fault.c | 60 +++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index ae890a8d5ebf..7f211b493170 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -68,8 +68,8 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	struct mm_struct *mm = tsk->mm;
 	int si_code = SEGV_MAPERR;
 	unsigned int write = 0, exec = 0, mask;
-	vm_fault_t fault;
-	unsigned int flags;
+	vm_fault_t fault;			/* handle_mm_fault() output */
+	unsigned int flags;			/* handle_mm_fault() input */
 
 	/*
 	 * NOTE! We MUST NOT take any locks for this case. We may
@@ -128,49 +128,51 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		goto bad_area;
 	}
 
-	/*
-	 * If for any reason at all we couldn't handle the fault,
-	 * make sure we exit gracefully rather than endlessly redo
-	 * the fault.
-	 */
 	fault = handle_mm_fault(vma, address, flags);
 
-	if (fatal_signal_pending(current)) {
+	/*
+	 * Fault retry nuances
+	 */
+	if (unlikely(fault & VM_FAULT_RETRY)) {
 
 		/*
-		 * if fault retry, mmap_sem already relinquished by core mm
-		 * so OK to return to user mode (with signal handled first)
+		 * If fault needs to be retried, handle any pending signals
+		 * first (by returning to user mode).
+		 * mmap_sem already relinquished by core mm for RETRY case
 		 */
-		if (fault & VM_FAULT_RETRY) {
+		if (fatal_signal_pending(current)) {
 			if (!user_mode(regs))
 				goto no_context;
 			return;
 		}
+		/*
+		 * retry state machine
+		 */
+		if (flags & FAULT_FLAG_ALLOW_RETRY) {
+			flags &= ~FAULT_FLAG_ALLOW_RETRY;
+			flags |= FAULT_FLAG_TRIED;
+			goto retry;
+		}
 	}
 
+	/*
+	 * Major/minor page fault accounting
+	 * (in case of retry we only land here once)
+	 */
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 	if (likely(!(fault & VM_FAULT_ERROR))) {
-		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			/* To avoid updating stats twice for retry case */
-			if (fault & VM_FAULT_MAJOR) {
-				tsk->maj_flt++;
-				perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-					      regs, address);
-			} else {
-				tsk->min_flt++;
-				perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-					      regs, address);
-			}
-
-			if (fault & VM_FAULT_RETRY) {
-				flags &= ~FAULT_FLAG_ALLOW_RETRY;
-				flags |= FAULT_FLAG_TRIED;
-				goto retry;
-			}
+		if (fault & VM_FAULT_MAJOR) {
+			tsk->maj_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
+				      regs, address);
+		} else {
+			tsk->min_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
+				      regs, address);
 		}
 
-		/* Fault Handled Gracefully */
+		/* Normal return path: fault Handled Gracefully */
 		up_read(&mm->mmap_sem);
 		return;
 	}
-- 
2.7.4

