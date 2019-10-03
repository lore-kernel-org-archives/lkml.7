Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC75C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E48222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122103;
	bh=FhMqtDm73GhvjtyVWDtKRVY17JuvvD8eg/8rpvN6FjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DmhTfXSMQmQOEvqtFyttFhIN10QeGlKNPECdHCZmVlMWLquXEzQ2yFUCYBDNh2mnQ
	 XtaM93J2nICm9d14AaBl0iHg/qRqFgq1LD42YKSZuIZiT9xKm0kstFabkbUv8FVabD
	 QNSRhX1J+rNgqsfSojzAZ5XWbDXo5svprdop+Klg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405374AbfJCQo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405363AbfJCQoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:44:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDB0206BB;
        Thu,  3 Oct 2019 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121063;
        bh=FhMqtDm73GhvjtyVWDtKRVY17JuvvD8eg/8rpvN6FjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPJagvi6tVpQbA5/7qnPh3P1tOZE+6rI7biLJgrrCUTLftDiy9SLthfgR689da44O
         DWcFNJXZJ2QbbpHzcQAMB2VoDDVizDagrmfuM3dXxBpz+Y1PkK/gxXQgMQHcbBlgDn
         eWGLPLvmO6mkcn5jdPrxrH4Fp2jyPH8qPTg/kZi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 139/344] s390/kasan: provide uninstrumented __strlen
Date:   Thu,  3 Oct 2019 17:51:44 +0200
Message-Id: <20191003154553.940953422@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit f45f7b5bdaa4828ce871cf03f7c01599a0de57a5 ]

s390 kasan code uses sclp_early_printk to report initialization
failures. The code doing that should not be instrumented, because kasan
shadow memory has not been set up yet. Even though sclp_early_core.c is
compiled with instrumentation disabled it uses strlen function, which
is instrumented and would produce shadow memory access if used. To
avoid that, introduce uninstrumented __strlen function to be used
instead.

Before commit 7e0d92f00246 ("s390/kasan: improve string/memory functions
checks") few string functions (including strlen) were escaping kasan
instrumentation due to usage of platform specific versions which are
implemented in inline assembly.

Fixes: 7e0d92f00246 ("s390/kasan: improve string/memory functions checks")
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/string.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/string.h b/arch/s390/include/asm/string.h
index 70d87db54e627..4c0690fc5167e 100644
--- a/arch/s390/include/asm/string.h
+++ b/arch/s390/include/asm/string.h
@@ -71,11 +71,16 @@ extern void *__memmove(void *dest, const void *src, size_t n);
 #define memcpy(dst, src, len) __memcpy(dst, src, len)
 #define memmove(dst, src, len) __memmove(dst, src, len)
 #define memset(s, c, n) __memset(s, c, n)
+#define strlen(s) __strlen(s)
+
+#define __no_sanitize_prefix_strfunc(x) __##x
 
 #ifndef __NO_FORTIFY
 #define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
 #endif
 
+#else
+#define __no_sanitize_prefix_strfunc(x) x
 #endif /* defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__) */
 
 void *__memset16(uint16_t *s, uint16_t v, size_t count);
@@ -163,8 +168,8 @@ static inline char *strcpy(char *dst, const char *src)
 }
 #endif
 
-#ifdef __HAVE_ARCH_STRLEN
-static inline size_t strlen(const char *s)
+#if defined(__HAVE_ARCH_STRLEN) || (defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__))
+static inline size_t __no_sanitize_prefix_strfunc(strlen)(const char *s)
 {
 	register unsigned long r0 asm("0") = 0;
 	const char *tmp = s;
-- 
2.20.1



