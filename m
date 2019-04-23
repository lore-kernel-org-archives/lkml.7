Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A53C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF29218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FASJTTWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDWVBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:01:08 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45733 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfDWVBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:01:08 -0400
Received: by mail-qt1-f201.google.com with SMTP id n1so15797195qte.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/NyG1QKcZGC0H097WcgmzNeJOBuKNIOMmohvdOrd7mQ=;
        b=FASJTTWCqCte6DZtqfZ3VuZF5Kms02wC6DBDMK17x1F7qlMATm4jEBrCThaJKzGvmf
         aZ9GyWywPQza1xB5ec+tlrEdQ85AZoXereip+ubkHlxt1AiO3XMo3HGpDdK4iDExJ3xg
         P1s1WOfO8/MnnpNJldTQuR+eGT001ReFDR5AJp1ZI0Ak9JqVztmm8cTHkvuT3Pkp2NqZ
         FaSmwL4RLz+bvl+5ZMaX4/c3UhBu18+ciQ4H2Fw6+FVXVrOR9p0Pt8Dv1vSrnMrdatYs
         bxivmWbnU7m20PzSBNOzbzGZxNqgC45k3Zxfl300ipVR+v11SWlrP2+/ndjqzStwT3jb
         +Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/NyG1QKcZGC0H097WcgmzNeJOBuKNIOMmohvdOrd7mQ=;
        b=Ntb4u+VrPJ7pgxuO4tQJPhg9cMPwRJBlaDGbqGibAmcS+RKxaDzK944jRVy1iCNc0o
         uKoURGgDyofloefThleq9aN7i4D8nj2vFz3SxSB80GN+zYLLeMl8AVF6KnMQjNG8Sf3z
         D5eVGaIyoRDnzT2QoxdUIjhkf+6Tr7E58lmuiZ2ZmBM1isfgth3/Hv+B9hd+pol9Cyqm
         MeyAU6WU4DYJeq8WfOCDV7XS0ZITl2okF1JYKJqdYJJkYBsBjCqRTBejuYpZhrLkZT+j
         P6QrbIvxjR8DqGdLazWAzJZI8DAR0NEWghz4bTZhndBxhZywAT7JgIAjKf7aADovSm2z
         2oug==
X-Gm-Message-State: APjAAAXLxndI5KN6JlMMrEKsiKnchL5bn/Di04mbRzCZOgcHTsZnBpVk
        Lvb72bWrO+jlTF1bsO/T4OnEhlgVNcKqGhh5L7M=
X-Google-Smtp-Source: APXvYqxCCV8acAiJ9upoQhPCBB9W+kif5F6hu0Z2EO0ew/BJS466O3AMZMHoU8jeo5R4t3+xXADnPtaELPZcNUcsgLQ=
X-Received: by 2002:ac8:708d:: with SMTP id y13mr23107682qto.245.1556053266943;
 Tue, 23 Apr 2019 14:01:06 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:00:56 -0700
Message-Id: <20190423210058.249510-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] s390: vdso: drop unnecessary cc-ldoption
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
 arch/s390/kernel/vdso32/Makefile | 2 +-
 arch/s390/kernel/vdso64/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index e76309fbbcb3..aee9ffbccb54 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -19,7 +19,7 @@ KBUILD_AFLAGS_31 += -m31 -s
 KBUILD_CFLAGS_31 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_31 += -m31 -fPIC -shared -fno-common -fno-builtin
 KBUILD_CFLAGS_31 += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
-			$(call cc-ldoption, -Wl$(comma)--hash-style=both)
+		    -Wl,--hash-style=both
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_31)
 $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_31)
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index f849ac61c5da..bec19e7e6e1c 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -19,7 +19,7 @@ KBUILD_AFLAGS_64 += -m64 -s
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_64 += -m64 -fPIC -shared -fno-common -fno-builtin
 KBUILD_CFLAGS_64 += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
-			$(call cc-ldoption, -Wl$(comma)--hash-style=both)
+		    -Wl,--hash-style=both
 
 $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
 $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_64)
-- 
2.21.0.593.g511ec345e18-goog

