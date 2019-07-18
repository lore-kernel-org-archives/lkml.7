Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1270DC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19B82173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YiSLHEbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391282AbfGRTVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:21:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40199 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfGRTVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:21:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJLXFY2126235
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:21:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJLXFY2126235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477694;
        bh=CnyZSSXgIKqDfh9kzVsFZ+320vtrkUBou3/dE6r75Jc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YiSLHEbW1nXbljV4cbxlhcbl4widNgNjVd7XZZXa7SJaraPUCL+OXtHekR/2HK2Ky
         /vS5LE2D73dtEn8/Pp7wPGnUTJoFTcjXYMT6YlVzQHAN+0jF2QcDcVmw8uij0E5gBF
         7hyBwnMTvR3F9aUuwo5jhMXluI0MDZ5j1hPEs7cjQukTvqCdti60dapzL7vj4l1+/1
         4wKk4m8ncW0sROcB52FbBFdYAsNldf4gAALBnfCAQwlsvQVPF2bBJtE/CZuKcrWKO/
         NVmoKjQt+zixiIRwM6x7ptCroutOnQbkjPkbZ8QqZA12a34xO/9HKb/F+4zdUuLQjP
         j8vehATiyiOwQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJLX0W2126232;
        Thu, 18 Jul 2019 12:21:33 -0700
Date:   Thu, 18 Jul 2019 12:21:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-e65050b94d8c518fdbee572ea4ca6d352e1fda37@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mingo@kernel.org, ndesaulniers@google.com, arnd@arndb.de,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          arnd@arndb.de, ndesaulniers@google.com
In-Reply-To: <a9db88eec4f1ca089e040989846961748238b6d8.1563413318.git.jpoimboe@redhat.com>
References: <a9db88eec4f1ca089e040989846961748238b6d8.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Fix seg fault on bad switch table entry
Git-Commit-ID: e65050b94d8c518fdbee572ea4ca6d352e1fda37
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

Commit-ID:  e65050b94d8c518fdbee572ea4ca6d352e1fda37
Gitweb:     https://git.kernel.org/tip/e65050b94d8c518fdbee572ea4ca6d352e1fda37
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:55 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:10 +0200

objtool: Fix seg fault on bad switch table entry

In one rare case, Clang generated the following code:

 5ca:       83 e0 21                and    $0x21,%eax
 5cd:       b9 04 00 00 00          mov    $0x4,%ecx
 5d2:       ff 24 c5 00 00 00 00    jmpq   *0x0(,%rax,8)
                    5d5: R_X86_64_32S       .rodata+0x38

which uses the corresponding jump table relocations:

  000000000038  000200000001 R_X86_64_64       0000000000000000 .text + 834
  000000000040  000200000001 R_X86_64_64       0000000000000000 .text + 5d9
  000000000048  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000050  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000058  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000060  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000068  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000070  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000078  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000080  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000088  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000090  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000098  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000a0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000a8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000b0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000b8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000c0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000c8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000d0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000d8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000e0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000e8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000f0  000200000001 R_X86_64_64       0000000000000000 .text + b96
  0000000000f8  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000100  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000108  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000110  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000118  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000120  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000128  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000130  000200000001 R_X86_64_64       0000000000000000 .text + b96
  000000000138  000200000001 R_X86_64_64       0000000000000000 .text + 82f
  000000000140  000200000001 R_X86_64_64       0000000000000000 .text + 828

Since %eax was masked with 0x21, only the first two and the last two
entries are possible.

Objtool doesn't actually emulate all the code, so it isn't smart enough
to know that all the middle entries aren't reachable.  They point to the
NOP padding area after the end of the function, so objtool seg faulted
when it tried to dereference a NULL insn->func.

After this fix, objtool still gives an "unreachable" error because it
stops reading the jump table when it encounters the bad addresses:

  /home/jpoimboe/objtool-tests/adm1275.o: warning: objtool: adm1275_probe()+0x828: unreachable instruction

While the above code is technically correct, it's very wasteful of
memory -- it uses 34 jump table entries when only 4 are needed.  It's
also not possible for objtool to validate this type of switch table
because the unused entries point outside the function and objtool has no
way of determining if that's intentional.  Hopefully the Clang folks can
fix it.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/a9db88eec4f1ca089e040989846961748238b6d8.1563413318.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 66f7c01385a4..a966b22a32ef 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -932,7 +932,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			break;
 
 		/* Make sure the destination is in the same function: */
-		if (dest_insn->func->pfunc != pfunc)
+		if (!dest_insn->func || dest_insn->func->pfunc != pfunc)
 			break;
 
 		alt = malloc(sizeof(*alt));
