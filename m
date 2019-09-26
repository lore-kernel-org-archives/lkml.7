Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB1C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91781222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfIZJkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:40:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfIZJkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:40:17 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D2AF50F64
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:40:17 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id s139so1339383pfc.21
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LpCSyY/6JZQuJ1z7pLkTHdeWJUVPhg/tAxJyi5b+KHU=;
        b=j57QCQQowMlVn6Fv5pRYDMhecg/IpyxbTMyeiqcfNY1nCInapdkN1HwKjGca9/z5Jg
         BYHfPmWJr9jdaOf7iCujyHGeLNufi5XxP+lHf2wH7Kl0erq/14UpDjfUmYid68dCvl9l
         7LguDlkglnCHO8gU425SvsFa4C7qxsgytGx4z/NgcZpBaomrFJgh9DMLG0l6tWS5X3Lg
         t1ZZ7YwTlmZUJISRtCMM5cFX09N9NGZ38n8hYGX1HqHNGMm5aN3bhboeXmN9LTQJmVfp
         c/cQ5ZMIcGl9MZ7w6nYWMJ0RmMDDrQ1WYUg1xhxhfZ/PmTmJjjISCF4L5/emkbijigbv
         U3Jg==
X-Gm-Message-State: APjAAAU+a6OTOLkRD+x3J2uZLZ+ru7QvrcwLYhO/g4EyuzwVqYLnTjg6
        locZEIZlrgqQ7CUff8ZJEeUaYKrpDUjukPAXzaX2voxc7UHzAcu2k7ppOfsFunUGcTNJJyyHZZw
        2nnib1f/eefqvt93Dk8tpMkFA
X-Received: by 2002:a63:a369:: with SMTP id v41mr2525766pgn.148.1569490816503;
        Thu, 26 Sep 2019 02:40:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxKACEquhcLFybN2y5JPp/3ZKltqjkLTVK4ufHCX/1hwGKZNzOpTcD/V3ar6+4lQuJZ+kgFxw==
X-Received: by 2002:a63:a369:: with SMTP id v41mr2525726pgn.148.1569490816214;
        Thu, 26 Sep 2019 02:40:16 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:40:15 -0700 (PDT)
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
Subject: [PATCH v5 07/16] powerpc/mm: Use helper fault_signal_pending()
Date:   Thu, 26 Sep 2019 17:38:55 +0800
Message-Id: <20190926093904.5090-8-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let powerpc code to use the new helper, by moving the signal handling
earlier before the retry logic.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/mm/fault.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 8432c281de92..7dabd1243f1b 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -583,6 +583,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	major |= fault & VM_FAULT_MAJOR;
 
+	if (fault_signal_pending(fault, regs))
+		return user_mode(regs) ? 0 : SIGBUS;
+
 	/*
 	 * Handle the retry right now, the mmap_sem has been released in that
 	 * case.
@@ -596,15 +599,8 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 			 */
 			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
-			if (!fatal_signal_pending(current))
-				goto retry;
+			goto retry;
 		}
-
-		/*
-		 * User mode? Just return to handle the fatal exception otherwise
-		 * return to bad_page_fault
-		 */
-		return is_user ? 0 : SIGBUS;
 	}
 
 	up_read(&current->mm->mmap_sem);
-- 
2.21.0

