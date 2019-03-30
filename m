Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3049EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A5A2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfC3Ar5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:47:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:64217 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbfC3Arx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:47:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 17:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="scan'208";a="129912804"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2019 17:47:51 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 11E62301BE3; Fri, 29 Mar 2019 17:47:51 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        mhiramat@kernel.org
Subject: [PATCH v2 7/9] x86/kprobes: Make trampoline_handler global and visible
Date:   Fri, 29 Mar 2019 17:47:41 -0700
Message-Id: <20190330004743.29541-7-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330004743.29541-1-andi@firstfloor.org>
References: <20190330004743.29541-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

This function is referenced from assembler, so in LTO
it needs to be global and visible to not be optimized away.

Cc: mhiramat@kernel.org
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/kprobes/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 31ab91c9c4e9..1309a4eb3119 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -752,7 +752,7 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 /*
  * Called from kretprobe_trampoline
  */
-static __used void *trampoline_handler(struct pt_regs *regs)
+__used __visible void *trampoline_handler(struct pt_regs *regs)
 {
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
-- 
2.20.1

