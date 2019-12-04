Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091D2C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C7C20656
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NkJEU/yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfLDXVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:21:05 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41078 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLDXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:21:04 -0500
Received: by mail-qv1-f68.google.com with SMTP id b18so570067qvo.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eby1Z/q7U+7Sxm/O/Jl7zP2rKdfik8y03EjcrV9rvuY=;
        b=NkJEU/yt/blJhAPAwm0//b+ZWq1n7s4JlJ6JP+qdBGuTQCQuHFZ8PMWe00iEhl9sXR
         D5h+fsIE0OGIVs9vXL4gpNLeOVHliEVsqZGstR3wOREMlUTyHMBjBqiiJN9XSmUHGnl9
         E029DgxCUKX3rVs0qGMWaVjtplCdTxiZQYRP12zEURRSXHIzCN4n9ZW6ehybuzzr5UNJ
         Zl0SICIsfPNpjp6MCNV3XJOhgzPiqFDsK+MaqCJejfrOaTmcJDz3S6PSEcE5G1+/Jk4t
         F2m0xoYu1kjAU9N6m6iUSEwzBQ39xf3hLWime1T3P66/AhdOKcdyJZrg+K7Z5WCheUkf
         kIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eby1Z/q7U+7Sxm/O/Jl7zP2rKdfik8y03EjcrV9rvuY=;
        b=kKmJSjAW1wq1PLksZQrIibz42HsHidI27pMsDj5mlsUzhvswterbqPNf721+Pyi7S5
         vdEnVMczT86HopJ3pAsbQpYKW80tTx/DD1jGxQhVKljdtgYk93e48MlOUts7lSNiKrDE
         5CMtFNJm8V9Vqnbeqsf/AxaW/yc+7C09ta8OQVjJlNBP7rNH6jmlhIX6a+Ltq8PLhJzo
         5sLBoZp5GVqNdIdNNaz22mF0Hl1VspyjRTLeHqKKbqsUubzVfmLYKB7CasgnMpXnwVDH
         Cuq/UDFGiCg+yVrtxXPX/EYUG4Dc6FVNMoROUPY1x57xmvd4YpILzlAaOE8I2XEm+04y
         HY9A==
X-Gm-Message-State: APjAAAUln3dh+381redRLzYjiqGC5qG2Lf/BtEKRWog3TIYLCG/IzkA0
        8NPZSeHUpbxoW5HT7bmaVQhCqQ==
X-Google-Smtp-Source: APXvYqwCGhoOs0wEUWkqNpwRHUAKwjbY4ROZeLY1H9ddt2HeC0y/qK9F5ZFbRQ+FLH5XluAaaaKK8A==
X-Received: by 2002:a0c:ef91:: with SMTP id w17mr5033755qvr.202.1575501663211;
        Wed, 04 Dec 2019 15:21:03 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t38sm4667864qta.78.2019.12.04.15.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 15:21:02 -0800 (PST)
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
Subject: [PATCH v4 1/6] arm/arm64/xen: hypercall.h add includes guards
Date:   Wed,  4 Dec 2019 18:20:53 -0500
Message-Id: <20191204232058.2500117-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
References: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm and arm64 versions of hypercall.h are missing the include
guards. This is needed because C inlines for privcmd_call are going to
be added to the files.

Also fix a comment.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm/include/asm/assembler.h       | 2 +-
 arch/arm/include/asm/xen/hypercall.h   | 4 ++++
 arch/arm64/include/asm/xen/hypercall.h | 4 ++++
 include/xen/arm/hypercall.h            | 6 +++---
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 99929122dad7..8e9262a0f016 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -480,7 +480,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.macro	uaccess_disable, tmp, isb=1
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/*
-	 * Whenever we re-enter userspace, the domains should always be
+	 * Whenever we re-enter kernel, the domains should always be
 	 * set appropriately.
 	 */
 	mov	\tmp, #DACR_UACCESS_DISABLE
diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
index 3522cbaed316..c6882bba5284 100644
--- a/arch/arm/include/asm/xen/hypercall.h
+++ b/arch/arm/include/asm/xen/hypercall.h
@@ -1 +1,5 @@
+#ifndef _ASM_ARM_XEN_HYPERCALL_H
+#define _ASM_ARM_XEN_HYPERCALL_H
 #include <xen/arm/hypercall.h>
+
+#endif /* _ASM_ARM_XEN_HYPERCALL_H */
diff --git a/arch/arm64/include/asm/xen/hypercall.h b/arch/arm64/include/asm/xen/hypercall.h
index 3522cbaed316..c3198f9ccd2e 100644
--- a/arch/arm64/include/asm/xen/hypercall.h
+++ b/arch/arm64/include/asm/xen/hypercall.h
@@ -1 +1,5 @@
+#ifndef _ASM_ARM64_XEN_HYPERCALL_H
+#define _ASM_ARM64_XEN_HYPERCALL_H
 #include <xen/arm/hypercall.h>
+
+#endif /* _ASM_ARM64_XEN_HYPERCALL_H */
diff --git a/include/xen/arm/hypercall.h b/include/xen/arm/hypercall.h
index b40485e54d80..babcc08af965 100644
--- a/include/xen/arm/hypercall.h
+++ b/include/xen/arm/hypercall.h
@@ -30,8 +30,8 @@
  * IN THE SOFTWARE.
  */
 
-#ifndef _ASM_ARM_XEN_HYPERCALL_H
-#define _ASM_ARM_XEN_HYPERCALL_H
+#ifndef _ARM_XEN_HYPERCALL_H
+#define _ARM_XEN_HYPERCALL_H
 
 #include <linux/bug.h>
 
@@ -88,4 +88,4 @@ MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
 	BUG();
 }
 
-#endif /* _ASM_ARM_XEN_HYPERCALL_H */
+#endif /* _ARM_XEN_HYPERCALL_H */
-- 
2.24.0

