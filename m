Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C574EC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1456222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfIZJke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfIZJke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:40:34 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07BEE7FDCA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:40:34 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id f11so1076327pgn.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zs0icSpFo5EckbI9NuVzMV23UUzKD43r4J1NyJ/klic=;
        b=JeBGu35grj4LtR9oy8ZhQKqcSengUy4OSsBPZl9RNXsemFdY4hy54mxC9d6XgkDDBG
         C/zp0J3pTE1vWiSVn1WyBU9dhB9sI/5/cCmcGfg3bC8V6Q8R/HDye3zywsf5UWhUvb8k
         /O7eGgT6Y6xLy5eG30bh9ElK94hTIpKsrsiQG+XGKdXUovnDeJ+cjUFnw9hbEtLGbhqR
         hkLhJZs8iqC1wFyXyXKOu7dDJxVFre3iRRG0/bvx8JSKVuZHW7DyyAWeVIG79+jDFNTN
         iwTbIkRmem7Z8rICq7ZQUuo/jSgcu180F8Vht0IP2/VZSAXiWd66ddhHtFKMOK+kgJx/
         OP+w==
X-Gm-Message-State: APjAAAXhtqy/7UlASns58zBQC2yCoYVUxjO+vEQ/r+Fg5JNmMD08yJsj
        i4DbETUJgdWE01RnnJQi5vBGoBiidJH7K/4ICi9IExKRRnCfnk3ZZbP5RV4jCop3Dc4WECcOIA4
        lcem6NaUVEtUPoULrMhp9Yv/8
X-Received: by 2002:a17:902:8488:: with SMTP id c8mr2742257plo.164.1569490833530;
        Thu, 26 Sep 2019 02:40:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy78qElHwxU+VN7yYhyu4WKCD5RFszqHAErQMKeM6BohEAgdvKCeLfzyvCTuMFSeTddGiEejA==
X-Received: by 2002:a17:902:8488:: with SMTP id c8mr2742227plo.164.1569490833256;
        Thu, 26 Sep 2019 02:40:33 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:40:32 -0700 (PDT)
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
Subject: [PATCH v5 09/16] mm: Return faster for non-fatal signals in user mode faults
Date:   Thu, 26 Sep 2019 17:38:57 +0800
Message-Id: <20190926093904.5090-10-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea comes from the upstream discussion between Linus and Andrea:

  https://lore.kernel.org/lkml/20171102193644.GB22686@redhat.com/

A summary to the issue: there was a special path in handle_userfault()
in the past that we'll return a VM_FAULT_NOPAGE when we detected
non-fatal signals when waiting for userfault handling.  We did that by
reacquiring the mmap_sem before returning.  However that brings a risk
in that the vmas might have changed when we retake the mmap_sem and
even we could be holding an invalid vma structure.

This patch is a preparation of removing that special path by allowing
the page fault to return even faster if we were interrupted by a
non-fatal signal during a user-mode page fault handling routine.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/sched/signal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 46429192733b..031af0a6505a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -387,7 +387,8 @@ static inline bool fault_signal_pending(unsigned int fault_flags,
 					struct pt_regs *regs)
 {
 	return unlikely((fault_flags & VM_FAULT_RETRY) &&
-			fatal_signal_pending(current));
+			(fatal_signal_pending(current) ||
+			 (user_mode(regs) && signal_pending(current))));
 }
 
 /*
-- 
2.21.0

