Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A998C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2568B20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Skz33sHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392034AbfIFKcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:32:52 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:48733 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391989AbfIFKct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:32:49 -0400
Received: by mail-vk1-f202.google.com with SMTP id l3so2225796vkb.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WpyyM8zjm4wtK5J690VZrM2s4HSiRGUxtkfpxo7zqKI=;
        b=Skz33sHpPCZnoHy3AvVrg/LLqwQwyEGz36anNkWQoU5roRNbtVs5HkCrAJzloD84GS
         FLXgT091RDmDDpkiFmgCVdrhxFh4kkwp/pxul1aUfuCd947ZNUFsfhjERMj7Cs7koVX0
         qWq3tCWdb9YWHwMxMI2hoEuadpcMBD3K5HPm5XCXLz/+Tx0QBEhvO59ElSqBGHqhgWVP
         vvw4IHRL1YGoIDpc+Ct+u2nvyGtLyZJGuviNOpHBItO2gMnzAZDevmP4oRFE7P46vTni
         fUh41ilsp4v3ceWjwKRPEZzgn6/oYJOGhl2jFZWF/019eio/TcnBj+J3z2ztgxL66/Z+
         5j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WpyyM8zjm4wtK5J690VZrM2s4HSiRGUxtkfpxo7zqKI=;
        b=Pm4PuTwtqOZ78vGikEUXGg8huG7TmSeIxeem/cADG/nVHImfy4bKZw7yo9Zjt5RrDB
         6O4N49YUm5GZh0UYg3tZ551woexFdhWdHNbYK1nBGK174HYMmPF4Pe9XXfJbOuqCNDOQ
         KRbCdV0+0xtGfcFSIkD3lHCyooN9ErEZn5LI1B02uP05+lpB3lJZVmN+ilxtiaAiDNi5
         qXFU3+UmmpHoLMSCC2iA4+/C6b9KS/Mn5QhRuh5QPqe19QRX9+6Djyys+T2Day/U2GFU
         rYcrsTUNvuPwWxogyWJEJe+r+yyIkBE3hmbWfkkU4nmUKKaYvIlzSi9yY1E4qbdu8NXw
         fluA==
X-Gm-Message-State: APjAAAXZMDVF11MV/TWCIZPfFMsz7YB6ed1eRZEK5JzsMQgPMuouiowi
        nqVRhDybRr7CYUip3bwSYK8RMO6QYhmnlKYJ8I+oAu+T+5lEdttOMud0AN+m32sCG0wgB1/vxIp
        qO+yRHT7FEAQd3MSTCfkjVoXM79qQshOqvQYttefpS1egECWkUf5eeoODGDwPRdKFihuV9jWGGP
        c=
X-Google-Smtp-Source: APXvYqwji9IO4P0sdnEEwGtqAmxa5gZ9mhcJuZTmoabFbDwxSe1f5uRwH8hIxTnlZWVDVEHc/tFE2bzrgk+OgQ==
X-Received: by 2002:a67:1687:: with SMTP id 129mr4598055vsw.232.1567765968027;
 Fri, 06 Sep 2019 03:32:48 -0700 (PDT)
Date:   Fri,  6 Sep 2019 11:32:26 +0100
In-Reply-To: <20190906103235.197072-1-maennich@google.com>
Message-Id: <20190906103235.197072-3-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190906103235.197072-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v5 02/11] export: explicitly align struct kernel_symbol
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        joel@joelfernandes.org, lucas.de.marchi@gmail.com,
        maco@android.com, sspatil@google.com, will@kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows growing struct kernel_symbol without wasting bytes to
alignment. It also concretized the alignment of ksymtab entries if
relative references are used for ksymtab entries.

struct kernel_symbol was already implicitly being aligned to the word
size, except on x86_64 and m68k, where it is aligned to 16 and 2 bytes,
respectively.

As far as I can tell there is no requirement for aligning struct
kernel_symbol to 16 bytes on x86_64, but gcc aligns structs to their
size, and the linker aligns the custom __ksymtab sections to the largest
data type contained within, so setting KSYM_ALIGN to 16 was necessary to
stay consistent with the code generated for non-ASM EXPORT_SYMBOL(). Now
that non-ASM EXPORT_SYMBOL() explicitly aligns to word size (8),
KSYM_ALIGN is no longer necessary.

In case of relative references, the alignment has been changed
accordingly to not waste space when adding new struct members.

As for m68k, struct kernel_symbol is aligned to 2 bytes even though the
structure itself is 8 bytes; using a 4-byte alignment shouldn't hurt.

I manually verified the output of the __ksymtab sections didn't change
on x86, x86_64, arm, arm64 and m68k. As expected, the section contents
didn't change, and the ELF section alignment only changed on x86_64 and
m68k. Feedback from other archs more than welcome.

Co-developed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Martijn Coenen <maco@android.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 arch/m68k/include/asm/export.h | 1 -
 include/asm-generic/export.h   | 8 +++-----
 include/linux/export.h         | 3 ++-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/include/asm/export.h b/arch/m68k/include/asm/export.h
index 0af20f48bd07..b53008b67ce1 100644
--- a/arch/m68k/include/asm/export.h
+++ b/arch/m68k/include/asm/export.h
@@ -1,3 +1,2 @@
-#define KSYM_ALIGN 2
 #define KCRC_ALIGN 2
 #include <asm-generic/export.h>
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 294d6ae785d4..63f54907317b 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -4,15 +4,13 @@
 #ifndef KSYM_FUNC
 #define KSYM_FUNC(x) x
 #endif
-#ifdef CONFIG_64BIT
-#ifndef KSYM_ALIGN
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define KSYM_ALIGN 4
+#elif defined(CONFIG_64BIT)
 #define KSYM_ALIGN 8
-#endif
 #else
-#ifndef KSYM_ALIGN
 #define KSYM_ALIGN 4
 #endif
-#endif
 #ifndef KCRC_ALIGN
 #define KCRC_ALIGN 4
 #endif
diff --git a/include/linux/export.h b/include/linux/export.h
index fd8711ed9ac4..28a4d2150689 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -52,7 +52,7 @@ extern struct module __this_module;
 #define __KSYMTAB_ENTRY(sym, sec)					\
 	__ADDRESSABLE(sym)						\
 	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.balign	8					\n"	\
+	    "	.balign 4					\n"	\
 	    "__ksymtab_" #sym ":				\n"	\
 	    "	.long	" #sym "- .				\n"	\
 	    "	.long	__kstrtab_" #sym "- .			\n"	\
@@ -66,6 +66,7 @@ struct kernel_symbol {
 #define __KSYMTAB_ENTRY(sym, sec)					\
 	static const struct kernel_symbol __ksymtab_##sym		\
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
+	__aligned(sizeof(void *))					\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 struct kernel_symbol {
-- 
2.23.0.187.g17f5b7556c-goog

