Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91F9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02CB2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909836;
	bh=mUhyyBjO06/dyxhqCghZnpDf0hg7B5DuAGK70pp7crw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eBgd7D+hqXOn3Mrr6Rpv5C9m5yEzj6VkgokbtvjDZS39ngQt7NgbiLHsX/KnffqoV
	 p59dt/cOhIUl8mXC9592lzYkrr7+u4KiWoojVhLOGJjt1Sf4VjaNiawSIfx8yxZQxd
	 Cg7POU4kruGpIfASNs67EL22b/70Nm1hnxhxaeQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbfC3BhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731776AbfC3Ba4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004D621773;
        Sat, 30 Mar 2019 01:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909455;
        bh=mUhyyBjO06/dyxhqCghZnpDf0hg7B5DuAGK70pp7crw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fz9Ze+mw2xhO25NaLMtQ1Wu3rd9sG93ewyYKAUYw5w3oYc9HqbYmxChtC/9aEmJJO
         dncgospGIe8locb+A7RkIoOmK5eWYtromK7k0N+32tUqP8Y2WjzJpY2TQt0pV9AgAP
         1Ck1dPHQAZs+27u2Vlv+keYtLdd+sk9xgCJ1DA+s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/37] compiler.h: update definition of unreachable()
Date:   Fri, 29 Mar 2019 21:29:58 -0400
Message-Id: <20190330013020.379-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "ndesaulniers@google.com" <ndesaulniers@google.com>

[ Upstream commit fe0640eb30b7da261ae84d252ed9ed3c7e68dfd8 ]

Fixes the objtool warning seen with Clang:
arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
instruction

Fixes commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
mutually exclusive")

Josh noted that the fallback definition was meant to work around a
pre-gcc-4.6 bug. GCC still needs to work around
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365, so compiler-gcc.h
defines its own version of unreachable().  Clang and ICC can use this
shared definition.

Link: https://github.com/ClangBuiltLinux/linux/issues/204
Suggested-by: Andy Lutomirski <luto@amacapital.net>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index a704d032713b..67c3934fb9ed 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -119,7 +119,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define ASM_UNREACHABLE
 #endif
 #ifndef unreachable
-# define unreachable() do { annotate_reachable(); do { } while (1); } while (0)
+# define unreachable() do {		\
+	annotate_unreachable();		\
+	__builtin_unreachable();	\
+} while (0)
 #endif
 
 /*
-- 
2.19.1

