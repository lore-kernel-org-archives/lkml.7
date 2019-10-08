Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAC6ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AA82070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="aHdlB1za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfJHJPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:15:35 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:56136 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbfJHJPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:15:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 365FC3F68E;
        Tue,  8 Oct 2019 11:15:25 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=aHdlB1za;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PK8-sFKECaEf; Tue,  8 Oct 2019 11:15:20 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 0400A3F374;
        Tue,  8 Oct 2019 11:15:17 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 7E8FC3605CA;
        Tue,  8 Oct 2019 11:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570526117; bh=fG/GNjL9xDuyikgbRDOUKbeudoZ9IgG6ULIdrU+mLBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHdlB1zax3KqHtdg+12GqQ4xe9oZhVhb/iGc5X6UYUyemkpWGmKCluj2cofgOkrXW
         kxRjrliinZnszyw+Eec2OClT+3OLJFNSQ8QLK9Mlwa6IBTYHo2i32L7z7Tvl5z2Eot
         ZrDcqiN6xpMBg0l1Z6nFYhbPQ3xjmUh5UbMINoAs=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v4 2/9] mm: pagewalk: Take the pagetable lock in walk_pte_range()
Date:   Tue,  8 Oct 2019 11:15:01 +0200
Message-Id: <20191008091508.2682-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008091508.2682-1-thomas_os@shipmail.org>
References: <20191008091508.2682-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Without the lock, anybody modifying a pte from within this function might
have it concurrently modified by someone else.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 mm/pagewalk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index d48c2a986ea3..83c0b78363b4 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -10,8 +10,9 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t *pte;
 	int err = 0;
 	const struct mm_walk_ops *ops = walk->ops;
+	spinlock_t *ptl;
 
-	pte = pte_offset_map(pmd, addr);
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	for (;;) {
 		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
 		if (err)
@@ -22,7 +23,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		pte++;
 	}
 
-	pte_unmap(pte);
+	pte_unmap_unlock(pte - 1, ptl);
 	return err;
 }
 
-- 
2.21.0

