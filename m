Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7D7C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B612077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JXM+kNuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfLDQB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:01:28 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37014 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfLDP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so238236qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sFepLZ6OnMRK4naYG+XlGBDsSgO0TlfIvhlIxKEb6bM=;
        b=JXM+kNuk9RiCYtsIMlqMyIdJMHztdqZg6ijzEGxxBoF9lerD5P5KGUDjwUcMJS0S7r
         ibicDlEt4RLrqxI+O7W4Fz48t9BPVxX017AGcAGQG01oqX9fCcZEG39xiCQC6r4eV/Bx
         v2lI23dFHYdeB7kasjpnJaae4QVzJ38kW1H2Ofz0l15eyAMc9PwQHPEPu93Xr+TZa62N
         JnGTxELo82oUym1FdKtT03COXJW1ONpyYG1MjzugbDrF4LjG8qQuNtjB9Uj/70daOJA4
         qKiCe94BG+2kgt24Q8XBeUCwiZNzydHzwQCCLMemYIBgDEG3TfjDN7J2zxLMZDn0uWX4
         APpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFepLZ6OnMRK4naYG+XlGBDsSgO0TlfIvhlIxKEb6bM=;
        b=UuOa+JEtqBSKEpgIMOm4HbIyGMSJTZedxHodQq1M54k0g59bbQyxZM7ymv5t8oINrW
         FtErPFvtDHWdy/moT4nbPUOLDIgPoPOTwKSb0HThxo9gMnw2JGnSv2D86UepaUwi+X6N
         8vvJShQXUPZ7W2LBpbdNY48JpMh2AG9FHinJB9ycJnLotvOqABEgd7VxID0rBZYl8KNR
         erAoLWkDmhCC/EbqZq3C0bNWc431WqWPtSYhUz5gPxbmZh1jiMMoJgyJmcnSTDzpdHGD
         mywRAA2AKfd5tWOwr0nc3w/SFkuH6gHBI8X5MYSu57KeiquN7v5bB9Txge3G3U7Y3EHP
         IXaw==
X-Gm-Message-State: APjAAAXXDhxpZkmajTViHQZQv41XpgWsjsXdRnnPSndi3ubpOIQ2a4Ad
        XKCw8zzBjtWaAkFejnZqA4TUUQ==
X-Google-Smtp-Source: APXvYqx1pQqGZR+fje1UxGEllxPX0PSwVlnKObHzQ1pC9MqOEi/b0A2MPL6Hl2FZSZSFPrAFQuyz6g==
X-Received: by 2002:ac8:7557:: with SMTP id b23mr1062511qtr.38.1575475189752;
        Wed, 04 Dec 2019 07:59:49 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:49 -0800 (PST)
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
Subject: [PATCH v8 06/25] arm64: hibernate: use get_safe_page directly
Date:   Wed,  4 Dec 2019 10:59:19 -0500
Message-Id: <20191204155938.2279686-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
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
2.24.0

