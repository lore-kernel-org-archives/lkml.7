Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4087C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B976421D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ell4lfoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfJBXDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:03:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40930 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfJBXDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:03:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so441372pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Kx1lQ6Xuj0lo4gXMSS/qxuv9enZ5ijN/jq6CI+qCygs=;
        b=Ell4lfoPjQ/U64uUNXZ1rWWz41pBKUiRnxxBUmzrplg1vOXSoFHUHs+cLMF4fl/2/I
         qhtxDkZZPYsZYz490rSFFz3RVb0eTfQV1FQChEZ7Rw7ohYw3TzvTpSl0c8t/nOTC2d8/
         qmZH0MYjsv4H4kGXvKG82vqQ0zkgVjGVe2IItfZzV5A2UwtbFV2v6TL7NmdILOV7z3mV
         PQv37bFpgeDQjoLjPcgLR4RQ62LjyU5mCxEi5bR8pOxOQdlFAENR7ZiqMZKdrdhv5C9f
         6CoapBroe9c3nzmT2bW0WiBc9QAIdHPlTLLRkEtc6Eu+346qX/M6s7tXNFGc+JwITWhR
         PiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=Kx1lQ6Xuj0lo4gXMSS/qxuv9enZ5ijN/jq6CI+qCygs=;
        b=RoMB/pcJWREQGD6pLNWFyeZvbDmTSy3JEl4UtRMS+HMFgxjP3Bfib1Q0FK7Si/eD/c
         HM7gQbRSrtiWMhATiPrPycJZ2yjDLJMvErCLt3phto5Jmni5XVjiFEiH/0w4Yor1/dQx
         OoShf4n1pVwaUnwWQZP3UZr1DuDlCJiK527NE+7hn4Dczi2xNsQPV4UtU3zVvZnbOOk1
         OvkAhxM4k8ZGdbz4z0YnPlP/6eVG4muoK7e9aj6u1MMsT9PkDhKBgztNZZ3i7bAZIP37
         9Jtvn+k1hoRvCwaR8/KE6DkSJSsAU7veiATafQaA9aPHYglYkTbfLBNxa05lHPCsKuL9
         jBsg==
X-Gm-Message-State: APjAAAVYOotTHe04lb7w4IOXZhHQOAz54taehOeYZ3pRoO3TG/C+Xxv0
        GhKW+zpKuxy6xENU1tBZ9Xg6uW6nOLI=
X-Google-Smtp-Source: APXvYqze6T/pvyncy2GIGKjzFCBiih1dWCjaT09cVEUfiHqI5i28yaqW2t6FRRhXydBoOryGEzmLnQ==
X-Received: by 2002:a17:90a:2301:: with SMTP id f1mr7086902pje.121.1570057385215;
        Wed, 02 Oct 2019 16:03:05 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id s1sm317223pjs.31.2019.10.02.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:03:04 -0700 (PDT)
Date:   Wed, 2 Oct 2019 16:03:03 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [rfc] mm, hugetlb: allow hugepage allocations to excessively
 reclaim
Message-ID: <alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugetlb allocations use __GFP_RETRY_MAYFAIL to aggressively attempt to get 
hugepages that the user needs.  Commit b39d0ee2632d ("mm, page_alloc: 
avoid expensive reclaim when compaction may not succeed") intends to 
improve allocator behind for thp allocations to prevent excessive amounts 
of reclaim especially when constrained to a single node.

Since hugetlb allocations have explicitly preferred to loop and do reclaim 
and compaction, exempt them from this new behavior at least for the time 
being.  It is not shown that hugetlb allocation success rate has been 
impacted by commit b39d0ee2632d but hugetlb allocations are admittedly 
beyond the scope of what the patch is intended to address (thp 
allocations).

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 Mike, you eluded that you may want to opt hugetlbfs out of this for the
 time being in https://marc.info/?l=linux-kernel&m=156771690024533 --
 not sure if you want to allow this excessive amount of reclaim for 
 hugetlb allocations or not given the swap storms Andrea has shown is
 possible (and nr_hugepages_mempolicy does exist), but hugetlbfs was not
 part of the problem we are trying to address here so no objection to
 opting it out.  

 You might want to consider how expensive hugetlb allocations can become
 and disruptive to the system if it does not yield additional hugepages,
 but that can be done at any time later as a general improvement rather
 than part of a series aimed at thp.

 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4467,12 +4467,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		if (page)
 			goto got_pg;
 
-		 if (order >= pageblock_order && (gfp_mask & __GFP_IO)) {
+		 if (order >= pageblock_order && (gfp_mask & __GFP_IO) &&
+		     !(gfp_mask & __GFP_RETRY_MAYFAIL)) {
 			/*
 			 * If allocating entire pageblock(s) and compaction
 			 * failed because all zones are below low watermarks
 			 * or is prohibited because it recently failed at this
-			 * order, fail immediately.
+			 * order, fail immediately unless the allocator has
+			 * requested compaction and reclaim retry.
 			 *
 			 * Reclaim is
 			 *  - potentially very expensive because zones are far
