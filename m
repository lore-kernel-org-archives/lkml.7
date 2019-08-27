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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E51DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDBE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIlVMPtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfH0Ukr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:47 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54199 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfH0Ukq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:46 -0400
Received: by mail-pf1-f202.google.com with SMTP id 191so207713pfy.20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6yNuMZ+qRtYF0Z0S5bbj5Vin0heyTc8hHeZYmojDlCY=;
        b=aIlVMPtEmORNLus5Du6VSEeTR+AxBIOU2u74x5O/HcddvgQP/TuEu+361Skly8Mawk
         zITjIiUyikL8e1QxWJJ+iyVfYPytRJknw54m+p5VTTsHiHUAfVoDnwA2spZ1POXs2yrT
         YkbS43FH7UTIqhsQVKjNzHpOaiJP0xx3U43umzjkL92BlD1bJSjwo3Dd7/zBtkwkqEua
         sk7WkTKny2ofK4FXD1OoZ+mfkKzcL13+/YA5yemvayFd3nzGVEsYfpQGN7p31ltDZv91
         ezDns0NVpR9KVZkEg6AFLWg28t+XgfVChl24Je7/svX/PvXD1NnnfEOXYBBNsxusb6Ac
         Wwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6yNuMZ+qRtYF0Z0S5bbj5Vin0heyTc8hHeZYmojDlCY=;
        b=Xd2r6hK8j0K3IZY2vzDTAe7wliwpuxaZcBG2L8jFQIXDAreChIaUUvukTH2s2Qv743
         AdQNuV1mz/liU79cN70zwKumTUBJOf63ZyWpCeumY/vO3d70+tckl1qUnMM+VqB4Vt+c
         BKb1uxV604q1X7uhlPOmpp9fJoy9nmpJyOSCo9xCjHFuIduvydzvwTxEGcuJA0USWN3N
         meACnY6B0GcutS0+ye/+yb6At6o8iAi0iHNsNErow1g3pAHgdV6A6sKfLE69waT5WK+E
         HEve3bmX/30rc8xYv1l4I7Jum1++GJDuGGz00CLnffIigORbrN27amgfJwkG3ITMLtDP
         ZlTw==
X-Gm-Message-State: APjAAAWDvkGgc5qHj/OXQ0YMRuJ6ZEQrfKH5f+lZjlUk3qg92chqHH8Z
        GZSTA1nsUNUbTJPccVWs187EB56MwBVtK/eZ5dg=
X-Google-Smtp-Source: APXvYqxDlKGPaeOkjGp9Y7CSRJfohxnVz+xJgC2J+EB2TlBqGe1MGT/xyuVzpk5/bO++vuroiqOwunzT9fF1z75kstM=
X-Received: by 2002:a63:4e60:: with SMTP id o32mr323110pgl.68.1566938444719;
 Tue, 27 Aug 2019 13:40:44 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:39:59 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-7-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 06/14] arm: prefer __section from compiler_attributes.h
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

