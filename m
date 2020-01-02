Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C40C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3084B217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XMSSOxhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgABVOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:14:16 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45567 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgABVOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:14:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id l12so35523516qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 13:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bK4p0uPVg9F/zZFyAk0NT01Djfe92ua8x9zSOEpgX0c=;
        b=XMSSOxhTUK43GOVMljv5Cr5RwtQATimoiWSKuX7QZwiSG8p+nVz0KElLQ3KYQppki3
         0nADKJW7oyFzaH1xdSee260L/7vjgMZdEHP2KYpS7xKLygmPvS8VddrKfiLWXq0XQ1tP
         mTMSHtbTPyMWMaifPK5FVD6QfHcv0NRPdCdtM5ui6/cDUzO06+YMIzcHoowYKWU1aFgg
         wkQawwqKyctGRtTYSl7BQk4ajl6X6Q5HvRqqFG+B7KtWTo7blSz7k8hIsDBLPlkkOCga
         LAh4lkeONzIjNUh1xzjZu+zRc9CbIjC0AgHidY3wCZKO3lbJyAT7kdCN5KazAfL2M+Fx
         8tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bK4p0uPVg9F/zZFyAk0NT01Djfe92ua8x9zSOEpgX0c=;
        b=BWBv/IecavbRvcVd4shBoO/RdjWDz+T7FEdKN7uCNv0ycJiBTOnrfiF7exko1R1OPD
         TpNTzXFOJwZA0VHyvovrwJIQWQ74oLZE/61jHhDGLiMJ4CuLtAKZRsG6blvmPSh71CZA
         OctbkFYH2HdhUsWYy5eto50XD5lPcpDrXC/EuUXs62HFrOtq/ZbsMCqzTaMvqWl+fyzk
         buLnJJhoca01iUXKphYHtYsrLUYRJQ7cHyTw7Yi3o0epZ8rWjHupNuxlUHAUsBkw7LHt
         MyJIf51uowYbFXpEDF0l6pd94MGH5ZbajZgADd3XR4d5iYz877ged5bO5PFiMb88bmSc
         KgQQ==
X-Gm-Message-State: APjAAAUXdveqbpB+Y2ONVi9Rkcb9ea30RsukDDiz3SPHVAri3cRpjg3y
        +W7pji/BIMCALJcuyU2I9W0vQw==
X-Google-Smtp-Source: APXvYqzDcF3N2y5hK5g2wp8jkF8WiIMA7CVV2LBb1kzom8ECtZ3Q8uEzKO01/KlbgewDQgLy3pJe1g==
X-Received: by 2002:ac8:7b4f:: with SMTP id m15mr62174264qtu.48.1577999649205;
        Thu, 02 Jan 2020 13:14:09 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f97sm17384185qtb.18.2020.01.02.13.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 13:14:08 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk,
        andrew.cooper3@citrix.com, julien@xen.org
Subject: [PATCH v5 5/6] arm64: move ARM64_HAS_CACHE_DIC/_IDC from asm to C
Date:   Thu,  2 Jan 2020 16:13:56 -0500
Message-Id: <20200102211357.8042-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102211357.8042-1-pasha.tatashin@soleen.com>
References: <20200102211357.8042-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assmbly functions __asm_flush_cache_user_range and
__asm_invalidate_icache_range have alternatives:

alternative_if ARM64_HAS_CACHE_DIC
...

alternative_if ARM64_HAS_CACHE_IDC
...

But, the implementation of those alternatives is trivial and therefore
can be done in the C inline wrappers.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/cacheflush.h | 19 +++++++++++++++++++
 arch/arm64/mm/cache.S               | 27 +++++----------------------
 arch/arm64/mm/flush.c               |  1 +
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 047af338ba15..fc5217a18398 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -77,8 +77,22 @@ static inline long __flush_cache_user_range(unsigned long start,
 {
 	int ret;
 
+	if (cpus_have_const_cap(ARM64_HAS_CACHE_IDC)) {
+		dsb(ishst);
+		if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
+			isb();
+			return 0;
+		}
+	}
+
 	uaccess_ttbr0_enable();
 	ret = __asm_flush_cache_user_range(start, end);
+
+	if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
+		isb();
+	else
+		__asm_invalidate_icache_range(start, end);
+
 	uaccess_ttbr0_disable();
 
 	return ret;
@@ -94,6 +108,11 @@ static inline int invalidate_icache_range(unsigned long start,
 {
 	int ret;
 
+	if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
+		isb();
+		return 0;
+	}
+
 	uaccess_ttbr0_enable();
 	ret = __asm_invalidate_icache_range(start, end);
 	uaccess_ttbr0_disable();
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 1981cbaf5d92..0093bb9fcd12 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -25,30 +25,18 @@
  *	- end     - virtual end address of region
  */
 ENTRY(__asm_flush_cache_user_range)
-alternative_if ARM64_HAS_CACHE_IDC
-	dsb	ishst
-	b	7f
-alternative_else_nop_endif
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	bic	x4, x0, x3
-1:
-user_alt 9f, "dc cvau, x4",  "dc civac, x4",  ARM64_WORKAROUND_CLEAN_CACHE
+1:	user_alt 3f, "dc cvau, x4",  "dc civac, x4",  ARM64_WORKAROUND_CLEAN_CACHE
 	add	x4, x4, x2
 	cmp	x4, x1
 	b.lo	1b
 	dsb	ish
-
-7:
-alternative_if ARM64_HAS_CACHE_DIC
-	isb
-	b	8f
-alternative_else_nop_endif
-	invalidate_icache_by_line x0, x1, x2, x3, 9f
-8:	mov	x0, #0
-1:	ret
-9:	mov	x0, #-EFAULT
-	b	1b
+	mov	x0, #0
+2:	ret
+3:	mov	x0, #-EFAULT
+	b	2b
 ENDPROC(__asm_flush_cache_user_range)
 
 /*
@@ -60,11 +48,6 @@ ENDPROC(__asm_flush_cache_user_range)
  *	- end     - virtual end address of region
  */
 ENTRY(__asm_invalidate_icache_range)
-alternative_if ARM64_HAS_CACHE_DIC
-	mov	x0, xzr
-	isb
-	ret
-alternative_else_nop_endif
 	invalidate_icache_by_line x0, x1, x2, x3, 2f
 	mov	x0, xzr
 1:	ret
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 61521285f27d..adfdacb163ad 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -76,6 +76,7 @@ EXPORT_SYMBOL(flush_dcache_page);
  * Additional functions defined in assembly.
  */
 EXPORT_SYMBOL(__asm_flush_cache_user_range);
+EXPORT_SYMBOL(__asm_invalidate_icache_range);
 
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size)
-- 
2.17.1

