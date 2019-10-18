Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DA2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2DE21835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634012AbfJRMsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:48:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56810 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633907AbfJRMsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:48:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLRg2-00078J-T1; Fri, 18 Oct 2019 14:48:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5E5E11C009C;
        Fri, 18 Oct 2019 14:48:18 +0200 (CEST)
Date:   Fri, 18 Oct 2019 12:48:18 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: kprobes: Prohibit probing on instruction which
 has emulate prefix
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@alien8.de>, xen-devel@lists.xenproject.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <156777566048.25081.6296162369492175325.stgit@devnote2>
References: <156777566048.25081.6296162369492175325.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157140289814.29376.7139596484011081680.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     004e8dce9c5595697951f7cd0e9f66b35c92265e
Gitweb:        https://git.kernel.org/tip/004e8dce9c5595697951f7cd0e9f66b35c92265e
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Fri, 06 Sep 2019 22:14:20 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Oct 2019 21:31:57 +02:00

x86: kprobes: Prohibit probing on instruction which has emulate prefix

Prohibit probing on instruction which has XEN_EMULATE_PREFIX
or KVM's emulate prefix. Since that prefix is a marker for Xen
and KVM, if we modify the marker by kprobe's int3, that doesn't
work as expected.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: xen-devel@lists.xenproject.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/156777566048.25081.6296162369492175325.stgit@devnote2
---
 arch/x86/kernel/kprobes/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 43fc13c..4f13af7 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -351,6 +351,10 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 	kernel_insn_init(insn, dest, MAX_INSN_SIZE);
 	insn_get_length(insn);
 
+	/* We can not probe force emulate prefixed instruction */
+	if (insn_has_emulate_prefix(insn))
+		return 0;
+
 	/* Another subsystem puts a breakpoint, failed to recover */
 	if (insn->opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
 		return 0;
