Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7F1ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C6C21835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="q/SEdriY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfJNNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:22:32 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:54107 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbfJNNWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:22:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id C6DB73F58C;
        Mon, 14 Oct 2019 15:22:23 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=q/SEdriY;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KCgbYllgGzX0; Mon, 14 Oct 2019 15:22:14 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id CCB333F4F6;
        Mon, 14 Oct 2019 15:22:12 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 4030D36804F;
        Mon, 14 Oct 2019 15:22:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571059332; bh=MLTPxtmk8SNu7SqpZRtwqOhnHm70c4ID2d03exwGJCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/SEdriY4bbDKRccK6gaviO34AVRogpexYWtt2du0BxGMBNrt3FtYIqZFaAMzeiBT
         YH7iJw9UBo3wmDlco/+RzpN7HR3KRiJ2qRx56+S08IG6MFNojXwQVZg1DQyveO2mCU
         RFK0Eu3IVtTWeqIlvxUjUB1slwv/K25ABivksWqg=
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v6 2/8] mm: pagewalk: Take the pagetable lock in walk_pte_range()
Date:   Mon, 14 Oct 2019 15:21:58 +0200
Message-Id: <20191014132204.7721-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014132204.7721-1-thomas_os@shipmail.org>
References: <20191014132204.7721-1-thomas_os@shipmail.org>
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
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/pagewalk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index d48c2a986ea3..c5fa42cab14f 100644
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
+	pte_unmap_unlock(pte, ptl);
 	return err;
 }
 
-- 
2.20.1

