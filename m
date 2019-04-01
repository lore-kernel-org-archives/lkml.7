Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D76C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4065220883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139276;
	bh=mqCKMemHHZPDRpj4/sEe1Wl5hj7FZZJKla0cTPN2bkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hk6dU/aRP/jgSfzbFCgVc0Kjox587bPh8PxEdwq2D4tFUbA7tSJG3reYkCoK2M11y
	 sGG9oG+qLThCEN35ydXaJ+2jZdkMZE2bBATnSX+0Ctoequye055IbQU4kn4h4lvTNp
	 vmoiyuCYwXRl1lVS3x+7FApljip8ugpE4zsWw5HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfDARVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731771AbfDARVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB0A206DD;
        Mon,  1 Apr 2019 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139271;
        bh=mqCKMemHHZPDRpj4/sEe1Wl5hj7FZZJKla0cTPN2bkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUkSxW9c+2K+WxZ/QBRatR+e5tM/69TsEo++MfJ7ypOxhxY7tLBodZLe4tpa3ga3E
         uyZq2zBQlFZTJHUBKwjnpjr49NbqR+8DPAyF3dnFltNwWcmnR7lt0iaceyJCbhBap3
         1r0U9yG6lMQrYlR05+nBFIDdXAliQLA2+Whw0ld4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 027/107] powerpc: Use barrier_nospec in copy_from_user()
Date:   Mon,  1 Apr 2019 19:01:42 +0200
Message-Id: <20190401170048.256446352@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit ddf35cf3764b5a182b178105f57515b42e2634f8 upstream.

Based on the x86 commit doing the same.

See commit 304ec1b05031 ("x86/uaccess: Use __uaccess_begin_nospec()
and uaccess_try_nospec") and b3bbfb3fb5d2 ("x86: Introduce
__uaccess_begin_nospec() and uaccess_try_nospec") for more detail.

In all cases we are ordering the load from the potentially
user-controlled pointer vs a previous branch based on an access_ok()
check or similar.

Base on a patch from Michal Suchanek.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/uaccess.h |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -238,6 +238,7 @@ do {								\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -249,8 +250,10 @@ do {								\
 	__long_type(*(ptr)) __gu_val = 0;				\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
-	if (access_ok(VERIFY_READ, __gu_addr, (size)))			\
+	if (access_ok(VERIFY_READ, __gu_addr, (size))) {		\
+		barrier_nospec();					\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
+	}								\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 	__gu_err;							\
 })
@@ -261,6 +264,7 @@ do {								\
 	__long_type(*(ptr)) __gu_val;				\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -288,15 +292,19 @@ static inline unsigned long raw_copy_fro
 
 		switch (n) {
 		case 1:
+			barrier_nospec();
 			__get_user_size(*(u8 *)to, from, 1, ret);
 			break;
 		case 2:
+			barrier_nospec();
 			__get_user_size(*(u16 *)to, from, 2, ret);
 			break;
 		case 4:
+			barrier_nospec();
 			__get_user_size(*(u32 *)to, from, 4, ret);
 			break;
 		case 8:
+			barrier_nospec();
 			__get_user_size(*(u64 *)to, from, 8, ret);
 			break;
 		}
@@ -304,6 +312,7 @@ static inline unsigned long raw_copy_fro
 			return 0;
 	}
 
+	barrier_nospec();
 	return __copy_tofrom_user((__force void __user *)to, from, n);
 }
 


