Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DA3C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088EC207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520978;
	bh=3fMw/zbAR7/WFG0cjvqYO0/y5D5DtOKBvIKrryhQEyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SmkY+r0Xi5u4zZbU9QeEQgDVlADEYoUknEjldF0LgvM1TkVMbli7t8YTfkJB3yyI/
	 J1i0y3zXZfUbRi+o4xB8ymjqcAw3HHKkvHsdvEFHpoZpKIimBJtyrQTPtS8HDSQpPW
	 XvlIKMhwebbN6pzDY73IeAbPePQ84pUzjttLGjcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfLPS3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:29:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731133AbfLPSNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:13:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E798207FF;
        Mon, 16 Dec 2019 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520028;
        bh=3fMw/zbAR7/WFG0cjvqYO0/y5D5DtOKBvIKrryhQEyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aC6D+nRziDUz2jfAC3RkYIxOly5kHk4T2ZdZjERNxb4rL3la1JEyH0XZ/uvW72q55
         3q6U7EicNbXGE3r4q6j9A5ux8WvHik692W1JZP7hBQTHl2LUKHK7mgil+9ysCqX5yv
         dVttplVOpP8lPB0ZwXEgEf7GtPIJpYQjh4EKOtDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 168/180] powerpc: Avoid clang warnings around setjmp and longjmp
Date:   Mon, 16 Dec 2019 18:50:08 +0100
Message-Id: <20191216174847.257845976@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit c9029ef9c95765e7b63c4d9aa780674447db1ec0 ]

Commit aea447141c7e ("powerpc: Disable -Wbuiltin-requires-header when
setjmp is used") disabled -Wbuiltin-requires-header because of a
warning about the setjmp and longjmp declarations.

r367387 in clang added another diagnostic around this, complaining
that there is no jmp_buf declaration.

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
Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191119045712.39633-3-natechancellor@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/Makefile | 4 ++--
 arch/powerpc/xmon/Makefile   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 56dfa7a2a6f2a..61527f1d4d05b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -5,8 +5,8 @@
 
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
-# Disable clang warning for using setjmp without setjmp.h header
-CFLAGS_crash.o		+= $(call cc-disable-warning, builtin-requires-header)
+# Avoid clang warnings around longjmp/setjmp declarations
+CFLAGS_crash.o += -ffreestanding
 
 ifdef CONFIG_PPC64
 CFLAGS_prom_init.o	+= $(NO_MINIMAL_TOC)
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index f142570ad8606..c3842dbeb1b75 100644
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
2.20.1



