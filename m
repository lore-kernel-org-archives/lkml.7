Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE79C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F6C233FF
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYltaOcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfH1W4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:18 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:57091 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfH1W4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:14 -0400
Received: by mail-yw1-f74.google.com with SMTP id x20so1044420ywg.23
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9sn2Js9Jk/bJ5Zg7h20L566WLWmk48WwAynvNmd3FH0=;
        b=tYltaOcXAE1Pk0+XWSPCxkgkn4DA8pkE8EZAGttEN1oDBLIzf0BNTyu+945ulEISPq
         rBAq8NTnpvqGlOZ/BEdwqoxU/Vkvr4MxH0mbzwbtCXbr90JtfwCO5LZe0+i7fq5KeZ4c
         gzXGaQBqsehZ/wx0X7zTnPe9JczuFwG4sx8nZkGMbKkOKh3Dw0voX02SmgMMmfvi3HEO
         3IbHAWJa/7sewAZmKYL78GA0dBir4bO6etEVF1VvnF3mgIDfZKOakkWXcOLs0ydxdvFi
         ChH2MNi9fQzHNDuUSpJf7P/+nYtv7jJy6fLKFYewdkcBAYn9AT51ylcMFlj+pldnfa0c
         Fl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9sn2Js9Jk/bJ5Zg7h20L566WLWmk48WwAynvNmd3FH0=;
        b=jOPo5f8RiseWcBMMxAbGH8yuHB3sKd1D2wvW5zu9FDx6v/q0/t3XGG+6i8u+BPf9M3
         BYOM4SjWGq8ID34mXU7bNSLFL+U0aLvB7SZPxee2iMNm3eyMQ/1c8cdxElN/XijSDCHG
         FiLYMbZLoGMIF+39gQUYiUWLsXqYV9X8Se4fNqfr9E6GIvJQAE+mURyWwzWodIsNCwXS
         y8E++mDTMUxrFWYPvRmdydF9m0ArT7m6liQ5QSkatHcc3VXY+nCF20DejiG7ELN5MwbR
         3BqKzc06jCVi9nIZQ5+4RVsnQZBN2HS7R5G+147S+Bimqw9Aj2nQmxjyZFuqHojI9KAq
         5BgQ==
X-Gm-Message-State: APjAAAUEhUQpplYtnSe5xogvKGrd+YGXuf+/dGQNrfvbO/XL/F1M1/Ve
        EIEEe+wsajyo+zOX0X0coZcZyrOyOB/PSk1BjVE=
X-Google-Smtp-Source: APXvYqyct/Nm+WyQyU3D6RHUexlV8O9rrKlkogR7y5MmqVECwCUKxqY+Dq/ozDF+TpLUU3J7i4g/uYt/m6vktMB2IJQ=
X-Received: by 2002:a81:2d46:: with SMTP id t67mr4917695ywt.512.1567032973325;
 Wed, 28 Aug 2019 15:56:13 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:27 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-7-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 06/14] arm: prefer __section from compiler_attributes.h
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
2. Only use __attribute__((__section__(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Link: https://github.com/ClangBuiltLinux/linux/issues/619
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/include/asm/cache.h     | 2 +-
 arch/arm/include/asm/mach/arch.h | 4 ++--
 arch/arm/include/asm/setup.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cache.h
index 1d65ed3a2755..cc06079600e0 100644
--- a/arch/arm/include/asm/cache.h
+++ b/arch/arm/include/asm/cache.h
@@ -24,6 +24,6 @@
 #define ARCH_SLAB_MINALIGN 8
 #endif
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 #endif
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index e7df5a822cab..2986f6b4862d 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -81,7 +81,7 @@ extern const struct machine_desc __arch_info_begin[], __arch_info_end[];
 #define MACHINE_START(_type,_name)			\
 static const struct machine_desc __mach_desc_##_type	\
  __used							\
- __attribute__((__section__(".arch.info.init"))) = {	\
+ __section(.arch.info.init) = {	\
 	.nr		= MACH_TYPE_##_type,		\
 	.name		= _name,
 
@@ -91,7 +91,7 @@ static const struct machine_desc __mach_desc_##_type	\
 #define DT_MACHINE_START(_name, _namestr)		\
 static const struct machine_desc __mach_desc_##_name	\
  __used							\
- __attribute__((__section__(".arch.info.init"))) = {	\
+ __section(.arch.info.init) = {	\
 	.nr		= ~0,				\
 	.name		= _namestr,
 
diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 67d20712cb48..00190f1f0574 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -14,7 +14,7 @@
 #include <uapi/asm/setup.h>
 
 
-#define __tag __used __attribute__((__section__(".taglist.init")))
+#define __tag __used __section(.taglist.init)
 #define __tagtable(tag, fn) \
 static const struct tagtable __tagtable_##fn __tag = { tag, fn }
 
-- 
2.23.0.187.g17f5b7556c-goog

