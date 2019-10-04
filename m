Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60552C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E37C222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GxD/3K/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfJDSwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:52:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43615 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbfJDSws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:52:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so9902478qtv.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1SIbn4I8MDCXYckkp2+GPJdKwVMA/7ROubKTL+86cvE=;
        b=GxD/3K/ycCEvxSiCWvnAT0GNjjm+4imYTIocK+9Ckg/Ul4GjTiRsEdFohkCTGhZWTE
         Q6HNlNrd9UIF0e1Q0sd+JIzh4upUqUWud2wKh2EVb8iN9NHOcmLrsww3vf1iUkle/Otr
         zmKTJUGeSpDA2IsVb3ZnIe1nnoUPg4C580BLlFwQjHVRqxLqbk/6KM0Maaf8lDucT/xz
         hudrVssAEfkKzZS3WbJ2jfUyj4rHsOc8Rmp9cWSDeHJt7Kr4zrM2MrlawyA7ePoU6Qe6
         hPq8al3oS07vFdn5m0pCpzE2qghjUSjuwRo7/B6X9+jO2cdUbHwdR6przKlPUgg6xuX/
         5kLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SIbn4I8MDCXYckkp2+GPJdKwVMA/7ROubKTL+86cvE=;
        b=R07+ZqiCMSrBHql3a0o7y3DIHyf5lQiKLqEsMDSLJYHRQLSeD2qhLK68YBcQLHaC5I
         J1BrZJBDdfL/HGY2sGsbSkgHVHIrRlyr6D4Ro8WwuyY5ohFD9WfAbATAvKI6mNHFJdjS
         wtz4Wx5DXtmxeQ/lKheYCw+ot3IrDjfM4VJmaKWBJwGywk//CgIMW7dAntv6cCIif2OI
         d2AcegY6wQLrBINKtt4pyFP9hIWm//huQbTIqiq0diTgQgAh0tx5UitSb/UY0zTrqpaT
         eiPEMuk1QcPZMqNnFZ/kK6eKrk2Sh93evsNIob3VpCrJSen3C91beN83NCAyR4s0lAk0
         qvYA==
X-Gm-Message-State: APjAAAWw0mYpI1xqszXEShqAXl0ljS1FGS52+WPiVO7NuFCDJGl7vOKY
        9TB7883flT8JdGNJm1vYIRRtlw==
X-Google-Smtp-Source: APXvYqzBYygrCAyKlflIPQOgQ3QCrC7h+B+qaT3fjkOb6GuMQ0AxS7vIMR6W5MfdOa1zXeNuAEGMWQ==
X-Received: by 2002:a0c:c541:: with SMTP id y1mr15297907qvi.116.1570215165841;
        Fri, 04 Oct 2019 11:52:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p77sm4042514qke.6.2019.10.04.11.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:52:45 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v6 06/17] arm64: hibernate: rename dst to page in create_safe_exec_page
Date:   Fri,  4 Oct 2019 14:52:23 -0400
Message-Id: <20191004185234.31471-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004185234.31471-1-pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
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

