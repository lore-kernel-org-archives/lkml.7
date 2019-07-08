Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731BCC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494EE216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599087;
	bh=iGU2IakMdnsGfZjyl6t1JmwybcKVOuOTkj4ZtxvOAag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aOjir5IAzocXCRT5FHUswezN+Xn2gQlq1coS1rcZn/iebiAiBv8RGA5Og77nkeq+N
	 l8+fJmb9zStMY2r91DPr0TAA4HD3kweKacbL/kJFUumBuvSuky4TX1cOm4YnUbRR26
	 6JYztiZzTSN/NGRMpi3fd262C3k3BOaoB5ww1wDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbfGHPSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732209AbfGHPSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:18:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042D0216C4;
        Mon,  8 Jul 2019 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599082;
        bh=iGU2IakMdnsGfZjyl6t1JmwybcKVOuOTkj4ZtxvOAag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFGcq13ze2LCrXyYR4ILJGwxQ9Hb129Wsf7P8/eh1+AMgNIzyK1UnnG2wq/yqXbv8
         jNF+j3IVvCI8b1ITfjo5ZychZTgpvCIaKlIDd/TpAiZZXxYmLD7l3Hl776sxJDPauC
         PrV3mvL1PZfo+hX6xUCKqX8QuQV51TuIkoy8fN1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 71/73] arm64, vdso: Define vdso_{start,end} as array
Date:   Mon,  8 Jul 2019 17:13:21 +0200
Message-Id: <20190708150524.993965245@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dbbb08f500d6146398b794fdc68a8e811366b451 upstream.

Adjust vdso_{start|end} to be char arrays to avoid compile-time analysis
that flags "too large" memcmp() calls with CONFIG_FORTIFY_SOURCE.

Cc: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/vdso.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 97bc68f4c689..908bc5ab94c1 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -36,7 +36,7 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
-extern char vdso_start, vdso_end;
+extern char vdso_start[], vdso_end[];
 static unsigned long vdso_pages;
 static struct page **vdso_pagelist;
 
@@ -115,14 +115,14 @@ static int __init vdso_init(void)
 {
 	int i;
 
-	if (memcmp(&vdso_start, "\177ELF", 4)) {
+	if (memcmp(vdso_start, "\177ELF", 4)) {
 		pr_err("vDSO is not a valid ELF object!\n");
 		return -EINVAL;
 	}
 
-	vdso_pages = (&vdso_end - &vdso_start) >> PAGE_SHIFT;
+	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
 	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
-		vdso_pages + 1, vdso_pages, &vdso_start, 1L, vdso_data);
+		vdso_pages + 1, vdso_pages, vdso_start, 1L, vdso_data);
 
 	/* Allocate the vDSO pagelist, plus a page for the data. */
 	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
@@ -135,7 +135,7 @@ static int __init vdso_init(void)
 
 	/* Grab the vDSO code pages. */
 	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i + 1] = virt_to_page(&vdso_start + i * PAGE_SIZE);
+		vdso_pagelist[i + 1] = virt_to_page(vdso_start + i * PAGE_SIZE);
 
 	/* Populate the special mapping structures */
 	vdso_spec[0] = (struct vm_special_mapping) {
-- 
2.20.1



