Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C33C11FF9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEE020673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TyuvnBIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502725AbfIWUe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:34:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43689 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502707AbfIWUey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:34:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so9823073pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1SIbn4I8MDCXYckkp2+GPJdKwVMA/7ROubKTL+86cvE=;
        b=TyuvnBIn7GTrkJOJF6O1n2kUKVjWTl/Jvq/eyl04IDGEV6GdE55xcYD+uXPR2CJYE2
         Fj6EcXdXduuUt1EhJLwSvO6fcyU4oSLHJ45WMKqPaiy+ElKfo9uflXCaBjVesMZXOA4c
         kAyU9Y/8s4SMeBT7mZta59+mTzqWJztbv/LdkfvoSNXRFaHh1FBDK4B7ofrT3Ltjadvv
         Os8RakD0DNjJTCwhFlW+dpkos4GKwNH2Th5ge+OFkLPGMjqdwuQlsCwu58U0vwZfK3MJ
         HHNMp+Uxvbrj+Xlu5ejnfqQOXwNtQ2cUig111vDTMd10LCfxD60w2qwEwgUwnuRpN5pv
         C+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SIbn4I8MDCXYckkp2+GPJdKwVMA/7ROubKTL+86cvE=;
        b=LutgIF2BTZLcrEGk7Mhp9+Ws2h0PeZr5UWpC9Tf6BHMi+S7v7Jy+MqpVap3cu/86Gr
         tURTL/8MiANU0gWsMRi9LhkvmOPRBwrsUl4m9MSFlPGeypBNGcjSJDIsmFHbyfQP3xPd
         RUBwTwf8GYlySo5JfJYx1zsOZUjdAp/UPD2hDQjgesRq+dyA7BeeDHyfT8gp3S8yQrYu
         vEinbGtBFk6To6fQ+bwocDZrCAWgvpHpj3sYOtmT5KN6yAgyq+MgPCh01mZ57x6/Mjb6
         c0oMMyGpSQJsHCAd0empWz5YLc8BDBkqurfRvS4Kj1W+1Q9YTpf37D3HOH4V4gZTaaOS
         LqOA==
X-Gm-Message-State: APjAAAW98R8rLHBya6BRhpSVIGOV0SKLr/LIkYo6Q4ffZd8QIIHsKGd1
        XKtqkkmocbNs6rH4quWk2w3DGpx2cY8=
X-Google-Smtp-Source: APXvYqw9oGXCsJ6OvOp1oWJ6xLrYsWIQg7iPoDupFuStJ4lfLcvfFLOSkhGnPGaSagWjR4lvHn8LvA==
X-Received: by 2002:a17:90a:360b:: with SMTP id s11mr1477696pjb.30.1569270892861;
        Mon, 23 Sep 2019 13:34:52 -0700 (PDT)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n29sm12798676pgm.4.2019.09.23.13.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:34:52 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v5 06/17] arm64: hibernate: rename dst to page in create_safe_exec_page
Date:   Mon, 23 Sep 2019 16:34:16 -0400
Message-Id: <20190923203427.294286-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923203427.294286-1-pasha.tatashin@soleen.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
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

