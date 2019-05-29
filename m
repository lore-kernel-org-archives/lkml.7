Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0823C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CB8242BC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2m6pNEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE2Wyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:54:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39527 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2Wyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:54:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so756053pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 15:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jSKQLZwrhmnSigLvBb1y7bTu3QweUmRNvIXEtuAqha8=;
        b=i2m6pNEp//jAEdoVKlUepZrqCrxOeGMnhLpqIgwHYjCZuF1j3b+HZSW8SKuGwf1zDt
         0bhyfZQPgyaivPOywVbLs91S4hzEVqMfYIG3C5qkLNxgmWMxMkjSo7UKUzLzHVsKOgvb
         2r2aceu5kfodmmZkfuuAz0O4G4lZv5m/9XI0on/lp9xeE60SF9e+JH3tFD3v0ohkBZoV
         w+7veRU2N4ilJsskcWqJRw3UYj6ram4axcu3rhFFM6R8kQJtHkKuJlk17BYP4tYHHjY9
         Ye2nbDpDWlhbhMpO7j+4cMkzYkUwtNMixcy88LTT3FUX0DPvQNzrI/nWRZXRQqSH6+ix
         kraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jSKQLZwrhmnSigLvBb1y7bTu3QweUmRNvIXEtuAqha8=;
        b=FqKogu9YQtULHaa3x1zJVakdduC1zs1t+DaJ5Zl0TPiLpp9O94ZFFOxRIjRyRCuWfq
         n1XACy/wx5cTSpqA/Mu9LuAJrQBliCrvkZvV17RU4VgkWTRvZY1CPaycH8AalEOF7yik
         QODRLjeXXEBD+5cxRgBLnM4xi6oJiRnjj6LfbUqxrMWsidrgiPt/4mhs9KajwxtA5MvX
         rEOuUyVLW5JcU0MECpM2na2mXCfuvxHh2bO6KUV0cO6s0ofZDhrXUQE78PYGWideBMT/
         wH8FeB+PUdzFkp2cQTOL/ZiYOLNcwf5Mhap5UoN2QfhaZU+MIEQqA5Un/Z52RWQYhPfw
         1ZKQ==
X-Gm-Message-State: APjAAAVNEbe58EcUVeJQFjI/m2t2GaTc4466z5McjgaBSO1M5rVPA2Q9
        OR4bwGkartFKtuqzQI/AvA==
X-Google-Smtp-Source: APXvYqwxpupc9N7njSo6f+msnHvsDLFKL5Sq7Tzn0RujPl74omIALXvHB2HQqQuQvOJWf8s9Yh/43Q==
X-Received: by 2002:a63:d157:: with SMTP id c23mr504819pgj.125.1559170471934;
        Wed, 29 May 2019 15:54:31 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:782a:8650:1229:85cd:500a:f525])
        by smtp.gmail.com with ESMTPSA id e12sm690266pfl.122.2019.05.29.15.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 15:54:31 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
Date:   Thu, 30 May 2019 06:54:04 +0800
Message-Id: <1559170444-3304-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for FOLL_LONGTERM, it is checked in the slow path
__gup_longterm_unlocked(). But it is not checked in the fast path, which
means a possible leak of CMA page to longterm pinned requirement through
this crack.

Place a check in the fast path.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index f173fcb..00feab3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2235,6 +2235,18 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 		local_irq_enable();
 		ret = nr;
 	}
+#if defined(CONFIG_CMA)
+	if (unlikely(gup_flags & FOLL_LONGTERM)) {
+		int i, j;
+
+		for (i = 0; i < nr; i++)
+			if (is_migrate_cma_page(pages[i])) {
+				for (j = i; j < nr; j++)
+					put_page(pages[j]);
+				nr = i;
+			}
+	}
+#endif
 
 	if (nr < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
-- 
2.7.5

