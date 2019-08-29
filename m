Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBD8C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE432189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3zJNkLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfH2NvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:51:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44788 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2NvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:51:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so1595550plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fW3k8zWPWk6FVp5QrWdqwjUBdQ4RebiwFEy2lJKDFrw=;
        b=a3zJNkLb0Tq4GidOYWeFBl+BOSSAnzsk8SKjd1/mq6SDr0Bi28W3HnkIm7ZP9qZERZ
         PJDjnROIewGZ3HWRr68Q1bMrWF9HikksxywFuLri5Tt+xcCyRIdaZ8zAbPZwkEVkKEtS
         kWNhJojo3SH32dQLAgUzUmTnM9Eulr+lV2PhDaRxaw/cGI0UA5y9T814yEIPvANy0QQB
         jqM5SzZpgwH0S5XYSM8e+ZL+7ev1Ygu7DQwiVvH/1+t+mYLqBz65cXFC0mj1t/q1Zh5w
         sdhSGQZdbP3ua0iAYc4Tu2tbuKEbbGDceYIZrmkubnB68pTXo9ZHMIc8NJGpepjA/lmk
         PUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fW3k8zWPWk6FVp5QrWdqwjUBdQ4RebiwFEy2lJKDFrw=;
        b=FFzPNi/Ah0zrHbQZUB492l1QbZtPVodacVQcYE9cy1KEEZ/h5QJ/GWY0HvZJCU1gVC
         D+ER4nyVPOHmAetdyEwEro1dtSt/WHV95IS2qB+sm7xMYGKMie4VVWd50PiUXsSDvVUy
         dn6i0+6MX99745sX4zjLcrqo5d0GlCvXkcAGyB+BUl5W5FVgG1braHk9CC18+JrIC0jF
         ePbA31nFJO8fAMtUYaoenRLW1oIId486Z/fyNBaWcPuO67iWU2WAm8YBAfQohdxzn1sa
         7pid+BKMAmLsd68YhdvW4aShLkBlYH0grQw+OlkLNZ3dhnEkN7dS6a3TgS67N4XIvqtD
         egAQ==
X-Gm-Message-State: APjAAAWk1rBPkam9XtyFEeMyamoHA6nQvCE+3Zow+uza/j4sSJ602NfD
        J6VDzVGkSJ9Bdspzb86Z2Jw=
X-Google-Smtp-Source: APXvYqxtmbM6WXnKoiaNk54ZgSjFsVFn9WynUjYzmF6o52O3dElyrmgEaX2U+RxbfprFvvaJ3DRfdA==
X-Received: by 2002:a17:902:fe0e:: with SMTP id g14mr4519162plj.307.1567086682624;
        Thu, 29 Aug 2019 06:51:22 -0700 (PDT)
Received: from VM_12_95_centos.localdomain ([58.87.109.34])
        by smtp.googlemail.com with ESMTPSA id w6sm2950630pgg.2.2019.08.29.06.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 06:51:21 -0700 (PDT)
From:   Zhigang Lu <totty.lu@gmail.com>
To:     luzhigang001@gmail.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Zhigang Lu <tonnylu@tencent.com>
Subject: [PATCH v2] mm/hugetlb: avoid looping to the same hugepage if !pages and !vmas
Date:   Thu, 29 Aug 2019 21:50:57 +0800
Message-Id: <1567086657-22528-1-git-send-email-totty.lu@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhigang Lu <tonnylu@tencent.com>

When mmapping an existing hugetlbfs file with MAP_POPULATE, we find
it is very time consuming. For example, mmapping a 128GB file takes
about 50 milliseconds. Sampling with perfevent shows it spends 99%
time in the same_page loop in follow_hugetlb_page().

samples: 205  of event 'cycles', Event count (approx.): 136686374
-  99.04%  test_mmap_huget  [kernel.kallsyms]  [k] follow_hugetlb_page
        follow_hugetlb_page
        __get_user_pages
        __mlock_vma_pages_range
        __mm_populate
        vm_mmap_pgoff
        sys_mmap_pgoff
        sys_mmap
        system_call_fastpath
        __mmap64

follow_hugetlb_page() is called with pages=NULL and vmas=NULL, so for
each hugepage, we run into the same_page loop for pages_per_huge_page()
times, but doing nothing. With this change, it takes less then 1
millisecond to mmap a 128GB file in hugetlbfs.

Signed-off-by: Zhigang Lu <tonnylu@tencent.com>
Reviewed-by: Haozhong Zhang <hzhongzhang@tencent.com>
Reviewed-by: Zongming Zhang <knightzhang@tencent.com>
Acked-by: Matthew Wilcox <willy@infradead.org>
---
 mm/hugetlb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6d7296d..2df941a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4391,6 +4391,17 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				break;
 			}
 		}
+
+		if (!pages && !vmas && !pfn_offset &&
+		    (vaddr + huge_page_size(h) < vma->vm_end) &&
+		    (remainder >= pages_per_huge_page(h))) {
+			vaddr += huge_page_size(h);
+			remainder -= pages_per_huge_page(h);
+			i += pages_per_huge_page(h);
+			spin_unlock(ptl);
+			continue;
+		}
+
 same_page:
 		if (pages) {
 			pages[i] = mem_map_offset(page, pfn_offset);
-- 
1.8.3.1

