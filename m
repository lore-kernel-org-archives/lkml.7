Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849E6C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E5F206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYU4x/H5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbfFMPdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:33:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41116 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbfFMKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:45:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so7959788plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f93IclPUPcs3Bt3TjEqqUNMcFkImDI5CNRnqLCqc+P8=;
        b=BYU4x/H5A/U1vDb2iAJXDaxX8mJ03+iBLBS2s7wEPWjYRW/6/REj+tyFh+ON5yPvJo
         tiCoiYOkqYP+kp556mYNnSX3QOkg5moTm3N6xbZw/Yrrj8L8vCoFdZF01ln2Kg1TSJ20
         l8yyAkVj8u1bv0D1tNhG8nVVbabbFkU6NKgh91Yw/+sfinCHWixpfmjN3+L8OCqLFdT5
         QtU1EFgQvcT1b2S+3dIO4h7MkzFXjGN/IczhQ4oDdb75vFwLc5ZAgem35ipiyzKI9zPX
         VpM54MBVxi/MPr7DE9sfD6fGln7FmUlJGPt2eA9X1qTtZGyKbN356+9p/3dkHHqR5suj
         WN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f93IclPUPcs3Bt3TjEqqUNMcFkImDI5CNRnqLCqc+P8=;
        b=kFQD353c4tlw35rjoaoE/D0nblkY5yRkoPFzhAlg52T68NQLviJKl0XYcniwN/7Mcd
         HtPfEedgSANYO/p5lgVsAS6jp6/Yl3Ps9MbWhAxl2SwFyH2ta7hx0+8ec19S7ujzMs1I
         SKgppusRECtyidBhCVsMmQhbcr+JModV01gZxQAd7sX7A2lkZh1WdmACZM34HBxV/kNV
         jrYKjXOzIe0zLusfZ1sLW6Xv59QaQ751RexUsg0Jb/OmjS/mNro3Y+6+w6hdWM+MaRbh
         Us7dzWul7KTcbjG/AJui2c5+lBtd1KluoO6W4yJN6QpSjLJUKUevTcQJOvSojZrJnjm+
         06bw==
X-Gm-Message-State: APjAAAVo87VRlt/TE1FlBXw7WoANaH/4tt47pgkmdBvsbs4iMv0Hv/AQ
        ZeRQsMi8zqp9mb2tOvzqzw==
X-Google-Smtp-Source: APXvYqzjzG1IExx5QhEFhc3PhY3IWUPkhfXxSPgDIyhVJDO97u6bC7ct5htX5h5CIaSIaAPehBv3WA==
X-Received: by 2002:a17:902:b695:: with SMTP id c21mr34964938pls.160.1560422749562;
        Thu, 13 Jun 2019 03:45:49 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:7825:dd90:9051:d949:55f9:678b])
        by smtp.gmail.com with ESMTPSA id a13sm2813285pgh.6.2019.06.13.03.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 03:45:48 -0700 (PDT)
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
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCHv4 1/3] mm/gup: rename nr as nr_pinned in get_user_pages_fast()
Date:   Thu, 13 Jun 2019 18:45:00 +0800
Message-Id: <1560422702-11403-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1560422702-11403-1-git-send-email-kernelfans@gmail.com>
References: <1560422702-11403-1-git-send-email-kernelfans@gmail.com>
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
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f173fcb..766ae54 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2216,7 +2216,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
 {
 	unsigned long addr, len, end;
-	int nr = 0, ret = 0;
+	int nr_pinned = 0, ret = 0;
 
 	start &= PAGE_MASK;
 	addr = start;
@@ -2231,25 +2231,25 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 
 	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_disable();
-		gup_pgd_range(addr, end, gup_flags, pages, &nr);
+		gup_pgd_range(addr, end, gup_flags, pages, &nr_pinned);
 		local_irq_enable();
-		ret = nr;
+		ret = nr_pinned;
 	}
 
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

