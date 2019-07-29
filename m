Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F092BC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A022070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564384247;
	bh=PJOEi6fcfOfijCptH6Rx8iutl/qGbP0V3PSk4+Ytgdo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QqNr6ADHKNdDovh4ToHVCcg8nmPUc73L07n4cpFfEeesLG1CVCkPs+Eu3uhRYMIyP
	 xziEjv1tEUw/ZqjzJBEkg73EE7l5Hhc157n6eHL8LJYXq7y+mId/zFB2S3wUmgNytC
	 rtkcJOsx+ApQsumRxYCmT2tgwDdpNpulCZqMqNwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfG2HKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:10:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35955 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfG2HKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:10:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so27751409pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MP9bWqLglik/G7ydzgpH6qxtoOPjTnKjIEZbq35U0w8=;
        b=GbpKZO+1qWJF5PiJfpJI+X1d49LQDhRSEjabzM4QoQoxyPC/ykpjviHT067xaP4ur9
         Q8obYhARMbKPZN2+MUi7KS43dNzPuKR0TZprepoLgqL8dD+kKWF7yA9cJNsgLDuWAebQ
         0gfhz135PdhcmBO/tQ+4kqQB0rCDV9+w4pqCBPOlGYoT71nY1o7yaEyjkMRD7hBR1P5C
         yhPQ3G7yavjMpqxRD9NSxGBh3X0PbYCwpznGkB3NPHVGfrc0PBFT5fj7o+pFYkL6z117
         bVr0nUhG4ri8CNjgE/N7liJe66keFa5uc+KTxXZUTrXVXIUPyjeXYn3corPlUzoq8C+Z
         tqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MP9bWqLglik/G7ydzgpH6qxtoOPjTnKjIEZbq35U0w8=;
        b=q6PHRk7fWEuAk1+zQKhjja+g5Gk5ytYdQsx6GsVJ0xHloRmcBcnugeJ2Ai0Mcv1jtF
         h8H44Y1PUev1aDwEXPbGQhQmlrhxJG6gC8F0eyXS70m69UYdYC3wONzKvzrTavwodOq2
         DUWRlbob1Bmb8bcgOng4b6uHyuCkdrkV10yIq9CO34shz8LZLZziEdxAWNPJoU0iXWn7
         ELXx2MTlMzrGEouFMy7xwwfDmx9DF2vZpQAgvWAJrXlwMOd8wnh+xJaNYcfRP0VCbjOw
         DpvAGaadfrNAtN2cAGwQ6qzcft7tBDMsYacVnJsd8QGflmiSRPUpHhLN7z+WBUHjBBI/
         o3tA==
X-Gm-Message-State: APjAAAXQ0cmwts5bQHIVAlJMdSHYZu/JsmdvG5PYs3rdsu+nT0gjRqsp
        KFqt80T/ZaXXBi/DaUNNyrc=
X-Google-Smtp-Source: APXvYqxnzOd4PuafCgb1AfLhTACUQYfJQLs65HMwphdh3OAlLdZAE/tGNxyoyJ+8bK3MjIY85KClhg==
X-Received: by 2002:a63:2784:: with SMTP id n126mr99458545pgn.92.1564384245259;
        Mon, 29 Jul 2019 00:10:45 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id i124sm111028139pfe.61.2019.07.29.00.10.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 00:10:44 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Minchan Kim <minchan@kernel.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] mm: release the spinlock on zap_pte_range
Date:   Mon, 29 Jul 2019 16:10:37 +0900
Message-Id: <20190729071037.241581-1-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our testing(carmera recording), Miguel and Wei found unmap_page_range
takes above 6ms with preemption disabled easily. When I see that, the
reason is it holds page table spinlock during entire 512 page operation
in a PMD. 6.2ms is never trivial for user experince if RT task couldn't
run in the time because it could make frame drop or glitch audio problem.

This patch adds preemption point like coyp_pte_range.

Reported-by: Miguel de Dios <migueldedios@google.com>
Reported-by: Wei Wang <wvw@google.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/memory.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2e796372927fd..bc3e0c5e4f89b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1007,6 +1007,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct zap_details *details)
 {
 	struct mm_struct *mm = tlb->mm;
+	int progress = 0;
 	int force_flush = 0;
 	int rss[NR_MM_COUNTERS];
 	spinlock_t *ptl;
@@ -1022,7 +1023,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	do {
-		pte_t ptent = *pte;
+		pte_t ptent;
+
+		if (progress >= 32) {
+			progress = 0;
+			if (need_resched())
+				break;
+		}
+		progress += 8;
+
+		ptent = *pte;
 		if (pte_none(ptent))
 			continue;
 
@@ -1123,8 +1133,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	if (force_flush) {
 		force_flush = 0;
 		tlb_flush_mmu(tlb);
-		if (addr != end)
-			goto again;
+	}
+
+	if (addr != end) {
+		progress = 0;
+		goto again;
 	}
 
 	return addr;
-- 
2.22.0.709.g102302147b-goog

