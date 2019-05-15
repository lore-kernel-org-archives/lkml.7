Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE77C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6DC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dxUetF3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfEOAa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:30:59 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:38852 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbfEOAac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:32 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D57C2C0A77;
        Wed, 15 May 2019 00:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557880222; bh=5nGJv3FYZ4K8QvJw3tH/+4ah4G8NKr7npBJJdtbIcCU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dxUetF3qUJUHHlevAE6m9jwQCZvx5OOcNg2+jVz5i7cLUOBRhCAhkOzlgeHBt4WDS
         RHLDjZKA8FU3rDUPnI3vhurYt4wOt6bcBiLfDdMlSMThKlTtlpc90jQY9G3KpXeGsM
         LPnjSyUJn4h+LP1QkcLiIPRyqBVC87QFt/J4odXpi+Ufu8DhByVj9kpVzgCnCiP1RM
         QTF7fSscMqlWfHE3VOOyBqq2xtUyqSa/IRDB83We81ZdEBEg7yX+indgkT3S1+ph/W
         tOrT4Z9gSBRlLv8Zd0X6g75pP8t3JeGYZSRoFGZfwwCHBttf4YZD1u1kpmmg1CwNQ6
         usCyvNyjo7jrQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 380E6A0068;
        Wed, 15 May 2019 00:30:32 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 May 2019 17:30:26 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:23 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.13.182.230) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:34 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <paltsev@snyopsys.com>, <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 9/9] ARC: mm: do_page_fault refactor #8: release mmap_sem sooner
Date:   Tue, 14 May 2019 17:29:36 -0700
Message-ID: <1557880176-24964-10-git-send-email-vgupta@synopsys.com>
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

In case of successful page fault handling, this patch releases mmap_sem
before updating the perf stat event for major/minor faults. So even
though the contention reduction is NOT supe rhigh, it is still an
improvement.

There's an additional code size improvement as we only have 2 up_read()
calls now.

Note to myself:
--------------

1. Given the way it is done, we are forced to move @bad_area label earlier
   causing the various "goto bad_area" cases to hit perf stat code.

 - PERF_COUNT_SW_PAGE_FAULTS is NOW updated for access errors which is what
   arm/arm64 seem to be doing as well (with slightly different code)
 - PERF_COUNT_SW_PAGE_FAULTS_{MAJ,MIN} must NOT be updated for the
   error case which is guarded by now setting @fault initial value
   to VM_FAULT_ERROR which serves both cases when handle_mm_fault()
   returns error or is not called at all.

2. arm/arm64 use two homebrew fault flags VM_FAULT_BAD{MAP,MAPACCESS}
   which I was inclined to add too but seems not needed for ARC

 - given that we have everything is 1 function we cabn stil use goto
 - we setup si_code at the right place (arm* do that in the end)
 - we init fault already to error value which guards entry into perf
   stats event update

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/fault.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 20402217d9da..e93ea06c214c 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -68,7 +68,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	struct mm_struct *mm = tsk->mm;
 	int sig, si_code = SEGV_MAPERR;
 	unsigned int write = 0, exec = 0, mask;
-	vm_fault_t fault;			/* handle_mm_fault() output */
+	vm_fault_t fault = VM_FAULT_ERROR;	/* handle_mm_fault() output */
 	unsigned int flags;			/* handle_mm_fault() input */
 
 	/*
@@ -155,6 +155,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		}
 	}
 
+bad_area:
+	up_read(&mm->mmap_sem);
+
 	/*
 	 * Major/minor page fault accounting
 	 * (in case of retry we only land here once)
@@ -173,13 +176,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 		}
 
 		/* Normal return path: fault Handled Gracefully */
-		up_read(&mm->mmap_sem);
 		return;
 	}
 
-bad_area:
-	up_read(&mm->mmap_sem);
-
 	if (!user_mode(regs))
 		goto no_context;
 
-- 
2.7.4

