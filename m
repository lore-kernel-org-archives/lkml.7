Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A5D22319
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzXqUC3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfKSE5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:57:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37828 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKSE5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:57:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id d5so16738810otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 20:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKv0VBuRwgPnUIE0FprSRERanMIVD3+yR6LSEQF1wLY=;
        b=NzXqUC3rnt0t3oKIEOl8NmoyMTwTXCgprN8GV/9qLL2YKXtUMUu4P4K8Ih1vdBU3Os
         /FriExA87fkZ2pE9T4EP9h9zsRQPj+ooLLWOb0gZQymIW46Ymn6/0gSLXYdqACB5SlLZ
         Yw6tIOXBARBSHr4lyussaVG4PrXR2VfkNP8NPr0noFNDUic2AJ0YH8Yrf/J+cOAsxefk
         tPwZgOjBo5fyoB422297DNvybdtVR2iZ80VL6bv4e+a9Rq24OFaUyRcoviTWVYtJmGsr
         BLODOqp1dTrWWHbK7LmRt0r4HLm77pUeDUneUvl5k62ym2Hay6x9uyrPdAJ4D5TzxHv9
         ajtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKv0VBuRwgPnUIE0FprSRERanMIVD3+yR6LSEQF1wLY=;
        b=sL9pVKoUoRsQfpTkU3iXIGuJxZIL5EMEqh+cY0Nw8d9IHfURZzf92VEl4EHp1X3llb
         Rw64i1Jgf4nK65kC/s+x6h95LoYTY5lePXo8PptUmK7AOsoe52nXaPDH5mUFusZqHO9t
         R1p2hxbWO6oTME+98nj/8zE1s6ab+wJx4Ok6fPClBQYE41J6EOEDWGdU81+SQYZ8SDfJ
         5NgjSAIs6im2SasvnlS6et/DJgXPqvI5Zh4BFTwZLAqUadcmPsv2zcjt1mc6mpzvSf+7
         QhXmSlu54gGHLc0m5sCGahdJkV+Jg6ZEZMfzdO/Vr4b8aQLZeBc5NVR4B5m7a5S70tfA
         78+w==
X-Gm-Message-State: APjAAAV7UQZemLhhfFbpTTAXmjxP3ugAcbUYD4hvzQ5dhBcFznL6AZKR
        wHpJdTy56I9Ocv0mALo6sQOeqKFC
X-Google-Smtp-Source: APXvYqxbAXeCxTtTdtfhCHIZocbAGoX1snmaFJ97WP3dgp44HVZfrhRUFqdNVrqmdzEN5O2SrmZvgQ==
X-Received: by 2002:a9d:75c7:: with SMTP id c7mr2239508otl.12.1574139440139;
        Mon, 18 Nov 2019 20:57:20 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::7])
        by smtp.gmail.com with ESMTPSA id e88sm7019765ote.39.2019.11.18.20.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 20:57:19 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v5 3/3] powerpc/prom_init: Use -ffreestanding to avoid a reference to bcmp
Date:   Mon, 18 Nov 2019 21:57:12 -0700
Message-Id: <20191119045712.39633-4-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119045712.39633-1-natechancellor@gmail.com>
References: <20191014025101.18567-1-natechancellor@gmail.com>
 <20191119045712.39633-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r374662 gives LLVM the ability to convert certain loops into a reference
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
Link: https://github.com/llvm/llvm-project/commit/76cdcf25b883751d83402baea6316772aa73865c
Reviewed-by: Nick Desaulneris <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v3:

* New patch in the series

v3 -> v4:

* Rebase on v5.4-rc3.

* Add Nick's reviewed-by tag.

* Update the LLVM commit reference to the latest applied version (r374662)
  as it was originally committed as r370454, reverted in r370788, and
  reapplied as r374662.

v4 -> v5:

* Rebase on next-20191118 to avoid a conflict with commit
  6266a4dadb1d ("powerpc/64s: Always disable branch profiling for prom_init.o")

 arch/powerpc/kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 3c113ae0de2b..82170c155cb6 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -23,6 +23,7 @@ CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 
 CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)
 CFLAGS_prom_init.o += -DDISABLE_BRANCH_PROFILING
+CFLAGS_prom_init.o += -ffreestanding
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-- 
2.24.0

