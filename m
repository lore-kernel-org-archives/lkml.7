Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FBFC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8907727BFC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhMamTU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfFCGeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:34:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46951 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfFCGeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:34:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so7661049pgr.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 23:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CBsIkBvODy2SMAroMU4TmKj7JDPTiCcRWf3bIgO8CHE=;
        b=BhMamTU0Mc/0EVu+/M0cSdxLSLtdEF4XdEDqq7cwIDqJ7R77OQ6DzkQx8nK1FEbT1z
         4eBywr+SqVgYb04iLdG+/a8DSBrlu5KiO5U47jSQVrXKBW1a0G34o5ggzIhiREoNDvlk
         7M2jOQlgXRYFa/bV2ss2jvJvHnZyl4wT68FX+ihBeaCkm09Yb4Ju5jSl+ni/0sz7yb14
         XSCCuNn4L/L0f3REr3TwEheSyYh34Nfgs9BmZaviqWTlA6thycR71efgcT7PEou8I13m
         9OPKCF0lbheyuixt8G7ahGo4tYBS65QA2LNGZU6zYTHpXQKOStN9Cu5ITqVI21372TMD
         Q8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CBsIkBvODy2SMAroMU4TmKj7JDPTiCcRWf3bIgO8CHE=;
        b=Nk6QkT3iDyWeUyr1bsCGY+hPrVZlPzNvzmqV3HBOoseX81LI48djsfklEmaNfvwdFv
         989RulLn+ijQMIT7qQWLNoVwBQbyR5w797AMuUgoQzxxoAgl+juxCS+mY106qf++3oBD
         3oDQmHGRHPt2awrORn6NSb248OkwgvqSJBayYsWFojgfhT09yU3HZQt0dTF89xugajIG
         QCkT/d+5HCwfgfHwsrKQPxOXQZmai3NNK1P5YFvo01xM+hjwBsSKvE3O5BrwEKfh3oU/
         i4eWB8U9nBc2HsemobM3zNBNlCUgCcyK49+yAmJUWD3AoZs3NdkJSGsnDtwK9ktaUom+
         piJg==
X-Gm-Message-State: APjAAAUKmTJ+pVHh2VIsJG4w+qy3dZ6AVs+d2qg1dxxO81OJWuMUrzoI
        dlmBw5Tlr+9nrxS4BSijKA==
X-Google-Smtp-Source: APXvYqwQ1TToPxYTZgvBH7nocMRSyjS+MAPRo/77b8NkuXiJ+gfrhgYYiGq1j9IXEVMHW9lP+JJuTw==
X-Received: by 2002:a65:518d:: with SMTP id h13mr25383136pgq.186.1559543670700;
        Sun, 02 Jun 2019 23:34:30 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j14sm13859027pfe.10.2019.06.02.23.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 23:34:30 -0700 (PDT)
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
Subject: [PATCHv2 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
Date:   Mon,  3 Jun 2019 14:34:12 +0800
Message-Id: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
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
 mm/gup.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index f173fcb..6fe2feb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2196,6 +2196,29 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
 	return ret;
 }
 
+#if defined(CONFIG_CMA)
+static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
+	struct page **pages)
+{
+	if (unlikely(gup_flags & FOLL_LONGTERM)) {
+		int i = 0;
+
+		for (i = 0; i < nr_pinned; i++)
+			if (is_migrate_cma_page(pages[i])) {
+				put_user_pages(pages + i, nr_pinned - i);
+				return i;
+			}
+	}
+	return nr_pinned;
+}
+#else
+static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
+	struct page **pages)
+{
+	return nr_pinned;
+}
+#endif
+
 /**
  * get_user_pages_fast() - pin user pages in memory
  * @start:	starting user address
@@ -2236,6 +2259,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 		ret = nr;
 	}
 
+	nr = reject_cma_pages(nr, gup_flags, pages);
 	if (nr < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
 		start += nr << PAGE_SHIFT;
-- 
2.7.5

