Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5EDFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A3120854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AvFdQHz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437052AbfJPUB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:01:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44435 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436853AbfJPUAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:00:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so37953397qth.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1SIbn4I8MDCXYckkp2+GPJdKwVMA/7ROubKTL+86cvE=;
        b=AvFdQHz3ZXrU1SWGbYfPv5ripelLhgYAiZX4rtccUBVKcJrrJ89mK3qk1C8RQsOusd
         spipU71v7sl2MCbZPijlOBg3Ym1xhGfX933/vvAiJ5FQBBjLv13ahbLY/UCbQLit+iGP
         tZE9GTZPfPZr46H4dtL1HBMd9zmLJiZuYXuN7XJvaGmVwXn17ouy0csJGm7ZvM8UMJAx
         0zLItSTrZF8dzw57+GuT2SlTYQ/p3nYXPXdVaGJjjB0V9xGWFkgNskFPL3e0JGXwyb5T
         cw6gnH13YNIEDNjpQY6UeuHmTKIsaxeacAz9HU4SCYCFiAKkqJurXy10lqoAimVCAJS9
         EFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SIbn4I8MDCXYckkp2+GPJdKwVMA/7ROubKTL+86cvE=;
        b=ReD2sKIHbop5510gqFWT2Yg+DKBwF7/63yXQSqhp0+55lbej4mGnojRoctLIpBJidE
         o6aQw3ayWtj+VZNyJYtbRcKJfkFdd4Q+kBYHrbuM4hYukrgroNlcWSkuHqICMlwzgFsR
         zf4P7gZ2IjohVkLHZLhDAhUz/CzHnfe6bwOklTzAiuvYisFrPvXClS1O1hrlT9tUBaSA
         MPrEkc2Rr7VUuPs/G1CPkTPDrWvAYBOxXhXWn3RYBf/BmuBkT1uuRCIdAvfTdt0SCFIP
         7UM4t3w9isnVk7Vd2reoaPKgQqfJqaDZxQOZkHBgzp68wS9H3tfqYvyYNwUO/WRJXOtK
         rBJA==
X-Gm-Message-State: APjAAAWwRp72AyGu+mpn9cJ9iM1aq10jHhoLs9+o7KHYZIx5U4r/y7E1
        bEjZ+XJMmGQusUFoeHMaCaZOvQ==
X-Google-Smtp-Source: APXvYqzMYMg73pDkx1yAwlUn08S8sYE7E9Q1+gs9YymMlmuvw8yVxsSZtWgo70CbRWvK/QVKhZ7d+w==
X-Received: by 2002:ac8:44d9:: with SMTP id b25mr47013143qto.347.1571256050345;
        Wed, 16 Oct 2019 13:00:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:00:49 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v7 08/25] arm64: hibernate: rename dst to page in create_safe_exec_page
Date:   Wed, 16 Oct 2019 16:00:17 -0400
Message-Id: <20191016200034.1342308-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
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
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/hibernate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 83c41a2f8400..1ca8af685e96 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -198,18 +198,18 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
+	void *page = (void *)get_safe_page(GFP_ATOMIC);
 	pgd_t *trans_pgd;
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
 
 	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
 	if (!trans_pgd)
@@ -240,7 +240,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-	set_pte(ptep, pfn_pte(virt_to_pfn(dst), PAGE_KERNEL_EXEC));
+	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
 
 	/*
 	 * Load our new page tables. A strict BBM approach requires that we
@@ -259,7 +259,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	write_sysreg(phys_to_ttbr(virt_to_phys(trans_pgd)), ttbr0_el1);
 	isb();
 
-	*phys_dst_addr = virt_to_phys((void *)dst);
+	*phys_dst_addr = virt_to_phys(page);
 
 	return 0;
 }
-- 
2.23.0

