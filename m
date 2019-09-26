Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E2C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67402222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfIZJkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:40:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfIZJkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:40:43 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 467F8C04AC69
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:40:42 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id p2so1373631pff.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mt5SnWXXSk9uI7dmB8jKwFtY/VxQIE33S8hNcu1UngY=;
        b=nyzH6nj5e4VgOluXix4Q6MwiKLyCWdiVsa6GgycZvVf7QqZxvq2MmAYVEMrxrdmuHg
         kapOw11woacZzBKjZntQ5ab2tqG2Nvq6K8u7BSLj4dbFNPsKESwV42hnBbMZm7Ng08OF
         /H2c6mdT43EXabgxxBB6GYlxoQjirn3CFgYyvxBygx+eO+N/W/q+2k/0E20y+vJ+WJ+M
         zI6HGdUgjzAvWaWkiD8iJz1llJIQzLFJK3GTcACimMOpV4FhFmMNkiqH7L5V4jC3XDJC
         9sTxwHi9EtmYaw4kY2yiVgmKYGGS41WtMqbh6ZjTVUwC2P4H5Pl3tGke28Od+NrjgK4L
         2b1A==
X-Gm-Message-State: APjAAAUOVKUvP4/L8TUb+0iCbX9ScH5ak6lvIqLqS8ZHkC3dJgCH6+xF
        ImjPypkOEl8mBnAO1o+8olDnn4zaFp8Yrn4Ivs+yaT3mF+RwKUyP2XhTjI9y49No1ZU3hsI0mDR
        l10xRdp0jef2sHUJaqoRuHtV1
X-Received: by 2002:a17:902:7615:: with SMTP id k21mr3125713pll.116.1569490841821;
        Thu, 26 Sep 2019 02:40:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8FZvMzCaS6tP09HihPyaGx7bD6hMWJf1hsxnBDZsjGhkkZymRtSV9xjgZdU3TLT4rGPDI4Q==
X-Received: by 2002:a17:902:7615:: with SMTP id k21mr3125689pll.116.1569490841636;
        Thu, 26 Sep 2019 02:40:41 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:40:40 -0700 (PDT)
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
Subject: [PATCH v5 10/16] userfaultfd: Don't retake mmap_sem to emulate NOPAGE
Date:   Thu, 26 Sep 2019 17:38:58 +0800
Message-Id: <20190926093904.5090-11-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the risk path in handle_userfault() then we will be
sure that the callers of handle_mm_fault() will know that the VMAs
might have changed.  Meanwhile with previous patch we don't lose
responsiveness as well since the core mm code now can handle the
nonfatal userspace signals even if we return VM_FAULT_RETRY.

Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index fe6d804a38dc..d8777146bae7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -524,30 +524,6 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	__set_current_state(TASK_RUNNING);
 
-	if (return_to_userland) {
-		if (signal_pending(current) &&
-		    !fatal_signal_pending(current)) {
-			/*
-			 * If we got a SIGSTOP or SIGCONT and this is
-			 * a normal userland page fault, just let
-			 * userland return so the signal will be
-			 * handled and gdb debugging works.  The page
-			 * fault code immediately after we return from
-			 * this function is going to release the
-			 * mmap_sem and it's not depending on it
-			 * (unlike gup would if we were not to return
-			 * VM_FAULT_RETRY).
-			 *
-			 * If a fatal signal is pending we still take
-			 * the streamlined VM_FAULT_RETRY failure path
-			 * and there's no need to retake the mmap_sem
-			 * in such case.
-			 */
-			down_read(&mm->mmap_sem);
-			ret = VM_FAULT_NOPAGE;
-		}
-	}
-
 	/*
 	 * Here we race with the list_del; list_add in
 	 * userfaultfd_ctx_read(), however because we don't ever run
-- 
2.21.0

