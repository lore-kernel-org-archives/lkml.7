Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BBEC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD517218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JoV0DWkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfDWVLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:11:24 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:38749 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWVLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:11:24 -0400
Received: by mail-qk1-f201.google.com with SMTP id z19so11532622qkj.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eHYZmjesflQdPVGOTGQwO4393GXn5tkz07pTFvSiuzs=;
        b=JoV0DWktfcvqI23dn2nF/pzJYfmDnrGO6DLOHhfm/g5OBEdGH7oA0Q5TOmf19zZAaj
         Q60IUoBjPZL39JkzbYjAO7l6GMwxpXnq1wEG8XgusrrYQVYtiA9g6jneFurYicXl+xSC
         qMS48VdntQhrXMpnnYMv0GMmCfrI3gj0PCPD/kxdao4CZllYceM+0GVfK4esyjY8ef3/
         FMxMTYl+zc9LYZ/kbIADFqFRmmi83ENVLSsGuTRJvCgmd9EjwqQdy5yaaNy/aLrfnYdQ
         zSDWWRtFJs9jB0BfTS9KpoESyRcwDiZRmJOj5rvAaboL3Tlzk5CMQompoROIODMjs28W
         1DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eHYZmjesflQdPVGOTGQwO4393GXn5tkz07pTFvSiuzs=;
        b=mFbshJBNnGpvgZCZM24DKbUM6pMO96QQXaaZRMjNye198gpuvFV4isW0iLRrdj1Vcp
         97mTyk8l76our7fraDWpDxrqiDPFsYkm3lY0NS4qPCb1f/qPEawOVL70mpRxuZRGRkdH
         j8IyDnwEDpg029TXnZL5Hvz9ffxhJ+xjdTJJ3ru3gUmtQTBinSA95981BwNMdffPPj3/
         0tOGLbElo49xmv66VngMeSRQsqWEw5L0/z9QiiF4NobwGLmZVjfYsUm/chgkQE6zHgcx
         TiWl2S8NdTYnqBa4uBTqzn4dVfsYDN8mGbYwY5BT2EeK+paF0FqWUgadb47Dc/BIzSVb
         4afA==
X-Gm-Message-State: APjAAAV6SDa/hAN43suTydUiweVwXAZ3mF913F6PNb9PiKQEQ/5SlEoC
        VRrWDuF3xbJsE4ZjTEaLe0DvjnQVkW/nSMld7y8=
X-Google-Smtp-Source: APXvYqwvUVrI5w7+HQ4Voz3Luialg00FkdVOpOuknQ3P85DcnoM1jeEyL7v3WA7N01k1YkXV8bVpSe0gA0rJoBxFp+U=
X-Received: by 2002:a37:9902:: with SMTP id b2mr10745835qke.239.1556053883187;
 Tue, 23 Apr 2019 14:11:23 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:11:14 -0700
Message-Id: <20190423211116.261111-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] powerpc: vdso: drop unnecessary cc-ldoption
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Towards the goal of removing cc-ldoption, it seems that --hash-style=
was added to binutils 2.17.50.0.2 in 2006. The minimal required version
of binutils for the kernel according to
Documentation/process/changes.rst is 2.20.

Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
Cc: clang-built-linux@googlegroups.com
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/kernel/vdso32/Makefile | 5 ++---
 arch/powerpc/kernel/vdso64/Makefile | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index ce199f6e4256..06f54d947057 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -26,9 +26,8 @@ GCOV_PROFILE := n
 KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
 
-ccflags-y := -shared -fno-common -fno-builtin
-ccflags-y += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=both)
+ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
+	-Wl,-soname=linux-vdso32.so.1 -Wl,--hash-style=both
 asflags-y := -D__VDSO32__ -s
 
 obj-y += vdso32_wrapper.o
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index 28e7d112aa2f..32ebb3522ea1 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -12,9 +12,8 @@ GCOV_PROFILE := n
 KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
 
-ccflags-y := -shared -fno-common -fno-builtin
-ccflags-y += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=both)
+ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
+	-Wl,-soname=linux-vdso64.so.1 -Wl,--hash-style=both
 asflags-y := -D__VDSO64__ -s
 
 obj-y += vdso64_wrapper.o
-- 
2.21.0.593.g511ec345e18-goog

