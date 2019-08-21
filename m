Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0411C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DB422DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="X2bYtpl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfHUScM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:32:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39643 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfHUScJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id 125so2726528qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sBcmTKCPArGqx1dLEuzw7dGqn3biKX2D2IdqnHxnWGU=;
        b=X2bYtpl73i+ZQotUx4rPisykcv7elNg3338iVDx51XS8IAesuAET+FJOq1+cDPHG3r
         9rXZdHhqVDL3/xQGl5vT6Oz1ojz+sochUryLWNC1UkgH72k4uApv4TU3RPAclgoyyqhi
         PtlrcnmGLE9h7VsHDPnkFYU5m0ABJTH/PIiWiIwSHa0+lVdUA+kmwFkX7o0khAOFTlSO
         mjutz0tdYRK2G5NUrq7EhUcZ2mAb37l6c2Nnbno0RHr3dhJsbHYDZXP896fB8kwPSIjI
         1XE3mEsJ/pqIbN/NdSziIya/6qdVEfThdKypQFpVlOqjbOH3B1UilgXm0yfhqpBaYVAs
         eABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBcmTKCPArGqx1dLEuzw7dGqn3biKX2D2IdqnHxnWGU=;
        b=XnKv6ncNGfIGmzTkemlYZQj539jmFw2cLu2fDDo02GBqrOZaJScUYKoNfiuLqs1u4J
         Mr/C7/5VyYpiPaX2xzPgH7s1a1srZaXxD3seHMMIt5xI7aCw39jB2Co25bFleJutlM/R
         lpC1PXmkE/W8eQl/8/f6GycwaPArdJi1onDsaR2y2ixu/qPaIp3BSsNgUjABZAQ55tPq
         rQfybDPf3j7GtUcwPRELcqi2S4J/fanvEu7eD1wU522/rgD5EevRC7XCgsCgkiSTkaVl
         yiqL7eNLrbE2TrgjNgFhS9Ts5Nt4LRf8MI9s2ylafbvj2/98FronSAwDEBP5LYs72N9K
         LPww==
X-Gm-Message-State: APjAAAXM9W4yV1mXHAMwrDQFj3Mz6a/URpiIffcyLuYLw1XDlFB45M2m
        N4fQQJWFpc26loaCydAyi3qaug==
X-Google-Smtp-Source: APXvYqwTD5jDmCNqAlhQx5bPMjXa8Ne5sUA8XkdytBk284LEJsuvSjr3IvAfqjwgKcf+e9prxBD89g==
X-Received: by 2002:a37:6290:: with SMTP id w138mr31111453qkb.139.1566412329038;
        Wed, 21 Aug 2019 11:32:09 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:08 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 02/17] arm64, hibernate: use get_safe_page directly
Date:   Wed, 21 Aug 2019 14:31:49 -0400
Message-Id: <20190821183204.23576-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_safe_exec_page is a local function that uses the
get_safe_page() to allocate page table and pages and one pages
that is getting mapped.

Remove the allocator related arguments, and use get_safe_page
directly, as it is done in other local functions in this
file.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 9341fcc6e809..4bb4d17a6a7c 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -196,16 +196,14 @@ EXPORT_SYMBOL(arch_hibernation_header_restore);
  */
 static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
-				 phys_addr_t *phys_dst_addr,
-				 void *(*allocator)(gfp_t mask),
-				 gfp_t mask)
+				 phys_addr_t *phys_dst_addr)
 {
 	int rc = 0;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
-	unsigned long dst = (unsigned long)allocator(mask);
+	unsigned long dst = get_safe_page(GFP_ATOMIC);
 
 	if (!dst) {
 		rc = -ENOMEM;
@@ -215,9 +213,9 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy((void *)dst, src_start, length);
 	__flush_icache_range(dst, dst + length);
 
-	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
+	pgdp = pgd_offset_raw((void *)get_safe_page(GFP_ATOMIC), dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
-		pudp = allocator(mask);
+		pudp = (void *)get_safe_page(GFP_ATOMIC);
 		if (!pudp) {
 			rc = -ENOMEM;
 			goto out;
@@ -227,7 +225,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	pudp = pud_offset(pgdp, dst_addr);
 	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = allocator(mask);
+		pmdp = (void *)get_safe_page(GFP_ATOMIC);
 		if (!pmdp) {
 			rc = -ENOMEM;
 			goto out;
@@ -237,7 +235,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	pmdp = pmd_offset(pudp, dst_addr);
 	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = allocator(mask);
+		ptep = (void *)get_safe_page(GFP_ATOMIC);
 		if (!ptep) {
 			rc = -ENOMEM;
 			goto out;
@@ -523,8 +521,7 @@ int swsusp_arch_resume(void)
 	 */
 	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
 				   (unsigned long)hibernate_exit,
-				   &phys_hibernate_exit,
-				   (void *)get_safe_page, GFP_ATOMIC);
+				   &phys_hibernate_exit);
 	if (rc) {
 		pr_err("Failed to create safe executable page for hibernate_exit code.\n");
 		goto out;
-- 
2.23.0

