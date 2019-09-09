Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C83C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2064321924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UthcQ8kO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405649AbfIISNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:13:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33107 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405419AbfIISMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:12:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so17313483qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Zyn9vu/MXqap+nTmKUuDMqr9t65lKRkBEWPsGRxQJWw=;
        b=UthcQ8kO9S9FCLunJhnz0p5vTTeqpswrs8HKI3djcyn4qVoYH5c1zslsQ8icQsNuPw
         lTHINs8zJxAuS3r7gWwVequPv79z7btg4C4cIvo/Bvv7pMUfe3fuVe+bUmep95QO26L2
         BI+gHcf2ROIyYWP16vdZ+yqFXHBvGWqGqai0v9yIfE//FjF2txzR9RwNq/Ro6no5KKwV
         SKLynI2BWiFTWDKzVEX3Ev6oQFBlSmwcv6iEYGjrpwCBHaXU8FBvmaYyobFXAihr09Sg
         +JDVKpR/sFM89wtVQck3jZCL1jiTauTsbPzPg+yIyOU05PD6RocOP6Ax0DRQKCCIMsDE
         CEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zyn9vu/MXqap+nTmKUuDMqr9t65lKRkBEWPsGRxQJWw=;
        b=te5JVaYEjTNwuyJZVLPX61mXtnq41o1MMJg9XjLCGFuCSiYJngtiEOTpDGhjDlHM3u
         hySk1H+OaTMC/pZ3KvVZlP+CFAhd2gJob/fioHbQbPSpTryX1RO+ajSwPWCvLv05ALVD
         t0gUQjOywULIKG6ZEzeM5O8nHuzR0bnwGFl6TAeO5KNM94hEXhgXG3R9lKqCXCjgQz4k
         zPBqhTkp9bjN50VULwPGfw1QQdg/z4ZUBqtTBNcMKgJ2G/R0F3z4xbtscixj2qtrpVKi
         ZvquayDbp1V//SeQSFlrKmuCsoKF2PZQYUtVPCIsp73U1OwiCrw09+hjMGNPk1+F0zcg
         uj7w==
X-Gm-Message-State: APjAAAX1BuE66udqkfLr4xK4//OvTy9ws+RwEDd7TuHOAb1cTfTvzJ3n
        BiCbnJ4TkNhEZF5GkReUP2zIJA==
X-Google-Smtp-Source: APXvYqxD+/dgh77RiunjjHz4vq1SlUkRHl7ZhEwgGQCd/ojd17d3Y9qj1SZatp7epiPygaYzVXaPxA==
X-Received: by 2002:a05:6214:451:: with SMTP id cc17mr15008123qvb.15.1568052751174;
        Mon, 09 Sep 2019 11:12:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q8sm5611310qtj.76.2019.09.09.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:12:30 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v4 05/17] arm64: hibernate: remove gotos in create_safe_exec_page
Date:   Mon,  9 Sep 2019 14:12:09 -0400
Message-Id: <20190909181221.309510-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually, gotos are used to handle cleanup after exception, but
in case of create_safe_exec_page there are no clean-ups. So,
simply return the errors directly.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/hibernate.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 47a861e0cb0c..7bbeb33c700d 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -198,7 +198,6 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
-	int rc = 0;
 	pgd_t *trans_pgd;
 	pgd_t *pgdp;
 	pud_t *pudp;
@@ -206,47 +205,37 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	pte_t *ptep;
 	unsigned long dst = get_safe_page(GFP_ATOMIC);
 
-	if (!dst) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!dst)
+		return -ENOMEM;
 
 	memcpy((void *)dst, src_start, length);
 	__flush_icache_range(dst, dst + length);
 
 	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
-	if (!trans_pgd) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!trans_pgd)
+		return -ENOMEM;
 
 	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = (void *)get_safe_page(GFP_ATOMIC);
-		if (!pudp) {
-			rc = -ENOMEM;
-			goto out;
-		}
+		if (!pudp)
+			return -ENOMEM;
 		pgd_populate(&init_mm, pgdp, pudp);
 	}
 
 	pudp = pud_offset(pgdp, dst_addr);
 	if (pud_none(READ_ONCE(*pudp))) {
 		pmdp = (void *)get_safe_page(GFP_ATOMIC);
-		if (!pmdp) {
-			rc = -ENOMEM;
-			goto out;
-		}
+		if (!pmdp)
+			return -ENOMEM;
 		pud_populate(&init_mm, pudp, pmdp);
 	}
 
 	pmdp = pmd_offset(pudp, dst_addr);
 	if (pmd_none(READ_ONCE(*pmdp))) {
 		ptep = (void *)get_safe_page(GFP_ATOMIC);
-		if (!ptep) {
-			rc = -ENOMEM;
-			goto out;
-		}
+		if (!ptep)
+			return -ENOMEM;
 		pmd_populate_kernel(&init_mm, pmdp, ptep);
 	}
 
@@ -272,8 +261,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	*phys_dst_addr = virt_to_phys((void *)dst);
 
-out:
-	return rc;
+	return 0;
 }
 
 #define dcache_clean_range(start, end)	__flush_dcache_area(start, (end - start))
-- 
2.23.0

