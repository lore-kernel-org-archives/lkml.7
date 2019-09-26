Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D9BC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAFF222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfIZJjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:39:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfIZJjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:39:51 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87BBA85540
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:39:51 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id g20so1164242plj.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nj2m7MUZQj6IXXRy4zbweijjogaCLtcKQ4EIZak4N0g=;
        b=cj7kfT68NxILWrM4A9gtDjCfB2NYh2Xh1Jx3VCuMjSahpMiFKGi95T2espczVDO4u+
         ecAl+D4UIskLPYlwRe6eehvxNJ5I4/QEeX/DoO0wYN4k1nxiNeEKgbIiZjlaXEv3ZJKt
         1XpXnnnWQoJND4K8ewUSomRucfo15x1j24nzPclG4WVoAgqviLk7qk3STPfc1TEV5APh
         Z5g1/yEWpzHVUgVhF41VP4iCMg8rXVyJ3K4QRO4Q6fOQggMGTbzw36S0eZMeyupnmURc
         CTbo0Hzhl9Phbrz95OicWm9ccpa9NnW9uF9EhPxWtHmDwreU/idT+xLlEAxdt3g/dX7R
         JOFA==
X-Gm-Message-State: APjAAAUbz/81aXA3pYrX9DZZ1k0op55nrDPkjz97hD8Dz1i6GJ/UzuSJ
        a393GvpOkvLA9SL8Lt1i6h4UymKFBbWCjh/BJpz5hddYlMCUnCk5wDD2hpCZUkhQc4yyV6a59RD
        lD8y8C2wdXGLi/Rm1b24Cq4dg
X-Received: by 2002:a63:9742:: with SMTP id d2mr2391531pgo.356.1569490791000;
        Thu, 26 Sep 2019 02:39:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw3zgXy3wRQcC9cw9sy7SwV86a9/+fNTVOhrGLjp87vBhGEjJORyCXZ82QFiBleXBcoc7oI5w==
X-Received: by 2002:a63:9742:: with SMTP id d2mr2391518pgo.356.1569490790717;
        Thu, 26 Sep 2019 02:39:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:39:50 -0700 (PDT)
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
Subject: [PATCH v5 04/16] x86/mm: Use helper fault_signal_pending()
Date:   Thu, 26 Sep 2019 17:38:52 +0800
Message-Id: <20190926093904.5090-5-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the fatal signal check even earlier so that we can directly
use the new fault_signal_pending() in x86 mm code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/fault.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9ceacd1156db..059331797827 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1441,27 +1441,25 @@ void do_user_addr_fault(struct pt_regs *regs,
 	fault = handle_mm_fault(vma, address, flags);
 	major |= fault & VM_FAULT_MAJOR;
 
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			no_context(regs, hw_error_code, address, SIGBUS,
+				   BUS_ADRERR);
+		return;
+	}
+
 	/*
 	 * If we need to retry the mmap_sem has already been released,
 	 * and if there is a fatal signal pending there is no guarantee
 	 * that we made any progress. Handle this case first.
 	 */
-	if (unlikely(fault & VM_FAULT_RETRY)) {
+	if (unlikely((fault & VM_FAULT_RETRY) &&
+		     (flags & FAULT_FLAG_ALLOW_RETRY))) {
 		/* Retry at most once */
-		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
-			flags |= FAULT_FLAG_TRIED;
-			if (!fatal_signal_pending(tsk))
-				goto retry;
-		}
-
-		/* User mode? Just return to handle the fatal exception */
-		if (flags & FAULT_FLAG_USER)
-			return;
-
-		/* Not returning to user mode? Handle exceptions or die: */
-		no_context(regs, hw_error_code, address, SIGBUS, BUS_ADRERR);
-		return;
+		flags &= ~FAULT_FLAG_ALLOW_RETRY;
+		flags |= FAULT_FLAG_TRIED;
+		goto retry;
 	}
 
 	up_read(&mm->mmap_sem);
-- 
2.21.0

