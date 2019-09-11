Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E438C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219152085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4IwgBxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfIKSVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:21:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41429 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfIKSVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:21:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so24666872wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnHA0tTLl+z1GnDOySHFBaJDRWZSuAxJ6rG0Ra7iSAY=;
        b=l4IwgBxdpDu9T+w0ajDNbGXdRI/iTLFenWDpAybrqkf9KOke9unReQoJhRvEqmQJBT
         gLW2eUCAgo7wcwJ9v087jsMcLwrcXZxxXzPBJALi6HR55Gl913E7Gppc/IxD7/b2pIOn
         KvKPtLxM2XW6zp35aZEfLgpEzq7mc6D1RaSXnsalXAIHYM9Fc/9Wk5kP/PSmt3BZoBrs
         nh0uEfnoeliD8oalMkdN1iGBJRnipxgk02ZRm5gUg6Cm30TuakHxjU0zyQW6j2Hitivo
         oxShvouMpH53hDwhHGJkaZDQcxZe82dYFPziQEFBiBbfc91jghXaPaMbPVOGoGpRgQdI
         l1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnHA0tTLl+z1GnDOySHFBaJDRWZSuAxJ6rG0Ra7iSAY=;
        b=VuJXlN76JZ3N4jqmZR7MBSzUjsS7mDMt+gHxuTbmOTlYggDTUbtxMZ3eFy4/kTnHMQ
         sEKDS10Sq/hofOzAgyNIbXuaQXhiOA1nibe21P/aEzbzKORv7eUnkmv8MEr0817usnCM
         GpF8/WRurd6k5XMAWsEynvbs3vAE6BwtjPSFaunM240KYDS5w5R0PD4OTlG/Mty0E6Dz
         /K/NB9lUKgDvdZG7czv9Nf9o6HjY+gwhLd05YvJHynx3+H0X/SYeiKhSsyP905Fw/MvU
         HwuW5tc530XspZthUD3OJTFMMz2crfkiZPdcgEO+1q4hN8Wg/LGuQ9XuQ4oZkSs9pjmV
         dRfw==
X-Gm-Message-State: APjAAAXNB5EZk0HH/BlB7YfWvQkZSSEt9WWhHegvWV2GWoYRaYFA/Tdf
        fpO7gcndaUlJ2ioHuHmkUS/q6ZHpJD8=
X-Google-Smtp-Source: APXvYqyoWuVYmjzKgrryye+Nv4SeeKM8ayud6J5dQEp6fgy1G8ogFGzl/HLfIC0P9S2J/Dhwnhe+3g==
X-Received: by 2002:adf:804d:: with SMTP id 71mr3414246wrk.3.1568226112313;
        Wed, 11 Sep 2019 11:21:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id q9sm2356753wmq.15.2019.09.11.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 11:21:51 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v3 3/3] powerpc/prom_init: Use -ffreestanding to avoid a reference to bcmp
Date:   Wed, 11 Sep 2019 11:20:52 -0700
Message-Id: <20190911182049.77853-4-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911182049.77853-1-natechancellor@gmail.com>
References: <20190911182049.77853-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r370454 gives LLVM the ability to convert certain loops into a reference
to bcmp as an optimization; this breaks prom_init_check.sh:

  CALL    arch/powerpc/kernel/prom_init_check.sh
Error: External symbol 'bcmp' referenced from prom_init.c
make[2]: *** [arch/powerpc/kernel/Makefile:196: prom_init_check] Error 1

bcmp is defined in lib/string.c as a wrapper for memcmp so this could be
added to the whitelist. However, commit 450e7dd4001f ("powerpc/prom_init:
don't use string functions from lib/") copied memcmp as prom_memcmp to
avoid KASAN instrumentation so having bcmp be resolved to regular memcmp
would break that assumption. Furthermore, because the compiler is the
one that inserted bcmp, we cannot provide something like prom_bcmp.

To prevent LLVM from being clever with optimizations like this, use
-ffreestanding to tell LLVM we are not hosted so it is not free to make
transformations like this.

Link: https://github.com/ClangBuiltLinux/linux/issues/647
Link: https://github.com/llvm/llvm-project/commit/5c9f3cfec78f9e9ae013de9a0d092a68e3e79e002
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

New patch in the series so no previous version.

 arch/powerpc/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 19f19c8c874b..aa78b3f6271e 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -21,7 +21,7 @@ CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 
-CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)
+CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector) -ffreestanding
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-- 
2.23.0

