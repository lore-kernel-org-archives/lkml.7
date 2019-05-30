Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C503C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65D025804
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191013;
	bh=oi8lKQ5r/i49dFb9dykc0Y0t9E2sFOuG489GbRWGmc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=flpNxjrrgxSdrwTqfzPqe8YcJx/7ezYNFM8IxGgymuEIkW66qYwmQbVkW9QLRxu+3
	 nbcXLfziMADuUG1RIx4O43PpEj5KMsrVopSzl34HCw146IrjQ975OQ4GZ+NLpkSnhY
	 sIUFwi0FAXl+uKIMAfj5mER9isz5e8UYXE74dmPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbfE3Egv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729301AbfE3DM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:57 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF9A244E8;
        Thu, 30 May 2019 03:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185976;
        bh=oi8lKQ5r/i49dFb9dykc0Y0t9E2sFOuG489GbRWGmc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kevY+k94O/zBFhLGYTF4ou4qsWGS9cw6sJ0oEbRqLRzdsBvTVoApvQJQE9UpBaZUG
         7SuoRXZl8mMBjsrhDkARTcVKO6zS0WaDnidXbRgw5xDNju1PDae7rfvaJZuujkXHvj
         O40niDGv9rYlc5Dca4J9i2Z4HjKAYCMaasmdjIB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.0 001/346] x86: Hide the int3_emulate_call/jmp functions from UML
Date:   Wed, 29 May 2019 20:01:14 -0700
Message-Id: <20190530030540.450712739@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 693713cbdb3a4bda5a8a678c31f06560bbb14657 upstream.

User Mode Linux does not have access to the ip or sp fields of the pt_regs,
and accessing them causes UML to fail to build. Hide the int3_emulate_jmp()
and int3_emulate_call() instructions from UML, as it doesn't need them
anyway.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/text-patching.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -39,6 +39,7 @@ extern int poke_int3_handler(struct pt_r
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 extern int after_bootmem;
 
+#ifndef CONFIG_UML_X86
 static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
 {
 	regs->ip = ip;
@@ -65,6 +66,7 @@ static inline void int3_emulate_call(str
 	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
 	int3_emulate_jmp(regs, func);
 }
-#endif
+#endif /* CONFIG_X86_64 */
+#endif /* !CONFIG_UML_X86 */
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */


