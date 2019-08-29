Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4EEC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A7F23407
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="R9QUMRrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfH2Ic6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39561 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbfH2Icy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id x4so2171554ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYbyB5kFUWf6dqvDXhjjxb+wzo/FqiSnAfPyprR2IAE=;
        b=R9QUMRrN65bwRnO9px8s4xj14f+pTyMo5vcqnpvdOmG1rcZUGAyrtBEnN5flG942eX
         t92t/xKLbVatDl4D+ZBDCE0Lb+K99LS04XpDFApSlgrxo1U9zGyXvGBigB9fLdH1sCK/
         n32IxO9Is/VSOTbXdS+kz3rq0GNhjFMjkZXpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYbyB5kFUWf6dqvDXhjjxb+wzo/FqiSnAfPyprR2IAE=;
        b=GV6vd/7K3wSi4YxNVrPrAriW8qsHlb1Ys42UVdkBSPGjzzfzBN9W2h5cbo1FHzXs9m
         RQ19BbWsIHYu8f2Y/jWXmLF5enDaKkZYMyd1UVQoEzJXd+tS1kBQbe+BQ/UJBJ/PNoEd
         KwVyKAke6QLVSsgXaFee6GL83P3KEtG3cZ6qCxIRV5tTbs8a16aVlV+9sPLGFQ84+9Ym
         HamQm9DPgsg2THkXu8W49Ex1+Rz8bWGlO4ThXI3rHldNOi8pkY0Ux5BJClFzYcan7P28
         fCrP7gI1mINLAunpuwH6KWyLv8xM/CM3pWdTfGmboATyFQSZpkFTUl8NUlg3yXIEUYZN
         i/yA==
X-Gm-Message-State: APjAAAVaxMGoT8NbVMm/IrRrLZFyG+3Gm6Buh/6PGiiaV8dbJtRD6F0/
        6dorkODyR73AwNWZurFolsy4/w==
X-Google-Smtp-Source: APXvYqwsHFI0WZ9GyKF8WpFJ1pt/ZVBy4yrgqqH9LCd3BkKb1rBspeYGAL8EvgrI6/YsX020f9mEoQ==
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr4606426lja.180.1567067572941;
        Thu, 29 Aug 2019 01:32:52 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o20sm248087ljg.31.2019.08.29.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 01:32:52 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 3/5] compiler-gcc.h: add asm_inline definition
Date:   Thu, 29 Aug 2019 10:32:31 +0200
Message-Id: <20190829083233.24162-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an asm_inline macro which expands to "asm inline" when gcc
is new enough (>= 9.1), and just asm for older gccs and other
compilers.

Using asm inline("foo") instead of asm("foo") overrules gcc's
heuristic estimate of the size of the code represented by the asm()
statement, and makes gcc use the minimum possible size instead. That
can in turn affect gcc's inlining decisions.

I wasn't sure whether to make this a function-like macro or not - this
way, it can be combined with volatile as

  asm_inline volatile()

but perhaps we'd prefer to spell that

  asm_inline_volatile()

anyway.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler-gcc.h   | 4 ++++
 include/linux/compiler_types.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c6bad48..abd7abf7d06b 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -172,3 +172,7 @@
 #endif
 
 #define __no_fgcse __attribute__((optimize("-fno-gcse")))
+
+#if GCC_VERSION >= 90100
+#define asm_inline __asm__ __inline__
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4a8b63e3a31d..3d354b166a94 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -188,6 +188,10 @@ struct ftrace_likely_data {
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
 
+#ifndef asm_inline
+#define asm_inline __asm__
+#endif
+
 #ifndef __no_fgcse
 # define __no_fgcse
 #endif
-- 
2.20.1

