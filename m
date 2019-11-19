Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823DBC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595EF2231A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odrJnbLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfKSE5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:57:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41753 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfKSE5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:57:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id 94so16725222oty.8;
        Mon, 18 Nov 2019 20:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BfAG347llFRLd3tFIx1Ke7J/fonGQZbEZDA3VvZY+U=;
        b=odrJnbLAQ+lW8dC5pbNDgv4E5e5dOChAG3k/NKL11OtONbwKb18OmogkgowYaoNreY
         /nTmfn66HhS81ckhyMXroeZ7VZAd78gvYQcujp7csy8DeQZLGyVl6axC2Ya/cVeEYwhZ
         LBWLBm83HxtutrXCkFe4ONuEJTxJyczM/eRNFJw2EC/SDa49L2jtHadlz75D5PPcGWnI
         iwOrFq6hxfZgMufhny/94XaoBwmh9eiP1o1G725lHpVnNbFPjPL7ELLZlAr53EUI0f7w
         7TQbdHfJ86cHqKkSoHKrHf6Dv9ddOTezxJ9/Rre4G9IbkREOsr6MPfuCIZQw3BFbAXu6
         t5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BfAG347llFRLd3tFIx1Ke7J/fonGQZbEZDA3VvZY+U=;
        b=RSRuAwmyxBYRA8NveAlqlurT6IXueEMwF31SrlKlbCtydDwHcLjpvrYZvCyFuxDSEM
         9wgvXKBzGKwnW2ZsyoDMxI/TY3BRRSdyjyWeSw8rJRx4SNJlxs8lwzPqix4AfEXnIlsi
         G1YvvcxLX6/5ICo1tSrCiOWRxs9N1sf0OSBlxGk0XA55oIHjXXnDDlbqkiEv7kfl196a
         CK8sy0K6LXU2a0znP7QZvJ9JP85bkJl2vn2L54JK/uCA+3aHeSd5sELztgCcUqOmScns
         mZppEWplXqbYhrVecNZbGWwVU6PIfSTd7/EWD67uSbtdQjk4YCOCEqPWHIdN3eu/myK3
         DPuw==
X-Gm-Message-State: APjAAAXe/NcZTesjd3nPRzeMbKekIbfgviZrB0sbB9+7DGK0uExFVx76
        2zq6d9jVZNcQadoBkcHtoFM=
X-Google-Smtp-Source: APXvYqymsvgrUhQmsQWi69cCe7+4yyiO+K/A7AyiJt/nSKg06hd83Nm3RGBTIb7mwxwlkdDzUCcFiQ==
X-Received: by 2002:a05:6830:2157:: with SMTP id r23mr1433047otd.343.1574139438568;
        Mon, 18 Nov 2019 20:57:18 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::7])
        by smtp.gmail.com with ESMTPSA id e88sm7019765ote.39.2019.11.18.20.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 20:57:18 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        stable@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v5 2/3] powerpc: Avoid clang warnings around setjmp and longjmp
Date:   Mon, 18 Nov 2019 21:57:11 -0700
Message-Id: <20191119045712.39633-3-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119045712.39633-1-natechancellor@gmail.com>
References: <20191014025101.18567-1-natechancellor@gmail.com>
 <20191119045712.39633-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aea447141c7e ("powerpc: Disable -Wbuiltin-requires-header when
setjmp is used") disabled -Wbuiltin-requires-header because of a warning
about the setjmp and longjmp declarations.

r367387 in clang added another diagnostic around this, complaining that
there is no jmp_buf declaration.

In file included from ../arch/powerpc/xmon/xmon.c:47:
../arch/powerpc/include/asm/setjmp.h:10:13: error: declaration of
built-in function 'setjmp' requires the declaration of the 'jmp_buf'
type, commonly provided in the header <setjmp.h>.
[-Werror,-Wincomplete-setjmp-declaration]
extern long setjmp(long *);
            ^
../arch/powerpc/include/asm/setjmp.h:11:13: error: declaration of
built-in function 'longjmp' requires the declaration of the 'jmp_buf'
type, commonly provided in the header <setjmp.h>.
[-Werror,-Wincomplete-setjmp-declaration]
extern void longjmp(long *, long);
            ^
2 errors generated.

We are not using the standard library's longjmp/setjmp implementations
for obvious reasons; make this clear to clang by using -ffreestanding
on these files.

Cc: stable@vger.kernel.org # 4.14+
Link: https://github.com/ClangBuiltLinux/linux/issues/625
Link: https://github.com/llvm/llvm-project/commit/3be25e79477db2d31ac46493d97eca8c20592b07
Link: https://godbolt.org/z/B2oQnl
Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v3 (I skipped v2 because the first patch in the series already
          had a v2):

* Use -ffreestanding instead of outright disabling the warning because
  it is legitimate.

v3 -> v4:

* Rebase on v5.4-rc3

* Add Nick's reviewed-by and Compiler Explorer link.

v4 -> v5:

* Rebase on next-20191118

 arch/powerpc/kernel/Makefile | 4 ++--
 arch/powerpc/xmon/Makefile   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index bb57d168d6f4..3c113ae0de2b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -5,8 +5,8 @@
 
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
-# Disable clang warning for using setjmp without setjmp.h header
-CFLAGS_crash.o		+= $(call cc-disable-warning, builtin-requires-header)
+# Avoid clang warnings around longjmp/setjmp declarations
+CFLAGS_crash.o		+= -ffreestanding
 
 ifdef CONFIG_PPC64
 CFLAGS_prom_init.o	+= $(NO_MINIMAL_TOC)
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index f142570ad860..c3842dbeb1b7 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for xmon
 
-# Disable clang warning for using setjmp without setjmp.h header
-subdir-ccflags-y := $(call cc-disable-warning, builtin-requires-header)
+# Avoid clang warnings around longjmp/setjmp declarations
+subdir-ccflags-y := -ffreestanding
 
 GCOV_PROFILE := n
 KCOV_INSTRUMENT := n
-- 
2.24.0

