Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7F4C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AB9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="gQI/TJw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbfGaPIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:08:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37840 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388575AbfGaPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:08:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id w13so66061047eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Khe0ucVPgmVgmnJxVPmTI2qFbR46a/XU3GbaeIl9uc=;
        b=gQI/TJw+wOqQw6LekNivfnNF6fibSqE/4WRzpwQ/xFvdfdzWIOKXpHhUn1bQVL5jdd
         s8R19Qps0QXcAPV0lO52UPBPITRDjAjDh/SdNDwu3XRjm5lsTT8qIamQcIZguTQYJIiB
         yIDfiSG+yNKGj0VjCG1RwhE4MWsax7zVXdKlnNwaiqDH/+nGjkdysfv6DFMPxlgpyJ3M
         o4jOiLhIl2Dn3zA6LPYDjCqNEtUQXPdGkN8q+07zTnoXPf13J7sXjetyVxHr4kSOq0fX
         pfmdMsUgm3rA6XWvbZ6saiZTASDDzRaVlogKfpNeKQARtiXGKhBjMKlIiR+9TtiOMwHK
         UhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Khe0ucVPgmVgmnJxVPmTI2qFbR46a/XU3GbaeIl9uc=;
        b=iRwxEokkNSwARBSBPVYsGbHxwaxFDxb7trjG7LFBG6bsc4Xc7GxntAaGC8CnuCjjmA
         OFv9xsABtJR6fLGxzXPt+aVsnI/ZMYszPZLo9Nn991DEarkQnri79wCfImj/LrQGV/rq
         mbUbxtEJ4707XMGWe8y3yC9bVS+M9Lfnsadau+cxpygKjOH0T1A4vN4tIaTiapn739bN
         ifHjJ+ORVJ6NG0nEjtU2T+fP4Ycd8rswHv2kQLaZoDwhK6306vSD2TflTc/aX/VkjSDf
         QOX9JUWoAVoJvkTIcqCOUzJabBn/eNFxi6wdCmHmp5mOlMOdm2uaMKi4JfEkIlTYUMOB
         4ZOQ==
X-Gm-Message-State: APjAAAUu6re6ocEXu3ietc5pVo0C0RXX4fTDjzyk9sA8uXqGDwkHnJHL
        6xlllV64CllyEVZfURAAgkc=
X-Google-Smtp-Source: APXvYqyYETJB0gBc/rsdzF8ujwDgg52+44KLAYVNOsjGpZelFLVDgZMEkF6ZatMWv69FcpZwOd/juw==
X-Received: by 2002:a50:ad2c:: with SMTP id y41mr105394092edc.300.1564585707403;
        Wed, 31 Jul 2019 08:08:27 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b30sm17643661ede.88.2019.07.31.08.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:08:22 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 56F3C1023AA; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 15/59] x86/mm: Map zero pages into encrypted mappings correctly
Date:   Wed, 31 Jul 2019 18:07:29 +0300
Message-Id: <20190731150813.26289-16-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero pages are never encrypted. Keep KeyID-0 for them.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0bc530c4eb13..f0dd80a920a9 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -820,6 +820,19 @@ static inline unsigned long pmd_index(unsigned long address)
  */
 #define mk_pte(page, pgprot)   pfn_pte(page_to_pfn(page), (pgprot))
 
+#define mk_zero_pte mk_zero_pte
+static inline pte_t mk_zero_pte(unsigned long addr, pgprot_t prot)
+{
+	extern unsigned long zero_pfn;
+	pte_t entry;
+
+	prot.pgprot &= ~mktme_keyid_mask();
+	entry = pfn_pte(zero_pfn, prot);
+	entry = pte_mkspecial(entry);
+
+	return entry;
+}
+
 /*
  * the pte page can be thought of an array like this: pte_t[PTRS_PER_PTE]
  *
@@ -1153,6 +1166,12 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 
 #define mk_pmd(page, pgprot)   pfn_pmd(page_to_pfn(page), (pgprot))
 
+#define mk_zero_pmd(zero_page, prot)					\
+({									\
+	prot.pgprot &= ~mktme_keyid_mask();				\
+	pmd_mkhuge(mk_pmd(zero_page, prot));				\
+})
+
 #define  __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 extern int pmdp_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp,
-- 
2.21.0

