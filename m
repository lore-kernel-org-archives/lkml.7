Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F28FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739B9208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="F6Gayf2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfGaPKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:10:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41211 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388470AbfGaPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:08:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so65977310eds.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtVfWkAA6f5+WVvylDNJC/YjX6VpSH295mUWXLakGJs=;
        b=F6Gayf2vpoXGYJV1uYsSi1oz9m/Dzpd5ss3IOuggi2htSc6htYXpy88IVTNHrSo5Kq
         hWpzEyAGHC2mXZ2wjIjArOS3WPtQuYHcn8nT+/O5W6T39U8KBhjxYitFwEIaU42F/UUZ
         MNDJaDmYDJ2rhvFYveEcpSA76sB3cuT4BXBPtSCQ2kN740Cc3sAloiWNwrNa1DM5fuLc
         QNavgnJR+irD1X17yEJ886mr2816CG2BFT/M05u0Cg9IRy9uHdqMz7DhseDkDzn7Vz3t
         VhUu8iRxDz4AskPYJARFdivUJOn42HuHlC1NNjkGej7JPSPdAEioY0xwz3pfTdTU9bkn
         rRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtVfWkAA6f5+WVvylDNJC/YjX6VpSH295mUWXLakGJs=;
        b=YWA4cM8wvNFfdqfvJQE4Ylb2XMYmQ84v9g9QbGJ7cReQWsdXXKm3e9PUGNSK2Ydhtn
         cAOIqEhSN4nJQTWlQ1og+f3meL2NcEyadn8/V6B3jupXU2KLEmm0GuHLokSCT4HgIXsn
         pVjcQy7Qw/HqmevjhkYjUhd40CvlMx0AsMIQojiiJhXFBbLztTNHGUhPelhyIM5WNU/W
         Nvoh9ZbYZCyqkyLMilPD7K8K1UzFBOzeNA+iQowniNwf1AzgO3OS0nPC4LWVtyGD55xG
         H6UjA3uWe7tkDLUa8a1O5YTLDtKbjACehFS9ohIxhXu7LSKUHegfcCnTiqg0nado8/Vx
         36ZQ==
X-Gm-Message-State: APjAAAWNeh94bgk6RO6JkZunkJ0CIivhDM2wodjNUujPaWhOSVIOsiKo
        3tJEHaCZJPruD2wKjjbuhUc=
X-Google-Smtp-Source: APXvYqxpbVO0IZEgbCImRCWNwH0wevZHXyUPfYVpywOy9u0W0e5mFEX3kiMgbftkDicJ8087eYkuCA==
X-Received: by 2002:a17:906:7f16:: with SMTP id d22mr95105774ejr.17.1564585700959;
        Wed, 31 Jul 2019 08:08:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d7sm16505352edr.39.2019.07.31.08.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:08:19 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 1E8B210131E; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
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
Subject: [PATCHv2 07/59] x86/mm: Mask out KeyID bits from page table entry pfn
Date:   Wed, 31 Jul 2019 18:07:21 +0300
Message-Id: <20190731150813.26289-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MKTME claims several upper bits of the physical address in a page table
entry to encode KeyID. It effectively shrinks number of bits for
physical address. We should exclude KeyID bits from physical addresses.

For instance, if CPU enumerates 52 physical address bits and number of
bits claimed for KeyID is 6, bits 51:46 must not be threated as part
physical address.

This patch adjusts __PHYSICAL_MASK during MKTME enumeration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/intel.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8d6d92ebeb54..f03eee666761 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -616,6 +616,29 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		mktme_status = MKTME_ENABLED;
 	}
 
+#ifdef CONFIG_X86_INTEL_MKTME
+	if (mktme_status == MKTME_ENABLED && nr_keyids) {
+		/*
+		 * Mask out bits claimed from KeyID from physical address mask.
+		 *
+		 * For instance, if a CPU enumerates 52 physical address bits
+		 * and number of bits claimed for KeyID is 6, bits 51:46 of
+		 * physical address is unusable.
+		 */
+		phys_addr_t keyid_mask;
+
+		keyid_mask = GENMASK_ULL(c->x86_phys_bits - 1, c->x86_phys_bits - keyid_bits);
+		physical_mask &= ~keyid_mask;
+	} else {
+		/*
+		 * Reset __PHYSICAL_MASK.
+		 * Maybe needed if there's inconsistent configuation
+		 * between CPUs.
+		 */
+		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+	}
+#endif
+
 	/*
 	 * KeyID bits effectively lower the number of physical address
 	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
-- 
2.21.0

