Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F126DECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C393621D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DuqfqRWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436864AbfJPUAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:00:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36513 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436828AbfJPUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:00:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so24012231qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MH284WpfdMmTT4sRM0t5AqX3XpYou6gu7tWPymm7DjQ=;
        b=DuqfqRWMPOvEPNM2SwMz7BaMdbSnbr2AOXFceodEDGBgvpTPxvzCCJRKO0XMXLWKTh
         p5mnTcTZu0KDFMwnKTHbaqAZXwXzW6PFYUveTxH/wBfPgzGiNCjn6GlWf+4Nvr1oufFO
         6V5GE/32z3BR70juhuUHJ2Hz52ZWJMuLiPhG90YCqIEOJXq8wQx1xpZz76Bqv5Dcsx6P
         6sZ/O1FIS2CgbuXRByzyFtw17uNhQjJiSkouOqEmo+3ol6GZE2Cc8gXwjti8Bt0HuDJd
         jNPp9QaZq6Kdh5YZ6MEpUQ5Sad/E+JSdbx+Q59PlgQop26kj0b3Bg5LY8JloRVaBAb+J
         YKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MH284WpfdMmTT4sRM0t5AqX3XpYou6gu7tWPymm7DjQ=;
        b=Jbg0LJIE55xj8V90cfDo6rBoN/EI4qOMoIwP49xgEYyw8hwKJc/0YTj3vlNqezyLK8
         19ljQHz021YUD8qWs6b245J10Lh0gnr4/aWkyOZ5NnuzSsFu8UvywytoEUEEQBwwoKId
         C5eaVKPx04QGowCoGvu6hXrk7QJa1LQlGqk/Pflm428aIC9zfOFInszvengR1DodwQ12
         d57p03kgdkaoAaqMmgInSC1tK3QivTB8piIh/1/lPt/Sv4DovJhIhDPubjyfQ+EVyVn7
         t36AAV4FH5R+dSL8r6E8366pRvBXif7H/+bmnww3hY4P+I0CYNjcP0aMHOENhLKKnWkI
         8FqA==
X-Gm-Message-State: APjAAAUnSqgM8SmShzQ0KuAR9H/kI9IG9n+DmUN0/XAB98t+SlBCxouM
        +R718ty71NX4Y2TOnJrrlin1xw==
X-Google-Smtp-Source: APXvYqwQfg+AMEijbvYInDKw1rQxmB6TO6d7tt0LCd8e4XMQCW2+/wCpDuDVQi3KUQIh6WJn1VFpNg==
X-Received: by 2002:a37:c40d:: with SMTP id d13mr6599119qki.371.1571256047252;
        Wed, 16 Oct 2019 13:00:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:00:46 -0700 (PDT)
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
Subject: [PATCH v7 06/25] arm64: hibernate: use get_safe_page directly
Date:   Wed, 16 Oct 2019 16:00:15 -0400
Message-Id: <20191016200034.1342308-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_safe_exec_page() uses hibernate's allocator to create a set of page
table to map a single page that will contain the relocation code.

Remove the allocator related arguments, and use get_safe_page directly, as
it is done in other local functions in this file to simplify function
prototype.

Removing this function pointer makes it easier to refactor the code later.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/kernel/hibernate.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index ef46ce66d7e8..34297716643f 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -196,9 +196,7 @@ EXPORT_SYMBOL(arch_hibernation_header_restore);
  */
 static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
-				 phys_addr_t *phys_dst_addr,
-				 void *(*allocator)(gfp_t mask),
-				 gfp_t mask)
+				 phys_addr_t *phys_dst_addr)
 {
 	int rc = 0;
 	pgd_t *trans_pgd;
@@ -206,7 +204,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
-	unsigned long dst = (unsigned long)allocator(mask);
+	unsigned long dst = get_safe_page(GFP_ATOMIC);
 
 	if (!dst) {
 		rc = -ENOMEM;
@@ -216,7 +214,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy((void *)dst, src_start, length);
 	__flush_icache_range(dst, dst + length);
 
-	trans_pgd = allocator(mask);
+	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
 	if (!trans_pgd) {
 		rc = -ENOMEM;
 		goto out;
@@ -224,7 +222,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
-		pudp = allocator(mask);
+		pudp = (void *)get_safe_page(GFP_ATOMIC);
 		if (!pudp) {
 			rc = -ENOMEM;
 			goto out;
@@ -234,7 +232,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	pudp = pud_offset(pgdp, dst_addr);
 	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = allocator(mask);
+		pmdp = (void *)get_safe_page(GFP_ATOMIC);
 		if (!pmdp) {
 			rc = -ENOMEM;
 			goto out;
@@ -244,7 +242,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	pmdp = pmd_offset(pudp, dst_addr);
 	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = allocator(mask);
+		ptep = (void *)get_safe_page(GFP_ATOMIC);
 		if (!ptep) {
 			rc = -ENOMEM;
 			goto out;
@@ -530,8 +528,7 @@ int swsusp_arch_resume(void)
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

