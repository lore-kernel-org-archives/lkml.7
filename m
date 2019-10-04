Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90409C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5C7222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cbV0/XSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfJDSxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:53:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44219 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731045AbfJDSwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:52:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so9909498qth.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zqjz6RgOj4sr7JAtiYy2U5c4q561GRonF/uToZbvMtQ=;
        b=cbV0/XSbNFTSiiM+0+QH8MvL54ryMmCHecyN10p82JZMgUjz4NAuNaO4H/8MqO02uB
         DH5SqTvw31/30Cm17haSt+OXKyVHeNUl3YmogImEDO9sn/UnPxH0qAmMXipRrR/Uct9n
         2N5X+rQMndJrc7PhVMCH+5DsPAoYqxx9FqvprPInWfziR8Nf18WMI8GaVe6CICmQJK58
         yzWF8Alzj6bWOxiHa4QlAiP+YJVJtikGcD8sofq9y2mv8v0DSK3A753WD828e7L0hCwc
         cV+hsQIYQ1Xmbx0reRqkJ6HbkysxUw64kuNp59klxTXpTAWwY+r+9avQLJTGJ+uZWrl/
         3Iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqjz6RgOj4sr7JAtiYy2U5c4q561GRonF/uToZbvMtQ=;
        b=pmI4gC32T0kullLXxtUqwBAYmUdrRtfbOd+zDi/wnnfYT5mJ66zXveHTLXo54/eMWS
         k1zPGB7qYMee6q5N5QW7ZIw7kvEgXG/89Tmj1NFlkzvwlp2xDdRFYa6ynmQq+mHlY2o7
         JxA1UWcHO2FX9JUE1Ywtp7xbpqM+mvvjr6rgpo/V6M02hirK8dp94ZzJxF5Izr6Rn5BT
         9cdM5Rg+zA8ToB7b3/W5GDuo4ClgaYtui5shnYuvxF4lOI7wPWhe1Xr21ae5UYSMnz5I
         50K/14f/w8NEmJOgM19oktV68JTE42cMPVEwbL6elw3FGUq9zzelBWuOTdQlLqfAO/w/
         MT1Q==
X-Gm-Message-State: APjAAAWzehAwGLoOQPJGFe/Z8p1fhKZOUURY/tg08+5vOxd6UF4ZdSAp
        BQqFaM7R+3hlv6TnB9U5ASix9A==
X-Google-Smtp-Source: APXvYqz/SlNz26COPOm3ZkvwHkWqmnKJHKOZXNlZegzlLgw/1j5CqwFayRpSluooPsIp5pEFfeC7dQ==
X-Received: by 2002:ac8:65d9:: with SMTP id t25mr18010890qto.261.1570215174236;
        Fri, 04 Oct 2019 11:52:54 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p77sm4042514qke.6.2019.10.04.11.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:52:53 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v6 12/17] arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
Date:   Fri,  4 Oct 2019 14:52:29 -0400
Message-Id: <20191004185234.31471-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004185234.31471-1-pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
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

