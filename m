Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D29FC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC4B222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfIZJk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:40:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfIZJk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:40:26 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D65610567
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:40:25 +0000 (UTC)
Received: by mail-pg1-f198.google.com with SMTP id d3so1082715pgv.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+W2E1LzRmGELKrtQEGc7UL31viDl3TRdbLGP+s2aPk=;
        b=dDhilb2xNIClIdZNcRGKT26z1Cp0EYENDN4Bvn+8Ng70V+PbuqZ/ShhevtV50MKM4N
         7tnUT/igCdokj/GBvJzcri9fDUjb9vQM/CWwadhqCbOd4t6BL9Sx2zzvSc0Xf+cjbA7P
         NfK8VC8WVRRJd1g/4cwo2bJiGIvR8n2QVUlIDbRSAETbGwiE6N4m0oK+BDYm7pdrNxJx
         S02bGpJKjugMegOJrKB7OvdAbtB7ncct0mHDYc2JG7WO89/3OEmnBOZMpFU72othZOOU
         p5otM2l4+PYTTxTyiuC7Xr5yMmtEpUXD+tiCx/RNK6McDzpy+Q6o6ZulGUKvZCuXl7nt
         rzPQ==
X-Gm-Message-State: APjAAAUSFzb1k+bW1fjL3de098EgYjLAZUcD8K5N5zDEnvZfPt3Fr+eT
        J1vr3TxLCZyp74kGC7X7BFqkn24nEFrJmqsNKE3GlrGr7vgN4dtn7JcX1i/B2mJ62PUFy8mHXlR
        NKgyq/h2dPZ1k0cby27mAXfKP
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr2842072plo.265.1569490825032;
        Thu, 26 Sep 2019 02:40:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqynSS4HR4dDuIQIw6IsL02LZzQrkS9X1jvtp6dAnxYs3miRg0CJh42FhqBbBwvL8J0ehgBiUQ==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr2842062plo.265.1569490824859;
        Thu, 26 Sep 2019 02:40:24 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:40:24 -0700 (PDT)
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
Subject: [PATCH v5 08/16] sh/mm: Use helper fault_signal_pending()
Date:   Thu, 26 Sep 2019 17:38:56 +0800
Message-Id: <20190926093904.5090-9-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let SH to use the new fault_signal_pending() helper.  Here we'll need
to move the up_read() out because that's actually needed as long as
!RETRY cases.  At the meantime we can drop all the rest of up_read()s
now (which seems to be cleaner).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sh/mm/fault.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 5f51456f4fc7..eb4048ad0b38 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -302,25 +302,25 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 	 * Pagefault was interrupted by SIGKILL. We have no reason to
 	 * continue pagefault.
 	 */
-	if (fatal_signal_pending(current)) {
-		if (!(fault & VM_FAULT_RETRY))
-			up_read(&current->mm->mmap_sem);
+	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, error_code, address);
 		return 1;
 	}
 
+	/* Release mmap_sem first if necessary */
+	if (!(fault & VM_FAULT_RETRY))
+		up_read(&current->mm->mmap_sem);
+
 	if (!(fault & VM_FAULT_ERROR))
 		return 0;
 
 	if (fault & VM_FAULT_OOM) {
 		/* Kernel mode? Handle exceptions or die: */
 		if (!user_mode(regs)) {
-			up_read(&current->mm->mmap_sem);
 			no_context(regs, error_code, address);
 			return 1;
 		}
-		up_read(&current->mm->mmap_sem);
 
 		/*
 		 * We ran out of memory, call the OOM killer, and return the
-- 
2.21.0

