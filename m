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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E61EC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D7227C03
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeweOGjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFCGef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:34:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37167 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfFCGef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:34:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh12so497842plb.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R+hQLAUcVNWROrMbU90MxMOWiIFmUVyPvMT6jkT1W4o=;
        b=JeweOGjjlqVIH0KxKJuMpIq1jSl5UooWsZl6FxhuW8sb2MrVdCeODLdOoT53EObqUZ
         4qjqklXB8sKCdnrChJYqiO2zwJFomiMOlfWPl/vGQHgSbOXLj/ZLI63GKQJPmNc16MiQ
         Gtu2Zndm8bSdcTbZ5IgIceYQ0+Y0UKAGwEDJEBVLuPfmUidBnMkozY/geDaUTJLyDzRS
         9Ad79TVjhULakP38inxlO4HWvIVyy/C0Z2vuFCmg8zNuXIz0ARsxoWQ1M1PdLU0fVXQ8
         +bV2Y1lvl8+TzKbz1LCnhDqSfNI1mwsALbONIGIuSbcLgLiaYXVT+Dh4vKyRBKAGJS9L
         wOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R+hQLAUcVNWROrMbU90MxMOWiIFmUVyPvMT6jkT1W4o=;
        b=mS9zMZ4IWF21sGXLxdz48gCz2MbR8d63o9d6Ao1RwQJfZSJJu6hDOa69fwaKYSzQIU
         mJNYvl1opluW3NEbMLiJwgzMK25MqpwQmRIa5R7y8hkcuuZoC+RAi/n0QJglp87cMG4u
         uimiHuljJMgM5/0ZNLEG9EquLYgHEeMkBCbgQWGZqZUh445Tkrs3au5541nnUoLGJEVR
         gz1UkCVRTSZVmxLF6lJIeaWimGMp8+eBU1qDh8BSmrmG/AF+qyLdk2Gp9un3REUXGdkt
         dkfaFShql7/OPlaR6NVNLHlPZcPO6XXiaBiJqSKs9Vx1B8GFlOnuQJi6L2tm9sYp3Rpk
         8JkQ==
X-Gm-Message-State: APjAAAUR8NBCL0Lq3us2qH4Ra0pCo59rpp5vgjN2eDGsseeMv9ZPcFt6
        yTCPCQ0Mw8UzfbVe+icXhw==
X-Google-Smtp-Source: APXvYqzm7+kJNYspgi7GV1P/I+D5ucOoLPIk/Mc2TPSNdzWzx+ipIDi9/crR7STfyeeK+Yteix/HFg==
X-Received: by 2002:a17:902:4381:: with SMTP id j1mr27518004pld.286.1559543674435;
        Sun, 02 Jun 2019 23:34:34 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j14sm13859027pfe.10.2019.06.02.23.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 23:34:34 -0700 (PDT)
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
Subject: [PATCHv2 2/2] mm/gup: rename nr as nr_pinned in get_user_pages_fast()
Date:   Mon,  3 Jun 2019 14:34:13 +0800
Message-Id: <1559543653-13185-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
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
Cc: linux-kernel@vger.kernel.org
---
 mm/gup.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 6fe2feb..106ab22 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2239,7 +2239,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
 {
 	unsigned long addr, len, end;
-	int nr = 0, ret = 0;
+	int nr_pinned = 0, ret = 0;
 
 	start &= PAGE_MASK;
 	addr = start;
@@ -2254,26 +2254,26 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 
 	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_disable();
-		gup_pgd_range(addr, end, gup_flags, pages, &nr);
+		gup_pgd_range(addr, end, gup_flags, pages, &nr_pinned);
 		local_irq_enable();
-		ret = nr;
+		ret = nr_pinned;
 	}
 
-	nr = reject_cma_pages(nr, gup_flags, pages);
-	if (nr < nr_pages) {
+	nr_pinned = reject_cma_pages(nr_pinned, gup_flags, pages);
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

