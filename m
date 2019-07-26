Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D2C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC605229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149380;
	bh=dA9rjTfI3ezqpl0b3sykI4tA/BBNeqQ0Y08JP8hVIyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g8AOmFVda1JvR5Uw+8Gc+MGIj8CqtXOheA4K0xpiMP7vx5xrfjwL+lSwgp39FSdeU
	 VUvi1F52Zaffns/RxZEochZZJ/SoJOuanmzAHRSZdLjOeMXEgNwLduUXv5BEfBdfTt
	 McqGpEBSmBImoDbffqXG6UV/gM1nq714qRu/AiXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfGZN4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfGZNlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:41:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE59722CBD;
        Fri, 26 Jul 2019 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148514;
        bh=dA9rjTfI3ezqpl0b3sykI4tA/BBNeqQ0Y08JP8hVIyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGmlVZl8XSMB0BSzWLuhfh9gXsSGgLETdAY8sOvTePaI1nTKSskBvFk5B/Ctp5nmK
         VdoT6+MmFT9gtlC8m3uXuC4q2zglgp0hJgbb2EYRuFD/fM95rZJrVhsNxTFbMpMteQ
         6g60XOzBKcKM0jDc0PUwn06wALiuQYUFzO7Rua/w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 77/85] objtool: Add mcsafe_handle_tail() to the uaccess safe list
Date:   Fri, 26 Jul 2019 09:39:27 -0400
Message-Id: <20190726133936.11177-77-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit a7e47f26039c26312a4144c3001b4e9fa886bd45 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f99195726..f5c3b97051a7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -488,6 +488,7 @@ static const char *uaccess_safe_builtin[] = {
 	/* misc */
 	"csum_partial_copy_generic",
 	"__memcpy_mcsafe",
+	"mcsafe_handle_tail",
 	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
 	NULL
 };
-- 
2.20.1

