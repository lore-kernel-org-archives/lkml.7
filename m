Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00BBC11FF7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D7F20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WnAw2fGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbfIWUfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:35:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43717 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502792AbfIWUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:35:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so9823651pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zqjz6RgOj4sr7JAtiYy2U5c4q561GRonF/uToZbvMtQ=;
        b=WnAw2fGSNE/myDLdhhX6BmHSTPEX7HnB3kfPVBIxFAmKlx5HFTEJTBGDR9Ljm7tmxX
         qFvbtBtRiGT/YrC/Vi002qJlWTVCBmg6080ME+eu+yEA4GFpI8xlnK4Mvg2E4e2m1lVJ
         +sXMy+qKAuSJsy+y4dHLIeJpXBGKcdl//fP/LTzqvMfmw6emFrRTpHCeRZmTpv3e4ur6
         0cw7gBF8XsAdK2VpUuOEYTeOv2cV6Vwatca3LnJjVSSwOXuyiFUivMYZBjDbvOPP6ZR3
         vzHol7eDJe4E/Eu5sGe6fbEEsVu1bhIpt6EyQtoHHOjmRQqFE7W28Gk0GzEmTxwwTCFv
         e9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqjz6RgOj4sr7JAtiYy2U5c4q561GRonF/uToZbvMtQ=;
        b=JmhKHUznOGfGhHCxnIn3J9d9eQDbcrH2X34zKL/xFb2t+UG/nFKnycKXd1AYTJTcfI
         XW8tQ+te8iyqDpUFEMiLVTqzclaU10SkAvp7ujW5zsiGBgNrGmmVmYchMzzSwsHM8ECy
         qlsEQOqK/KuIYUz+kQ34s6yD8eghHKYKdtO22ML1Qw4DYVR3aiwl+vfXl0t9d010Xx9M
         iBE3LKM/oWWg3S9egsdOcnMXmuHCwJpv3UVGzJXDdCidcLTlet61EzHL2H3eVu3jPXRM
         +t2lIsdzhegFcLRBWVz6h8Y4DPw+/5Z/UAthEKUkBPll1AD5JmtnjJ24TNhnbQPZQF/s
         fD8g==
X-Gm-Message-State: APjAAAVD3dda28PdSnh7wYRV2DZxaVGeNYBvet52TcP70afm4PkEgWra
        AcPuSlXI9jJ7eTjTDX4wOWaXYw==
X-Google-Smtp-Source: APXvYqzXWJHRickfcJWQxs+CgMxHvl/b0k8/aUu4O+dX/YeWwklhNW/J0DTVkn8q5vOK+EICXnoj3Q==
X-Received: by 2002:a62:7d8c:: with SMTP id y134mr1547755pfc.257.1569270909101;
        Mon, 23 Sep 2019 13:35:09 -0700 (PDT)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n29sm12798676pgm.4.2019.09.23.13.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:35:08 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v5 12/17] arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
Date:   Mon, 23 Sep 2019 16:34:22 -0400
Message-Id: <20190923203427.294286-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923203427.294286-1-pasha.tatashin@soleen.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
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
2.23.0

