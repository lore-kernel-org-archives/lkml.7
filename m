Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE07CC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8484C21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KvxArwRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391234AbfGRTRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:17:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55947 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfGRTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:17:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJH3eA2125268
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:17:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJH3eA2125268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477423;
        bh=Lru04ggB+q+jtzDE7jyxC2o5FPl/tZz9AqQl3Z43C0s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KvxArwRlfI1OUcfFi/Ri0PFXsbpazXgoDF4a5cosrM9bqmdJ4dZLMxLJj12wNIItu
         sm4aAOROluC1EQgzepx8V73VIEV0N82Ilw+AbL0k7bXttVbdJ63qN1ReVWwKg+qtTu
         A/n+X1G+AgilCdpSpp6JSdiGqsWrfa1NPX83l0MZBMS5yK8VNQJnxKZsuTWmKOZgl8
         A1hmGitZm4+IZdAOx1lU2jN4EE+H/FRkAl7tIHkdOFgaAVE2Ak/ANPO+MMoTXUPcSq
         dbfJHA4rzyjkxkqvWXc81UyVS0d8H1ranRBoeMoacAA4eb8wnvQn4mV+N+Jt5Tk09Z
         CZupXEtVyQDAA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJH27R2125264;
        Thu, 18 Jul 2019 12:17:02 -0700
Date:   Thu, 18 Jul 2019 12:17:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-61e9b75a0ccf1fecacc28a2d77ea4a19aa404e39@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, jpoimboe@redhat.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, jpoimboe@redhat.com, tglx@linutronix.de,
          ndesaulniers@google.com, mingo@kernel.org
In-Reply-To: <03d429c4fa87829c61c5dc0e89652f4d9efb62f1.1563413318.git.jpoimboe@redhat.com>
References: <03d429c4fa87829c61c5dc0e89652f4d9efb62f1.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Warn on zero-length functions
Git-Commit-ID: 61e9b75a0ccf1fecacc28a2d77ea4a19aa404e39
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

Commit-ID:  61e9b75a0ccf1fecacc28a2d77ea4a19aa404e39
Gitweb:     https://git.kernel.org/tip/61e9b75a0ccf1fecacc28a2d77ea4a19aa404e39
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:49 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:07 +0200

objtool: Warn on zero-length functions

All callable functions should have an ELF size.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/03d429c4fa87829c61c5dc0e89652f4d9efb62f1.1563413318.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3f8664b0e3f9..dece3253ff6a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2357,6 +2357,12 @@ static int validate_functions(struct objtool_file *file)
 			if (func->type != STT_FUNC)
 				continue;
 
+			if (!func->len) {
+				WARN("%s() is missing an ELF size annotation",
+				     func->name);
+				warnings++;
+			}
+
 			if (func->pfunc != func || func->alias != func)
 				continue;
 
