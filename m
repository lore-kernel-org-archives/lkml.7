Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D6C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C507222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfIZJkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfIZJkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:40:09 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDA3C806CD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:40:08 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id 135so1052093pgc.23
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppg1NSAShmiSu6checGzn4FvUz9QiJFKA275BDKmjpQ=;
        b=pVgsHRiDpsjepMiS82KqyFX+CPX5VWKk0knACQhyXuTk2xMKWcrWAJ3k7+QvCCj9f1
         0i8Pqd/DxOWM9kRwee4OKTffoC0/wEtpBtEEBOya2Xt0oV+XFzyi8GTNPC/CSFwpMdWs
         MoYpAQWQ9Ay32coiDlo3ApUNz23eR7GetQZR4Czv4eaGHfS6B8emJ9GyLGfkzFRrYel9
         HoZbN4ZAtxcQ5fCUadg1ZoBa23VbMVh8oW3hDpu3+TQGOUfLaNRuDWd793SNA62poJV4
         BTpOwtMIyBbVx6eu8bMYQXsUtysSF57WAedAgXvpusTKxvg1EToUQClfkU5aboE/3NvI
         NVpA==
X-Gm-Message-State: APjAAAV3t13xK6Br4M62NuLno0a6E0dN9FAKUvoR8R/Jtcjqh6L54cez
        UHrRhwa3+tljpWcRtomdGkUtqGa7tPMzRO3s/pQAEeTkNVOzBcgohCvoVi8rxm5qtyXFFy/rNDq
        T2i4Jw9ps26b/76mOFjJKDKOm
X-Received: by 2002:a17:90a:8986:: with SMTP id v6mr2583654pjn.115.1569490807824;
        Thu, 26 Sep 2019 02:40:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQD3YCFxyODT7vLmOJs1BI9wxQJcPhmEkojKoQ0r5Yub0wIQeWe0SUpPIZubTSCqM/BHQXwg==
X-Received: by 2002:a17:90a:8986:: with SMTP id v6mr2583641pjn.115.1569490807619;
        Thu, 26 Sep 2019 02:40:07 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:40:06 -0700 (PDT)
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
Subject: [PATCH v5 06/16] arm64/mm: Use helper fault_signal_pending()
Date:   Thu, 26 Sep 2019 17:38:54 +0800
Message-Id: <20190926093904.5090-7-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the arm64 fault handling to use the new fault_signal_pending()
helper, by moving the signal handling out of the retry logic.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/fault.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index cfd65b63f36f..4a695a44fb05 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -477,19 +477,14 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	fault = __do_page_fault(mm, addr, mm_flags, vm_flags);
 	major |= fault & VM_FAULT_MAJOR;
 
-	if (fault & VM_FAULT_RETRY) {
-		/*
-		 * If we need to retry but a fatal signal is pending,
-		 * handle the signal first. We do not need to release
-		 * the mmap_sem because it would already be released
-		 * in __lock_page_or_retry in mm/filemap.c.
-		 */
-		if (fatal_signal_pending(current)) {
-			if (!user_mode(regs))
-				goto no_context;
-			return 0;
-		}
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return 0;
+	}
 
+	if (fault & VM_FAULT_RETRY) {
 		/*
 		 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk of
 		 * starvation.
-- 
2.21.0

