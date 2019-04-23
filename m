Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6117C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06B121773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNb+/yQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfDWU30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:29:26 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34745 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWU3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:29:25 -0400
Received: by mail-qk1-f201.google.com with SMTP id s70so14203529qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BAEeSB7WGLvyDCfjwH+OOZ5AXvciJFw3qki2ZdjWtqk=;
        b=rNb+/yQd2oJ6Ajh3K+GJoteTQiuU1XWUI8+ojiGXzxP3NWfXLPE8GZRRO6aLRQUjv0
         y9vm4CQ7TB+pU8KgxaLbUdOjKbWUUFJhhkQ6rve1b/AiNpSNkNmHWpSpT5PxRB/Piwff
         9lMQ7b+iR4bdPCmCaKZ6BsMacA0OCJ1pTxZZEw1IJmNvWoCQ9Ghh11QKj6oWfWDBUNjE
         DoxWkQ2W79k/Zy+LBhbDXggzKka0q0rq3qUbtb1bJUlzKd+EXAQ52ErM/x1dcoxxYoAD
         JQyKc2NrZbjJHIE4QdIbRAyr8LMQw1sMfE31nEadL2pLEM1UGldr76znBP2eoKnqO+DB
         NQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BAEeSB7WGLvyDCfjwH+OOZ5AXvciJFw3qki2ZdjWtqk=;
        b=nsSjixB1+s5LE8nJ6gHjSsCgIuL4FfP+Y9T1k25pTXeU4OwYRLk6lVATQ8LJ9J4t8o
         tePxb5lmgib+Ny1pZI48esM3wtzqwLH3Hpn4n7U6R1cARiJRAXptilV+jVS7xeZvkkw4
         D0YKl6C4u7uz0V/omO7zR/bW3wESAai2yr3eipGBM2LfSp9M2THnuQoWM015jYLfG2U/
         ZtfeGhJncQYGGPcg+XZNVYvxWbOKb64+zKHY2/ahM3Pmbk/YYWLxXudgArlbOqPLhpN/
         de3SwSLdQuBcPIk32W12pHpYhCDyraFI69jcigP+XGTLH17ia/KmS874S0QQdvLRVy2g
         gQYA==
X-Gm-Message-State: APjAAAX7S0hxGCigG6QTwOlQDV2mJf1Fj13frZ8K0EH5cVvVg3rSu7y3
        XvkDl4x0ke/8Q3raprp0XQOsWt4suEMM6BjBqDM=
X-Google-Smtp-Source: APXvYqyHBWfne7Rhm7SSxkktmG3M+4Zkv5H3nTWiSwql9vMWiQwqUWuoIsdRIQug3xaxUac6nox+uotiQOZVZKRQWfI=
X-Received: by 2002:a05:6214:327:: with SMTP id j7mr7710680qvu.150.1556051364679;
 Tue, 23 Apr 2019 13:29:24 -0700 (PDT)
Date:   Tue, 23 Apr 2019 13:29:05 -0700
Message-Id: <20190423202907.234180-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] sh: require --Wl,--hash-style=sysv
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirsky <luto@kernel.org>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Towards the goal of removing cc-ldoption, prefer ld-option, or better
yet, require --Wl,--hash-style=sysv since the selftest for vdso's
requires DT_HASH.

Cc: Andy Lutomirsky <luto@kernel.org>
Cc: clang-built-linux@googlegroups.com
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sh/kernel/vsyscall/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
index 5db6579bc44c..6e8664448048 100644
--- a/arch/sh/kernel/vsyscall/Makefile
+++ b/arch/sh/kernel/vsyscall/Makefile
@@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
 
 export CPPFLAGS_vsyscall.lds += -P -C -Ush
 
-vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
 
 SYSCFLAGS_vsyscall-trapa.so	= $(vsyscall-flags)
 
-- 
2.21.0.593.g511ec345e18-goog

