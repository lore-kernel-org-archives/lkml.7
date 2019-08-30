Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C5FC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944442343B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SEyfKpx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfH3XPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:15:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36218 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbfH3XPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:15:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id g24so9746262edu.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgLR6Eqt8jfsgQZgs5aBVeUPiD11IsQFXRalFsn+2h4=;
        b=SEyfKpx+UxdmCsImA4NLZZVWJ0Qc7uZoy3V9wb5N7x6SfGZ6OBGkohHadaiHd5Gj9W
         GOhE+amAdonKoqRYvNSkuCIc4WvUouS4zt2RSP5UR8HUOz4Xoxo/yP2zugiG8WFh1cJj
         8EWjQ+fE1yv2bFmRCJIwOvbJyC5Wm0Nl1Qg7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgLR6Eqt8jfsgQZgs5aBVeUPiD11IsQFXRalFsn+2h4=;
        b=MAs5j7iDKY/flV+Grm/BIWGSrbSlrRzH9h+yoecXLMO2FCo1rO2A05x/LbcMTew0xs
         0vuubNPvI44ilypkv8nWhZ77IGG2ZsFGwxmOuXn4VxUa4/nnOGi4Xy2ffOjcgq7fcWIB
         YZdwTqXDSsBEvh+2tXLNVCTr+iqj+JmPjVFvWQq6EipPA0ZIrpNjFkFf7P68vr0Eom6a
         FgWoUraXX3eSG6RnZa5v3sOGPknL0OL4eohpajLUeUTpceZXd3tGPEGrYznyixSAdPOU
         urL+gh9PacL8GewfFJVx9ZTlxVynCWCOnSeGjVzGT0tnKMxXRz4/sUSxGl+8lpxCVVmb
         bUZw==
X-Gm-Message-State: APjAAAVIGH97G8m9Yk8m0J7xDayCdZXncQGsH4Djx/3kNJJyepe1glSt
        zNmkW1HkKcmfsFHxhSeJjLgfyw==
X-Google-Smtp-Source: APXvYqwztN8hUXwHyb2f1ocdxqiHWw3X9QG++5pPp9Dg6rUm/5MJi2FmPCmzx0umElLLb9kC/VnUww==
X-Received: by 2002:a17:906:5c49:: with SMTP id c9mr8555292ejr.78.1567206939423;
        Fri, 30 Aug 2019 16:15:39 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id s4sm875457ejx.33.2019.08.30.16.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:15:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 6/6] x86: bug.h: use asm_inline in _BUG_FLAGS definitions
Date:   Sat, 31 Aug 2019 01:15:27 +0200
Message-Id: <20190830231527.22304-7-linux@rasmusvillemoes.dk>
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

