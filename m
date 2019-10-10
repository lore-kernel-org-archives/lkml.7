Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D442C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD352067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="ijWXaZYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbfJJNlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:41:23 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:23236 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfJJNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:41:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 5038F3F662;
        Thu, 10 Oct 2019 15:41:19 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=ijWXaZYo;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JuFPudYhk_3z; Thu, 10 Oct 2019 15:41:18 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id EBF0D3F247;
        Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 2C952360ED5;
        Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570714877; bh=xEUu8V1jmdy0b1JnfsdE1ixgai5iPm/a0UL1Js6USpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijWXaZYo+2T/KF/TFThEJ4/Jb8vCSvNjD316eFCovtyF5dIhD6is1nn8Kn78Yp1wl
         109pQPDHWw2KQATIc41ioJqlpOP16P7BQjGrKD72PtUYMLh1D9cydzTUygDh0D4Xbp
         cSmgxlrMIlSAK3nmcoPyIrQVjCSCd17RHCyvyuIs=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name
Cc:     Thomas Hellstrom <thellstrom@vmware.com>
Subject: [RFC PATCH 1/4] mm: Have the mempolicy pagewalk to avoid positive callback return codes
Date:   Thu, 10 Oct 2019 15:40:55 +0200
Message-Id: <20191010134058.11949-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010134058.11949-1-thomas_os@shipmail.org>
References: <20191010134058.11949-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

The pagewalk code is being reworked to have positive callback return codes
do walk control. Avoid using positive return codes: "1" is replaced by
"-EBUSY".

Co-developed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 mm/mempolicy.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4ae967bcf954..df34c7498c27 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -482,8 +482,8 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
  *
  * queue_pages_pte_range() has three possible return values:
  * 0 - pages are placed on the right node or queued successfully.
- * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
- *     specified.
+ * -EBUSY - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
+ *          specified.
  * -EIO - only MPOL_MF_STRICT was specified and an existing page was already
  *        on a node that does not follow the policy.
  */
@@ -503,7 +503,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	if (ptl) {
 		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
 		if (ret != 2)
-			return ret;
+			return (ret == 1) ? -EBUSY : ret;
 	}
 	/* THP was split, fall through to pte walk */
 
@@ -546,7 +546,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	cond_resched();
 
 	if (has_unmovable)
-		return 1;
+		return -EBUSY;
 
 	return addr != end ? -EIO : 0;
 }
@@ -669,9 +669,9 @@ static const struct mm_walk_ops queue_pages_walk_ops = {
  * passed via @private.
  *
  * queue_pages_range() has three possible return values:
- * 1 - there is unmovable page, but MPOL_MF_MOVE* & MPOL_MF_STRICT were
- *     specified.
  * 0 - queue pages successfully or no misplaced page.
+ * -EBUSY - there is unmovable page, but MPOL_MF_MOVE* & MPOL_MF_STRICT were
+ *	    specified.
  * -EIO - there is misplaced page and only MPOL_MF_STRICT was specified.
  */
 static int
@@ -1285,7 +1285,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	ret = queue_pages_range(mm, start, end, nmask,
 			  flags | MPOL_MF_INVERT, &pagelist);
 
-	if (ret < 0) {
+	if (ret < 0 && ret != -EBUSY) {
 		err = -EIO;
 		goto up_out;
 	}
@@ -1303,7 +1303,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 				putback_movable_pages(&pagelist);
 		}
 
-		if ((ret > 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
+		if ((ret < 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
 			err = -EIO;
 	} else
 		putback_movable_pages(&pagelist);
-- 
2.21.0

