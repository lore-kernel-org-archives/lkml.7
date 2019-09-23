Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B07EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181CC20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfIWEZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 00:25:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfIWEZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 00:25:56 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 356D42CD7E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:25:56 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id v4so7950344plp.23
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 21:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nL20lZzBbwkIGL5V1u5lEN6f2V609pKVyYfWwZ4NMZQ=;
        b=iKDzWQCvOKCbLdimkNEhApuUxI6rJnxEwADWSfVprDP5xUwTRTlO+1BizeDW9fVUxh
         ZBuNByEtLRwWtPe9g6xdT9ojdh1B2qzE4K+kzThtFCJzK3Jd7qEsX6E1+yCd7Ni+eZuI
         TLasWtCqACAmh2k+a8WGkkca1Fl+Yy3FyskZEqNijnOFqBAjnvNdrzBjGmN8m/Qmziea
         RfumQbYYhHU8ULMy1Q+e4RTb2nGiSRuTYz66KtniqFizfma7W1y0wxCdeJoNTYc1mgCY
         VmBiibTJDKNvxl/4xuo0V1/xzSoGLMJaTFzsWVrpxw/uyHQ9YvwuWGRm1PwVi7jzHpwx
         1VuQ==
X-Gm-Message-State: APjAAAWnQJUV2DeyqUAvQVsnREgn2v09ZLnILQlLEnzvu6b926Rha/XH
        wGV3oC5RYtktLTAntRJtyf2oAtwH0ylCVuGeMgvbcFpR4dZO85fQQIa0fMM9arrXlxFgiLCpI4W
        zvfdeVgX15Mc+83W2SFFTQejg
X-Received: by 2002:a65:67d4:: with SMTP id b20mr27376180pgs.445.1569212755561;
        Sun, 22 Sep 2019 21:25:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyxuxMhYGvH4EJC3+piC4YcWYwZ7eWeZxL3c1t1HTqZSY/8jbiqPCLTpPP6LH9KEz2RQOBjDg==
X-Received: by 2002:a65:67d4:: with SMTP id b20mr27376164pgs.445.1569212755347;
        Sun, 22 Sep 2019 21:25:55 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x20sm11781867pfp.120.2019.09.22.21.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 21:25:54 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 02/10] mm/gup: Fix __get_user_pages() on fault retry of hugetlb
Date:   Mon, 23 Sep 2019 12:25:15 +0800
Message-Id: <20190923042523.10027-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923042523.10027-1-peterx@redhat.com>
References: <20190923042523.10027-1-peterx@redhat.com>
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

