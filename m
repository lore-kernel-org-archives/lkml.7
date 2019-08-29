Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A898EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7D623404
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BU4KkARm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH2IdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38781 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfH2Ic5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id x3so2172792lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgLR6Eqt8jfsgQZgs5aBVeUPiD11IsQFXRalFsn+2h4=;
        b=BU4KkARm9AOg73ixkmQcodJmg2l9rT+7dX+UZ8Jw9ryRRFNzrHnsAuixQ+pL+oP051
         XFKRDBQv4bD5G7uYzkiksRsBunaSAiB+YDMlwhKYgONropqpuRl0Qv9pAAX2dJv0U2a/
         Mjnak4cemlkKbG3YV1McfAPLIXFEy29F/fLCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgLR6Eqt8jfsgQZgs5aBVeUPiD11IsQFXRalFsn+2h4=;
        b=HLKk335xamvtTAKHwsO7d7Vi7E2u+TQrlbR5iVB+ts7HhapPXvQA9Bc8W79CTNGSgg
         kNnreabr1sian+YX2z1i7bjmKUFmydbEbpPIXmviU5Ylk0Ghu7NAl8yKxUe0SuaE5fdX
         /pqEAq3USvGj5VZHIwqP7koyvhEmJemObmJoKRYmX7B9IFgV6AFGTiVtG4GZeiONcx7p
         4+t18W7s/yhU5LcpTKdPRPy7kIG0oeQQ5Q2OZWtC+3IRt219ZcVl+ByNbATP6DwMhlSE
         gmu0ywpGX0ZQwF+W3iBCB7MXDS1nJDqQPGBLhq2zHo6qa+mRFuC27U4x2S4vetsHgYL7
         fArQ==
X-Gm-Message-State: APjAAAUhZMvx8XXASc1iNKursHub4gcic8wB+bJ2zeVyc6SrNoZdUh32
        VBASEJyms1QK3Dg+kTArAxBhxQ==
X-Google-Smtp-Source: APXvYqyiXnmDPZw3Wq01Z5lJf0JrUon18lAytn2k8k+m4ePo8H2XqV7q1jPIEaZVEQSOaAvVbqEQaA==
X-Received: by 2002:a2e:9c91:: with SMTP id x17mr4517998lji.103.1567067575093;
        Thu, 29 Aug 2019 01:32:55 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o20sm248087ljg.31.2019.08.29.01.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 01:32:54 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 5/5] x86: bug.h: use asm_inline in _BUG_FLAGS definitions
Date:   Thu, 29 Aug 2019 10:32:33 +0200
Message-Id: <20190829083233.24162-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
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

