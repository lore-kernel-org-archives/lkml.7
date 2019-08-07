Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11B6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895F42238C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlUPUw8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbfHGIlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:41:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37179 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfHGIlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:41:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so39740310plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EyvgUT/mHFqMk636dxzLzzgFDS37eM5CM15yX+1C0h4=;
        b=OlUPUw8OMiKKCWaFUHD6Ldd8xeESIBSCde7fJSBGlkMgtMtAXAF0V5RYNm/uBNjNWk
         SccP1cbUdZ1EMPUBm8h4Wqkr76glmchV0EXc+DlVxTNTNUWLZ2ZuSIcm2KyNqzBmoR53
         CANTzvzY66eGU1DHo0OhI/Pna9FHVKCFPxPBSxoiMZNTSCn7Mi9iSqn/u4D3mVWELc07
         g6J5hQQJK3EK5PAUyg3ZNM4KKjC/cfggdgAjUhK8PwHfdyjNAk8tCfyfAOhWZLkIdqBB
         P3RBckcsZrkxQEJ925kS0ZzxNlibQDNST4aGHHnFvSj7lYJsBj5VAhRVhwO8nRdeveDd
         Ytjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EyvgUT/mHFqMk636dxzLzzgFDS37eM5CM15yX+1C0h4=;
        b=ZWVmoyzV/m0lmW26Ivh4/Us71rTVecqF2EnXjS0Yw3PiZQhqF23f/p6VOpxUs7d0KG
         PCGcWSzTguYUY4D2dlIXcqQPJfyS+6jK9V9q26qU3ZlA4e7FbBLZq2QB55dpexc9BDvP
         RijR2ZbcCtl+DV6YRWNcYhyBMYNJIUV/FzL35TAq8mZaLhSw07AE0FL/ZxOHdKhSwZoH
         PS+BS2G8cADpOhSkyO59Qy6ZkqxABqFJzB3kPofhc3H4WtMu56KvvLgtVcuH2iaSOtwQ
         yEqAAFDRLKnrUG0RHj9AEZRehg4W+GfvJSHooAlr4P84Kow4tD2UFaK9R7/K8yQJmWlZ
         xDtw==
X-Gm-Message-State: APjAAAWn3AqgRw8I1VcP3hDhPoe4M8LzfzfmDTntBNln1yC30oSPPaXq
        e9olvZQC87lFZiwTQNwuuA==
X-Google-Smtp-Source: APXvYqw/n0QlPhHlhzhx9MFD9LDM+HAokHgsvQnV1xpG/W+ICmOn7xen/JNe40OAfwcvozRxSVEMcQ==
X-Received: by 2002:a63:f048:: with SMTP id s8mr6613569pgj.26.1565167301983;
        Wed, 07 Aug 2019 01:41:41 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f19sm135030521pfk.180.2019.08.07.01.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 01:41:41 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2] mm/migrate: clean up useless code in migrate_vma_collect_pmd()
Date:   Wed,  7 Aug 2019 16:41:12 +0800
Message-Id: <1565167272-21453-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <20190807052858.GA9749@mypc>
References: <20190807052858.GA9749@mypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up useless 'pfn' variable.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Jan Kara <jack@suse.cz>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/migrate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8992741..d483a55 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2225,17 +2225,15 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		pte_t pte;
 
 		pte = *ptep;
-		pfn = pte_pfn(pte);
 
 		if (pte_none(pte)) {
 			mpfn = MIGRATE_PFN_MIGRATE;
 			migrate->cpages++;
-			pfn = 0;
 			goto next;
 		}
 
 		if (!pte_present(pte)) {
-			mpfn = pfn = 0;
+			mpfn = 0;
 
 			/*
 			 * Only care about unaddressable device page special
@@ -2252,10 +2250,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			if (is_write_device_private_entry(entry))
 				mpfn |= MIGRATE_PFN_WRITE;
 		} else {
+			pfn = pte_pfn(pte);
 			if (is_zero_pfn(pfn)) {
 				mpfn = MIGRATE_PFN_MIGRATE;
 				migrate->cpages++;
-				pfn = 0;
 				goto next;
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
@@ -2265,10 +2263,9 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 		/* FIXME support THP */
 		if (!page || !page->mapping || PageTransCompound(page)) {
-			mpfn = pfn = 0;
+			mpfn = 0;
 			goto next;
 		}
-		pfn = page_to_pfn(page);
 
 		/*
 		 * By getting a reference on the page we pin it and that blocks
-- 
2.7.5

