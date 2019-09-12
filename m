Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED69DC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A8120856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="emaSQFCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfILWT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:19:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43755 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbfILWTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:19:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id c19so25284625edy.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgLR6Eqt8jfsgQZgs5aBVeUPiD11IsQFXRalFsn+2h4=;
        b=emaSQFCsNxR0TOUbWEOIul/RdEc3pNYGCkF3wFh/69CjFZ9x7ltYEeLfJ99AwF5KG4
         qH9jEvtbCSNU/hbGeZL+riq2yqkwnkyGkgQS4d7wa4AY0kAHJ5rqkmjDuXbIHeLebnul
         QtiXYOsivkfV8ug9UswoQKKfHgkKF8i9dhs34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgLR6Eqt8jfsgQZgs5aBVeUPiD11IsQFXRalFsn+2h4=;
        b=L62stRleA9Gc20Ic66pIdjzjOoq3aiSJi5c+z26crDK+rHbqmjQiG3Fr0r5B+ugYGZ
         SHV/z9IRixw4leq2G2w+ZGNVwJfEIU6PCEs2V2AKTfn+hdDiMNPQ4eZcYKyEXu49CpzU
         hkNkhzDmbFgz3eIGdjAGiLXVocWvtcxK8ItOaU9a+ZSdJHxM67FFQycCZpqUJ3dNKuG9
         w1df1sEqAIs4Fbuwq595sllx075yLcbQ89AfTl2giyH57k/V7WIRbEF33mcgAb85RCwi
         /2G2Am1p59AW1CpWh4TLw6lln3+FanIUBYC8XxV9pPPaLRqFeayd/wuHXDQ8tNmh8iDx
         yd/w==
X-Gm-Message-State: APjAAAWQl6ddN/A8kBcOI5eI+R/kuLfFWpulFhvRIe/4kUUEAxQ5rLdc
        LDTiWS7+cDaR2/NWk6Dyt3dPnQ==
X-Google-Smtp-Source: APXvYqy6Q8jsn40Z9Ky59Aj/cuBZZRTM4SiMOjBdnE5DKsqqE4B8mjzTXbiMzqMwVuf2LhOgpcObAw==
X-Received: by 2002:aa7:da8b:: with SMTP id q11mr44338366eds.19.1568326789172;
        Thu, 12 Sep 2019 15:19:49 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id 36sm4305228edz.92.2019.09.12.15.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:19:48 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 6/6] x86: bug.h: use asm_inline in _BUG_FLAGS definitions
Date:   Fri, 13 Sep 2019 00:19:27 +0200
Message-Id: <20190912221927.18641-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912221927.18641-1-linux@rasmusvillemoes.dk>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps preventing a BUG* or WARN* in some static inline from
preventing that (or one of its callers) being inlined, so should allow
gcc to make better informed inlining decisions.

For example, with gcc 9.2, tcp_fastopen_no_cookie() vanishes from
net/ipv4/tcp_fastopen.o. It does not itself have any BUG or WARN, but
it calls dst_metric() which has a WARN_ON_ONCE - and despite that
WARN_ON_ONCE vanishing since the condition is compile-time false,
dst_metric() is apparently sufficiently "large" that when it gets
inlined into tcp_fastopen_no_cookie(), the latter becomes too large
for inlining.

Overall, if one asks size(1), .text decreases a little and .data
increases by about the same amount (x86-64 defconfig)

$ size vmlinux.{before,after}
   text    data     bss     dec     hex filename
19709726        5202600 1630280 26542606        195020e vmlinux.before
19709330        5203068 1630280 26542678        1950256 vmlinux.after

while bloat-o-meter says

add/remove: 10/28 grow/shrink: 103/51 up/down: 3669/-2854 (815)
...
Total: Before=14783683, After=14784498, chg +0.01%

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/bug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 6804d6642767..facba9bc30ca 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -32,7 +32,7 @@
 
 #define _BUG_FLAGS(ins, flags)						\
 do {									\
-	asm volatile("1:\t" ins "\n"					\
+	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
 		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
@@ -49,7 +49,7 @@ do {									\
 
 #define _BUG_FLAGS(ins, flags)						\
 do {									\
-	asm volatile("1:\t" ins "\n"					\
+	asm_inline volatile("1:\t" ins "\n"				\
 		     ".pushsection __bug_table,\"aw\"\n"		\
 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
 		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
-- 
2.20.1

