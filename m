Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B9DC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6482147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QEOkJI1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfHERFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:05:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42782 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbfHERFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:05:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so40054102pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RUBxnyz640QfvTz6lz/Tqs2pyOPmGqnxC24rkQCQqR8=;
        b=QEOkJI1uuZ+jSdOl6tBfEcxS4lwaMuWo43bvHb8IEHarKAyNN0MWV5t12h+iKsm8dO
         J7HViNVcJnELGFCNRTAE5kuQ6V6zX93lvwyuOag45IAvbLYcCRmpuzE0Y8TZwWBke/rZ
         +zU9hexd9hgPeIjOktomqrMSW7rr5L8f+KbsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUBxnyz640QfvTz6lz/Tqs2pyOPmGqnxC24rkQCQqR8=;
        b=sdBiC5VPVw8Q9fJyYHMxbRXE9JQHdHXY4QeqZqjOPJWQXgSsCh106i++sDVTWWP2dw
         rnxcv5b/HRoPFOJsOq8L078PPtiH3xduSAequ7R9eUE+4ym7e47EYe5zbIIm3wqTSWYT
         11viTCIb92ej0usR3RMEDHCpFugPKjMclyLRdgDF8HXHRvOLk82sQE+UQQkmzizrkdhe
         GLV8Sgn9EqFT0zJpueozyzRN7EYH9YMDzdOKXmJFVa0GdtFFW3vkTgeObjdb2CV4jBLF
         67BEm/aLXSCAVsOw+IKR1cvz74Pgn+gyLZ07cIoJaYHWw5IicNUqqVu9dCqU7G7MHYm9
         tFJg==
X-Gm-Message-State: APjAAAWxDIRO8YnE8uK9LvaTy3JLloAp3vEF7qnsiecUjm2d9sxjPxH8
        M5tYGr79hg5+cO4u3of1BOGDrU5P
X-Google-Smtp-Source: APXvYqwnR2jAWfV7TWIbHzeRGGMkSbdfN64oix1so/G/sVSVrD4k1Fz1wn7L6kV9yuqrFmYXXVE03A==
X-Received: by 2002:a62:7a8a:: with SMTP id v132mr73809561pfc.103.1565024712416;
        Mon, 05 Aug 2019 10:05:12 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p23sm89832934pfn.10.2019.08.05.10.05.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:05:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 3/5] [RFC] arm64: Add support for idle bit in swap PTE
Date:   Mon,  5 Aug 2019 13:04:49 -0400
Message-Id: <20190805170451.26009-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805170451.26009-1-joel@joelfernandes.org>
References: <20190805170451.26009-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bit will be used by idle page tracking code to correctly identify
if a page that was swapped out was idle before it got swapped out.
Without this PTE bit, we lose information about if a page is idle or not
since the page frame gets unmapped.

In this patch we reuse PTE_DEVMAP bit since idle page tracking only
works on user pages in the LRU. Device pages should not consitute those
so it should be unused and safe to use.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/pgtable-prot.h |  1 +
 arch/arm64/include/asm/pgtable.h      | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..9d1412c693d7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -128,6 +128,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
+	select HAVE_ARCH_PTE_SWP_PGIDLE
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 92d2e9f28f28..917b15c5d63a 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -18,6 +18,7 @@
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
+#define PTE_SWP_PGIDLE		PTE_DEVMAP		 /* for idle page tracking during swapout */
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3f5461f7b560..558f5ebd81ba 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -212,6 +212,21 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return set_pte_bit(pte, __pgprot(PTE_DEVMAP));
 }
 
+static inline int pte_swp_page_idle(pte_t pte)
+{
+	return 0;
+}
+
+static inline pte_t pte_swp_mkpage_idle(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_SWP_PGIDLE));
+}
+
+static inline pte_t pte_swp_clear_page_idle(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_SWP_PGIDLE));
+}
+
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	WRITE_ONCE(*ptep, pte);
-- 
2.22.0.770.g0f2c4a37fd-goog

