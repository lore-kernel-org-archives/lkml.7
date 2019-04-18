Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E61DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4FC206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610473;
	bh=8uFTb7gN5no2l0Wj9GJs/9HY3QWW9pxO8mtPIE3n/ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cUr9RKmM22fzt3wGRjv2nYaUfF6tK6BixJ8BM+UwwICfH0XEp/Fpd/0YubMQI0dDX
	 z598cxlb/3t1EkUjLS3v+QOupNgQa4VPG6SYfOYQDSc6x/rQi/2Dt3qli094avepEm
	 1t4XR+rklG2BPomJ3zxbHEkmCd03ApGT2DseqfAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390508AbfDRSBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390494AbfDRSBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:01:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C2F206B6;
        Thu, 18 Apr 2019 18:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610468;
        bh=8uFTb7gN5no2l0Wj9GJs/9HY3QWW9pxO8mtPIE3n/ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xv7P6MV585Ma00p8MdqJr58RlVokJ8+z72h7Iz4Rpfqk0TuagWXGDNTTxn2QWoOAZ
         EarsFzT/8aiLRgQMnMcna3c/rPVN6pkSFsesTXCkTzla2jvfO9edm+Hq9PlKJeAFkr
         nFc325H1+VX3YlUjcnMz7AGajG2rPBx+iGD4Ujr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/110] compiler.h: update definition of unreachable()
Date:   Thu, 18 Apr 2019 19:57:02 +0200
Message-Id: <20190418160445.180360887@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



