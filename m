Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B2C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1983B222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfIZJkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:40:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfIZJj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:39:59 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A79174FCC7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:39:59 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id e15so1059628pgh.19
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jbuek0IBtNMleGLem0b6G1JP1yfyDp1ywawNI2SggWk=;
        b=mHGboalVzk/U+qjFxscRzubffwsXAKf3/3NAyfTgbC/EPhzHUhDYHRyZs9nITNyAGW
         uXjwPJEmj2Dsa/aiF9y1DOlMVJO0U0AIjbThqqN0Uq8i6z4FTZ5XzOyNA8NxVQZznQSF
         cvLHCRJYfT1lxtC/oU7SE7na6A3572n0z55AV7NiBC9CzSHT5CsC7MZuPVPMer8q8r6f
         9XYPeAzDA0MVUMoygEN420CzTSzxy8xDAMfPUMbtD1Aawl+FhK/rxD3VeQDYQ+qg1NVJ
         vqUZSXPhgOtcbCFkR6S7h2Twn5GEf+TdPFNXYLOydxaorg2wNY85GoLMYy9TECwDcV37
         R0vQ==
X-Gm-Message-State: APjAAAWm/5/fIgUuu6qnEnA7m7+JejE9harq94DWDFId37/GQadHMNyy
        ZEITgiFcXSD+0ZlDTdp9L4JPKrfOPGFJ6X1F0vGrObLe7+JhTjHZ/c3B67B0PUdNRX78M4yVAJS
        Lh6d5+a92gvn9VI7sKWSUV+RP
X-Received: by 2002:a17:902:202:: with SMTP id 2mr3091343plc.96.1569490799212;
        Thu, 26 Sep 2019 02:39:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOsZ3BVghSeIFfGQEyW6lVgkhzRLJGhChjYo8ExyTTO9l78osOjDKhtCVViyXliYW7TRe8jw==
X-Received: by 2002:a17:902:202:: with SMTP id 2mr3091314plc.96.1569490799031;
        Thu, 26 Sep 2019 02:39:59 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:39:58 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Matthew Wilcox <willy@infradead.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 05/16] arc/mm: Use helper fault_signal_pending()
Date:   Thu, 26 Sep 2019 17:38:53 +0800
Message-Id: <20190926093904.5090-6-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let ARC to use the new helper fault_signal_pending() by moving the
signal check out of the retry logic as standalone.  This should also
helps to simplify the code a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arc/mm/fault.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 3861543b66a0..ee3ba7c7b891 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -127,29 +127,21 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return;
+	}
+
 	/*
-	 * Fault retry nuances
+	 * Fault retry nuances, mmap_sem already relinquished by core mm
 	 */
-	if (unlikely(fault & VM_FAULT_RETRY)) {
-
-		/*
-		 * If fault needs to be retried, handle any pending signals
-		 * first (by returning to user mode).
-		 * mmap_sem already relinquished by core mm for RETRY case
-		 */
-		if (fatal_signal_pending(current)) {
-			if (!user_mode(regs))
-				goto no_context;
-			return;
-		}
-		/*
-		 * retry state machine
-		 */
-		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
-			flags |= FAULT_FLAG_TRIED;
-			goto retry;
-		}
+	if (unlikely((fault & VM_FAULT_RETRY) &&
+		     (flags & FAULT_FLAG_ALLOW_RETRY))) {
+		flags &= ~FAULT_FLAG_ALLOW_RETRY;
+		flags |= FAULT_FLAG_TRIED;
+		goto retry;
 	}
 
 bad_area:
-- 
2.21.0

