Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A8C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486AC20854
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355782;
	bh=q+cN5ok+VrAZGQOSbtWyaOQZIbwaK+5NNW/nn9cFBnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lWX2GfbP54d5y0zEcFhOVbnohnHSM3kx3xwxerQOAeRnlvheUQib+s9ghtlt9hiJ/
	 QPOQCXV6Q14PbeG8yXcitqqjzzOZiPVywiQMASsu+YkfiNJqm1ooI76UEDvWSGN+0Q
	 kKHxfPCcEP0YFEXYS93UaQyKkQ3/tjZYJYAiWijw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfKJDQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:16:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfKJCk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:40:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C16832196F;
        Sun, 10 Nov 2019 02:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353658;
        bh=q+cN5ok+VrAZGQOSbtWyaOQZIbwaK+5NNW/nn9cFBnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmrSCTRw4hzoI7Jre2VI8gHXC6rDwmP7sFtp0yDUD6eFHgGqf3csTbFiAQb2UdC9s
         EB3Ok5SVAbnuoK/lK1WJaZmaPprJM+w+N4ZMqn1Zq5RcyBIjhNGkY+zIQNzB7Zp0Mo
         dnB6ISlO3LovTreQiKf/Zr86grmUmyVupNl+AIfg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anton Blanchard <anton@samba.org>, Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 031/191] powerpc: Fix duplicate const clang warning in user access code
Date:   Sat,  9 Nov 2019 21:37:33 -0500
Message-Id: <20191110024013.29782-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Blanchard <anton@samba.org>

[ Upstream commit e00d93ac9a189673028ac125a74b9bc8ae73eebc ]

This re-applies commit b91c1e3e7a6f ("powerpc: Fix duplicate const
clang warning in user access code") (Jun 2015) which was undone in
commits:
  f2ca80905929 ("powerpc/sparse: Constify the address pointer in __get_user_nosleep()") (Feb 2017)
  d466f6c5cac1 ("powerpc/sparse: Constify the address pointer in __get_user_nocheck()") (Feb 2017)
  f84ed59a612d ("powerpc/sparse: Constify the address pointer in __get_user_check()") (Feb 2017)

We see a large number of duplicate const errors in the user access
code when building with llvm/clang:

  include/linux/pagemap.h:576:8: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
        ret = __get_user(c, uaddr);

The problem is we are doing const __typeof__(*(ptr)), which will hit
the warning if ptr is marked const.

Removing const does not seem to have any effect on GCC code
generation.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/uaccess.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 1ca9e37f7cc99..38a25ff8afb76 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -260,7 +260,7 @@ do {								\
 ({								\
 	long __gu_err;						\
 	__long_type(*(ptr)) __gu_val;				\
-	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
@@ -274,7 +274,7 @@ do {								\
 ({									\
 	long __gu_err = -EFAULT;					\
 	__long_type(*(ptr)) __gu_val = 0;				\
-	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
+	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
 	if (access_ok(VERIFY_READ, __gu_addr, (size))) {		\
 		barrier_nospec();					\
@@ -288,7 +288,7 @@ do {								\
 ({								\
 	long __gu_err;						\
 	__long_type(*(ptr)) __gu_val;				\
-	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
-- 
2.20.1

