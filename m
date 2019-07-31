Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A263C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5C22064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="BHAeXd7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbfGaPKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:10:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37829 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388533AbfGaPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:08:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so66060906eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JEZNWwFcWS55jw+6SIN48eCAvZTaxQLDv71jatzDjOE=;
        b=BHAeXd7gVXgBxYu3UUq38JWfB9LxZIY8nRNcqLidTcyniNbN1kGL7m8gr0DYCgHyfo
         bYCkEUg7twHqYl9//YYyF3oRucuIzp6d8krWu5AXZuwBtWBWqFWBt/UfnX3pxSNussqT
         vPwPX9shBW0HElOKWXJF5lb9bZsc1LRrg5iG4cMsZyUylv9NMvgzxJC+ak2MqH41uDGx
         kDLz4WiHVp5dMULHZ0AJck/7y17op+S1LY4RIr4iUP8aw3l+KaMe13SwSVOBLq30rQZD
         RxmVZou3sCnH16cwB+iAELC3TlHF1bUMdJfNLvVlBfrQL9P/s9szyRTBQ5Oj+oYcjPpJ
         mDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEZNWwFcWS55jw+6SIN48eCAvZTaxQLDv71jatzDjOE=;
        b=t6pmul2ZJ6LwxU84e6sqwBHGu5wGShNbJoqv1eTj4Y5z2lpVMJxXchLK3Hm3XWhsVx
         ByzH03S3li9o2d4ISQEpJnnkcen+kneL6Rx7Oesv0q9XqEoZq+0St9NFbZOoNpTetz9A
         1/rxEpcc6ezVk5ePJVuViNNuLcdga8JZxWu7A3+XnNRGfbFVjY+gcjWVdI7Swbg5nOVl
         KgmI3znO/LuIiWeU2LjkvYKr4GKNPU9qkDjzTQ/RecsocjE1oNwetcZG54q9V7n2qe5a
         C0uJCHItxFQCuLKGtMkuyMqtkL1apIgSJ8VqDtr3iV6ZnuXbT3WPnkPgHzCALue6QcK0
         lFvA==
X-Gm-Message-State: APjAAAU9dlsA7PtFb8Az9xDAc4680ysL4U654NP7U+u0JXTg/fqPBc37
        YyWJS7JekTsSOgGYZ5B7HBQ=
X-Google-Smtp-Source: APXvYqwrlyk+jtOIzcQNAVf6976bJtJVVuXE4BPNEUU4FrC1EBQZ1KrsVfR+sDVvD7XGNJvKjIp/UA==
X-Received: by 2002:a05:6402:1212:: with SMTP id c18mr108401816edw.7.1564585704701;
        Wed, 31 Jul 2019 08:08:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w14sm17419509eda.69.2019.07.31.08.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:08:22 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 48F28101324; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
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
Subject: [PATCHv2 13/59] x86/mm: Add a helper to retrieve KeyID for a VMA
Date:   Wed, 31 Jul 2019 18:07:27 +0300
Message-Id: <20190731150813.26289-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We store KeyID in upper bits for vm_page_prot that match position of
KeyID in PTE. vma_keyid() extracts KeyID from vm_page_prot.

With KeyID in vm_page_prot we don't need to modify any page table helper
to propagate the KeyID to page table entires.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 12 ++++++++++++
 arch/x86/mm/mktme.c          |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index 46041075f617..52b115b30a42 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -5,6 +5,8 @@
 #include <linux/page_ext.h>
 #include <linux/jump_label.h>
 
+struct vm_area_struct;
+
 #ifdef CONFIG_X86_INTEL_MKTME
 extern phys_addr_t __mktme_keyid_mask;
 extern phys_addr_t mktme_keyid_mask(void);
@@ -31,6 +33,16 @@ static inline int page_keyid(const struct page *page)
 	return lookup_page_ext(page)->keyid;
 }
 
+#define vma_keyid vma_keyid
+int __vma_keyid(struct vm_area_struct *vma);
+static inline int vma_keyid(struct vm_area_struct *vma)
+{
+	if (!mktme_enabled())
+		return 0;
+
+	return __vma_keyid(vma);
+}
+
 #else
 #define mktme_keyid_mask()	((phys_addr_t)0)
 #define mktme_nr_keyids()	0
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index 48c2d4c97356..d02867212e33 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,3 +1,4 @@
+#include <linux/mm.h>
 #include <asm/mktme.h>
 
 /* Mask to extract KeyID from physical address. */
@@ -48,3 +49,9 @@ struct page_ext_operations page_mktme_ops = {
 	.need = need_page_mktme,
 	.init = init_page_mktme,
 };
+
+int __vma_keyid(struct vm_area_struct *vma)
+{
+	pgprotval_t prot = pgprot_val(vma->vm_page_prot);
+	return (prot & mktme_keyid_mask()) >> mktme_keyid_shift();
+}
-- 
2.21.0

