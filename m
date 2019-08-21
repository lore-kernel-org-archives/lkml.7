Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42952C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163FD233FE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ILjJA4n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfHUSdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:33:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45930 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbfHUScM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so2696825qki.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bQvsgscqpy4gJx0RSAZHmPdNixt0ATCDS0WU9XTwyb8=;
        b=ILjJA4n/giE8JmPiexv7Bw1nwvbRl2Z+YSLoE4FuqVk0Cy9Y8l0Z/Oi043el4txkPI
         biHES+QyYLZFcNUoZPuckwwgZ/ZXoRyQ8rxMSMLPx468ECFak95S7bHRA5hE7sgYwLo1
         ERLOIgzIGS0X8aQ1hin4TNUKMPvt4jZ8F71XOY2yF9JNx+98bKfh5WdXq2GAL7Nq6Uo3
         KfLn8Kp0O5dqjYZeCaQSMuaUmJE3xMJ+Hjjv8je7GShbQFFNY8YKqG+42V9uOpm21DqX
         2cavH9DsopJFxHmz518GX7AOejraE2dw00Ly+gcqnjNxEU861osit10n9wkODkePQq2J
         VOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bQvsgscqpy4gJx0RSAZHmPdNixt0ATCDS0WU9XTwyb8=;
        b=jkLrcYubkWro7Q+dFJ/ZkyOYqfaNDKVauC21voReIYX7g50vqrbrypftp/NYe0NrGT
         heO6SVD1RMouGH9MWUfWDOC3AmHef3KvAOMlTKh091DDfAmJV4EQcaJ0M4Laud4Tip8N
         8X3W7kXmjNDGcKM2fFq5CFyTqMrhCJcea84j8s6cWLJKNELlwibqRryVhU6+EJCHlrz1
         XIEEtypynJyVxXwikHwrmT0agCTOTx/7QrClaiFGREcShy0abxTxRNwfV54JZZHtIBNw
         sCF7xWTw5l0kgSeFgNG8+4DfIN2falINr0p8vdv1XpysEqA7x6mz+iiDm8OW/qpmMmcc
         XbVQ==
X-Gm-Message-State: APjAAAU3Ww8u2fdz5mc5K8H6q6S06ptnt1iBo8Ck8KEHaGqI2W1XO79j
        HT06fdhXTL1DNZoTJBJi6TST1g==
X-Google-Smtp-Source: APXvYqzfJ8BXdrEH0K8CKkw4fBwWFDafodl10SDkUCPN4bBIEhI2MWQI353Halx8ux+skSlbJLzXYQ==
X-Received: by 2002:ae9:ec1a:: with SMTP id h26mr17120619qkg.80.1566412331857;
        Wed, 21 Aug 2019 11:32:11 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:11 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 04/17] arm64, hibernate: rename dst to page in create_safe_exec_page
Date:   Wed, 21 Aug 2019 14:31:51 -0400
Message-Id: <20190821183204.23576-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_safe_exec_page() allocates a safe page and maps it at a
specific location, also this function returns the physical address
of newly allocated page.

The destination VA, and PA are specified in arguments: dst_addr,
phys_dst_addr

However, within the function it uses "dst" which has unsigned long
type, but is actually a pointers in the current virtual space. This
is confusing to read.

Rename dst to more appropriate page (page that is created), and also
change its time to "void *"

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index c8211108ec11..ee34a06d8a35 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -198,17 +198,17 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
+	void *page = (void *)get_safe_page(GFP_ATOMIC);
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
-	unsigned long dst = get_safe_page(GFP_ATOMIC);
 
-	if (!dst)
+	if (!page)
 		return -ENOMEM;
 
-	memcpy((void *)dst, src_start, length);
-	__flush_icache_range(dst, dst + length);
+	memcpy(page, src_start, length);
+	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
 
 	pgdp = pgd_offset_raw((void *)get_safe_page(GFP_ATOMIC), dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
@@ -235,7 +235,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-	set_pte(ptep, pfn_pte(virt_to_pfn(dst), PAGE_KERNEL_EXEC));
+	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
 
 	/*
 	 * Load our new page tables. A strict BBM approach requires that we
@@ -254,7 +254,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
 	isb();
 
-	*phys_dst_addr = virt_to_phys((void *)dst);
+	*phys_dst_addr = virt_to_phys(page);
 
 	return 0;
 }
-- 
2.23.0

