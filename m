Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B76C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A5620869
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180332;
	bh=FhMqtDm73GhvjtyVWDtKRVY17JuvvD8eg/8rpvN6FjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TAygO3M/q08mBsi/AbzXBnjz8002p/FEnpmKQuM6Y19K/dAz4JxjYFNIrUuwbn4er
	 Kc7uVa0NbasDNnIJIdDMg+BrXUncpi5pV2HU0vuT5n2Dlvkg8DEf5ibo4bkmJ5h+Xa
	 FXMQ05NciroAQnRwhJJ8QN3u7XHFeyIDbJriqJgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407828AbfIVSwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407718AbfIVSwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:52:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B40C221479;
        Sun, 22 Sep 2019 18:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178333;
        bh=FhMqtDm73GhvjtyVWDtKRVY17JuvvD8eg/8rpvN6FjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAljFacNAWxYB1+dErbQAYMIEzNjNynDRv0RNvgErY87dIGlpBQ2Oe/2CsNbp6yKt
         XMw5+uHMFIXRuFPLgPW2/lS3MskAmBOau5IucyPuu5EVW8NBk+imNHKIjIRxF1ZPrP
         MejWDkAiFAjXpuaVINFll0U0G8a3yWNWvtYwBtWI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 096/185] s390/kasan: provide uninstrumented __strlen
Date:   Sun, 22 Sep 2019 14:47:54 -0400
Message-Id: <20190922184924.32534-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

