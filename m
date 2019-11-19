Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F980C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346162084D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143087;
	bh=Nzgnhf+2GHFkypQFGo5Xy3DsKIb1HLQt3PdfciKOnvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xl6Xja85bH0vViUEbAc1rnRkn5d/xGz9eFG4VF+hKD6pHmWL3WqEdxMmKspJ64UWe
	 4yZBw5jMDpdB30Mt8fZrnKWWgYpThM1mjbhj2MTTFeedYrgXE9cgt5WBi/jbt2qZ21
	 Oc+771DMuq1Sf8vzTpRZ1xptk5M9S7MO10Gjs/DQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbfKSF6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbfKSFuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:50:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 481B221850;
        Tue, 19 Nov 2019 05:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142614;
        bh=Nzgnhf+2GHFkypQFGo5Xy3DsKIb1HLQt3PdfciKOnvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ek5Q7Hc2njmx5WQQQURLm3JfcjVA+bgmPe4riycRsMQKDb23o8GcOEQli11EzM/IL
         XRZYEx/Io1nITDEgKmkaG/0X7r5vLUJt3vj1u7HzrUh3XvhOj+h6szhjLj8faWJJSc
         gHyiENdzvzgfBgXsKHUs7VjrGzky1M3qwkwVOiMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Blanchard <anton@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 142/239] powerpc: Fix duplicate const clang warning in user access code
Date:   Tue, 19 Nov 2019 06:19:02 +0100
Message-Id: <20191119051331.777572659@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 51f00c00d7e49..3865d1d235976 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -234,7 +234,7 @@ do {								\
 ({								\
 	long __gu_err;						\
 	__long_type(*(ptr)) __gu_val;				\
-	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
@@ -248,7 +248,7 @@ do {								\
 ({									\
 	long __gu_err = -EFAULT;					\
 	__long_type(*(ptr)) __gu_val = 0;				\
-	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
+	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
 	if (access_ok(VERIFY_READ, __gu_addr, (size))) {		\
 		barrier_nospec();					\
@@ -262,7 +262,7 @@ do {								\
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



