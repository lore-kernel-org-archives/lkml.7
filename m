Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC21C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6034622DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567508910;
	bh=XgZDVToYtxydQv1kuHCV3/EJ66RoUOiOqTzG5Lf9Fuc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=W2VGioISrW8u+jHS0NoJIay46vRjqm4Q8mnCiMUpjq0U0CA+AVvkUyiZV0Wt13LT/
	 8C9oOB8ZCOEraR7ZkcBpnBaDXqsKbp9qu1GnOyrrlRrQeziwzFeDw6c76ygH124rcH
	 DaGOBUFlYKd5kDLZmPmtlS6RWdo1jjjrpXGqAQRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfICLI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbfICLI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:08:27 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE0022CF8;
        Tue,  3 Sep 2019 11:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567508906;
        bh=XgZDVToYtxydQv1kuHCV3/EJ66RoUOiOqTzG5Lf9Fuc=;
        h=From:To:Cc:Subject:Date:From;
        b=1ueJrrTJnHQsSbbOw/cYdAZPLZ/IXfGus1SoFofc6Mnbipf01Ni8trxtiRb1QEoE8
         fjC4wGWTJ8/iuUXREri1B3g88LRn54FdntT5m9RUAngP/2JCAyzMQLtFnmtd9Lj4n7
         QEoHMaKPY4QZiDejY6up7/R9OMLYdRQa0w5I91vc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip v2] kprobes: Prohibit probing on BUG() and WARN() address
Date:   Tue,  3 Sep 2019 20:08:21 +0900
Message-Id: <156750890133.19112.3393666300746167111.stgit@devnote2>
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
  Changes in v2:
   - Add find_bug() stub function for !CONFIG_GENERIC_BUG
   - Cast the p->addr to unsigned long.
---
 include/linux/bug.h |    5 +++++
 kernel/kprobes.c    |    3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bug.h b/include/linux/bug.h
index fe5916550da8..f639bd0122f3 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -47,6 +47,11 @@ void generic_bug_clear_once(void);
 
 #else	/* !CONFIG_GENERIC_BUG */
 
+static inline void *find_bug(unsigned long bugaddr)
+{
+	return NULL;
+}
+
 static inline enum bug_trap_type report_bug(unsigned long bug_addr,
 					    struct pt_regs *regs)
 {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 452151e79535..5bdf47190f09 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1514,7 +1514,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	/* Ensure it is not in reserved area nor out of text */
 	if (!kernel_text_address((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
-	    jump_label_text_reserved(p->addr, p->addr)) {
+	    jump_label_text_reserved(p->addr, p->addr) ||
+	    find_bug((unsigned long) p->addr)) {
 		ret = -EINVAL;
 		goto out;
 	}

