Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4E1C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BEA2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354282;
	bh=3AXHy2hp4dP5wN2QSmLVSEZHDsL0J04sy3afJZNKdaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B6m27UhSCyjeIfCIsfB4orMRwK8H8yss3GPiUxY+frgWTgDL22hDyINtdhl0UzjtB
	 wPniM1sXNElNR1K2nOO6vUv9xw9OkvuOfoUvsmkUtY6srPCCxM9v0+CmIEo27TMlsi
	 ntyXk3XFTCKoVu8d066yG+uCO4fFFE/lRkNkIKIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfDOSvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbfDOSpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1082087C;
        Mon, 15 Apr 2019 18:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353950;
        bh=3AXHy2hp4dP5wN2QSmLVSEZHDsL0J04sy3afJZNKdaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3VoPpCziy7AKUN2DBM2Rvzl8OOfwa0WkpBMH06VKa4055ms3N1+42qTfWcOVcGiT
         ka0oIHA5aOTXPUvyuDtQhgzyzLjUY62ZpZmZQT90A62QGijqZr4dElHhcs+QFJTkt9
         Cnv6XN0oZ/RAcpk4lB9NBfORAiG/zeFd3C+u1EQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 16/76] powerpc: Use barrier_nospec in copy_from_user()
Date:   Mon, 15 Apr 2019 20:43:40 +0200
Message-Id: <20190415183712.067256091@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/uaccess.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 31913b3ac7ab..da852153c1f8 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -269,6 +269,7 @@ do {								\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -280,8 +281,10 @@ do {								\
 	unsigned long  __gu_val = 0;					\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
-	if (access_ok(VERIFY_READ, __gu_addr, (size)))			\
+	if (access_ok(VERIFY_READ, __gu_addr, (size))) {		\
+		barrier_nospec();					\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
+	}								\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 	__gu_err;							\
 })
@@ -292,6 +295,7 @@ do {								\
 	unsigned long __gu_val;					\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -348,15 +352,19 @@ static inline unsigned long __copy_from_user_inatomic(void *to,
 
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
@@ -366,6 +374,7 @@ static inline unsigned long __copy_from_user_inatomic(void *to,
 
 	check_object_size(to, n, false);
 
+	barrier_nospec();
 	return __copy_tofrom_user((__force void __user *)to, from, n);
 }
 
-- 
2.19.1



