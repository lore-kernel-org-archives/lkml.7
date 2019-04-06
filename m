Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF05DC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC87B2133F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 16:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="qmOQ5jlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDFQ0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 12:26:36 -0400
Received: from smtp.duncanthrax.net ([89.31.1.170]:49713 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDFQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 12:26:36 -0400
X-Greylist: delayed 1845 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Apr 2019 12:26:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From;
        bh=KQi7/O0/S5TD77WmLAt9ftqw2MlthSJ2fzdI3yc/0/Q=; b=qmOQ5jlW5bS24XNL715Murqp1b
        wHIpwT500FCwisAPAHyuu5Yw9NLPnnrR5zbQZ9Bdh1S5tj5/7wu7cRek9weQKpWY84mClmstzlXs2
        EGXgSthmlgIHOaBd8y5E/eSybZpQ5pbrSwDEZ5c7/aRWjyfkii1Mh8phyD72pZsvA9hE=;
Received: from [134.3.47.207] (helo=t470p.stackframe.org)
        by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <svens@stackframe.org>)
        id 1hCnfT-00083I-La; Sat, 06 Apr 2019 17:55:43 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sven Schnelle <svens@stackframe.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] kprobes: fix compilation when KPROBE_EVENTS is enabled without kretpobes
Date:   Sat,  6 Apr 2019 17:55:43 +0200
Message-Id: <20190406155543.15353-1-svens@stackframe.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While implementing kprobes on PA-RISC (without kretprobes) compilation
fails when CONFIG_KPROBE_EVENTS is enabled:

kernel/trace/trace_kprobe.o: in function `trace_kprobe_create':
kernel/trace/trace_kprobe.c:666: undefined reference to `kprobe_on_func_entry'
kernel/trace/trace_kprobe.o: in function `trace_kprobe_on_func_entry':
kernel/trace/trace_kprobe.c:167: undefined reference to `kprobe_on_func_entry'
kernel/trace/trace_kprobe.c:167: undefined reference to `kprobe_on_func_entry'
make: *** [Makefile:1029: vmlinux] Error 1

Given the fact that these functions have no dependencies on kretprobes i think
they should be moved out of the #ifdef CONFIG_KRETPROBES block.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c83e54727131..10a7e67fea67 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1819,6 +1819,26 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 	return (unsigned long)entry;
 }
 
+bool __weak arch_kprobe_on_func_entry(unsigned long offset)
+{
+	return !offset;
+}
+
+bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym,
+			  unsigned long offset)
+{
+	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
+
+	if (IS_ERR(kp_addr))
+		return false;
+
+	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
+					 !arch_kprobe_on_func_entry(offset))
+		return false;
+
+	return true;
+}
+
 #ifdef CONFIG_KRETPROBES
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
@@ -1875,25 +1895,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
 
-bool __weak arch_kprobe_on_func_entry(unsigned long offset)
-{
-	return !offset;
-}
-
-bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
-{
-	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
-
-	if (IS_ERR(kp_addr))
-		return false;
-
-	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
-						!arch_kprobe_on_func_entry(offset))
-		return false;
-
-	return true;
-}
-
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret = 0;
-- 
2.20.1

