Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3B3C11FF4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D560F20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NPdkNIm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502682AbfIWUeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:34:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46615 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502671AbfIWUem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:34:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id q24so6979162plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3zTijyt8B1oVtT9JT6yCKls7nJQIDBWuYolaWDAK7ic=;
        b=NPdkNIm0wrZOKAEjjebCfOXhVt9BA9UfqiHQ6RuQplwNC6RxIM1b11Cd8A5afWNV07
         O6nrgyrp1NE11jqQQCyB9u5TPHar+d5IM2aGGaZIYmpdW8dv7YMiMNhr1NSeN1HdA17Q
         qA5tfNc/q4JkZV2xI+YaOcH/q+gypgvpqre3Jkl1CqhZ7D587jfQ0Spvdkvxzjv8zD2N
         CRZ62EB12Q0TusTaPfzTP14sUgiy/v1N1+PCc2ulUmZTK1P7yRF5UBuYnlTdZVPkmV33
         LOXk1q2Arz2juRQsSya+z99tARblhJgNSrG3P6W3AXLNVCUaP7uV2C1cIZnhzMYJ/rur
         HjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zTijyt8B1oVtT9JT6yCKls7nJQIDBWuYolaWDAK7ic=;
        b=hEr/9YSjHT75Nz1L1U2lL2ZSvAKIrGWT5l9AVQiabNB30GqHIkZZJzhi1pHOWWdcqP
         bD3pDmnvAL5VqQ0GeXSKX55QK/RPaSmu9GuVbDLz4GWHDGYk8QAWrV1JgBSV9NkAERsC
         c6sPFmoOvxtAXQqA/pmiJ/uFgoaub/A81XOvbQW9sLGBqSiD6vyx74qjNFaVD91HWphw
         Qjp+iWoWsrm3U3d9FnXpas2Udplr7ppmWZuaoTnnkq2cSbI5jEBgGnD+kXeL58IGdEOH
         WoL6S+jHAX3RzNFeswic4ecutriPCy1dhMksDVnQOu0GPIpN6I8NVdFcf0EuuyB6eEnu
         hfCQ==
X-Gm-Message-State: APjAAAWaW7NYlPUbyqJFrMMsvo3uKSZSyrCVsSLrH9tHo8SMOhrlQ6Rw
        iEC9C01akRk0i0P65VT6kFLb6A==
X-Google-Smtp-Source: APXvYqyM+tozPszKt/AHnpXbGQE8m+WydlkTbUy8bM7XQTkOKWP6qGml1eU2fXHZcpiqnRJpO7UwYA==
X-Received: by 2002:a17:902:ba89:: with SMTP id k9mr1747223pls.44.1569270882293;
        Mon, 23 Sep 2019 13:34:42 -0700 (PDT)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n29sm12798676pgm.4.2019.09.23.13.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:34:41 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v5 02/17] arm64: hibernate: pass the allocated pgdp to ttbr0
Date:   Mon, 23 Sep 2019 16:34:12 -0400
Message-Id: <20190923203427.294286-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923203427.294286-1-pasha.tatashin@soleen.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
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

