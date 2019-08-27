Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801AEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5499220656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CxO4kuP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfH0Ptu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:49:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38881 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbfH0Ptu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:49:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id u190so17430202qkh.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dibpdWj0PBeXuEM69FfN87DRWH5kS3v94RiPB1mv5iU=;
        b=CxO4kuP71bXMdZBURSFVdEA6wqQw9veNFs9SiOUXDz8+GLQkSMpNUvDc2+Uu7dWt5K
         2RVqK/QVIomtdFygUzu5x3xCfxHiRlG1TaWOhZw9yakOOL7eXp8igeouILW2IaBuMGay
         4KaJtN0aWzCBRsZKQ5XbWAH8QKIfmKVbVsIi6DrJvzDGlXADj65lpVVey4TVTpELbhjQ
         DAm9fF3n4JfH6dW+9Ax7obiuUAB8pkae7qQawFmQUd90wT2p/W0euy8Hh6/qYLWuMb/9
         j50hqCT+1aYw1nZRljxHT2U4ZMnPFIUFpeTnY3fVpOScRYLoiFUFUeFMkjfYEgWJnyRH
         jLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dibpdWj0PBeXuEM69FfN87DRWH5kS3v94RiPB1mv5iU=;
        b=WasUyfeQKyvLSs4jKQvyl2Jgc4N2+jH/8UZ6trRdLFiyd4s3iO7g9SrnrkKq1NcCnr
         JY7/ppOfy1BcjCiblDpIT8snvCX4V9JUn/kBoKYh3DOLpDxijtCxkeP/mdtjEs4a6UGw
         HpUGuQ9OzgLC+23QU2cGnv2Bng4/6vQom7q5cSwXdRheaMEX3rJhBmx8EE9u7qwzyJe4
         zKEVtVcJ2/H63N/2hzv4ykTquXqqWlpVIG/CdxvEVmmLQGhZE3Gdd3dENEfND2ayF7nj
         KSOojIbhDMGdPHN1T8ERWJTFzc2yrWqJUK+N7Gc+bm3ocBOP4YPqSMgsCw0AbfB0+PYN
         JnSA==
X-Gm-Message-State: APjAAAU13q/HvALZk8765CHTa+hcyRc90Z0ma+VfO8wOtJoGP28azxPh
        IpM7bWSMqQp7rXnXuyvrTuTa5Mtloik=
X-Google-Smtp-Source: APXvYqzu5/zr/pjEg/k5K28N3QPNYROqHF/i7rqJ5Ju2ChMhxp/jinXqOZrHzVQafRHebX5wnlONpg==
X-Received: by 2002:a37:c49:: with SMTP id 70mr22348368qkm.429.1566920989128;
        Tue, 27 Aug 2019 08:49:49 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w1sm8505153qte.36.2019.08.27.08.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 08:49:48 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     clang-built-linux@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm: silence -Woverride-init/initializer-overrides
Date:   Tue, 27 Aug 2019 11:47:47 -0400
Message-Id: <1566920867-27453-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling a kernel with W=1, there are several of those warnings
due to arm64 override a field by purpose. Just disable those warnings
for both GCC and Clang of this file, so it will help dig "gems" hidden
in the W=1 warnings by reducing some noises.

mm/init-mm.c:39:2: warning: initializer overrides prior initialization
of this subobject [-Winitializer-overrides]
        INIT_MM_CONTEXT(init_mm)
        ^~~~~~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/mmu.h:133:9: note: expanded from macro
'INIT_MM_CONTEXT'
        .pgd = init_pg_dir,
               ^~~~~~~~~~~
mm/init-mm.c:30:10: note: previous initialization is here
        .pgd            = swapper_pg_dir,
                          ^~~~~~~~~~~~~~

Note: there is a side project trying to support explicitly allowing
specific initializer overrides in Clang, but there is no guarantee it
will happen or not.

https://github.com/ClangBuiltLinux/linux/issues/639

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/Makefile b/mm/Makefile
index d0b295c3b764..5a30b8ecdc55 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -21,6 +21,9 @@ KCOV_INSTRUMENT_memcontrol.o := n
 KCOV_INSTRUMENT_mmzone.o := n
 KCOV_INSTRUMENT_vmstat.o := n
 
+CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
+CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
+
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
-- 
1.8.3.1

