Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C9C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BD021D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VXzjqIBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgABVOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:14:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35407 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:14:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so35590670qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 13:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=sLfto7pDtwtBpFy7vHWfBkT+4MM0vP3E4VHWVzt8Ru4=;
        b=VXzjqIBLu3/HymaztMnJa4bgYGRIKjuKvwh/j9RPNIJWjpGXOEr1VmGNPSBxUDjp51
         jCJlFgiNVRUfJZn6U40n9Z0YUEOc48bycD7pBbYa3hWgMnBJFiDGV2Zt4MkJ7YLqEtwM
         wGod6fo6QvA9UzKjlu2OU1A8lBDFiz0GoHozfSABoVdIzYWL89usU6RoBoA7YQDG+qny
         vXj8qD2XmnZ493Dr1R7rUb8bOQttoaqcAZD1nEYLr40Axq9CupzdqJcr6CALslZgu0W+
         UGFrW3BmiMeOFLTiiQx1pNqrm7K+5BxUfVnvg1KFLiEbEZnx/1ujngCGiaofoUXqOJKY
         8k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=sLfto7pDtwtBpFy7vHWfBkT+4MM0vP3E4VHWVzt8Ru4=;
        b=UHeJ7BiFsd1uGlf5/YKBpFPPW5esYYfYo/2QfdFK6U0wygNhYpDBxQmxUx+Ag1OqiB
         cCbpeT3gcrQctvwhPeAyR10n3dxHSq8+2peHWymSCfTyazSjsmXb7vu8a/AkmmJ0vLnJ
         gyqkLbjg2LCq/hdOoVu94QMazE0tFDM7Qr0l/AuvPaPBtwleO5IRQGec82DdKuVbojlV
         CW3GReIltCig7heBQYjDA/HXSg68yaSQZ2lTz7omON9hhG6vyOLDxk6DVFKk0vJ90jov
         l8A1H9Eui/YT1aeedRDSIzqV4xNwAVTn9MPkdjaIMp7+vPNA55YSAm2xValmTi805p+w
         YUmg==
X-Gm-Message-State: APjAAAX/26Ok4Mrwou3cSs6BoJsYk40amImH4Ef1a7Bu2O2xAd1EKKHS
        mH/ECzwZ3cdFt/o4rAlNtGl2Ng==
X-Google-Smtp-Source: APXvYqxfIYiffLt+0sAKnDiS1/f+cfl6AxYc1/2VA/kOzDQqWA8cYvIwfRewT5+nHZ3IdtFcW1T0QA==
X-Received: by 2002:ac8:5159:: with SMTP id h25mr62711218qtn.249.1577999642118;
        Thu, 02 Jan 2020 13:14:02 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f97sm17384185qtb.18.2020.01.02.13.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 13:14:01 -0800 (PST)
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
Subject: [PATCH v5 1/6] arm/arm64/xen: hypercall.h add includes guards
Date:   Thu,  2 Jan 2020 16:13:52 -0500
Message-Id: <20200102211357.8042-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102211357.8042-1-pasha.tatashin@soleen.com>
References: <20200102211357.8042-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm and arm64 versions of hypercall.h are missing the include
guards. This is needed because C inlines for privcmd_call are going to
be added to the files.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Julien Grall <julien@xen.org>
---
 arch/arm/include/asm/xen/hypercall.h   | 4 ++++
 arch/arm64/include/asm/xen/hypercall.h | 4 ++++
 include/xen/arm/hypercall.h            | 6 +++---
 3 files changed, 11 insertions(+), 3 deletions(-)

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
2.17.1

