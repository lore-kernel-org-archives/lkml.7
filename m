Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EC6C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB1F21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaXZcevV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDEWMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:12:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34744 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDEWMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:12:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so3743504plt.1;
        Fri, 05 Apr 2019 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6vIqu5AbJXGwURZ/x1P8u+8ZQ7uFngKRtabwAKH4lKk=;
        b=AaXZcevVbqDJKo2yhUTaeeyqT+FTQEuobGRmKBpkrnlthtbbFwFfypEu9jOhKsOZVg
         +UQg5E3SMZaW1yQbl+/bMWebkz3hqP+amJzksTp1Xk+xPQ1Tb7FOPWc5hbhHb+HrFUKK
         p5ipXJf1eh3E4jHx1C1M2hiNS6fZ3/ssDYIwP9d3dX4BCOcO0TLkQVwHa5m+h2ErwDiV
         rMbb/4KnTVKGmNTp1P5LdesEJvIf/3JGmSqPTDA1KASfjtIRyJfWjfeFv6lFof5ZwOO7
         Wj1zx/qvHFJ2P7xjAH+VL7STVAkgMnpH6EVVOld6EgnSIlH6SYiEawhLbvIDXfAglLkC
         MmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6vIqu5AbJXGwURZ/x1P8u+8ZQ7uFngKRtabwAKH4lKk=;
        b=YA9j9G6vYigUH0Rnnm4YWZ5zjTA4G3rE5MzWitkk9lIkIXvf9Cd+J8+dEqwgc/c5RL
         sFJDCqT5TLMf4/tR/mWsxXUzK4f0jPblo9Wel9xg6XlflJPxM20A1tMzKhy0kzVOinrR
         Y5F5yyIBAssR3gZ3pDyEqHsa2WBK+mmwP4DqHFWGCsKelMYvN+zsF8GqTilceg0hvHpn
         TjXcHmU3fETS6CqhAhz036ntIF/zwQGkLV79ZePUaUeDEC82iZrc+unX51GocdCdLkLG
         2goVvgvTl95vAJ694g51EVA0KKppKO0BkC/VoTHB80zsNOGxLVRlTghMbfy66I5DDbC3
         DCcw==
X-Gm-Message-State: APjAAAXQ7ThirvFd/CnmSPADFH5xV81NnwCVD0xh0mDf3RF0v3jQPjtu
        S0pgsYAyQ75Vh1Gl3+0jA/P3SMha
X-Google-Smtp-Source: APXvYqwDFkg3s634IuCt/DDVsGVay2lJjERO15hTE9pSPT4JufXw1seluZxsaXsAI68OURcCjqb39A==
X-Received: by 2002:a17:902:758d:: with SMTP id j13mr15626076pll.44.1554502334418;
        Fri, 05 Apr 2019 15:12:14 -0700 (PDT)
Received: from localhost.localdomain (50-126-100-225.drr01.csby.or.frontiernet.net. [50.126.100.225])
        by smtp.gmail.com with ESMTPSA id h11sm26078686pgq.57.2019.04.05.15.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 15:12:13 -0700 (PDT)
Subject: [mm PATCH v7 1/4] mm: Use mm_zero_struct_page from SPARC on all 64b
 architectures
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, linux-nvdimm@lists.01.org,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, mingo@kernel.org, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        davem@davemloft.net, kirill.shutemov@linux.intel.com
Date:   Fri, 05 Apr 2019 15:12:13 -0700
Message-ID: <20190405221213.12227.9392.stgit@localhost.localdomain>
In-Reply-To: <20190405221043.12227.19679.stgit@localhost.localdomain>
References: <20190405221043.12227.19679.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Use the same approach that was already in use on Sparc on all the
architectures that support a 64b long.

This is mostly motivated by the fact that 7 to 10 store/move instructions
are likely always going to be faster than having to call into a function
that is not specialized for handling page init.

An added advantage to doing it this way is that the compiler can get away
with combining writes in the __init_single_page call. As a result the
memset call will be reduced to only about 4 write operations, or at least
that is what I am seeing with GCC 6.2 as the flags, LRU pointers, and
count/mapcount seem to be cancelling out at least 4 of the 8 assignments on
my system.

One change I had to make to the function was to reduce the minimum page
size to 56 to support some powerpc64 configurations.

