Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47857C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FF420821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7obGYnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfDQHWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:22:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45880 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDQHWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:22:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id k92so1934281edc.12;
        Wed, 17 Apr 2019 00:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3v8wsDy/ILxximCAVSroNW2xK66Zhy7QhWurePfHt2c=;
        b=P7obGYnGhTlp1nP9s4sVV1v7uo1BZAlPWNRKoB+iGUvBJg59OVXXnfYNoIvDN/l5rb
         Lj+zBUEnftZreUYfToqqzu/DYQnXmYpgGYjXUUG+tbLutDCaxjwrVx2gF8B0Tzlb2lhV
         7fPHLwG5Ff0XegisJWkrXmMiM3ejupkgRl1DpYc7RZ9p82ohKf0b1WnugCbUn75sjek+
         qEqtOdAZvIn6jeuvfai0GCFrLSiP3Hatml5cMThv5xFWew4Y9Rn8arnvgj/sT3UvffnM
         ZI3ttiTiRuzIhDsp0kofwDKpVfOu9/ppj8XXXFhUr7u7lDp714OuJHSSkkRO6fSwZRts
         qM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3v8wsDy/ILxximCAVSroNW2xK66Zhy7QhWurePfHt2c=;
        b=AqAqT5krA3X2lxnrrB78vld/X447vUFzc3dJ5PcY2/dJwrnPlPvNt8PeG0D32Dj6t5
         A1PheFl7ZMxg64XV50YEQ69y5c0BFSId3T5tUf/kA50zem89gBw5eSVv6kTe+BJUZ9jm
         LjggdJCUAdYhC73XN+y3hxnZpOmBUMt9bhyE0Mb29WUHM7G/Ef3drDl8WY12VFUEjVy+
         6FvwgSzVyYWu4XnEGU9S9XQb1qfy1CNck8byrPCWPFpo5EhytlobY73OyXDoHWbQLn/l
         8mPaUyqDHlSUCgQ8RZMRbQCrKHZvWSTt4sJAj2LGBij3XglCOuDa7JIJPVFG84N7Xfj1
         /Sog==
X-Gm-Message-State: APjAAAWcoGPNFe517/lmeFQFREcgtbUNcuLKglLHWgc2esVCIvQgEoey
        CeNONBAXx2zdCsnvw3Tpdd0=
X-Google-Smtp-Source: APXvYqxc0WZjk8xaXLbNAFK+ANxUnCzD9KngaYeQE14wOtXlaED2g9GpBy2QqIW2ZYnA01FpFiAu0Q==
X-Received: by 2002:a17:906:90d3:: with SMTP id v19mr15384841ejw.268.1555485726589;
        Wed, 17 Apr 2019 00:22:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id s3sm8439889eds.0.2019.04.17.00.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 00:22:04 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] arm64: futex: Restore oldval initialization to work around buggy compilers
Date:   Wed, 17 Apr 2019 00:21:21 -0700
Message-Id: <20190417072121.4450-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 045afc24124d ("arm64: futex: Fix FUTEX_WAKE_OP atomic ops with
non-zero result value") removed oldval's zero initialization in
arch_futex_atomic_op_inuser because it is not necessary. Unfortunately,
Android's arm64 GCC 4.9.4 [1] does not agree:

../kernel/futex.c: In function 'do_futex':
../kernel/futex.c:1658:17: warning: 'oldval' may be used uninitialized
in this function [-Wmaybe-uninitialized]
   return oldval == cmparg;
                 ^
In file included from ../kernel/futex.c:73:0:
../arch/arm64/include/asm/futex.h:53:6: note: 'oldval' was declared here
  int oldval, ret, tmp;
      ^

GCC fails to follow that when ret is non-zero, futex_atomic_op_inuser
returns right away, avoiding the uninitialized use that it claims.
Restoring the zero initialization works around this issue.

[1]: https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/

Cc: stable@vger.kernel.org
Fixes: 045afc24124d ("arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/include/asm/futex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index e1d95f08f8e1..c7e1a7837706 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -50,7 +50,7 @@ do {									\
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 {
-	int oldval, ret, tmp;
+	int oldval = 0, ret, tmp;
 	u32 __user *uaddr = __uaccess_mask_ptr(_uaddr);
 
 	pagefault_disable();
-- 
2.21.0

