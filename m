Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8EBC4646C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678B92082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sF5cOlP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfFTLXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:23:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33977 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbfFTLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:23:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so4232828edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k6jBm3m8DhKgqtXjcF3v4YaO/nzyhYcWShmOHl2tfSA=;
        b=sF5cOlP6NF6MUZg1+D+OgOBtD7qusSeLF8QZokS+0uS7nCHJBEVXO5xQEhixcyDaRM
         vJwe+d9aJIbOQPIEEgmyn3J6HgjTUoFNmnJYkUbFAzvdkzdmX3cToNr8TBTY7b2jxZ1Y
         C/KYGG00xTZ7x41fTiPZxGK0JtV557kWBYbamsufxezraj0ul0E8I9maD+sC5/HDBDUq
         xO6PZ1rJFTEbKcIQbsZA0MZsgDmK1+Ym1+9JUr3GcEV1HakTGwmsu10aawo2LuHxaw2Z
         aWQlG42BwBvnt5NokkDYSDjhA7hLYq1cYk05cXIhkABXlXTbtLKnWzhrydJoGW77iAB/
         U0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k6jBm3m8DhKgqtXjcF3v4YaO/nzyhYcWShmOHl2tfSA=;
        b=h07BwfSjFdA1S96LFii04nRg6qhVnKSLBq7Gk5AwqJyOXa8r+j/icpvJIGoecx5XXM
         o8wfwnMewF+KzRJK9699sDrtTHFnK0uSc7HvU+XXEDg/6ycOS+EtoAfhf1Atxyc+7hNn
         N2i+27JpTmLx7oEZ3Bo2vA0RDyedZzSjWe4TFoAhL5vlkC3SNSYFrki2Gbo/kxfpeVhw
         O2tq/hocWdmAt1/HF/3bXVipDtdm6fnQbIx+9EqUwZWWoccqmDBbk/8vDD65JsT0qpAc
         0NsZnG3PULI829LzBofM14efZritHaX3bJq8tuX4u+OkZo+jv9T+JAPmW2+tAECyrOQn
         RkYw==
X-Gm-Message-State: APjAAAW/gR3t1abYcDApqCyKwxQqYFpcZJnHAgN5GDwRdCEc/nt8uEzp
        5amSCfS9jcaRbJX29eerz6C5oA==
X-Google-Smtp-Source: APXvYqxsWEGg3RQMKWsF+3b6YFJfMktg+JBLTx3Csvcy05kd/bEIAmUXXkB4WZjXHwloCXz/SUCZNA==
X-Received: by 2002:a50:addc:: with SMTP id b28mr42393604edd.174.1561029832083;
        Thu, 20 Jun 2019 04:23:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y21sm3736798ejm.60.2019.06.20.04.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 04:23:51 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 96CA01040F8; Thu, 20 Jun 2019 14:23:49 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/boot/64: Fix crash if kernel images crosses page table boundary
Date:   Thu, 20 Jun 2019 14:23:45 +0300
Message-Id: <20190620112345.28833-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel that boots in 5-level paging mode crashes in small percentage of
cases if KASLR is enabled.

This issue was tracked down to the case when the kernel image unpack in
the way it crosses 1G boundary. The crash was due to overrun of PMD page
table in __startup_64() and corruption of P4D page table allocated next
to it.

The issue is not visible with 4-level paging as we don't use the P4D
page table.

The root cause is that the handling of page table wraparound was lost
when part of startup_64() was rewritten in C.

Restore the handling. It also fixes the issue when the kernel image put
across 512G and, for 5-level paging, 64T boundary.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: c88d71508e36 ("x86/boot/64: Rewrite startup_64() in C")
---
 arch/x86/kernel/head64.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4d98ba8063d1..b502c28801fc 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -190,18 +190,18 @@ unsigned long __head __startup_64(unsigned long physaddr,
 		pgd[i + 0] = (pgdval_t)p4d + pgtable_flags;
 		pgd[i + 1] = (pgdval_t)p4d + pgtable_flags;
 
-		i = (physaddr >> P4D_SHIFT) % PTRS_PER_P4D;
-		p4d[i + 0] = (pgdval_t)pud + pgtable_flags;
-		p4d[i + 1] = (pgdval_t)pud + pgtable_flags;
+		i = physaddr >> P4D_SHIFT;
+		p4d[(i + 0) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
+		p4d[(i + 1) % PTRS_PER_P4D] = (pgdval_t)pud + pgtable_flags;
 	} else {
 		i = (physaddr >> PGDIR_SHIFT) % PTRS_PER_PGD;
 		pgd[i + 0] = (pgdval_t)pud + pgtable_flags;
 		pgd[i + 1] = (pgdval_t)pud + pgtable_flags;
 	}
 
-	i = (physaddr >> PUD_SHIFT) % PTRS_PER_PUD;
-	pud[i + 0] = (pudval_t)pmd + pgtable_flags;
-	pud[i + 1] = (pudval_t)pmd + pgtable_flags;
+	i = physaddr >> PUD_SHIFT;
+	pud[(i + 0) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
+	pud[(i + 1) % PTRS_PER_PUD] = (pudval_t)pmd + pgtable_flags;
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
@@ -211,8 +211,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pmd_entry +=  physaddr;
 
 	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
-		int idx = i + (physaddr >> PMD_SHIFT) % PTRS_PER_PMD;
-		pmd[idx] = pmd_entry + i * PMD_SIZE;
+		int idx = i + (physaddr >> PMD_SHIFT);;
+		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
 	}
 
 	/*
-- 
2.21.0

