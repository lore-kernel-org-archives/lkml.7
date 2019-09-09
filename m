Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB36C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A1621A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RzzD8B3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405468AbfIISMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:12:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:47083 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405423AbfIISMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:12:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id v11so17202743qto.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nvbvJVLr4nkLYl4WcL+kdWRjmAFlh6tLMOt4xIPRheI=;
        b=RzzD8B3mcShO+xNiGkp9aYsaF8e5zs36M3yyRXQYZQsScGZadM3wetxdkkMKDwZhAs
         5GJzlnrTMY4MJPkNtxbp/8WWx+DniOE48TA3hKJcCE6INrqeo1R08BOXvZt5dLSWHWsB
         zOvgEgPACr2i4FOe/q+JTl8q1peE4qF6QCX7UoHhJk9RqfV39j8BwniCkwiq49X91qPP
         UJcdsAaV3a8kcF6lg6PpmHzsZP1kspVO4+RTIrnIljy78YcmyNiwhasJjzN4jnpIhnnz
         /wi4yGG6fcN+WwBP4w09/RJqegG5DBYoT4wMjYrFfF+Xj0OaXW86QPLztqCz4NlUf/SC
         3XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvbvJVLr4nkLYl4WcL+kdWRjmAFlh6tLMOt4xIPRheI=;
        b=JoWxtNEuXRZIJenLdRgL7T39gXgxiCPRyrvB0MZIXzE54GIYLTSFQzvDYX+7mi8Z4C
         TM7/CtLeMFRV/GW4vICR6fnrCsGOKfcMIImrEWW73Q0OQZqA2mE1nUk7E8LjZZ8NiY1j
         EcRlyZ0nTpzM7pVOqqsPj0r+qPiLwrrwlsOEAcJSIwBVNeX8JWQ8HjB9gcVnIlqdye6/
         VjrdAdZO+cjyFgq69m9njJccxpQ+NW4P6OmhKmOFxOUODkptTkTzbjM9FJzvi774aHRX
         IAbsBA4cR0KYsJsKnDWPX/TOA35uFzV52BuR4S+5MnrlVdMzYitCn058/i+p8U29slsb
         TXcQ==
X-Gm-Message-State: APjAAAW+xgbdqrxg68UecGyIt0yAfGPDjT7JMqvqiZoa0fw0GTD9jQRx
        yilFBoMZXmNgvSGuDucF1N+spQ==
X-Google-Smtp-Source: APXvYqxCUUwIn8Crj99uq610NweqGHwoS2Q66TNJxTfkDd8LzzPyrQkWbGkKYuRh3YqV+VdDq9stmg==
X-Received: by 2002:a0c:fc05:: with SMTP id z5mr8555882qvo.128.1568052752590;
        Mon, 09 Sep 2019 11:12:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q8sm5611310qtj.76.2019.09.09.11.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:12:32 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v4 06/17] arm64: hibernate: rename dst to page in create_safe_exec_page
Date:   Mon,  9 Sep 2019 14:12:10 -0400
Message-Id: <20190909181221.309510-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
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
index 7bbeb33c700d..750ecc7f2cbe 100644
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

