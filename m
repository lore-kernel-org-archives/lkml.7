Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982ABC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7404021A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gEFy66rK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405608AbfIISNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:13:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35205 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405486AbfIISMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:12:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so17313859qth.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VDzqkQgnkwsjeSD2sj+xCRv+aPoQdl7/oAUIodozYzI=;
        b=gEFy66rKgwtrGikuVUBnPyDp5wFXvKrpxJzr2q8Qx3ehi4m93SO+cT8ckPzt3hC8G1
         5wjKdyCc5YIkYVxz+nYq19eoJQ0rdnxqNJnsnOqZZT/PzPbJu2FhQiaHyxcaNdKXnr09
         0jnUs37ghN8KKRCsNZnq1V0ltm+b6H7CnXfXZik/8St/OTcFJqQPRi+/6I9Ra8kgjZTm
         yZfQFlr+97DIgzbJ0FcDnqMXwd4Wdj/tGE00x1RC0STKY6PXXcs1ELvfCOTKQMrVguot
         oy2uD6HEOhYRGdzg2HchRp5NQ8ML3hZbKNCubNsZaCy/bs/6SVxAEVcXq+z3OiC54hub
         B0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDzqkQgnkwsjeSD2sj+xCRv+aPoQdl7/oAUIodozYzI=;
        b=C6slbUOd9BlWFIprofQpDGDBkt4RV77+7Q7YhPMydZK7XylySMOdd+oEamtXo2MSJa
         I0G0W2zk86O93nMGKQ0yI/hLt08sxN8XCU+RBltyOSOIQjg+fMm3LKJAUM5Rq0+Z8j62
         ChIKExAf0poKJydui6u8v1Bo2KLgl5FgTAwBeZHml/Rv75mIGGt/XJ0rJlK4YBwYaURs
         dGJBmhYqQPjbRF6Po+uHJh3ro1I7pUArd1xE53LxmgCPJYUIEKXckfy7NZyYQi//605z
         Gl01Kpyie7Q8TdLpQT+YelyCxAW3GPDHVyW7zaUo6cFkzr3irLurDkSUVqNqSKv/r4ap
         lM8g==
X-Gm-Message-State: APjAAAXJUudStZ7VYBh7mXZKVNybXOucC32fjEaJ7GmRTbGKD3pmwTFA
        +KC95eaGI0sMe5OKUWoCoi1yOA==
X-Google-Smtp-Source: APXvYqy2DfI9VQoDCC6Va2zmAeWcK9TGmDIi0yl0BgAbKSBK0D91mrY30M5+sJkkAC/vKvqTDaqtSg==
X-Received: by 2002:ad4:4d8e:: with SMTP id cv14mr7524241qvb.49.1568052761763;
        Mon, 09 Sep 2019 11:12:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q8sm5611310qtj.76.2019.09.09.11.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:12:41 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v4 12/17] arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
Date:   Mon,  9 Sep 2019 14:12:16 -0400
Message-Id: <20190909181221.309510-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
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
index dfde87159840..e7b8625b3ac3 100644
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
 
@@ -199,7 +199,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		pudp = trans_alloc(info);
 		if (!pudp)
 			return -ENOMEM;
-		pgd_populate(&init_mm, pgdp, pudp);
+		pgd_populate(NULL, pgdp, pudp);
 	}
 
 	pudp = pud_offset(pgdp, dst_addr);
@@ -207,7 +207,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		pmdp = trans_alloc(info);
 		if (!pmdp)
 			return -ENOMEM;
-		pud_populate(&init_mm, pudp, pmdp);
+		pud_populate(NULL, pudp, pmdp);
 	}
 
 	pmdp = pmd_offset(pudp, dst_addr);
@@ -215,7 +215,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		ptep = trans_alloc(info);
 		if (!ptep)
 			return -ENOMEM;
-		pmd_populate_kernel(&init_mm, pmdp, ptep);
+		pmd_populate_kernel(NULL, pmdp, ptep);
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-- 
2.23.0

