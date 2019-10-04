Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7C2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956C7222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QBfxsXlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfJDSwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:52:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37772 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730801AbfJDSwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:52:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so9973906qtr.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3zTijyt8B1oVtT9JT6yCKls7nJQIDBWuYolaWDAK7ic=;
        b=QBfxsXlV7QG8qGyT7yovERfIlFzUSjbPWKWeYhz6on/h85J+eTplEGg+PnYLNe2g2V
         5K1buQ67xs+gJJrvrxE2PnrXBiC/WKbpjDK/y05bxM9jw4pW7RhuVOwtWUQQ+KiXF7ml
         JA751aW5xF8qW02iqVleyASrW/+TGd3dgtpvq7AFHfGO6TV+tsjdz0sbYDOTj56WsKwM
         zDdQJgSHc3StoExrI2ytE0r7vFhhZZdhdq3IqWEzHDTYn3s/BTm/QtNy654271iMnGcu
         mtGsbJLQWQSsE1Vg/9uQta2yjEZvs3zI6mJ3pmibJMTwXefrPnfkV4n4jpIrmPvjFu5r
         2e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zTijyt8B1oVtT9JT6yCKls7nJQIDBWuYolaWDAK7ic=;
        b=o94sgHVgPhbLxy3GGw/f1bbH9WmdeLhaFPpZ3VNv9VVAiJ3N1ponAY00WHA1cPDXGY
         7s6dITtykrObhBsUfPrLW1RiCmlD6Y+0404atHcv1J6lB9sAS/thPN/H6cVJEVgOSgAH
         d66+V66SKS76Ih7PYbMfJ78VviU7u/b931OjNTud1FPveJ69CKBWl8omj2U6Q1bJa1y+
         7XmSutvg2NR8utRHHjL9dAY/QdnnHDBc7Tr+/3UTc3URz1x/2XI0JLcZyswLmzlrkUjF
         JhtoIpk4cSKY5AZroilOnADrtJ3U15FzCKiYzskyVp1hrdL2V2Y2KnOi0ZtNux/rB6Ub
         9AUg==
X-Gm-Message-State: APjAAAU9CrEO7G4WXzhsf65RIaq8p2UYZXuWvIlSpz1mMoNWhNRSNSFh
        fGhMB8EsyHYVwQgGIZTiH+uLeA==
X-Google-Smtp-Source: APXvYqz0VrEtbfOPZiQUcwn5FhaB6/JDqh7xKU3KH/BA6dVj2t/BXgqShHLdvVsoAFfqxEftxuHL5A==
X-Received: by 2002:ac8:6bc5:: with SMTP id b5mr17605033qtt.244.1570215160265;
        Fri, 04 Oct 2019 11:52:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p77sm4042514qke.6.2019.10.04.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:52:39 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v6 02/17] arm64: hibernate: pass the allocated pgdp to ttbr0
Date:   Fri,  4 Oct 2019 14:52:19 -0400
Message-Id: <20191004185234.31471-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004185234.31471-1-pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ttbr0 should be set to the beginning of pgdp, however, currently
in create_safe_exec_page it is set to pgdp after pgd_offset_raw(),
which works by accident.

Fixes: 0194e760f7d2 ("arm64: hibernate: avoid potential TLB conflict")

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index e0a7fce0e01c..d52f69462c8f 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -201,6 +201,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 gfp_t mask)
 {
 	int rc = 0;
+	pgd_t *trans_pgd;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
@@ -215,7 +216,8 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy((void *)dst, src_start, length);
 	__flush_icache_range(dst, dst + length);
 
-	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
+	trans_pgd = allocator(mask);
+	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = allocator(mask);
 		if (!pudp) {
@@ -262,7 +264,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	 */
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
+	write_sysreg(phys_to_ttbr(virt_to_phys(trans_pgd)), ttbr0_el1);
 	isb();
 
 	*phys_dst_addr = virt_to_phys((void *)dst);
-- 
2.23.0

