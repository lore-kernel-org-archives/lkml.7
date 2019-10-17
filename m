Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512B7FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2449020663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392579AbfJQPcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:32:07 -0400
Received: from [217.140.110.172] ([217.140.110.172]:39702 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2388925AbfJQPcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:32:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0398A329;
        Thu, 17 Oct 2019 08:31:47 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (unknown [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 199B03F6C4;
        Thu, 17 Oct 2019 08:31:45 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     mhiramat@kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: kprobes: Drop open-coded exception fixup
Date:   Thu, 17 Oct 2019 16:31:42 +0100
Message-Id: <e70f7b9de7e601b9e4a6fedad8eaf64d304b1637.1571326276.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The short-circuit call to fixup_exception() from kprobe_fault_handler()
poses a problem now that the former wants to consume the fault address
too, since the common kprobes API offers us no way to pass it through.
Fortunately, however, it works out to be unnecessary:

- uaccess instructions themselves are not probeable, so at most we
  should only ever expect to take a fixable fault from the pre or post
  handlers.
- the pre and post handler run with preemption disabled, thus for any
  fault they may cause, an unhandled return from kprobe_page_fault()
  will proceed directly to __do_kernel_fault() thanks to the
  faulthandler_disabled() check.
- __do_kernel_fault() will immediately call fixup_exception() unless
  we're in an EL1 instruction abort, and if we've somehow taken one of
  those on what we think is the middle of a uaccess routine, then the
  world is already very on fire.

Thus we can reasonably drop the call from kprobe_fault_handler() and
leave uaccess fixups to the regular flow.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/kernel/probes/kprobes.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index c4452827419b..422fbd5c6c55 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -334,13 +334,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		 */
 		if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
 			return 1;
-
-		/*
-		 * In case the user-specified fault handler returned
-		 * zero, try to fix up.
-		 */
-		if (fixup_exception(regs))
-			return 1;
 	}
 	return 0;
 }
-- 
2.21.0.dirty

