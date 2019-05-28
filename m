Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018E3C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7DC206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 23:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI5A5RfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfE1X5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 19:57:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43114 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1X5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 19:57:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id w33so599069edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tY1S9QD7vrCtWoh/cKmDSkmGt1HGWJIL0pZvj39EZVc=;
        b=JI5A5RfOFw7zOIGH20VztXP0bA2BvcknRnm0vFZRC3rSsuffHbE7bgrV9ZVhUenjBH
         PSug/nv+vELoCpRaNVwey/8uixFj8fMi/O+9mYe+HSkse6CsLZnYP04lRBQsMBthTRs3
         2RmR8I4z+x6MODC5cdThOQrYER+d0kg5skVN2WAkU7AEIoYTkxUglfTfVCxackfHR1qi
         7FcwGF5FbgrlcZ3OMCkUSYakKTtnVkHD8yscBKtVvSittUlBw1W0ZyWJllZml7InwpLC
         NrSQJ39xiWtSyVaNN3+sxnM6l8IgncM8c/PQXM61UtfTBgbYtGDPnksQf6rUhwZGMnTo
         ndkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tY1S9QD7vrCtWoh/cKmDSkmGt1HGWJIL0pZvj39EZVc=;
        b=OGnf4LiifsCqQU5xKse9kI3Xo6YrM/oAYQKoZq1PrwVdit1yE/3rMTottUthSM5AFZ
         AmSSZJU+eGe4WBk/RZNzpq/wlkHYy7F6t90yf/5bzEB1W9WuUW2+GLroagDYioEciBqa
         H7bjLD+dK7mrb1pnSTDPs7Zv46PSvZvA4sgrRfTCtdrEGZbOc5PIhSdJhjb3p38YECjL
         JggM0CmiJzpZVY3YBgs6hfo68k/W33OoOFo04HIXHZMWlFkcBX+bexP6R4iG6JRhISsK
         vK1439JXW5uBpPIzzvDn1x74PRQhaehcJzA7unYCsmj9yYS7/0fUDR8OKlkCbXPhrBDb
         zFeg==
X-Gm-Message-State: APjAAAU2KWVtBV3Pk2+tew+nn1JW1o94A8p08tEcNw37aplokn5QS3qN
        xSECCRmmfVtvXcNtPj5lQ08=
X-Google-Smtp-Source: APXvYqwe8zzoO0T1q2g/lUQM7eKqTZrrvLgQ/+AH38CB0uekNs1XDc1NdxoBewlXX0FRRvcFAk/Ayg==
X-Received: by 2002:a17:906:ca5b:: with SMTP id jx27mr94012887ejb.233.1559087866574;
        Tue, 28 May 2019 16:57:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id v22sm2499638eji.13.2019.05.28.16.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:57:45 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Nicolas Pitre <nico@fluxnic.net>, Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] ARM: xor-neon: Replace __GNUC__ checks with CONFIG_CC_IS_GCC
Date:   Tue, 28 May 2019 16:57:42 -0700
Message-Id: <20190528235742.105510-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when compiling this code with clang, the following warning is
emitted:

    CC      arch/arm/lib/xor-neon.o
  arch/arm/lib/xor-neon.c:33:2: warning: This code requires at least
  version 4.6 of GCC [-W#warnings]

This is because clang poses as GCC 4.2.1 with its __GNUC__ conditionals
for glibc compatibility[1]:

$ echo | clang -dM -E -x c /dev/null | grep GNUC | awk '{print $2" "$3}'
__GNUC_MINOR__ 2
__GNUC_PATCHLEVEL__ 1
__GNUC_STDC_INLINE__ 1
__GNUC__ 4

As pointed out by Ard Biesheuvel and Arnd Bergmann in an earlier
thread[2], the oldest version of GCC that is currently supported is gcc
4.6 after commit cafa0010cd51 ("Raise the minimum required gcc version
to 4.6") so we do not need to check for anything older anymore.

However, just removing the version check is not enough to silence clang
because it does not recognize '#pragma GCC optimize':

  arch/arm/lib/xor-neon.c:25:13: warning: unknown pragma ignored
  [-Wunknown-pragmas]
  #pragma GCC optimize "tree-vectorize"

Looking into it further, -ftree-vectorize (which '#pragma GCC optimize
"tree-vectorize"' enables) is an alias in clang for -fvectorize[3],
which according to the documentation is on by default[4] (at least at
-O2 or -Os).

Just add the pragma when compiling with GCC so that clang does not
unnecessarily warn.

[1]: https://reviews.llvm.org/D51011#1206981
[2]: https://lore.kernel.org/lkml/CAK8P3a3NjTCgFd2dQ9KbHP8DpXf6s-ULfeU6acAYC4SDi+2qvw@mail.gmail.com/
[3]: https://github.com/llvm/llvm-project/blob/eafe8ef6f2b44ba/clang/include/clang/Driver/Options.td#L1729
[4]: https://llvm.org/docs/Vectorizers.html#usage

Link: https://github.com/ClangBuiltLinux/linux/issues/496
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/lib/xor-neon.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index c691b901092f..d532bc072ee4 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -22,15 +22,8 @@ MODULE_LICENSE("GPL");
  * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
  * NEON instructions.
  */
-#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
+#ifdef CONFIG_CC_IS_GCC
 #pragma GCC optimize "tree-vectorize"
-#else
-/*
- * While older versions of GCC do not generate incorrect code, they fail to
- * recognize the parallel nature of these functions, and emit plain ARM code,
- * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
- */
-#warning This code requires at least version 4.6 of GCC
 #endif
 
 #pragma GCC diagnostic ignored "-Wunused-variable"
-- 
2.22.0.rc1

