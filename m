Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62030C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3567B208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="wnJQX8mA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfGaPWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:22:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39860 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfGaPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:21:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so66051557edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eu+g52fZa4bEGKyIAIp4EBxePC6msthuJH3Uu+nPhTw=;
        b=wnJQX8mAznJJYoCaujK7jTh3QOUX6PWjjuHiLLJcqeV5ss0Z+2QOjKE/V/f7i2iOiK
         nWVMBrRzOEuvD50CqQeMSrlLn2yn9nza0e9HYNf9Ci+gZHXztuPcnXQO8Dv/jueUicfh
         7x8hxn+DoCcOemE+5xb8GVrcsoOF21pEeWL359gwrBqCcOEFkYVISmg99A9v32xeC8nY
         K1fXvjaKfAQ0uf1yUKgRc0FXE0a1c8GjVdeZkh9RF4YCM+ZniD98ehoTPZKfBwPrhyWd
         vT4LGzn8l+GiV/PrV8efZhSU7sLAmcDsKabNfPrtzDTZJ+6VtoCaBOiq1M24C/XlfUJi
         ySJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eu+g52fZa4bEGKyIAIp4EBxePC6msthuJH3Uu+nPhTw=;
        b=mY7hQfJoWiEWuj+Y6VGuv0osK/yywFEGqokEkvIaMvtm9bgaFJHmFF4OyFrjOgy/kl
         nkneycoT0JB+rnSK+zUHAR1rTA4rbv/GbUnmEJ2ryV8c7SajeD/ILf16/sanNyP6CEMV
         EMqLrLD91rtNK9e7Qc+20qNyrkQ/J42JE3IsqINtesR527Qy3l+BYOMe9Dc4wgcsz2l1
         aqohRRVBa4jiTctsdOBnF4u/to2Ll03kjOnym2J/8NMLarYyo7zFOMlwQ0JA9PFXMSvz
         SY1+zuNpkkYrYZcQi3ys0PVi89WdAxgMA5U/3jLOQgr54NEDfyYech6ABxjgcJfG6nWL
         YBBw==
X-Gm-Message-State: APjAAAVQVursjuP7J15WvfFnGuFmMsDR5z35b57w4rGCHDvmnKxKJkLQ
        RA3HiJwNPG1xkgBHggavH50=
X-Google-Smtp-Source: APXvYqxAI13PpDAJZQellLR+hBXyuxC6IRUxmch2g01/3TCjBtlaolRAKh1msonh8wE/v8SwQy/t/w==
X-Received: by 2002:a50:addc:: with SMTP id b28mr108191573edd.174.1564586031854;
        Wed, 31 Jul 2019 08:13:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l2sm16613746edn.59.2019.07.31.08.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:13:50 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 7A1691030BB; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
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
Subject: [PATCHv2 20/59] x86/mm: Handle encrypted memory in page_to_virt() and __pa()
Date:   Wed, 31 Jul 2019 18:07:34 +0300
Message-Id: <20190731150813.26289-21-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per-KeyID direct mappings require changes into how we find the right
virtual address for a page and virt-to-phys address translations.

page_to_virt() definition overwrites default macros provided by
<linux/mm.h>.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/page.h    | 3 +++
 arch/x86/include/asm/page_64.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 39af59487d5f..aff30554f38e 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -72,6 +72,9 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 extern bool __virt_addr_valid(unsigned long kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
 
+#define page_to_virt(x) \
+	(__va(PFN_PHYS(page_to_pfn(x))) + page_keyid(x) * direct_mapping_size)
+
 #endif	/* __ASSEMBLY__ */
 
 #include <asm-generic/memory_model.h>
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index f57fc3cc2246..a4f394e3471d 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -24,7 +24,7 @@ static inline unsigned long __phys_addr_nodebug(unsigned long x)
 	/* use the carry flag to determine if x was < __START_KERNEL_map */
 	x = y + ((x > y) ? phys_base : (__START_KERNEL_map - PAGE_OFFSET));
 
-	return x;
+	return x & direct_mapping_mask;
 }
 
 #ifdef CONFIG_DEBUG_VIRTUAL
-- 
2.21.0

