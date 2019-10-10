Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA6AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1419208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzzPZFBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfJJUc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:32:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40828 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfJJUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:32:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so6067439ota.7;
        Thu, 10 Oct 2019 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWk3YhiiJHg8k8ptjSkAx7ItL9F1legAJpF+beihn+4=;
        b=nzzPZFByrpOo0NvlBOUhGFQUZP2Zqe60DgnyztdpxgMoIpUWkyzpl5Z+TrlaDdjzRi
         3NCJrGLGAb77NBhiFeC3ttL8yXBov+S8RXCOTej35+cZIUWTtSSc//r2RD4HD5Jfapcv
         AvFTqMtDmnKbTguqLzRt76FOxK6iU7fhJdWPiPSNZcA5Nhay/TWmbiQn7moWj9jsEwPq
         tka0fyspeegLizi+iUZSnwGF3Wyvv4G8HsUmOkPnfw2HFjvrEiFoTDAsKWrp6RLXmO3z
         qs451Dr7MiITaSUZs9icAnNS5Y2nghpjMfHmV10zro8sq+SaayVxdvZ0AuFlXrGg96Br
         PQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWk3YhiiJHg8k8ptjSkAx7ItL9F1legAJpF+beihn+4=;
        b=WMFaB94NjRL48tFhnbXF898YXn+IuO4Hs53HFPT5EppSvbRij9jNIvDr9i/BYbSrK1
         Vj2jKUwGSoFW7izP3QJ7p8p0R6U2bTKU8hPLvyg+Ei8mtGCi3jd0x59Zr5QKl2MKG++V
         0JRroIIqiwXzGMO4Hj8N/YAJ5DTqce8TNiulxNSLeyy6YYAFw144QGzSFr6TBmwWuV96
         wCo+d9jGuMaqKC7lM1RjV+tXkhor2ZB4pciodc347ra8D1HPWqmofLsw54aiV82Zdrhv
         FOyOPQXP0pYMXuHa30zH7K/frx7uInzevyMOfR0jxzxM8U7x2C54UGGZCvmMvlkUkNTP
         avng==
X-Gm-Message-State: APjAAAXkeCj9m5wwLiFJLs2tU8RDCHNY41q4stRHuJoQ7K8cJzYm7JNm
        /VviRobJczkrL9SJoXDEfJ4=
X-Google-Smtp-Source: APXvYqzrg7UULLxw4lPwCZO1r2RsOUHQycSN8nXrqfNDK/es35HP7CtBAATV5kvUXSHuW7tGYPg5cg==
X-Received: by 2002:a9d:5605:: with SMTP id e5mr9056238oti.150.1570739546944;
        Thu, 10 Oct 2019 13:32:26 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id l17sm1726636oic.24.2019.10.10.13.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:32:26 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mips: Fix unroll macro when building with Clang
Date:   Thu, 10 Oct 2019 13:31:59 -0700
Message-Id: <20191010203159.20565-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with Clang errors after commit 6baaeadae911 ("MIPS: Provide
unroll() macro, use it for cache ops") since the GCC_VERSION macro
is defined in include/linux/compiler-gcc.h, which is only included
in compiler.h when using GCC:

In file included from arch/mips/kernel/mips-mt.c:20:
./arch/mips/include/asm/r4kcache.h:254:1: error: use of undeclared
identifier 'GCC_VERSION'; did you mean 'S_VERSION'?
__BUILD_BLAST_CACHE(i, icache, Index_Invalidate_I, Hit_Invalidate_I, 32,
)
^
./arch/mips/include/asm/r4kcache.h:219:4: note: expanded from macro
'__BUILD_BLAST_CACHE'
                        cache_unroll(32, kernel_cache, indexop,
                        ^
./arch/mips/include/asm/r4kcache.h:203:2: note: expanded from macro
'cache_unroll'
        unroll(times, _cache_op, insn, op, (addr) + (i++ * (lsize)));
        ^
./arch/mips/include/asm/unroll.h:28:15: note: expanded from macro
'unroll'
        BUILD_BUG_ON(GCC_VERSION >= 40700 &&                    \
                     ^

Use CONFIG_GCC_VERSION, which will always be set by Kconfig.
Additionally, Clang 8 had improvements around __builtin_constant_p so
use that as a lower limit for this check with Clang (although MIPS
wasn't buildable until Clang 9); building a kernel with Clang 9.0.0
has no issues after this change.

Fixes: 6baaeadae911 ("MIPS: Provide unroll() macro, use it for cache ops")
Link: https://github.com/ClangBuiltLinux/linux/issues/736
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/mips/include/asm/unroll.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/unroll.h b/arch/mips/include/asm/unroll.h
index df1cdcfc5a47..c628747d4ecd 100644
--- a/arch/mips/include/asm/unroll.h
+++ b/arch/mips/include/asm/unroll.h
@@ -25,7 +25,8 @@
 	 * generate reasonable code for the switch statement,	\
 	 * so we skip the sanity check for those compilers.	\
 	 */							\
-	BUILD_BUG_ON(GCC_VERSION >= 40700 &&			\
+	BUILD_BUG_ON((CONFIG_GCC_VERSION >= 40700 ||		\
+		      CONFIG_CLANG_VERSION >= 80000) &&		\
 		     !__builtin_constant_p(times));		\
 								\
 	switch (times) {					\
-- 
2.23.0

