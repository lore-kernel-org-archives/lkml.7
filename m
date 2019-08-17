Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C84C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE62D2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Jk5d2DZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfHQCqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:46:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46350 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfHQCql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:46:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id j15so8155174qtl.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 19:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6MXr7ZNXr9pMh8s805CN1W/EkafXMpyZxym4cVvk9wc=;
        b=Jk5d2DZoBShB4ze9idh4b2whUtX/SmRx3TmrhS9c1oewUdCmJEzH/hGw70meFsxow+
         YDVZ3g0EIXKLmKSP1feQTYCGq491WhjWp3qsTbrKER7ArdWIh+EthjCYgIfVGvoygFUV
         tlHsVX4W+sVOY918LixttJyVlaBCZPFsYG/tnp66k+QKq69YlEcdd8RSyu/uuUQ4HzmN
         A2B4BbxV4o4Zdo2HKLL7ZT2tz79MNM8jtjl4cPB7HdLIkuSvqyw1UBAIJzHx9+L9WUOK
         x90PRf3db1rUecDzrbU/GBXEF5jwUHyMjdo64PX/wkrXaBHGfKHryUcwkyGIRw2NodIV
         GEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MXr7ZNXr9pMh8s805CN1W/EkafXMpyZxym4cVvk9wc=;
        b=b2xfgUk/H7lGUW3DHPTXYAmNmdCLsxd1ngfvNi4KEYiMnir2EqSCsxFaYCUFE548Xm
         x3UzGirxYEzIFPS9gZk/NzxCAx6JCEcSMRZon91GSZQJMZCJvExag29OjpRJqr4hPbQ8
         Iry7HMimbiNqiWWVCQT4klPM3p+ArNnfiswBbjbmud8v5Bm6uMY+aINXxEuLw6p5UmeI
         CNQrQNpNe851fLgTFDshZIn9hNrw+eQSMPioC/pCxvWlh7oEN5/VN0qe+/25fXYGfmLA
         qKwoWOd16IIEUsYEqva6xoKHPuNwsvz5p43pnsqN8lSzEJihXDncwMP9oa80VumS77mm
         ZcWg==
X-Gm-Message-State: APjAAAUE0t0m9oWyQw0FBtjML4GRCxMTy0yaD4INRqJ1My8GzBiL+fX2
        hvZmxGJTT+PCZeVC5/cSyJLdeA==
X-Google-Smtp-Source: APXvYqxndPHKSjrYVebk9sscUfiq8znh7MMHnkLzeCbrUekUG7hOvdYEmZRZVAY2SFXWMAuk/MAFdQ==
X-Received: by 2002:ac8:3737:: with SMTP id o52mr11736300qtb.9.1566009999892;
        Fri, 16 Aug 2019 19:46:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o9sm3454657qtr.71.2019.08.16.19.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:46:39 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v2 06/14] arm64, trans_table: add trans_table_create_empty
Date:   Fri, 16 Aug 2019 22:46:21 -0400
Message-Id: <20190817024629.26611-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817024629.26611-1-pasha.tatashin@soleen.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This functions returns a zeroed trans_table using the allocator that is
specified in the info argument.

trans_tables should be created by using this function.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_table.h |  4 ++++
 arch/arm64/kernel/hibernate.c        |  6 +++---
 arch/arm64/mm/trans_table.c          | 12 ++++++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/trans_table.h b/arch/arm64/include/asm/trans_table.h
index 1a57af09ded5..02d3a0333dc9 100644
--- a/arch/arm64/include/asm/trans_table.h
+++ b/arch/arm64/include/asm/trans_table.h
@@ -40,6 +40,10 @@ struct trans_table_info {
 	unsigned long trans_flags;
 };
 
+/* Create and empty trans table. */
+int trans_table_create_empty(struct trans_table_info *info,
+			     pgd_t **trans_table);
+
 int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			    unsigned long end);
 
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 524b68ec3233..3a7b362e5a58 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -216,9 +216,9 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy(page, src_start, length);
 	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
 
-	trans_table = (void *)get_safe_page(GFP_ATOMIC);
-	if (!trans_table)
-		return -ENOMEM;
+	rc = trans_table_create_empty(&trans_info, &trans_table);
+	if (rc)
+		return rc;
 
 	rc = trans_table_map_page(&trans_info, trans_table, page, dst_addr,
 				  PAGE_KERNEL_EXEC);
diff --git a/arch/arm64/mm/trans_table.c b/arch/arm64/mm/trans_table.c
index 12f4b3cab6d6..6deb35f83118 100644
--- a/arch/arm64/mm/trans_table.c
+++ b/arch/arm64/mm/trans_table.c
@@ -164,6 +164,18 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 	return 0;
 }
 
+int trans_table_create_empty(struct trans_table_info *info, pgd_t **trans_table)
+{
+	pgd_t *dst_pgdp = trans_alloc(info);
+
+	if (!dst_pgdp)
+		return -ENOMEM;
+
+	*trans_table = dst_pgdp;
+
+	return 0;
+}
+
 int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			    unsigned long end)
 {
-- 
2.22.1

