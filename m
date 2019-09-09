Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E258C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB91F21924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OkCmWbda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfIISNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:13:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35157 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405402AbfIISM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:12:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so17312944qth.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KdFLASV7D2idWllIjItORA3EXDrjQlb3wnbM2/KPLUA=;
        b=OkCmWbdatFX5LAIn2tZSLcvkwIY8ATYEygi2Y5l77xTfEmsig7FuHjhR+Tc515QvuB
         euMog6/tyZCybSHTwlh79lmWstJtQD3RSy5kH+1xIfPremKMTqJWefDoRzxNP2TLUsUs
         A8mnkxLDs8vT8FE9iLekjK4ByYIMB1NN3YTPldP3X2f9sUKe/mLymg0KFvbKoyLBs/Gn
         j9lDolC3WKF+dc5DLnUZsHk8vVHh9Gj4g3oIHklgpDlJwdONuTr8iJNBwEwkKdeX1KU4
         g1KI3/6zAlekor5jSiDFbhluVvtrCqObj12PpnCxo2VKSdot0KUik0DDJKcvZWQxzbaN
         LhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KdFLASV7D2idWllIjItORA3EXDrjQlb3wnbM2/KPLUA=;
        b=RmPDj+0u5DoXZQM55Nbn86oX7T0hqBGoK4jS22MxweWSkRGvtvzzSoj1nlzAm8hpkR
         DkToYB1OQnHzOqf7wOtjihFvYt7WjWQ7RKFCpvzlSBGD0ncUkiSuHSNL+ji+949im2ic
         m5KjVygYRaqr5engxlqbCaJ4HgfunyuAWHIoXkC0FRGFqoKgNUOJPOfBZYmIwzm91zSX
         aw6sfIFIBKUd4/krRJTckORW6JwTcg0n1CeXTZH3rMRsg4apGYE4d9IC7ozSyDof5Lq0
         N2LKqKCeg+iJaQOcMG3MgUjs4n2GmpeM27NS55d2Lox4sWXfiIdY22Gi9p0mGDc2DVir
         3i+Q==
X-Gm-Message-State: APjAAAVwA3SXk/5psUi99+pIub0LaHOKxdLmHIidlBcywVDJyLdcs6w7
        jzaBnZdmBfF1+3FQ3TQttvo3LQ==
X-Google-Smtp-Source: APXvYqwN9aenhg2yxq0xot4VzXYd6PfSrS/JrN5n4RjN+y0s2BVwk+1HvDraVw9P1etriXpA8qtInA==
X-Received: by 2002:a0c:e64e:: with SMTP id c14mr15415087qvn.17.1568052746853;
        Mon, 09 Sep 2019 11:12:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q8sm5611310qtj.76.2019.09.09.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:12:26 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v4 02/17] arm64: hibernate: pass the allocated pgdp to ttbr0
Date:   Mon,  9 Sep 2019 14:12:06 -0400
Message-Id: <20190909181221.309510-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
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
index 9341fcc6e809..025221564252 100644
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

