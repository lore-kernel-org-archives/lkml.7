Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A61C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2452186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezyo80UF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCNWPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:15:12 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34038 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCNWPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:15:12 -0400
Received: by mail-pg1-f201.google.com with SMTP id z14so7843063pgu.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a0Z+F0fmFULDIL5rprNh3E5BB87HBNzyaQEazZwo8Qo=;
        b=ezyo80UFCqF77L/UIQxJ158UXxq76PaoXjEMckKTRveE72ftF7nAsQicf+Bl2pscg7
         CKg4CHZE5cGPVOrG4Q4zRmvz2e/RfXxj9QberpSCQ1WQxdNTaHdt+b3ia/F04nMygpK1
         dylUAO/Yh1nr52563Hx9Jleo0Brv3/+hZet0iZmGBZ378pP0vRjdHh5yqG3I7Xrg6O3o
         9N75eQ5p8t2fnMsgH5+j5IcTEJ7DwTqR43YwgDhuyfnOyeEK8RIkvu8mDAF7yRxykJC4
         i58pfCrF4djBE5ZefEq68LIAizmZoLVNYbJ2x2boj6t39bqKNFzd4ct10GP9RkYP9siC
         rQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a0Z+F0fmFULDIL5rprNh3E5BB87HBNzyaQEazZwo8Qo=;
        b=loz3TeYmHb+xD+qjRo2sYH9u5KVRJGdQIzkXnpN/PwidKgRJO//whSOSGUs7lpNcIx
         7jc84YfkYKx+KS2STKnKvXdEfuYCiYrXo5zaJ7DUzt/xt+3cpazn83/MXDT612sPFu+d
         Vjhdx7lW/neNL6mu5nVGU4JIiBP9hORV4DLWpnBSGRCdIejApwULWx6tLavQW33tR3J0
         +kCFm1/pf5mPg2W81uz+bz70QsdTfQDgu9gEXaa9JF1WB0n5XQ94793xfr2Th0etSBIb
         nr08Gr9wCh1VZQtvsGGsOzcwqNaZQ+3F77CT0QF8K28bglqfaaaE2VDCQltWG+TayACq
         Swcg==
X-Gm-Message-State: APjAAAVF/1tqdJskhyMsEAYB5caJpynv5iGXRryae9nPL8VfmMvmbFWd
        hOEL8et/5Va9ak4U18JtnU0rFbGP1ks9EGrliHk=
X-Google-Smtp-Source: APXvYqyQrj3Vx5wD8I8YjHCK8XkS7nQ2eCCjOt7vZDrLgBIMuLkU4oMqgEBW+ru+fuxG+s7Vpfemam9bcwQt8NtYmn4=
X-Received: by 2002:a62:1f12:: with SMTP id f18mr310434pff.49.1552601711421;
 Thu, 14 Mar 2019 15:15:11 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:14:57 -0700
In-Reply-To: <20190305085707.GA8256@zn.tnic>
Message-Id: <20190314221458.83047-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190305085707.GA8256@zn.tnic>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v4] x86/boot: clean up headers
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     bp@alien8.de
Cc:     natechancellor@gmail.com, niravd@google.com, sfr@canb.auug.org.au,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inclusion of <linux/kernel.h> was causing issue as the definition of
__arch_hweight64 from arch/x86/include/asm/arch_hweight.h eventually gets
included. The definition is problematic when compiled with -m16 (all code
in arch/x86/boot/ is) as the "D" inline assembly constraint is rejected
by both compilers when passed an argument of type long long (regardless
of signedness, anything smaller is fine).

Because GCC performs inlining before semantic analysis, and
__arch_hweight64 is dead in this translation unit, GCC does not report
any issues at compile time.  Clang does the semantic analysis in the
front end, before inlining (run in the middle) can determine the code is
dead. I consider this another case of PR33587, which I think we can do
more work to solve.

It turns out that arch/x86/boot/string.c doesn't actually need
linux/kernel.h, simply linux/limits.h and linux/compiler.h.

Link: https://bugs.llvm.org/show_bug.cgi?id=33587
Link: https://github.com/ClangBuiltLinux/linux/issues/347
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V3 -> V4:
* Drop sentence from commit message about sorting headers.

Changes V2 -> V3:
* keep linux/types.h

Changes V1 -> V2:
* Add Reviewed, Tested, Suggested tags.
* Drop linux/types.h; it's included in linux/limits.h.

 arch/x86/boot/string.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 315a67b8896b..90154df8f125 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -13,8 +13,9 @@
  */
 
 #include <linux/types.h>
-#include <linux/kernel.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
+#include <linux/limits.h>
 #include <asm/asm.h>
 #include "ctype.h"
 #include "string.h"
-- 
2.21.0.360.g471c308f928-goog

