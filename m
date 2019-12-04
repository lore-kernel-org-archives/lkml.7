Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B460DC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899AD20866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FjadenDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfLDQAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:00:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39903 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfLDQAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:00:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id d124so355460qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DKzlVpcQACwKyKSnVgM8/kIMtrkAmhYmiL9LEjDkgAw=;
        b=FjadenDBB0WXDBFJdWK7wBZKtljVrQ27er7ggcYbGrfj98oRl7SVlOIDfJ2h9HrPtE
         wIqr2ofYxOfX6BMuSzWrC0sDIpsGXZTC7vbIDEQdASHo2pj94l2BfblVKhs3O6gzASbA
         TGPBNG1idbWrNff4njPvq10uxySF7fBdj4Q7+cq0l2rIGmSJmmB/Tv17w49pIZiQzVvi
         pLKAEc6jvaFbhTyqdG0Wa0MwrLSrQKN8nriHBroKG1N/uBDiekFN9S7NYt9rhWoAbcxY
         jV64qMQvSaCxRqmF56MrsKGlYdwewMjSpycG6KwB9mz9NTuiHu/hZpCYHFV++BqkcGqO
         KIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKzlVpcQACwKyKSnVgM8/kIMtrkAmhYmiL9LEjDkgAw=;
        b=lIcCn+Apyc1/fhvkMPXumbmt9LKGkEkZaWimLrcm2o0rg5A5j1CwTs5i+zZiAn9YUd
         JdL2ZVf8DjmOOCUGFi2lkXeAsu7+dV9UEAY1wOPkRwMKb6U4q7Q6aFKsQwgCn98XaD7E
         AQwRefUgx3n7wG6vi5mwm/DlQAVWsT/dv4Zv7DYGbIlq9q46nb0sLNH1E/9PckcTaD2C
         n1w6Upns0ai5K2TaIU160qLKNZRV/TM/G8yq17oe7fGf+FJ0F7sKiJvzK2EbvltxH85u
         68y6bgeOIoXV8SQuGtYOD4EIJSZ9ohRRyUARVdZ365jQIH1q4OaGEAumDCK8rppQ35Bw
         jfvQ==
X-Gm-Message-State: APjAAAWXkJC2xssx0zFg5qql+5fflu7D6ojIr9qHjizAeXENr5JA5pSB
        kJaXX7uwSa1+n8p39V5uabdYKw==
X-Google-Smtp-Source: APXvYqzUVnv0sHBRbFLKAkGAwpPFGyFDkQYb6mc2NV6YjM+pV7Ku7ddKMWBd73yxnZ5kCDE4HXkdwA==
X-Received: by 2002:a37:514:: with SMTP id 20mr3503569qkf.321.1575475201461;
        Wed, 04 Dec 2019 08:00:01 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.08.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:00:00 -0800 (PST)
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
Subject: [PATCH v8 14/25] arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
Date:   Wed,  4 Dec 2019 10:59:27 -0500
Message-Id: <20191204155938.2279686-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trans_pgd_* should be independent from mm context because the tables that
are created by this code are used when there are no mm context around, as
it is between kernels. Simply replace mm_init's with NULL.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/mm/trans_pgd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index df3a10d36f62..2b02a646101f 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -67,7 +67,7 @@ static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
 	dst_ptep = trans_alloc(info);
 	if (!dst_ptep)
 		return -ENOMEM;
-	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
+	pmd_populate_kernel(NULL, dst_pmdp, dst_ptep);
 	dst_ptep = pte_offset_kernel(dst_pmdp, start);
 
 	src_ptep = pte_offset_kernel(src_pmdp, start);
@@ -90,7 +90,7 @@ static int copy_pmd(struct trans_pgd_info *info, pud_t *dst_pudp,
 		dst_pmdp = trans_alloc(info);
 		if (!dst_pmdp)
 			return -ENOMEM;
-		pud_populate(&init_mm, dst_pudp, dst_pmdp);
+		pud_populate(NULL, dst_pudp, dst_pmdp);
 	}
 	dst_pmdp = pmd_offset(dst_pudp, start);
 
@@ -126,7 +126,7 @@ static int copy_pud(struct trans_pgd_info *info, pgd_t *dst_pgdp,
 		dst_pudp = trans_alloc(info);
 		if (!dst_pudp)
 			return -ENOMEM;
-		pgd_populate(&init_mm, dst_pgdp, dst_pudp);
+		pgd_populate(NULL, dst_pgdp, dst_pudp);
 	}
 	dst_pudp = pud_offset(dst_pgdp, start);
 
@@ -218,7 +218,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		pudp = trans_alloc(info);
 		if (!pudp)
 			return -ENOMEM;
-		pgd_populate(&init_mm, pgdp, pudp);
+		pgd_populate(NULL, pgdp, pudp);
 	}
 
 	pudp = pud_offset(pgdp, dst_addr);
@@ -226,7 +226,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		pmdp = trans_alloc(info);
 		if (!pmdp)
 			return -ENOMEM;
-		pud_populate(&init_mm, pudp, pmdp);
+		pud_populate(NULL, pudp, pmdp);
 	}
 
 	pmdp = pmd_offset(pudp, dst_addr);
@@ -234,7 +234,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		ptep = trans_alloc(info);
 		if (!ptep)
 			return -ENOMEM;
-		pmd_populate_kernel(&init_mm, pmdp, ptep);
+		pmd_populate_kernel(NULL, pmdp, ptep);
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-- 
2.24.0

