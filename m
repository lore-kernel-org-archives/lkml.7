Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C2C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCCC222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfIZJjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:39:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfIZJjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:39:35 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2355C88309
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:39:35 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id x8so1067872pgq.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nL20lZzBbwkIGL5V1u5lEN6f2V609pKVyYfWwZ4NMZQ=;
        b=OkMKh6m6rR0DOxRpoJGdZoF7tnUsZxikIlmx1CJBZl8Zz6wQ81iT0a0wzTa7AxZGon
         CQAnGlhcPV6PjCphqQW2EyY1vuzAurGf7Jx2J1FYkAGPXnQnwY3U4sobVBMijIb1E5JG
         8M5lzm5RczJnq/C+5H+I70mJq2i4U8hKNLy+KAyJmUrM7fGSC0M0ow6Ef5rXAcI5Z+Zq
         GtC0eGFX+Ys63xJFowZhFFyEKTH+iPCUqxYyHSrXZ1oTblX7cm3BlEEGC/XSR99+tBJF
         nd2BDn39iOYVNXwiQ8s+79OU9Cp991Fh+spWyGEUA9lrVYjYTSszlYrsBcANmAA1ROy1
         BnIg==
X-Gm-Message-State: APjAAAUDHmdAzW+h0ewKnJ/Umg9RoK0avbWcUw5k4G+3z10151TFhO+b
        83w9ZTKmWjr6DUdzt2xw41v1iqBMv10XvP3OhQCeXtODBdrHHRhNfSe95qo9FRM+x4uXD+Sel9R
        oSVni12nolEIonY52v80FhU4R
X-Received: by 2002:a63:5807:: with SMTP id m7mr2441411pgb.371.1569490774571;
        Thu, 26 Sep 2019 02:39:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqygg2Fz4n5y2GLmYVjuAatu7ERh1+nfGR8vHRiW6krMcMD+JGfGkv1cX87Z1ZdlzHDovLsjPg==
X-Received: by 2002:a63:5807:: with SMTP id m7mr2441382pgb.371.1569490774350;
        Thu, 26 Sep 2019 02:39:34 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:39:33 -0700 (PDT)
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
Subject: [PATCH v5 02/16] mm/gup: Fix __get_user_pages() on fault retry of hugetlb
Date:   Thu, 26 Sep 2019 17:38:50 +0800
Message-Id: <20190926093904.5090-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926093904.5090-1-peterx@redhat.com>
References: <20190926093904.5090-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When follow_hugetlb_page() returns with *locked==0, it means we've got
a VM_FAULT_RETRY within the fauling process and we've released the
mmap_sem.  When that happens, we should stop and bail out.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index eddbb95dcb8f..e60d32f1674d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -833,6 +833,16 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
 						gup_flags, locked);
+				if (locked && *locked == 0) {
+					/*
+					 * We've got a VM_FAULT_RETRY
+					 * and we've lost mmap_sem.
+					 * We must stop here.
+					 */
+					BUG_ON(gup_flags & FOLL_NOWAIT);
+					BUG_ON(ret != 0);
+					goto out;
+				}
 				continue;
 			}
 		}
-- 
2.21.0

