Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090B2C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14612064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="McRooZfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGaPKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:10:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35916 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388436AbfGaPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:08:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so66032841edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UEVrEENQF6GgqskaCpeVIXbw1wxW9ZHP7LEfmwaIX1Y=;
        b=McRooZfyR/RpXN5XMwhhQ4fnXOkpn46XyCphce8PhxPou3dx2i+zeEUPZwHp8TipgC
         BGI1enXNjaRfPWABi/58N/CnaStzBfe7I/sVoHLEwUVWO5RPpvbMnQlhUk+vrP5KitP0
         xlN7apakZ23IIc8QM67elrLhwzfh8ZdwIfgG4AOrbh58L2rHumcrLS2HKAJ0RvRNAs4E
         tHD5vqNYW5h49SvrGSAt/0No/7IhX7t7K59+y1G7hgFuma9uWtGUIV6MdVueE6BaPNDj
         +qOFDedI65e57Y1anrGxh7x7TSxMfmTc9skU5uDbNPifz28H6hTWzz2877Q1hXd1xky2
         0RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEVrEENQF6GgqskaCpeVIXbw1wxW9ZHP7LEfmwaIX1Y=;
        b=X6dNi0W/zYt4u335hm6iWp5+unxU1pg29ISqcEhnfwYbdxu8eJHHKBXYby3txWfooQ
         jxG6AJaQuvcLy2b9HuPbjrqUHe9tDhLz17TfJFzCoZ3xEe1agFPfanXhtDLXg4bes7zr
         3pMw87baVsx+qme0i0cbEz1Gg5sfOo3CbKpLfhGODOskJ4vowkszNDCmjX7/EyYuYpIZ
         OvSwUBwSaU34Ztk9hqEzYXdbruVBFqgB8zaaVrsv/l5JswpBzJhNyZtkRLM3qGj+aorP
         DKUvaCBSF6niePqzzP/SM9K4T8y1b3YNBK42Bf1hQgl24YzAt6WX6xfM49aKMXSnNTdN
         KnMg==
X-Gm-Message-State: APjAAAXtRU41jZAIs9MRwgtIrf4F72SnFiqZeqxvEKVLXloaY/xdK97f
        ZmaZyT4A5otmoD2F7ic5yCk=
X-Google-Smtp-Source: APXvYqz0kJ4Lqf/rOwIPdDm01UGfUWsjDSwUjlM7k6Av4cmEuFi6nnooAYqixqH6Nb/ho2xl1lQryA==
X-Received: by 2002:a50:a3ec:: with SMTP id t41mr107352548edb.43.1564585701601;
        Wed, 31 Jul 2019 08:08:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a9sm17507685edc.44.2019.07.31.08.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:08:19 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 33AC2101321; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
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
Subject: [PATCHv2 10/59] x86/mm: Preserve KeyID on pte_modify() and pgprot_modify()
Date:   Wed, 31 Jul 2019 18:07:24 +0300
Message-Id: <20190731150813.26289-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An encrypted VMA will have KeyID stored in vma->vm_page_prot. This way
we don't need to do anything special to setup encrypted page table
entries and don't need to reserve space for KeyID in a VMA.

This patch changes _PAGE_CHG_MASK to include KeyID bits. Otherwise they
are going to be stripped from vm_page_prot on the first pgprot_modify().

Define PTE_PFN_MASK_MAX similar to PTE_PFN_MASK but based on
__PHYSICAL_MASK_SHIFT. This way we include whole range of bits
architecturally available for PFN without referencing physical_mask and
mktme_keyid_mask variables.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable_types.h | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b5e49e6bac63..c23793146759 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -116,12 +116,25 @@
 				 _PAGE_ACCESSED | _PAGE_DIRTY)
 
 /*
- * Set of bits not changed in pte_modify.  The pte's
- * protection key is treated like _PAGE_RW, for
- * instance, and is *not* included in this mask since
- * pte_modify() does modify it.
+ * Set of bits not changed in pte_modify.
+ *
+ * The pte's protection key is treated like _PAGE_RW, for instance, and is
+ * *not* included in this mask since pte_modify() does modify it.
+ *
+ * They include the physical address and the memory encryption keyID.
+ * The paddr and the keyID never occupy the same bits at the same time.
+ * But, a given bit might be used for the keyID on one system and used for
+ * the physical address on another. As an optimization, we manage them in
+ * one unit here since their combination always occupies the same hardware
+ * bits. PTE_PFN_MASK_MAX stores combined mask.
+ *
+ * Cast PAGE_MASK to a signed type so that it is sign-extended if
+ * virtual addresses are 32-bits but physical addresses are larger
+ * (ie, 32-bit PAE).
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
+#define PTE_PFN_MASK_MAX \
+	(((signed long)PAGE_MASK) & ((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
+#define _PAGE_CHG_MASK	(PTE_PFN_MASK_MAX | _PAGE_PCD | _PAGE_PWT |		\
 			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
 			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
-- 
2.21.0

