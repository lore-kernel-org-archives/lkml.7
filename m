Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5716EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E752217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427905;
	bh=JBtVoaT0g82CvcmsPisB4l2gsmCEcnu04QTdbPJ3rSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fx+M06T8w4u8e1NTd20v3qxpMhSG5yIQsM/HX6/RiW34N6tkXx7gFYTmNXNH61brM
	 kjEqbExCUrYwq6TAAvxnXkA81u2N3iX8kKo2YTcfqrU4f/xnEpG4ENQ/bj0pZytunm
	 LfQNCCNnYAdhPJnE47ModIcyS5DKLxPVKLpzpiUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfEISvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfEISvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:51:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5292177E;
        Thu,  9 May 2019 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427902;
        bh=JBtVoaT0g82CvcmsPisB4l2gsmCEcnu04QTdbPJ3rSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qShn9gKlpRHlGs78ev0XtMGoeyO5AuQXYsxinXs8LJXOAJIQ80HZ9pxz3AshJZYL2
         QL3boEDb84KMBdGc07j+FIv8Yh008EKNQ8uJwEqX/cRMPzh6woThv7qgTtQdD25ft0
         LErJhqgGLWW+Ry2ipmNmba3L9wj1laPLs54DURWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 47/95] objtool: Add rewind_stack_do_exit() to the noreturn list
Date:   Thu,  9 May 2019 20:42:04 +0200
Message-Id: <20190509181312.759976502@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4fa5ecda2bf96be7464eb406df8aba9d89260227 ]

This fixes the following warning seen on GCC 7.3:

  arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_regs()

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/3418ebf5a5a9f6ed7e80954c741c0b904b67b5dc.1554398240.git.jpoimboe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5dde107083c60..479196aeb4096 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -165,6 +165,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"fortify_panic",
 		"usercopy_abort",
 		"machine_real_restart",
+		"rewind_stack_do_exit",
 	};
 
 	if (func->bind == STB_WEAK)
-- 
2.20.1



