Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B7FC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5F12089C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQR29j5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfJMAat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 20:30:49 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43378 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfJMAap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 20:30:45 -0400
Received: by mail-pg1-f201.google.com with SMTP id 6so9886540pgi.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 17:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xekgIg4dN3m1HVyQSgfrAu003H3IqqF6Q7QAQZd3RT0=;
        b=aQR29j5FYNJohLbfcXRNwkGUhbOnF+f07QgP1hMkNy7kiKn1f5mnO8EVdG7aw01ly5
         TtSY91Przz2c/ZSOK8uEKQiaIgFMSiIpENtHoQuJxMWLTgn4tGCqj+65kukDeTvuPZ+6
         e0aIFU+zJxpx8cSGSTanyam9LjcbAm5+M063GirvgsUNTDcfagTWeRYCTtHzVqnwLLM7
         69ewHkcoHtOzQ0btNWcjLRJURH9G3Y0Bhzo7A+/nE7v0y300AxR4DbiKcLJHGloN4RHm
         ctuwoCBT++gTQxKoneYGym6bnDCYtc6ZwSEYHmKmL+Fa0JZy8Lz3Qh4pnmBaTp7cQ0RP
         3+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xekgIg4dN3m1HVyQSgfrAu003H3IqqF6Q7QAQZd3RT0=;
        b=BDAQHawJ1XVYg0L5SvrpoEb2UeO2VDDKYVWWxKKdMg6nImpR9BSzU8XbN4zYDlI3pk
         JAEIyuwZgaMJMGBhgWc6fjNJXsDzpA/s0ZVbtGlU8CUz02iZ5ubLoy1UlSG7LGdhMTCT
         +2P2BKXkus/jjvUapVphtiA1r9v6fKRPp1g38Z/35KK9dPc606KKpVJZm31nxemEm00A
         bv3BcnvCwxv1/6tnPTItLGnw66V+CjiL91QI7p958A52NYWTHqMGYzr/W0V+H9/TYpPv
         RjB8oXfG2282E8bt/3jWaKDKSWeJh3IQoWpL3/0qenF3xGSySpMRAg/JAB7qu8JGhmHI
         z9jA==
X-Gm-Message-State: APjAAAUDApYr6rVZ5mgotHf4ID6mRf2iK3iwpUyHcSzTurfzDqqmL3l/
        245NLiNulwcORfMaVLomxWHrGo9QPtiNLSmQlQ==
X-Google-Smtp-Source: APXvYqwO1B/rBxyR8P/t+7Sb94rTCepgrVxZzgfjaNGhv1GAZuM8kwDVsFDuBpAPLFO8daUod0KAKRyTnJXMKu9s9g==
X-Received: by 2002:a63:e853:: with SMTP id a19mr24813620pgk.192.1570926644257;
 Sat, 12 Oct 2019 17:30:44 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:30:22 -0700
In-Reply-To: <20191013003024.215429-1-almasrymina@google.com>
Message-Id: <20191013003024.215429-7-almasrymina@google.com>
Mime-Version: 1.0
References: <20191013003024.215429-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v6 7/9] hugetlb_cgroup: support noreserve mappings
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
index af336bf227fb6..79b99878ce6f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1217,6 +1217,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_writeback);
 	}
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, false), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, true), page);
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
@@ -1328,6 +1329,9 @@ void free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
 				     page, false);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, true);
+
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -1354,6 +1358,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	spin_lock(&hugetlb_lock);
 	set_hugetlb_cgroup(page, NULL, false);
+	set_hugetlb_cgroup(page, NULL, true);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	spin_unlock(&hugetlb_lock);
@@ -2155,10 +2160,19 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
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
@@ -2182,6 +2196,11 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
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
@@ -2207,6 +2226,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
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
2.23.0.700.g56cf767bdb-goog
