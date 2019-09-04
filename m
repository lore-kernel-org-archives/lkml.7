Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D3EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BC322CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3u/RtT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfIDHWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:22:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34795 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDHWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:22:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so10752048pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 00:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k5iU7vWPjCKUNszLjo1EIEgwZ0+VgslA2cRZaOoMdXw=;
        b=E3u/RtT3z0ejfdWGzoAwlpOd3pFC+iFylvsxbFkIQG5Mk6lIrZFqAxY/wzfukTZab4
         IlCc9iZEZth6OuNubGQNJrjIH5thuTE4jo5kuW7zcMnGChwRSC/H/Buwf9yugb0rbVht
         kMscYzGT9e/V0v0yPDjBt1mfX+Z2GQvGhPYy7tHvR8ypFt3CgyVUBrR0HUAWSPggtc3Z
         m7jfVT1jVDT3YgxP71iC9aeu9BOpvLt7hAvuMqNliX+XUIzPJ5pDDZquxZNPDZVu76cD
         l38fu0wg10M3nUq7d01NNdMGuakN19VcglJzVR8etxln+4ZTk8mKV7/2f/FkhswVK2On
         CxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k5iU7vWPjCKUNszLjo1EIEgwZ0+VgslA2cRZaOoMdXw=;
        b=F2hhp6ypSvHxITxA1BU2WbWFGVpigu184N0AaOvMb7wDWmdZwkHUne+XwU9Wo2tkDA
         ffi+McLRNOa3iEqcOwJ+pxIzmd6edCECcpqHgZ0ECqm3xb0Qv53EphT2K00h7f+rKxH6
         jR0SThGLo6YJ+oHCsTtsaDyrMN9qwZEa+WNqJ+SVvcBHIqDR9AW1AvsrPt6C/okplWWM
         e7bMWs6jWjTG/HaKnDeoBjSHY+JPCZwLWFJf2jNx/5pOhRJ+MlpxFL9mNdZJMowoi9tV
         CcL7al9ztBu6rmF1u3QpTt4+zSKP5LHoZMhydZYgUMhVCI5VVo+WvVg+O+q4OfpEwDjI
         U5ww==
X-Gm-Message-State: APjAAAUUGiPWtnCtSBlhMOkq0QrLLqX/M42J++CGTnms88gTFAJfnnXp
        7KZALGqd/UO7HhSOXcDR9VaV3F+WxzU=
X-Google-Smtp-Source: APXvYqxLCJ/mi+WEi6Hizyc8n+UGDgwDe+iBmNMTCCrPk2L2yLhgzlweZdQeKPuU7rt4Jv/8s4pLdw==
X-Received: by 2002:a65:6294:: with SMTP id f20mr34883435pgv.349.1567581738039;
        Wed, 04 Sep 2019 00:22:18 -0700 (PDT)
Received: from VM_12_95_centos.localdomain ([58.87.109.34])
        by smtp.googlemail.com with ESMTPSA id x24sm17102188pgl.84.2019.09.04.00.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 00:22:17 -0700 (PDT)
From:   Zhigang Lu <totty.lu@gmail.com>
To:     luzhigang001@gmail.com, mike.kravetz@oracle.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Zhigang Lu <tonnylu@tencent.com>
Subject: [PATCH v3] mm/hugetlb: avoid looping to the same hugepage if !pages and !vmas
Date:   Wed,  4 Sep 2019 15:21:52 +0800
Message-Id: <1567581712-5992-1-git-send-email-totty.lu@gmail.com>
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Matthew Wilcox <willy@infradead.org>
---
 mm/hugetlb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6d7296d..a096fb3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4391,6 +4391,21 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				break;
 			}
 		}
+
+		/*
+		 * If subpage information not requested, update counters
+		 * and skip the same_page loop below.
+		 */
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

