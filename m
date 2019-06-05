Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09929C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28AC2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8PDFRD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfFEJKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:10:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45397 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEJKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:10:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so12027520pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qe2qEqCwB2kLhiPVN6wzjgcS8llGOmV8LcU4p/YtuR0=;
        b=k8PDFRD65GfqIRKyHH1gKGhC28AUBf1rIqpRtBVKZkFOyfSofJ+xIM+bLtiUdsa1ig
         BfBeMXE4TTb+OvlBSRfaFAWMxhPvW7zD7u0gshBiyiG+f/AP+hFcw5/3p//x5e6yNF8i
         iPCPlE6TLiaKPZK4piGiEE9Pkzh5T8527HyNmPxS/jzZbdznDq+UHq0PUsYFS68PCjVH
         c6haPJ8Zsy54mqCByUbYktyztQAztfiraWDZZawfYhmUvogLTVoFiPHNA4cKvrB/L4eM
         ZBGGJxngz4OmNGVs5i1rAmncPcv9RqFAq3rg7aA50c5lr/VrCFjmg28FjvRrq5P13Hx3
         Xgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qe2qEqCwB2kLhiPVN6wzjgcS8llGOmV8LcU4p/YtuR0=;
        b=YX08LWNF108vlP6HkfEoDkXyAbxOImJaXNmtsTv1FOvhYSPvXqbkkSx4qvA/xrvdee
         UrWgACkp8deXvsRUjrRibZNLKQYdSBzBxsnhyDngpULf6sKYoRrmpDTvcCcb0pZE0Sdf
         rgfYUsf+vAWFTq8jy5sg2mkyZmEx4/glkrmlgAGy+e9I4DXNdYGi61jVJWMq+Udk1EZi
         ApX/vH67oglhYxtMziMkCVvpoGa5xOytXvqrTYiXHNWzXD9euQDQHHZ+VT4G4307zxtm
         kYnXzXm5iK9fhhhew1CXumTTzPeQN5OVMbiTup5I34vekgzAjJIp86soTNxVHndCCJDU
         NDeQ==
X-Gm-Message-State: APjAAAVdCxFCy/MfUzPFxAEBj5ZbACkut591FhEYlpwfKWEgL9zZC3+T
        5Q2RHFyFJYKwnICJd5/RqThyig0=
X-Google-Smtp-Source: APXvYqxhrX6wAssVXs2ZclXfwzF30GmChMOrWvQir8bDvycAg5gzUgp1/7H0hRmAZ6tIjdILLAT+Sg==
X-Received: by 2002:a63:4c54:: with SMTP id m20mr2997813pgl.316.1559725847045;
        Wed, 05 Jun 2019 02:10:47 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w36sm11844525pgl.62.2019.06.05.02.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 02:10:46 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3 2/2] mm/gup: rename nr as nr_pinned in get_user_pages_fast()
Date:   Wed,  5 Jun 2019 17:10:20 +0800
Message-Id: <1559725820-26138-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To better reflect the held state of pages and make code self-explaining,
rename nr as nr_pinned.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 0e59af9..9b3c8a6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2236,7 +2236,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
 {
 	unsigned long addr, len, end;
-	int nr = 0, ret = 0;
+	int nr_pinned = 0, ret = 0;
 
 	start &= PAGE_MASK;
 	addr = start;
@@ -2251,28 +2251,28 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 
 	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_disable();
-		gup_pgd_range(addr, end, gup_flags, pages, &nr);
+		gup_pgd_range(addr, end, gup_flags, pages, &nr_pinned);
 		local_irq_enable();
-		ret = nr;
+		ret = nr_pinned;
 	}
 
-	if (unlikely(gup_flags & FOLL_LONGTERM) && nr)
-		nr = reject_cma_pages(nr, pages);
+	if (unlikely(gup_flags & FOLL_LONGTERM) && nr_pinned)
+		nr_pinned = reject_cma_pages(nr_pinned, pages);
 
-	if (nr < nr_pages) {
+	if (nr_pinned < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
-		start += nr << PAGE_SHIFT;
-		pages += nr;
+		start += nr_pinned << PAGE_SHIFT;
+		pages += nr_pinned;
 
-		ret = __gup_longterm_unlocked(start, nr_pages - nr,
+		ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned,
 					      gup_flags, pages);
 
 		/* Have to be a bit careful with return values */
-		if (nr > 0) {
+		if (nr_pinned > 0) {
 			if (ret < 0)
-				ret = nr;
+				ret = nr_pinned;
 			else
-				ret += nr;
+				ret += nr_pinned;
 		}
 	}
 
-- 
2.7.5

