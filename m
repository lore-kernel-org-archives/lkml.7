Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F5DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90FE22296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfGVPms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:42:48 -0400
Received: from foss.arm.com ([217.140.110.172]:40204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbfGVPmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:42:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BDA01509;
        Mon, 22 Jul 2019 08:42:45 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 257E33F694;
        Mon, 22 Jul 2019 08:42:42 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v9 07/21] s390: mm: Add p?d_leaf() definitions
Date:   Mon, 22 Jul 2019 16:41:56 +0100
Message-Id: <20190722154210.42799-8-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722154210.42799-1-steven.price@arm.com>
References: <20190722154210.42799-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_leaf() functions/macros.

For s390, pud_large() and pmd_large() are already implemented as static
inline functions. Add a macro to provide the p?d_leaf names for the
generic code to use.

CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/s390/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 9b274fcaacb6..f99a5f546e5e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -674,6 +674,7 @@ static inline int pud_none(pud_t pud)
 	return pud_val(pud) == _REGION3_ENTRY_EMPTY;
 }
 
+#define pud_leaf	pud_large
 static inline int pud_large(pud_t pud)
 {
 	if ((pud_val(pud) & _REGION_ENTRY_TYPE_MASK) != _REGION_ENTRY_TYPE_R3)
@@ -691,6 +692,7 @@ static inline unsigned long pud_pfn(pud_t pud)
 	return (pud_val(pud) & origin_mask) >> PAGE_SHIFT;
 }
 
+#define pmd_leaf	pmd_large
 static inline int pmd_large(pmd_t pmd)
 {
 	return (pmd_val(pmd) & _SEGMENT_ENTRY_LARGE) != 0;
-- 
2.20.1

