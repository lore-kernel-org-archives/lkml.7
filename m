Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA73C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2B623779
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OzS0K7LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfH3XPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:15:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32973 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfH3XPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:15:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id l26so9116031edr.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8cz7uF/ZnFNso4QfEvcj/HoNYUQhTLdxA2/ZapBbiuA=;
        b=OzS0K7LXPv7kdg0gaC4aaajPRCQ+oDjZz1mx22oIuxiEou8DV4pC8zE3kQRSQBu3Nn
         FtmcH3Dkk72l1+PKl7ZWe0W8lVlHwdZVO09qzh+wAcnn5Fs6PCQHlDGNzOUfnll5dE3c
         rYCulrsMmdnkowgqDN5xyQDfNGeS3p3i7BZxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cz7uF/ZnFNso4QfEvcj/HoNYUQhTLdxA2/ZapBbiuA=;
        b=sJ7e3a6RLT3QmMRUxMans+WY+MqvQ++IPCRNbl0rKYyNZu3xx5fgYuJgGvgUf9VZ25
         V5P7EDhhOg6UziLJL4okRswCJ7lrLa1+NlP9TFLcFLYiwqKieF6pZ420TVRYogchX3rU
         r6sOq9SWc21nSWW05OSjhvEyT3H9GKaCWBmtMe9uICYuiMY8EWYPH+OtqDZQPSK1xocR
         Udyc7JCUPiyDntFdVjdX6LIiaadFnzJzXZyysPbZvH4LsEYAE2EAkd62Tx47qRUzrk3P
         nk/yfNrGbfPbsQ/qxyo7C/VIdSNQnW54tmDl9uwkC5NnczqBmDa3RGpl/cBMLcMUrjrQ
         kvDQ==
X-Gm-Message-State: APjAAAXfndN7Z/TZEJDOpyHfmci9EKeD9Gpc3Imun9H0jrkaRDA86VIm
        S7acNm6/aL0gGtmzO/8FJrG/2w==
X-Google-Smtp-Source: APXvYqwZoDbhV2WcBa/+3EzQw7TbJHQnBAJxMlA3g8VAp87i0F/MNrkAC/HxD9nKWnuC1Z5Zn26+zw==
X-Received: by 2002:a17:906:94d3:: with SMTP id d19mr15230618ejy.298.1567206937359;
        Fri, 30 Aug 2019 16:15:37 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id s4sm875457ejx.33.2019.08.30.16.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:15:36 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
Date:   Sat, 31 Aug 2019 01:15:25 +0200
Message-Id: <20190830231527.22304-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an asm_inline macro which expands to "asm inline" [1] when gcc
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

[1] Technically, asm __inline, since both inline and __inline__
are macros that attach various attributes, making gcc barf if one
literally does "asm inline()". However, the third spelling __inline is
available for referring to the bare keyword.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler-gcc.h   | 4 ++++
 include/linux/compiler_types.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c6bad48..544b87b41b58 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -172,3 +172,7 @@
 #endif
 
 #define __no_fgcse __attribute__((optimize("-fno-gcse")))
+
+#if GCC_VERSION >= 90100
+#define asm_inline asm __inline
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index ee49be6d6088..ba8d81b716c7 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -198,6 +198,10 @@ struct ftrace_likely_data {
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
 
+#ifndef asm_inline
+#define asm_inline asm
+#endif
+
 #ifndef __no_fgcse
 # define __no_fgcse
 #endif
-- 
2.20.1

