Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D7CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FF821A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjjU9+3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfJXU33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:29:29 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:39703 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfJXU3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:29:25 -0400
Received: by mail-pf1-f201.google.com with SMTP id l20so78415pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CY1SErJX00acWObUhsBSXFRXX6IflpSHZNkrAmXXrxE=;
        b=YjjU9+3kRuzqEnDF0lHEdI+lMEq/b6/LbphlLr8wHsnojuFpkmXbGoNuyndDhuvoIk
         9aPUUZ+8WRZQe9M/d+ab65zEm+xV34DmZN9Yv9896/nb/VxJEAkGfVOVKO+s86d8lbgu
         7ybynVdq/IplG7KBOw/0ViWe9VXKKe5jNTHwew6vbs1Y2AHtC9BEog7MUTekM2xPx+co
         RIW/XGHJ/2+FEEs70mOhYdi35FWPWWDBQnh9Gk5fp3J0GMvujjRgpyTexjB55ijqDqno
         bK5YlRUpsaHVfiGD95mnwxnBjbjYo+tmgbEIoN96SXGU9ETDDhwGkCOUbzn9Z7H+dvOs
         5D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CY1SErJX00acWObUhsBSXFRXX6IflpSHZNkrAmXXrxE=;
        b=Ew1YR3kubhE6qMfRt/km5B0BOmrTmDoqzSNpiMj7TXn7FvKhVFb/kTE+JlmqFaiv11
         QtJTtnxKOZ/Vwect2AsECwHCH1ARPaYD0oCwJEtko878j6FqJGPKa7vBokLTGqR15Zbg
         IgdEHBi9L1dXGSMhxF8F3xq2tYpIKo5BddVctKJf0sjlusD/Ia9Zypjca4RXgqDVvaeX
         bNWsxEvOO+eRcsCrKXD7ETMilsXZD3f7f8NQkWM998htsT7IL8TtyMh9bpYE1egpcvZZ
         P9yKotCbCVR7/45jM+GK5mK7kVnBpCK/g2Uvjtl81zLHqyzP75KbfpoXQNTugMHZWWNe
         Q0iw==
X-Gm-Message-State: APjAAAViNb/y8NLzx5E8Va903Ud+Tvho5xpBV25hRM7YY5iQii4EfQek
        JIzJOqdNJT6Bso7kHjZDTb7wEg6TJmmkyCFD8Q==
X-Google-Smtp-Source: APXvYqzg6h2xjNbEkJ/s193lqIa08ssOYMh8AgBOCD0SF5L3y22RXE3QioF3xPh850uAcVV8DfeopsmuVLQ0sSb0jQ==
X-Received: by 2002:a63:fb4f:: with SMTP id w15mr11117978pgj.403.1571948964078;
 Thu, 24 Oct 2019 13:29:24 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:28:56 -0700
In-Reply-To: <20191024202858.95342-1-almasrymina@google.com>
Message-Id: <20191024202858.95342-7-almasrymina@google.com>
Mime-Version: 1.0
References: <20191024202858.95342-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v7 7/9] hugetlb_cgroup: support noreserve mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support MAP_NORESERVE accounting as part of the new counter.

For each hugepage allocation, at allocation time we check if there is
a reservation for this allocation or not. If there is a reservation for
this allocation, then this allocation was charged at reservation time,
and we don't re-account it. If there is no reserevation for this
allocation, we charge the appropriate hugetlb_cgroup.

The hugetlb_cgroup to uncharge for this allocation is stored in
page[3].private. We use new APIs added in an earlier patch to set this
pointer.

---
 mm/hugetlb.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cef15e68626bd..7715018a0af22 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1253,6 +1253,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_writeback);
 	}
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, false), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, true), page);
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
@@ -1364,6 +1365,9 @@ void free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
 				     page, false);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, true);
+
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -1390,6 +1394,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	spin_lock(&hugetlb_lock);
 	set_hugetlb_cgroup(page, NULL, false);
+	set_hugetlb_cgroup(page, NULL, true);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	spin_unlock(&hugetlb_lock);
@@ -2195,10 +2200,19 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

+	/* If this allocation is not consuming a reservation, charge it now.
+	 */
+	if (map_chg || avoid_reserve || !vma_resv_map(vma)) {
+		ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h),
+						   &h_cg, true);
+		if (ret)
+			goto out_subpool_put;
+	}
+
 	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
 					   false);
 	if (ret)
-		goto out_subpool_put;
+		goto out_uncharge_cgroup_reservation;

 	spin_lock(&hugetlb_lock);
 	/*
@@ -2222,6 +2236,11 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
 				     false);
+	if (!vma_resv_map(vma) || map_chg || avoid_reserve) {
+		hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg,
+					     page, true);
+	}
+
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2247,6 +2266,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
 				       false);
+out_uncharge_cgroup_reservation:
+	if (map_chg || avoid_reserve || !vma_resv_map(vma))
+		hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h),
+					       h_cg, true);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
--
2.24.0.rc0.303.g954a862665-goog
