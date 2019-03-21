Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A77C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0500721917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfCUWBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:01:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:53197 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbfCUWAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="216357242"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 58BB130214C; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, mhiramat@kernel.org
Subject: [PATCH 11/17] x86/kprobes: Make trampoline_handler global and visible
Date:   Thu, 21 Mar 2019 15:00:03 -0700
Message-Id: <20190321220009.29334-12-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
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

