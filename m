Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718A3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E23208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="DnqAXhTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfGaPYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:24:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37831 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfGaPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:23:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so66107128eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4Vs01tlfRxj/hdhWvsn+MzzX7wMrP0xYcTZ6W3t7PA=;
        b=DnqAXhTZp01yN6WSw/evIc0boNe52PO2BoJktJtMh2RgostVls+YOyjDU6sjdeAXpu
         pYNcxAcwMJyK9ACo0Uze5/331zleuRgZ8tdMXcyXHPouR7MjjLnzEm4vrrvRLtE8OL+z
         76Cfo0xHGEhi44+MBvlBGlpc/EOvonqmzkGktFkI44+xmuDaiqapmC1Xp/Y9zTg7OInG
         a9YhCGJldybaRAWWZ5RBIZd3ymSs+wsjDNu5AUmyHnhmm+vat7AO8LplmVvMjX0krWt7
         jQavX89FPCTjy4eg6GZ4rPAOp0XfZXIvJviPw7ZSaRn3QUgHcgBLfJ3RAn+sdl9p07vK
         IUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4Vs01tlfRxj/hdhWvsn+MzzX7wMrP0xYcTZ6W3t7PA=;
        b=lOsX1k6nETP/S3FPkRbju+zp9180x0L/ctKxkZzx6xuyyWdL3IFaEKVBx7QXGOpNBr
         FHXG3xOxoOYfutSNA19+McRR3fMGOw3Xo+CWO17T6h+FlsUy4RcK4h+/roopb5k6Drwa
         m7f2mecNjqLJZGfSBOxuoPrSn/bscdNQA8YtgExKjCMLBdz+b57xjcjiG1d9a1ChC3ka
         KOdNL9f9V9M+fT8F4un+5bM7be+iuBohmB4YiGX2b5f6uXoHv1NHvWO0lZndi/Yysk2y
         3xmdn9nbvYfueg8BIpFeAKkpne1ZO7Xy3NCW+oVM/rck2kNXn9YZYG1SrvDBL/Tn5Jwg
         8tYw==
X-Gm-Message-State: APjAAAWRSgrO+lv+MV65G86LynorpUnDLtRRpNv4MzU1KJDLJjjbM5Rd
        D6jhIkK1fjxzIHwcSka03u4=
X-Google-Smtp-Source: APXvYqzpD06BRkFUgNWq9pUNA5hd6n+ixu+p9XWwB3ULdCfnwz/4f2lQt2Iw5Gwg1+XUTttxmbAlwg==
X-Received: by 2002:a50:9116:: with SMTP id e22mr108657772eda.161.1564586630746;
        Wed, 31 Jul 2019 08:23:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 9sm8073176ejw.63.2019.07.31.08.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:23:49 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 6C43A1048A5; Wed, 31 Jul 2019 18:08:17 +0300 (+03)
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
Subject: [PATCHv2 53/59] x86: Introduce CONFIG_X86_INTEL_MKTME
Date:   Wed, 31 Jul 2019 18:08:07 +0300
Message-Id: <20190731150813.26289-54-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new config option to enabled/disable Multi-Key Total Memory
Encryption support.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f2cc88fe8ada..d8551b612f3b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1550,6 +1550,25 @@ config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
 	  If set to N, then the encryption of system memory can be
 	  activated with the mem_encrypt=on command line option.
 
+config X86_INTEL_MKTME
+	bool "Intel Multi-Key Total Memory Encryption"
+	depends on X86_64 && CPU_SUP_INTEL && !KASAN
+	select X86_MEM_ENCRYPT_COMMON
+	select PAGE_EXTENSION
+	select KEYS
+	select ACPI_HMAT
+	---help---
+	  Say yes to enable support for Multi-Key Total Memory Encryption.
+	  This requires an Intel processor that has support of the feature.
+
+	  Multikey Total Memory Encryption (MKTME) is a technology that allows
+	  transparent memory encryption in upcoming Intel platforms.
+
+	  MKTME is built on top of TME. TME allows encryption of the entirety
+	  of system memory using a single key. MKTME allows having multiple
+	  encryption domains, each having own key -- different memory pages can
+	  be encrypted with different keys.
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
@@ -2220,7 +2239,7 @@ config RANDOMIZE_MEMORY
 
 config MEMORY_PHYSICAL_PADDING
 	hex "Physical memory mapping padding" if EXPERT
-	depends on RANDOMIZE_MEMORY
+	depends on RANDOMIZE_MEMORY || X86_INTEL_MKTME
 	default "0xa" if MEMORY_HOTPLUG
 	default "0x0"
 	range 0x1 0x40 if MEMORY_HOTPLUG
-- 
2.21.0

