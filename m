Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B794C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3510721A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="X+y/07DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbfJJNlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:41:24 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:44104 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733228AbfJJNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:41:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 590523F598;
        Thu, 10 Oct 2019 15:41:19 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="X+y/07DC";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wl0QoKF-zCWb; Thu, 10 Oct 2019 15:41:18 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id E9AE93F58C;
        Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 7D18E36016C;
        Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570714877; bh=PbaGuh2AWzgR/QobTlpM3PYlJJowJXX6P7DMUtKFhwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+y/07DCYti5qO8GpDRx7v6qmNnd1qY4d+px/dYzGwT/xp4RIn7PYIWspQ0IqSV5k
         T4E+F8ZdO3cy4VxhktQQac/74KLcQaOPnohGoQXODFsAYS7v5WSu25HzRX1Bxm9r4R
         qTMpmKo7XQMCwVieRVRZ2yPsEEPBimGYbC3+eQ7M=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name
Cc:     Thomas Hellstrom <thellstrom@vmware.com>
Subject: [RFC PATCH 4/4] mm: mapping_dirty_helpers: Handle huge pmds correctly
Date:   Thu, 10 Oct 2019 15:40:58 +0200
Message-Id: <20191010134058.11949-5-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010134058.11949-1-thomas_os@shipmail.org>
References: <20191010134058.11949-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

We always do dirty tracking on the PTE level. This means that any huge
pmds we encounter should be read-only and not dirty: We can just skip
those. Write-enabled huge pmds should not exist. They should have been
split when made write-enabled. Warn and attempt to split them.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 mm/mapping_dirty_helpers.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 799b9154b48f..f61bb9de1530 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -115,11 +115,18 @@ static int clean_record_pte(pte_t *pte, unsigned long addr,
 static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
-	/* Dirty-tracking should be handled on the pte level */
 	pmd_t pmdval = pmd_read_atomic(pmd);
 
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
-		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
+	/*
+	 * Dirty-tracking should be handled on the pte level, and write-
+	 * enabled huge PMDS should never have been created. Warn on those.
+	 * Read-only huge PMDS can't be dirty so we just skip them.
+	 */
+	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
+		if (WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval)))
+			return 0;
+		return PAGE_WALK_CONTINUE;
+	}
 
 	return 0;
 }
-- 
2.21.0

