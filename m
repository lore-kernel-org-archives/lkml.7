Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C6C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEA020862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HoaR3fob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEOAa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:30:27 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:38638 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbfEOAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:23 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 91053C125D;
        Wed, 15 May 2019 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557880228; bh=93f71ZD3+EurATqopDmH75w385G69mhgd8zJncs+9Rk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=HoaR3fobjpKsYMDby8xp+QxzN2t5qSrJf5H3K7JYvInIR+3RI/BeNz4pkj7Ob3K8T
         SnkBG0G4nkd5g/D1azqUQd2lbmpAgzm8a9QFTzZ0FaS+ZMSVhFcolC3DytYX1R72tC
         bvuEky12aDX/QFmFsR5Hk3/uLWc7x0p7J+D5qDqAUGhlqh/6dizBRckWkPf5zf3JIe
         2lQvfFAJElDXxEW6GmWF+tCvKhjPtpWX0asQU+O1eygfrJpIX3XIu2GjRzdOzQRuty
         8WCsTCOfRR0Ht30/h4SDceHamgm7NXVPQtjfNo93BCyxA/qXv4/L2aEllk30LSFeB1
         eyZV1FoRi6Cfg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6F9E7A023D;
        Wed, 15 May 2019 00:30:23 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 May 2019 17:30:15 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:11 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.13.182.230) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:23 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <paltsev@snyopsys.com>, <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 6/9] ARC: mm: do_page_fault refactor #5: scoot no_context to end
Date:   Tue, 14 May 2019 17:29:33 -0700
Message-ID: <1557880176-24964-7-git-send-email-vgupta@synopsys.com>
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

This is different than the rest of signal handling stuff

No functional change

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/fault.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 7f211b493170..c0a60aeb4abd 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -201,20 +201,6 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		return;
 	}
 
-no_context:
-	/* Are we prepared to handle this kernel fault?
-	 *
-	 * (The kernel has valid exception-points in the source
-	 *  when it accesses user-memory. When it fails in one
-	 *  of those points, we find it in a table and do a jump
-	 *  to some fixup code that loads an appropriate error
-	 *  code)
-	 */
-	if (fixup_exception(regs))
-		return;
-
-	die("Oops", regs, address);
-
 out_of_memory:
 	up_read(&mm->mmap_sem);
 
@@ -233,4 +219,11 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 
 	tsk->thread.fault_address = address;
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
+	return;
+
+no_context:
+	if (fixup_exception(regs))
+		return;
+
+	die("Oops", regs, address);
 }
-- 
2.7.4

