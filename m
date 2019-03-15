Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D4BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D682186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QCLYFU77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCOTy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:54:28 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39416 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCOTyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:54:15 -0400
Received: by mail-yw1-f68.google.com with SMTP id z191so8215224ywa.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=0RCX3Ltyuj+IFk9jI40YoK7mwfQtQVtvVQbx4Yv4YiM=;
        b=QCLYFU77ErSpHb/s1QV0ApuMMdOUn1ZDIR78tKYrg/jxn91lOdBBQ+oE/VJM0NxjLL
         u+TZMWXVvDi0kcw8XsAeksBL4X64PFW3MXy7fE6uHIRygZV2BDZAGOlqH5sVlMkiYRwD
         dTIDsxdhMIV0RSS2z4A6uyUaJQwSy5ti7W7ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=0RCX3Ltyuj+IFk9jI40YoK7mwfQtQVtvVQbx4Yv4YiM=;
        b=hlLZaWga2NabNQyrUOh1WYeo4NUCBx9Iau2pzZDmZVQbT4euGxARQ5U902yZFKAw2Q
         xST+gJaMd7Rrdka/lbGiETGbTQPIouR1MbpRZS+a/X97jACkd14RZvkQJfwc+6ldBDEz
         CSZo467y5Annnf/0N0LD58YBfmRiuP5KRNeO9oZVCew+LrhVfFFovhjUEwVcGT7oToOO
         i+3l3bdOSCvx1hdCJUyLzYxDFRPyMjQnnbib8NMp0PDT/oWnIli16OT2C12uV27W/zm6
         hSU0uL8LCfhZjKkWdkf4zpnTK6G/NMF7/uDPN6RZZYXLvtBvWGBKkWgOuRRUlYd3FN/t
         F+FQ==
X-Gm-Message-State: APjAAAW0GcaU4TzZdoG7I02QQ9NI61pRri+s1x+DDXcvntLzUmacEUH8
        /oDoLoAD4ngdA4zT3A4vFxLYte24shLc3jqjyYBZnQ==
X-Google-Smtp-Source: APXvYqx11p/WV9bZIM36YCpP8/Sbo4A9LFCEceafrqfRTMlsilj9QLFJMzyi7X3yJG2WYuSVAdbBfhTPt/CmKLX1Gus=
X-Received: by 2002:a25:2f8e:: with SMTP id v136mr4646345ybv.200.1552679654879;
 Fri, 15 Mar 2019 12:54:14 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 Mar 2019 12:54:14 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Date:   Fri, 15 Mar 2019 12:54:13 -0700
Message-ID: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
Subject: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the 32-bit vDSO with a recent clang version fails due
to undefined symbols:

arch/x86/entry/vdso/vdso32.so.dbg: undefined symbols found

The undefined symbol in this case is __lshrdi3, which is part of
the compiler runtime library, however the vDSO isn't linked against
this library.

Include the kernel version of __lshrdi3 in the 32-bit vDSO build.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/x86/entry/vdso/Makefile | 7 ++++++-
 lib/lshrdi3.c                | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 5bfe2243a08f..7517cd87e10b 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -144,6 +144,7 @@ KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
 KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
 KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS_32 += -DBUILD_VDSO

 ifdef CONFIG_RETPOLINE
 ifneq ($(RETPOLINE_VDSO_CFLAGS),)
@@ -153,12 +154,16 @@ endif

 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)

+$(obj)/vdso32/lshrdi3.o: $(srctree)/lib/lshrdi3.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
 $(obj)/vdso32.so.dbg: FORCE \
 		      $(obj)/vdso32/vdso32.lds \
 		      $(obj)/vdso32/vclock_gettime.o \
 		      $(obj)/vdso32/note.o \
 		      $(obj)/vdso32/system_call.o \
-		      $(obj)/vdso32/sigreturn.o
+		      $(obj)/vdso32/sigreturn.o \
+		      $(obj)/vdso32/lshrdi3.o
 	$(call if_changed,vdso)

 #
diff --git a/lib/lshrdi3.c b/lib/lshrdi3.c
index 99cfa5721f2d..8a4fc6bcf3a4 100644
--- a/lib/lshrdi3.c
+++ b/lib/lshrdi3.c
@@ -16,7 +16,7 @@
  * to the Free Software Foundation, Inc.
  */

-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/libgcc.h>

 long long notrace __lshrdi3(long long u, word_type b)
@@ -42,4 +42,6 @@ long long notrace __lshrdi3(long long u, word_type b)

 	return w.ll;
 }
+#ifndef BUILD_VDSO
 EXPORT_SYMBOL(__lshrdi3);
+#endif
-- 
2.21.0.360.g471c308f928-goog
