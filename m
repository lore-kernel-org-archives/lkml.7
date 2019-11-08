Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2035FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2E820656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxvRK/XH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfKHT0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:26:35 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39698 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHT0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:26:35 -0500
Received: by mail-qk1-f201.google.com with SMTP id s3so7868254qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CkJ8BjIClBalW4Y8w4jj3zANoh6LyH1bD+0n/0uxb4s=;
        b=DxvRK/XHt9Ol7n7p5ISNiuBjXfbFXBOX5S8wdWgPBxQ7FEeX2sENsoymr4muRy1AVS
         bMIHbLqlBxqFtvFiQWhELfcdvUZF9qc80iNQLX5WhvuEmVaoNpy7zS0w6Cu0N+EzpzGx
         72eZ+Q8t8olFKWQihVixJ0+T1pKyMuP9zjBIsUDqp1vTSKllBxz5uqHU9PN2O1BAlEPX
         N4auhyMbYhUFtqk+NOgz9UzzpgiMnmXrjOdmlTaqJfXOUYWtaHuD1ch1AsSaCbLG01LP
         IHKb1awqa0gnT7qIxphP8Lpgr1tyq6Fpee4bM65068IjxdrMUwp5RlgYwy1rLisCDg6D
         K72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CkJ8BjIClBalW4Y8w4jj3zANoh6LyH1bD+0n/0uxb4s=;
        b=qjpuIm2NqnZDmXcQ2tUWHSVRFKCv8AWFlLZWh37UinTHhu6Lp0o/ASBgFuMrulMwl2
         6yLqtXV+mZgfoE1GUS1rPRwgnYKT8rhbvVB/dOlg4mgaUxYEk5Hi9lG0sx8qBwtxermB
         kqDGZDtYZnNykRVwx/R54fogurx8YgXnPYVH5sP299jywZ2hfK/jI4MHGQNkyci5Tpr7
         KZEaKiSEecq+RzTlUiTMjbMbDON1gJVkTqAUFBXj+PYz4E2s17zpGKDGJE5RrNEqbPAn
         BbBIA9aeKEPHIXLFE1oN+5qFaVgrsZpoZ8gbb8uH5hIwJ8mCLftmcZkbIAlCl1isLDfu
         1HeA==
X-Gm-Message-State: APjAAAUihi2hxrDYQFtHdCCxMOzK4Xfy0nZ7t12tsC1FJVOqRci4XFuU
        McdoJ5VuxSFALrEqO0PqxgsL/t54JiE=
X-Google-Smtp-Source: APXvYqysL+LzuTzAGpCWRV5hZJ/EIYvM6ZlPZycnNHVHeOUPhvj2NV66yrGjKf/4pBFV10bm6riOtOItdKw=
X-Received: by 2002:a05:620a:12b7:: with SMTP id x23mr10132390qki.31.1573241193752;
 Fri, 08 Nov 2019 11:26:33 -0800 (PST)
Date:   Fri,  8 Nov 2019 12:26:29 -0700
In-Reply-To: <20190825200621.211494-1-yuzhao@google.com>
Message-Id: <20191108192629.201556-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20190825200621.211494-1-yuzhao@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v2] mm: replace is_zero_pfn with is_huge_zero_pmd for thp
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For hugely mapped thp, we use is_huge_zero_pmd() to check if it's
zero page or not.

We do fill ptes with my_zero_pfn() when we split zero thp pmd, but
this is not what we have in vm_normal_page_pmd() --
pmd_trans_huge_lock() makes sure of it.

This is a trivial fix for /proc/pid/numa_maps, and AFAIK nobody
complains about it.

Gerald Schaefer asked:
> Maybe the description could also mention the symptom of this bug?
> I would assume that it affects anon/dirty accounting in gather_pte_stats(),
> for huge mappings, if zero page mappings are not correctly recognized.

I came across this while I was looking at the code, so I'm not aware of
any symptom.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a079f2..cf209f84ce4a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -654,7 +654,7 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	if (pmd_devmap(pmd))
 		return NULL;
-	if (is_zero_pfn(pfn))
+	if (is_huge_zero_pmd(pmd))
 		return NULL;
 	if (unlikely(pfn > highest_memmap_pfn))
 		return NULL;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

