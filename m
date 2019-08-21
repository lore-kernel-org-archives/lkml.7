Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B855C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B1E233FC
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="F5/vglG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfHUScS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:32:18 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36786 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfHUScO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id d23so2739786qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Wh9WjFIAkHLcLqaIxEdJCbYPtfUD1HKjJMfvVa6suJE=;
        b=F5/vglG3qyPmeB0JD/AkU7IGnC36OiRKuIbJpU/5z6Qd1GRGZOhFlF4y4Lh2ICo5Fx
         vtQOuW3utAdvtWyr18dzkIZCDVqXJao9VeZUSFJutBJ77JmxNiuLaWJh03JuWREaAQHG
         FUxoecx1zcaDw4ixSBLROQIVxLWli/e9CqYQ6KV/GQnqhUgExJN7sHGLijzlXW3+8H9p
         T1Fy4UosgCEWylhQulEZ68Ue/TEGUq5aaC9Fuso7GsR0u+2KN1F6WA5iq9CXrtN1hbws
         KCspb69kFM10WTEkPeGAYxLiYN2U8KBR4h/dfkNn5EtUCntDKVOFUooIGbuk8QCbibaC
         VDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wh9WjFIAkHLcLqaIxEdJCbYPtfUD1HKjJMfvVa6suJE=;
        b=Y22/lX43bWqP7fII1wYHiyUsDp15CopjYwiqVu+UH+kN9GZ3Z2QyvOcDozxkrDF/Jc
         8nrIWrMinFWXopBbC13kT4KVDwbFKSssM0WhXP/8grw0mdEONMM/NziF7d+HdZybnGmQ
         oaDcYdqGiFh9gdL1Dgtcr2d0s0per0yjSgu+uotUXhmoQw18gC2B61XWqLhg9Me+Dz1/
         FgzhU36bs8UetZfMzc9z9lF1L+0q8tQAbAOGJ9FprdOtg3P0ZJcrRpTuRkp5VuLodnZ1
         U8jtvN60i1PIzDXZthxOokdkd9bDHEXWdXexVAhkLQ8nZ1LWyyCx3gvkUfXQRu7cpj7e
         FhcQ==
X-Gm-Message-State: APjAAAUCqPGt1rtO3Idz0PCjRODlJAZdv8cK198jMYlTQfIbAPVQo7e5
        DATwkVKieJHRGDTjLEqRdUxFVA==
X-Google-Smtp-Source: APXvYqzVNLy+zlNZt58NDFTFB1VkACqlq5vozOSGre9tQf+0u5mRcMmJRu7ZCEw94OQindIwKWGR9A==
X-Received: by 2002:ae9:eb87:: with SMTP id b129mr31494076qkg.453.1566412333290;
        Wed, 21 Aug 2019 11:32:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:12 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 05/17] arm64, hibernate: check pgd table allocation
Date:   Wed, 21 Aug 2019 14:31:52 -0400
Message-Id: <20190821183204.23576-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in create_safe_exec_page(), when page table is allocated
it is not checked that table is allocated successfully:

But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).

Another issue, is that phys_to_ttbr() uses an offset in page table instead
of pgd directly.

So, allocate page table, check that allocation was successful, and use it
directly to set ttbr0_el1.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index ee34a06d8a35..750ecc7f2cbe 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -199,6 +199,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 phys_addr_t *phys_dst_addr)
 {
 	void *page = (void *)get_safe_page(GFP_ATOMIC);
+	pgd_t *trans_pgd;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
@@ -210,7 +211,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy(page, src_start, length);
 	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
 
-	pgdp = pgd_offset_raw((void *)get_safe_page(GFP_ATOMIC), dst_addr);
+	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
+	if (!trans_pgd)
+		return -ENOMEM;
+
+	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = (void *)get_safe_page(GFP_ATOMIC);
 		if (!pudp)
@@ -251,7 +256,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	 */
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
+	write_sysreg(phys_to_ttbr(virt_to_phys(trans_pgd)), ttbr0_el1);
 	isb();
 
 	*phys_dst_addr = virt_to_phys(page);
-- 
2.23.0

