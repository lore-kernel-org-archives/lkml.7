Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC3DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648E720656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iwi+WE6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbfH0Uk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:58 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34160 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfH0Uk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:56 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so242554pfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7fwBBDcVeQDxpK7w1Viqz28DYsc11S+Pn/agx9uPCfE=;
        b=Iwi+WE6JbPkkCKZbTw1n8ZZdbyETfaDCr/XrX/9YqyhWNcNtRyG64M9A6jv8Lx4jcs
         nGYeBarBt+BbRLrO7UHy4GOXQKG6gQKxw5pmT7UORkJXFn3yhYkQK92lMgMRGtNOgwWF
         xsyZm2QDeLm9Pzf/p8j9W0DP25eatD626aJoQwt6NwNRy/8mB2bEcJMfWA9CRE9V3hcN
         ZgdNdL1ihrQIEciqkbtzAANN0TLA8JOBxyZoqrW9YC9gX5KoOQrE1/olIKblieTfwbIs
         TsZMgWnajhs3Kp8X0pGppkisz2yKvk/okD7MHoZk4fv9GIO1rrs+nfLAiipg7yfLNpgB
         3qHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7fwBBDcVeQDxpK7w1Viqz28DYsc11S+Pn/agx9uPCfE=;
        b=c14R9hvc3UFDFGcYRkFmwfEBOxPNEvdB041naJoFF9tPuaxQh+fp8IV7o1XyCvUwCW
         WQuZSTFR3yGfAEoWY833WoynpnLSOHxg4wcoTDZNnzFVueWzxvISLd9r0DGmIgjrEeVs
         T73BONfsPn+Xf69KDs74lUmxXrLVL8lDW8aniy/9PUxE8l6AXsRPgb3rj3ciwPd0MIHF
         rkxDK/KZ2zZmPQjrVHrE09oDBqT+ED5Ww6ZdGN6CnInnjPitozeR3yKnDIZJDkmJblXq
         I7VwXOeGpmBz7h04FLJlXDvM1dM2fHmFa2K/vWiYmKCJmSgEesgktLcb+LZL9dBDLysz
         ZlGg==
X-Gm-Message-State: APjAAAWt7gs1IzWFuBGAyGRo7GTYQPkHXprOdXPXxeKd+RKZ43Mx9gsh
        HzIOGcQJRxRoXYWM4LgF3sHJg0hDc3RdTfyaKB0=
X-Google-Smtp-Source: APXvYqx5VthNp7UGG0v6Jj7E/M8bTW6qDbWpl8pT7TSG7jPQ/rA4IlhrpmZSjG4/PtoEpVdGoCVKztjG8YHQnHikEwA=
X-Received: by 2002:a65:5183:: with SMTP id h3mr300039pgq.250.1566938455242;
 Tue, 27 Aug 2019 13:40:55 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:40:03 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-11-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 10/14] x86: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/cache.h       | 2 +-
 arch/x86/include/asm/intel-mid.h   | 2 +-
 arch/x86/include/asm/iommu_table.h | 5 ++---
 arch/x86/include/asm/irqflags.h    | 2 +-
 arch/x86/include/asm/mem_encrypt.h | 2 +-
 arch/x86/kernel/cpu/cpu.h          | 3 +--
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/cache.h b/arch/x86/include/asm/cache.h
index abe08690a887..bb9f4bf4ec02 100644
--- a/arch/x86/include/asm/cache.h
+++ b/arch/x86/include/asm/cache.h
@@ -8,7 +8,7 @@
 #define L1_CACHE_SHIFT	(CONFIG_X86_L1_CACHE_SHIFT)
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 #define INTERNODE_CACHE_SHIFT CONFIG_X86_INTERNODE_CACHE_SHIFT
 #define INTERNODE_CACHE_BYTES (1 << INTERNODE_CACHE_SHIFT)
diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index 8e5af119dc2d..f51f04aefe1b 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -43,7 +43,7 @@ struct devs_id {
 
 #define sfi_device(i)								\
 	static const struct devs_id *const __intel_mid_sfi_##i##_dev __used	\
-	__attribute__((__section__(".x86_intel_mid_dev.init"))) = &i
+	__section(.x86_intel_mid_dev.init) = &i
 
 /**
 * struct mid_sd_board_info - template for SD device creation
diff --git a/arch/x86/include/asm/iommu_table.h b/arch/x86/include/asm/iommu_table.h
index 1fb3fd1a83c2..7d190710eb92 100644
--- a/arch/x86/include/asm/iommu_table.h
+++ b/arch/x86/include/asm/iommu_table.h
@@ -50,9 +50,8 @@ struct iommu_table_entry {
 
 #define __IOMMU_INIT(_detect, _depend, _early_init, _late_init, _finish)\
 	static const struct iommu_table_entry				\
-		__iommu_entry_##_detect __used				\
-	__attribute__ ((unused, __section__(".iommu_table"),		\
-			aligned((sizeof(void *)))))	\
+		__iommu_entry_##_detect __used __section(.iommu_table)	\
+		__aligned((sizeof(void *)))				\
 	= {_detect, _depend, _early_init, _late_init,			\
 	   _finish ? IOMMU_FINISH_IF_DETECTED : 0}
 /*
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8a0e56e1dcc9..68db90bca813 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -9,7 +9,7 @@
 #include <asm/nospec-branch.h>
 
 /* Provide __cpuidle; we can't safely include <linux/cpu.h> */
-#define __cpuidle __attribute__((__section__(".cpuidle.text")))
+#define __cpuidle __section(.cpuidle.text)
 
 /*
  * Interrupt control:
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 0c196c47d621..db2cd3709148 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,7 +50,7 @@ void __init mem_encrypt_free_decrypted_mem(void);
 bool sme_active(void);
 bool sev_active(void);
 
-#define __bss_decrypted __attribute__((__section__(".bss..decrypted")))
+#define __bss_decrypted __section(.bss..decrypted)
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index c0e2407abdd6..7ff9dc41a603 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -38,8 +38,7 @@ struct _tlb_table {
 
 #define cpu_dev_register(cpu_devX) \
 	static const struct cpu_dev *const __cpu_dev_##cpu_devX __used \
-	__attribute__((__section__(".x86_cpu_dev.init"))) = \
-	&cpu_devX;
+	__section(.x86_cpu_dev.init) = &cpu_devX;
 
 extern const struct cpu_dev *const __x86_cpu_dev_start[],
 			    *const __x86_cpu_dev_end[];
-- 
2.23.0.187.g17f5b7556c-goog