This change should introduce no change on SPARC since it already had this
code. In the case of x86_64 I saw a reduction from 3.75s to 2.80s when
initializing 384GB of RAM per node. Pavel Tatashin tested on a system with
Broadcom's Stingray CPU and 48GB of RAM and found that __init_single_page()
takes 19.30ns / 64-byte struct page before this patch and with this patch
it takes 17.33ns / 64-byte struct page. Mike Rapoport ran a similar test on
a OpenPower (S812LC 8348-21C) with Power8 processor and 128GB or RAM. His
results per 64-byte struct page were 4.68ns before, and 4.59ns after this
patch.

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 arch/sparc/include/asm/pgtable_64.h |   30 --------------------------
 include/linux/mm.h                  |   41 ++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 1393a8ac596b..22500c3be7a9 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -231,36 +231,6 @@
 extern struct page *mem_map_zero;
 #define ZERO_PAGE(vaddr)	(mem_map_zero)
 
-/* This macro must be updated when the size of struct page grows above 80
- * or reduces below 64.
- * The idea that compiler optimizes out switch() statement, and only
- * leaves clrx instructions
- */
-#define	mm_zero_struct_page(pp) do {					\
-	unsigned long *_pp = (void *)(pp);				\
-									\
-	 /* Check that struct page is either 64, 72, or 80 bytes */	\
-	BUILD_BUG_ON(sizeof(struct page) & 7);				\
-	BUILD_BUG_ON(sizeof(struct page) < 64);				\
-	BUILD_BUG_ON(sizeof(struct page) > 80);				\
-									\
-	switch (sizeof(struct page)) {					\
-	case 80:							\
-		_pp[9] = 0;	/* fallthrough */			\
-	case 72:							\
-		_pp[8] = 0;	/* fallthrough */			\
-	default:							\
-		_pp[7] = 0;						\
-		_pp[6] = 0;						\
-		_pp[5] = 0;						\
-		_pp[4] = 0;						\
-		_pp[3] = 0;						\
-		_pp[2] = 0;						\
-		_pp[1] = 0;						\
-		_pp[0] = 0;						\
-	}								\
-} while (0)
-
 /* PFNs are real physical page numbers.  However, mem_map only begins to record
  * per-page information starting at pfn_base.  This is to handle systems where
  * the first physical page in the machine is at some huge physical address,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fe52e266016e..f391c2d7c180 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -124,10 +124,45 @@ static inline void totalram_pages_set(long val)
 
 /*
  * On some architectures it is expensive to call memset() for small sizes.
- * Those architectures should provide their own implementation of "struct page"
- * zeroing by defining this macro in <asm/pgtable.h>.
+ * If an architecture decides to implement their own version of
+ * mm_zero_struct_page they should wrap the defines below in a #ifndef and
+ * define their own version of this macro in <asm/pgtable.h>
  */
-#ifndef mm_zero_struct_page
+#if BITS_PER_LONG == 64
+/* This function must be updated when the size of struct page grows above 80
+ * or reduces below 56. The idea that compiler optimizes out switch()
+ * statement, and only leaves move/store instructions. Also the compiler can
+ * combine write statments if they are both assignments and can be reordered,
+ * this can result in several of the writes here being dropped.
+ */
+#define	mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
+static inline void __mm_zero_struct_page(struct page *page)
+{
+	unsigned long *_pp = (void *)page;
+
+	 /* Check that struct page is either 56, 64, 72, or 80 bytes */
+	BUILD_BUG_ON(sizeof(struct page) & 7);
+	BUILD_BUG_ON(sizeof(struct page) < 56);
+	BUILD_BUG_ON(sizeof(struct page) > 80);
+
+	switch (sizeof(struct page)) {
+	case 80:
+		_pp[9] = 0;	/* fallthrough */
+	case 72:
+		_pp[8] = 0;	/* fallthrough */
+	case 64:
+		_pp[7] = 0;	/* fallthrough */
+	case 56:
+		_pp[6] = 0;
+		_pp[5] = 0;
+		_pp[4] = 0;
+		_pp[3] = 0;
+		_pp[2] = 0;
+		_pp[1] = 0;
+		_pp[0] = 0;
+	}
+}
+#else
 #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
 #endif
 

