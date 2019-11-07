Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519CFC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D233218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbfKGEl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:41:28 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54619 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbfKGEl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:41:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0ThOmKb0_1573101683;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0ThOmKb0_1573101683)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Nov 2019 12:41:24 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH untested] x86_32: fix extable entry for iret
Date:   Thu,  7 Nov 2019 04:41:09 +0000
Message-Id: <20191107044109.22272-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3c88c692c287(x86/stackframe/32: Provide consistent pt_regs)
added code after label .Lirq_return and before 'iret', an instruction
which should be expected to be found in the extable when there is
an exception on it. But the extable entry stores the address of
.Lirq_return not the new address of 'iret', which disables
the corresponding fixup. This patch fixes the extable entry
by using a new label.

CC: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
Purely accidently found, untested.

 arch/x86/entry/entry_32.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index f83ca5aa8b77..f62aa6655cfb 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1081,6 +1081,7 @@ restore_all:
 	 * when returning from IPI handler and when returning from
 	 * scheduler to user-space.
 	 */
+.Lirq_return_ex:
 	INTERRUPT_RETURN
 
 restore_all_kernel:
@@ -1118,7 +1119,7 @@ ENTRY(iret_exc	)
 
 	jmp	common_exception
 .previous
-	_ASM_EXTABLE(.Lirq_return, iret_exc)
+	_ASM_EXTABLE(.Lirq_return_ex, iret_exc)
 ENDPROC(entry_INT80_32)
 
 .macro FIXUP_ESPFIX_STACK
-- 
2.20.1

