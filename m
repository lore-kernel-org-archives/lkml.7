Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6017C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 19:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28A62081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 19:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfILTqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 15:46:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:47888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbfILTqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 15:46:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73597AFB2;
        Thu, 12 Sep 2019 19:46:36 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/perf: remove current_is_64bit()
Date:   Thu, 12 Sep 2019 21:46:33 +0200
Message-Id: <20190912194633.12045-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <9973bf6b-f1b9-c778-bd88-ed41e45ca126@c-s.fr>
References: <9973bf6b-f1b9-c778-bd88-ed41e45ca126@c-s.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
current_is_64bit() is quivalent to !is_32bit_task().
Remove the redundant function.

Link: https://github.com/linuxppc/issues/issues/275
Link: https://lkml.org/lkml/2019/9/12/540

Fixes: linuxppc#275
Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/perf/callchain.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 8f30f1b47c78..dd5051015008 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -100,22 +100,10 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 	}
 }
 
-static inline int current_is_64bit(void)
-{
-	if (!IS_ENABLED(CONFIG_COMPAT))
-		return IS_ENABLED(CONFIG_PPC64);
-	/*
-	 * We can't use test_thread_flag() here because we may be on an
-	 * interrupt stack, and the thread flags don't get copied over
-	 * from the thread_info on the main stack to the interrupt stack.
-	 */
-	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
-}
-
 void
 perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
-	if (current_is_64bit())
+	if (!is_32bit_task())
 		perf_callchain_user_64(entry, regs);
 	else
 		perf_callchain_user_32(entry, regs);
-- 
2.23.0

