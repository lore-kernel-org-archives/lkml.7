Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32515C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3372146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcB3+mac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442046AbfIXXZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 19:25:19 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:50745 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393729AbfIXXZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:25:18 -0400
Received: by mail-qt1-f201.google.com with SMTP id x26so3919106qtr.17
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8TGliIBWPQiMc/dcK6U25tRYwGliMmayQocgS2bc3e4=;
        b=GcB3+maccc3yyJ68p6K6orlxKqatE32oUgshjiHKVZsaWKaPYUjICFK3v/zSYFr6jj
         35J0LEAaUV1gahRSD3uui0BgHElrdBfxTtpBQxXFu7nO5RAzCMsztrcDrBogams0wBLN
         /JSK0q+AGwo2zFh+eZemw25WwBDqVQ2E0U9BgNQgbKSe/VJvUp3AFssYHLlXr2IWcU3P
         w7UxVFKW43AAZIWrhAKtL/HJDQaYza9VlYGq+Fy8TOP/oU75vBbs4BpHhai4QYbNXl9E
         7E/F6h9+Y+3Tnt2l44lXRpFgq0POnIviT0Fy411wk//ApNDq4085CX6An4BQz+ubebij
         j1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8TGliIBWPQiMc/dcK6U25tRYwGliMmayQocgS2bc3e4=;
        b=Rq5+Gnkey6+HwJlgYiveiPDzEQrD+2koasaorEgrm5/HGd4a3r3UYpjXWgXCsjPAZl
         XLiNAk40NlGme60hOO/jA1uidhiG77p2t9B6TiyitleMYYbxY01RoZ0YF2OOEVtlZk+t
         ipbc64ye1gveKuNaOsye3vHJSwl0f+xblBN/0xKDU+M4EGZeABGaTc3TBXsXulDf+wQU
         7c0M7w7d0s3mNVrBbr2Kmkmlauds5pol2X70Y/+9+etr6j/4KQYpo78h06toyDIdL4bQ
         st6aVr2M9mAf9CLIZEeofVVtT0TukzlVlBDE3H+cpSru0FZZxOps1hx2Zm/TYrrdLn+O
         6ieQ==
X-Gm-Message-State: APjAAAVJSFKPjtC4c1RP51jqjIVgi0Jfjg4GMCOFeS7/yO0jv2w63O7n
        pw4gu5mwkVzCxpiuk7KijYyltfeRenM=
X-Google-Smtp-Source: APXvYqwqBI8fxarOPb9Kg9kSXeOK0+ZnCpMrgtm6xbNSOhZGZ6kttvBsIjy9TurHbnzhnJqkh7NowzV1lsk=
X-Received: by 2002:a0c:c251:: with SMTP id w17mr4701768qvh.226.1569367517179;
 Tue, 24 Sep 2019 16:25:17 -0700 (PDT)
Date:   Tue, 24 Sep 2019 17:24:56 -0600
In-Reply-To: <20190914070518.112954-1-yuzhao@google.com>
Message-Id: <20190924232459.214097-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20190914070518.112954-1-yuzhao@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v3 1/4] mm: remove unnecessary smp_wmb() in collapse_huge_page()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Lance Roy <ldr709@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <ziqian.lzq@antfin.com>,
        Omar Sandoval <osandov@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__SetPageUptodate() always has a built-in smp_wmb() to make sure
user data copied to a new page appears before set_pmd_at().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/khugepaged.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ccede2425c3f..70ff98e1414d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1067,13 +1067,6 @@ static void collapse_huge_page(struct mm_struct *mm,
 	_pmd = mk_huge_pmd(new_page, vma->vm_page_prot);
 	_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
 
-	/*
-	 * spin_lock() below is not the equivalent of smp_wmb(), so
-	 * this is needed to avoid the copy_huge_page writes to become
-	 * visible after the set_pmd_at() write.
-	 */
-	smp_wmb();
-
 	spin_lock(pmd_ptl);
 	BUG_ON(!pmd_none(*pmd));
 	page_add_new_anon_rmap(new_page, vma, address, true);
-- 
2.23.0.351.gc4317032e6-goog

