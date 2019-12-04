Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA998C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90945206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dZgMVj5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfLDQBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:01:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36003 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbfLDP7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id v19so376325qkv.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fVYvb4CPMnyIVG1hgy1MDDfoLwRyTtZYsYaQvsi8498=;
        b=dZgMVj5phzD4WJ2lOv72Eli/7A96+5Gpb3Ad7wS4GpAFxm3R0rC/e/T/q93LuYYwPm
         4Uz5Q8I/DWN0wNungTmuJGHv9zyRMvbTlDr5/OzwP5GoC30b30nMCyYmFdgSAwxtMCMr
         s6GVlkYLM0/inwraONhs7ey8QePReOKIsyMKUfWui2nc3itEsnkD96RTEB8rvLSAdnIE
         gtTPLG5LSyobuU4GMuMU/5vT8Hc9i1eSaNPjx2L0ArP8dc3LXawEBRgI5ydHEvRBT4TF
         bSgRb+cyZ1GQ1BQQp9DFLSr5KzZM+QJWqW7HmPTzU/iVWuCWZJxYtxCvbzaIsVERIBY1
         MihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVYvb4CPMnyIVG1hgy1MDDfoLwRyTtZYsYaQvsi8498=;
        b=HMTUxT4+eadDbbmjb9QhOSRq2W5HVMYI8jvpjxTFIq2oylkgwZRjcmtNrtLPLnqStz
         nEh6OS8kH7UhwnxhQnNNrUnCruHhDvNuplrjwu0muhL90kRQorUI39Hm6G8ciyNfo/7H
         dlMGCCUoVDtaEN1kuj1JPomMhHxAkrfmthJnycjn5+JxuEjDxz0q26mbQOJToOqXvySm
         cBEd0UiUYXmm8SHnU700VR+w7BH3yaTYvR5DOrO8yV0aSAoHmHN2Lt+zBJ4vAXxCJQGC
         kKUcUzTnOwtc49PsInP2ca4JDEwogIgZg5PD0QJEvaRZVImtfWwYOX70pMJUKIi2Kkhl
         9W1w==
X-Gm-Message-State: APjAAAU5ub5D1lIqUNXkrnVubcgtO41cPUKi9caPo9ydLv6eKvfptdl2
        HIaAIxUSTgIL9mNuCm+lORT7jNvNrFs=
X-Google-Smtp-Source: APXvYqw8jqG/hkE99HXXnyk9J4EEotNsFaWyu6oqW81IWVO4OQqs2JZQD9LGJEKBgl2Hhffa8MbTdw==
X-Received: by 2002:a05:620a:1459:: with SMTP id i25mr2498599qkl.36.1575475192642;
        Wed, 04 Dec 2019 07:59:52 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.07.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:52 -0800 (PST)
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
Subject: [PATCH v8 08/25] arm64: hibernate: rename dst to page in create_safe_exec_page
Date:   Wed,  4 Dec 2019 10:59:21 -0500
Message-Id: <20191204155938.2279686-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
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
2.24.0

