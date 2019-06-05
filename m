Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE513C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE42020866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsKJodQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfFEJKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:10:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39511 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEJKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:10:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so9461056plm.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 02:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A0F5TwKY/VCSLcp+XKNpiRnciFopNfIc4l3QtF9bGnE=;
        b=qsKJodQeWHQrpBSUsCV/81Z7vFl9IiPrLe7Wx+TTMYwOb8vRhY7qMbyumwt8N6nzUp
         huDpz/WgJhGZQJNcubX5sDMOT5m/6LbguxcPIte89UJaj/B9lKADRPVtqIepVB+oX5sd
         hnXgkLK8L2MAW5lPvWDC99pJ4HSaC8QE332V5c6l5n9kmFfM5U7iJgD+3HoP8nJY6/oe
         T2TGY4+lUrdaa/iyrZ9+h1U0EN1aUJNorBJTwurwt7/FrvQoDKhFU75jWXstBB47BFp4
         vZG8Ouj9I7fWnXUOm8nkebeHXwU6K1NcK2iJ+B0SMP3aK6IXE+yb2bmKcQto4teTeueg
         RHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A0F5TwKY/VCSLcp+XKNpiRnciFopNfIc4l3QtF9bGnE=;
        b=fA5br/hzAN9IYWMvPcnXrm2Tas4QHys4d7+yV6XU77qXOYq9OEB+EJDOTuylcnJtlk
         QYNWb8YjbaYSFOFYjBS+LKjMhvbqOP1aOck3yjANWACjl/faMvUnVSKqoeDeavwKgMeo
         fj2oeYr2gK5xEdcU70JVxm5TxsL4i1A/Js61HBi+aOTHv5BCJAyz8YhYPl5up1MsWRyf
         RMk1lcd3c62hJ904nZJ0RmlIuy1fzoyGQM1F3jwvxiW5S6xQpfeTMxTZN/7G4QSMLpVu
         lpZbpQ3PQrwr1pqfjWCO41CmGozKsbRoS1hwEQsaH3ra5AFbUm6wHUd1SS+DZAdIl+wh
         jtlw==
X-Gm-Message-State: APjAAAVWf0EVia7eHPvj5i2XYA3a/+zuAd7BNpAQBhUeYaCS8Tt2J+a3
        9iHZ0mJdcxX6WRKYgm7gUA==
X-Google-Smtp-Source: APXvYqwPrprfYIFcfp2U4RhBi6aA36+dRA/hHPLVJndUrShnel3Up//HynanoblmvqR0aoxy92SoVg==
X-Received: by 2002:a17:902:624:: with SMTP id 33mr42733906plg.325.1559725842640;
        Wed, 05 Jun 2019 02:10:42 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w36sm11844525pgl.62.2019.06.05.02.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 02:10:39 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Subject: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
Date:   Wed,  5 Jun 2019 17:10:19 +0800
Message-Id: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
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
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index f173fcb..0e59af9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2196,6 +2196,26 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
 	return ret;
 }
 
+#ifdef CONFIG_CMA
+static inline int reject_cma_pages(int nr_pinned, struct page **pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pinned; i++)
+		if (is_migrate_cma_page(pages[i])) {
+			put_user_pages(pages + i, nr_pinned - i);
+			return i;
+		}
+
+	return nr_pinned;
+}
+#else
+static inline int reject_cma_pages(int nr_pinned, struct page **pages)
+{
+	return nr_pinned;
+}
+#endif
+
 /**
  * get_user_pages_fast() - pin user pages in memory
  * @start:	starting user address
@@ -2236,6 +2256,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 		ret = nr;
 	}
 
+	if (unlikely(gup_flags & FOLL_LONGTERM) && nr)
+		nr = reject_cma_pages(nr, pages);
+
 	if (nr < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
 		start += nr << PAGE_SHIFT;
-- 
2.7.5

