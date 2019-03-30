Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A91217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553910013;
	bh=/YDHOgL/tSBnVUy+gBUJQ2XXaLnuamsARngpraor9Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yr9FYblVBRjRyxMsxVmlkuS/clnUhJ42z09RMa/B+2rwS0OuuYGTx+5MIja/FM6zF
	 naUh502uJVlM6qrC2yR6scnJGh61Z3uTHKdFiOxshk4v6OsygJuiiEBSHdSSONvSS7
	 GqUKz3oPbzOuZpsPvw1K/vtSoW44pbP1aJsN23wQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfC3BkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731066AbfC3B3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:29:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49037218D3;
        Sat, 30 Mar 2019 01:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909377;
        bh=/YDHOgL/tSBnVUy+gBUJQ2XXaLnuamsARngpraor9Fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=us8u/Mf2tGPllNtR4UnBnu4FxDQ619iCkIQN2DPm10BtWEv1ViQbsnOR6jORuhQx5
         SqxjBigb9WjFCwGazUj/Q/7+KnzDwqt+BAnIIhxT5t8GzC9RDBSY2kfZvDUx7PIFO1
         tJhHavjcXT+vAekgngnuRy9C0TbcLOtUn5Iqqdh8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 21/57] compiler.h: update definition of unreachable()
Date:   Fri, 29 Mar 2019 21:28:14 -0400
Message-Id: <20190330012854.32212-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
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
index 269d376f5a11..81c2238b884c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -124,7 +124,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
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

