Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4843EC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC27217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567422376;
	bh=vTuLNZWbArQhjA5Ei1L923sxshBXsB/l6eR0W0H2a70=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QwALoeqe/Fsles3OCh1VT/rq7Wl/mY6FdU0DfFyNTNkOSqxdHOgNUN31ko83SP+pi
	 UmlHHtHbeaDGXhZGKx7Tpl07MFUjPRw5UzrHH10+MIBeUnBkPy2UPKjP3tMKbug3c0
	 XdaElFZ9h8ykoC+y3vZDbjY75VaSvPz9m/NO5QWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfIBLGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfIBLGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:06:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF65B2168B;
        Mon,  2 Sep 2019 11:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567422374;
        bh=vTuLNZWbArQhjA5Ei1L923sxshBXsB/l6eR0W0H2a70=;
        h=From:To:Cc:Subject:Date:From;
        b=B+62yvoudfnsvKVeTyvgp1D0xRdfIlnWUJivjQPY++omYfA4fllXkni7xL05eqvOv
         pzZAgUsnuQdi8DsarIj5fnhi/FWJcht4hjn7Ntc/CqhYrUoI1o717Q8N2oXOiFWm7s
         Ay026KeJkLSbcSWwU0nNBbt3qNDyLFcgBqd++xzs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip] kprobes: Prohibit probing on BUG() and WARN() address
Date:   Mon,  2 Sep 2019 20:06:09 +0900
Message-Id: <156742236963.18000.1855866569667433247.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since BUG() and WARN() may use a trap (e.g. UD2 on x86) to
get the address where the BUG() has occurred, kprobes can not
do single-step out-of-line that instruction. So prohibit
probing on such address.

Without this fix, if someone put a kprobe on WARN(), the
kernel will crash with invalid opcode error instead of
outputing warning message, because kernel can not find
correct bug address.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 452151e79535..771054401e35 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1514,7 +1514,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	/* Ensure it is not in reserved area nor out of text */
 	if (!kernel_text_address((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
-	    jump_label_text_reserved(p->addr, p->addr)) {
+	    jump_label_text_reserved(p->addr, p->addr) ||
+	    find_bug(p->addr)) {
 		ret = -EINVAL;
 		goto out;
 	}

