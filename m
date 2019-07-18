Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC28C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B1C21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gTk8RyXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbfGRTPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:15:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46283 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfGRTPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:15:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJErik2124834
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:14:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJErik2124834
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477294;
        bh=nXxzt6oYYaGALLLbBPXNV3DKBKwoYMzXt4K0mJ5iBlY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gTk8RyXEftbtE6RZgWWRmFoaSv0WayCdSE8jCFnTYQdZB340R7XdLL04dg4boN3IY
         x7XPcHDyyGrhXzZFHRiSYNVsw3iIIwvteluhkRDi2OEqTsnuFSzZrQ/xWXdjj7oorN
         4Hd1iKXEaIUc+g6DMfBiD581YawzQoHsAv27lmpauBL9Xd19iW/x+IPoajeHfPeGaR
         zE1O2k9JXdACZVyh//nPIYD7N1rKwW32Q+1TuBUZCIeydbOEW5RncJRUaKrW2NlbWP
         bQDV+LOacGxOA766kZpp9BqPTh51UpumM1YzdsFOtS5LtAWa8S0R433W3CyQidss15
         ncM8zDCpZrWyA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJErOd2124831;
        Thu, 18 Jul 2019 12:14:53 -0700
Date:   Thu, 18 Jul 2019 12:14:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-a7e47f26039c26312a4144c3001b4e9fa886bd45@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        jpoimboe@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org
Reply-To: jpoimboe@redhat.com, ndesaulniers@google.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com
In-Reply-To: <035c38f7eac845281d3c3d36749144982e06e58c.1563413318.git.jpoimboe@redhat.com>
References: <035c38f7eac845281d3c3d36749144982e06e58c.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Add mcsafe_handle_tail() to the uaccess
 safe list
Git-Commit-ID: a7e47f26039c26312a4144c3001b4e9fa886bd45
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

Commit-ID:  a7e47f26039c26312a4144c3001b4e9fa886bd45
Gitweb:     https://git.kernel.org/tip/a7e47f26039c26312a4144c3001b4e9fa886bd45
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:46 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:06 +0200

objtool: Add mcsafe_handle_tail() to the uaccess safe list

After an objtool improvement, it's reporting that __memcpy_mcsafe() is
calling mcsafe_handle_tail() with AC=1:

  arch/x86/lib/memcpy_64.o: warning: objtool: .fixup+0x13: call to mcsafe_handle_tail() with UACCESS enabled
  arch/x86/lib/memcpy_64.o: warning: objtool:   __memcpy_mcsafe()+0x34: (alt)
  arch/x86/lib/memcpy_64.o: warning: objtool:   __memcpy_mcsafe()+0xb: (branch)
  arch/x86/lib/memcpy_64.o: warning: objtool:   __memcpy_mcsafe()+0x0: <=== (func)

mcsafe_handle_tail() is basically an extension of __memcpy_mcsafe(), so
AC=1 is supposed to be set.  Add mcsafe_handle_tail() to the uaccess
safe list.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/035c38f7eac845281d3c3d36749144982e06e58c.1563413318.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2f8ba0368231..f9494ff8c286 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -490,6 +490,7 @@ static const char *uaccess_safe_builtin[] = {
 	/* misc */
 	"csum_partial_copy_generic",
 	"__memcpy_mcsafe",
+	"mcsafe_handle_tail",
 	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
 	NULL
 };
