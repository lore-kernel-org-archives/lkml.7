Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA57C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087702077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaamSG58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfCLVxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:53:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38429 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfCLVxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:53:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id h58so3659892edb.5;
        Tue, 12 Mar 2019 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KSavGfwM2q9hiXIYXwLw11qtr4FNxFlfDu0QQ0s44pI=;
        b=KaamSG58eho7v280SkLdR2H02gzPlaMJEkNMA93aJEzqJ4YyYYRrYNpM2eAwUNnUbD
         fTF9cNQMVDjOhQ+7ffygxJIJ8s+zshPVbjpldI/mheVuPLejE6ta8G3vRY1zGKDKxylS
         hiI5vEHdxvkD9EwakpCOnBB/S77HOjBwFdl2FKwZLcAl47Vc3ho15xc6xjdLMbhP5JJL
         8OwUlBtJNaE5BYFDqJ1jhOfs/rZbXS6aqIaqVsCri9+AAr+nZj/7BENesHE1DoHKFBeb
         y4MpPRXq4LNt8fZc1zdnEI19t2ggu64kgVtJ/spejIqMMrKf/W0Y7YlfzFeYwpuf4vem
         U/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KSavGfwM2q9hiXIYXwLw11qtr4FNxFlfDu0QQ0s44pI=;
        b=HWEBBpUThNI8QjW2J3urNtT3nDPvuFhUuTRbf/L/0iJMQ9Kqs99bUSIhYy9X5BXK8w
         t/ol9Ndwrc1oZHPQB6Wr3J8FQEifhu+9ePtWVyB+KuoIpMwfoRpJcc0zs400qLQkhNUg
         rGX8l5lh1gNjZKkRfZuqKZKI6PeZfhxrHE2Ib4vVSN8QrmKO6JuhOPSZp83PcoMO5vHD
         7E5d9olfP2A/YoJaXnp5BJGvUEOv1v/uMjwIyRSz6avcqeQHpApa+wSzQT215ez4jITQ
         hf7xHNwoO6KZrFYW2BaZX/28zUDReWUzZq9kJxtwtBqbfWNQdXEytZtRXZHKXYgcLbMu
         JLZA==
X-Gm-Message-State: APjAAAXDkL60ivX+e5kDCSykUKEztMHTpxCJXK9DqjWYK8sYL3Njoa8p
        3rqRA9E3GGJzpZSMEF7s050=
X-Google-Smtp-Source: APXvYqyvsV1XtR4v+JmhJAY/+XXK1EyFuJWZ9BT2jUgQ9yWOocSksM0Hme8RN07pdiU1tQaWMMsERg==
X-Received: by 2002:a17:906:52d0:: with SMTP id w16mr27542428ejn.6.1552427597640;
        Tue, 12 Mar 2019 14:53:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id u47sm3363972edm.37.2019.03.12.14.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 14:53:16 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] Makefile: Add '-fno-builtin-bcmp' to CLANG_FLAGS
Date:   Tue, 12 Mar 2019 14:52:04 -0700
Message-Id: <20190312215203.27643-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After LLVM revision r355672 [1], all known working kernel configurations
fail to link [2]:

ld: init/do_mounts.o: in function `prepare_namespace':
do_mounts.c:(.init.text+0x5ca): undefined reference to `bcmp'
ld: do_mounts.c:(.init.text+0x5e6): undefined reference to `bcmp'
ld: init/initramfs.o: in function `do_header':
initramfs.c:(.init.text+0x6e0): undefined reference to `bcmp'
ld: initramfs.c:(.init.text+0x6f8): undefined reference to `bcmp'
ld: arch/x86/kernel/setup.o: in function `setup_arch':
setup.c:(.init.text+0x21d): undefined reference to `bcmp'

Commit 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to
builtin") removed '-ffreestanding' globally and the kernel doesn't
provide a bcmp definition so the linker cannot find a reference to it.

Fix this by explicitly telling LLVM through Clang not to emit bcmp
references. This flag does not need to be behind 'cc-option' because all
working versions of Clang support this flag.

[1]: https://github.com/llvm/llvm-project/commit/8e16d73346f8091461319a7dfc4ddd18eedcff13
[2]: https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/104027249

Link: https://github.com/ClangBuiltLinux/linux/issues/416
Link: https://bugs.llvm.org/show_bug.cgi?id=41035
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9ef547fc7ffe..6645a274b6e3 100644
--- a/Makefile
+++ b/Makefile
@@ -501,6 +501,7 @@ ifneq ($(GCC_TOOLCHAIN),)
 CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
 CLANG_FLAGS	+= -no-integrated-as
+CLANG_FLAGS	+= -fno-builtin-bcmp
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
-- 
2.21.0

