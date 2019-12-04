Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE41C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB6022525
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GnME/3GQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfLDXVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:21:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43604 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfLDXVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:21:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id q28so1639125qkn.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jgWMYHD023tAXPY9yBvY7HlxUi3NtG7yB+YFJsFM+4s=;
        b=GnME/3GQIkWEOnq+HnWtjzDW7KOeACVPsdHQBWSmyQiiOW1JrEqbNdO1yXHOHEGGLa
         uiDQATmlJ+LFhPgQXv8Zf0F4NJElVwhSGKvmCcAUMQv+wEkB+XJDpMyg6iSNtxNh7VMy
         4YRsLqt/0+myzBWoF8xlK6sHJAEmEPWcOsskDtof8qDxEGxli6obH0/ql8HXvOYyNOx0
         E4CqVF/g/r8Y9BXPjdTCfVR8SCXfFoQnrtKWfB6fqzn7mEoF7LZSIahhhG8TlbwvWdi0
         eV1TWGsF+FoGohnl0fwH163lctm1VQfxvAxKHjBKsqfJP8bqMssseBKgpDoDEsAqYzvT
         ACgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jgWMYHD023tAXPY9yBvY7HlxUi3NtG7yB+YFJsFM+4s=;
        b=TRKzPpGRRMrsCw0rZKyVzuWnE9aeL8crYcDvWAjPRO6/kLOInKP/QfWAKj9ygv7VeJ
         66a3TF/846niBwbW50meMQ6f3CjsZrVRXn5HaBJmXyni8HWcLdVTvZTvJjr9gk3NvWJK
         50gX/KDO5/BgUpKzF5FPBflb2myAOFxzbJQeytDcj+8YPNWVELw9/J1mAB9NDNRi+RjK
         k6Lm5Opzlkaz4RxOwOlII2mDGaxurI4arr8l/C16O+mPrWi6tncvpP90xINHshz9qnSV
         lpRmU1fvCcZOnYMo3Bk2If1SSPsK0kFxHRl5k0ErEetwAuaL/m/uA3gC3Tl6i4t0rPMO
         iS1w==
X-Gm-Message-State: APjAAAW6S7kwqsl7dK82HOVqZRyzpaS3ZqacvMx660L5myzDSMJigIp9
        HIJTmDiOWFa8JAd85+KD2317yw==
X-Google-Smtp-Source: APXvYqxYW3lHiAaEktvIv9R2Rs4Q7wh7u41fkOvqH028QUBhjHchCrv3OL1EskvJ6xR8p1wI4qmnmw==
X-Received: by 2002:a05:620a:102e:: with SMTP id a14mr5398925qkk.159.1575501670158;
        Wed, 04 Dec 2019 15:21:10 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t38sm4667864qta.78.2019.12.04.15.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 15:21:09 -0800 (PST)
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
Subject: [PATCH v4 5/6] arm64: move ARM64_HAS_CACHE_DIC/_IDC from asm to C
Date:   Wed,  4 Dec 2019 18:20:57 -0500
Message-Id: <20191204232058.2500117-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
References: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index ea563344b4ad..4eb244ee7154 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -75,8 +75,22 @@ extern void sync_icache_aliases(void *kaddr, unsigned long len);
 static inline void __flush_cache_user_range(unsigned long start,
 					    unsigned long end)
 {
+	if (cpus_have_const_cap(ARM64_HAS_CACHE_IDC)) {
+		dsb(ishst);
+		if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
+			isb();
+			return;
+		}
+	}
+
 	uaccess_ttbr0_enable();
 	__asm_flush_cache_user_range(start, end);
+
+	if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
+		isb();
+	else
+		__asm_invalidate_icache_range(start, end);
+
 	uaccess_ttbr0_disable();
 }
 
@@ -90,6 +104,11 @@ static inline int invalidate_icache_range(unsigned long start,
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
2.24.0

