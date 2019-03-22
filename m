Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67313C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB9F218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfCVQNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:13:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45955 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCVQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:13:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MGDJVb650421
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 09:13:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MGDIOg650418;
        Fri, 22 Mar 2019 09:13:18 -0700
Date:   Fri, 22 Mar 2019 09:13:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nathan Chancellor <tipbot@zytor.com>
Message-ID: <tip-e898e69d6b9475bf123f99b3c5d1a67bb7cb2361@git.kernel.org>
Cc:     ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        natechancellor@gmail.com
Reply-To: tglx@linutronix.de, bp@alien8.de, natechancellor@gmail.com,
          ndesaulniers@google.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190307212756.4648-1-natechancellor@gmail.com>
References: <20190307212756.4648-1-natechancellor@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/hw_breakpoints: Make default case in
 hw_breakpoint_arch_parse() return an error
Git-Commit-ID: e898e69d6b9475bf123f99b3c5d1a67bb7cb2361
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e898e69d6b9475bf123f99b3c5d1a67bb7cb2361
Gitweb:     https://git.kernel.org/tip/e898e69d6b9475bf123f99b3c5d1a67bb7cb2361
Author:     Nathan Chancellor <natechancellor@gmail.com>
AuthorDate: Thu, 7 Mar 2019 14:27:56 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 17:08:17 +0100

x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() return an error

When building with -Wsometimes-uninitialized, Clang warns:

arch/x86/kernel/hw_breakpoint.c:355:2: warning: variable 'align' is used
uninitialized whenever switch default is taken
[-Wsometimes-uninitialized]

The default cannot be reached because arch_build_bp_info() initializes
hw->len to one of the specified cases. Nevertheless the warning is valid
and returning -EINVAL makes sure that this cannot be broken by future
modifications.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/392
Link: https://lkml.kernel.org/r/20190307212756.4648-1-natechancellor@gmail.com

---
 arch/x86/kernel/hw_breakpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index ff9bfd40429e..d73083021002 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -354,6 +354,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 #endif
 	default:
 		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	/*
