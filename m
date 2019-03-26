Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873B8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AACA2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582268;
	bh=A+IP7jlzj4xsXQ6SdYRFEecix0YJ4VQ/h+7H2zYrrcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hz+E+yUO9ah17v2ElsslbiyDiilNqzdDiGfvUV6dz8t4htb5qcCm4QpEKuj5Go6bF
	 PVU3pW61evD9ZXhpHhwbUHyutktrvRJ0oA5heD3Se1OmRLGSP6SQl4tM6VL4Uk9C5u
	 +PwVtX28QLFjbilIsbmWB2o7mJzhSlAOPAtAgMU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbfCZGhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732414AbfCZGho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:37:44 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90BDE2075E;
        Tue, 26 Mar 2019 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582263;
        bh=A+IP7jlzj4xsXQ6SdYRFEecix0YJ4VQ/h+7H2zYrrcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/J/OhohDrTFclReg/FIpLL3eNBZUeOGjL30GzrOVbGlndDjVBD3SFnzzowFK8fbd
         ZKCmDh0sRLB/vvOdPB6tfQ1NrV8lWYXBxieCoOe2PEGC6ko6jlcYxdp73aaYlf9T/a
         N5QRbpu4gn2t+cthTYOmLHDu0NHtqj4AsQFo9jW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 4.19 40/45] x86/unwind: Add hardcoded ORC entry for NULL
Date:   Tue, 26 Mar 2019 15:30:23 +0900
Message-Id: <20190326042704.799087974@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042702.565683325@linuxfoundation.org>
References: <20190326042702.565683325@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit ac5ceccce5501e43d217c596e4ee859f2a3fef79 upstream.

When the ORC unwinder is invoked for an oops caused by IP==0,
it currently has no idea what to do because there is no debug information
for the stack frame of NULL.

But if RIP is NULL, it is very likely that the last successfully executed
instruction was an indirect CALL/JMP, and it is possible to unwind out in
the same way as for the first instruction of a normal function. Hardcode
a corresponding ORC entry.

With an artificially-added NULL call in prctl_set_seccomp(), before this
patch, the trace is:

Call Trace:
 ? __x64_sys_prctl+0x402/0x680
 ? __ia32_sys_prctl+0x6e0/0x6e0
 ? __do_page_fault+0x457/0x620
 ? do_syscall_64+0x6d/0x160
 ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

After this patch, the trace looks like this:

Call Trace:
 __x64_sys_prctl+0x402/0x680
 ? __ia32_sys_prctl+0x6e0/0x6e0
 ? __do_page_fault+0x457/0x620
 do_syscall_64+0x6d/0x160
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

prctl_set_seccomp() still doesn't show up in the trace because for some
reason, tail call optimization is only disabled in builds that use the
frame pointer unwinder.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Link: https://lkml.kernel.org/r/20190301031201.7416-2-jannh@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/unwind_orc.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -113,6 +113,20 @@ static struct orc_entry *orc_ftrace_find
 }
 #endif
 
+/*
+ * If we crash with IP==0, the last successfully executed instruction
+ * was probably an indirect function call with a NULL function pointer,
+ * and we don't have unwind information for NULL.
+ * This hardcoded ORC entry for IP==0 allows us to unwind from a NULL function
+ * pointer into its parent and then continue normally from there.
+ */
+static struct orc_entry null_orc_entry = {
+	.sp_offset = sizeof(long),
+	.sp_reg = ORC_REG_SP,
+	.bp_reg = ORC_REG_UNDEFINED,
+	.type = ORC_TYPE_CALL
+};
+
 static struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
@@ -120,6 +134,9 @@ static struct orc_entry *orc_find(unsign
 	if (!orc_init)
 		return NULL;
 
+	if (ip == 0)
+		return &null_orc_entry;
+
 	/* For non-init vmlinux addresses, use the fast lookup table: */
 	if (ip >= LOOKUP_START_IP && ip < LOOKUP_STOP_IP) {
 		unsigned int idx, start, stop;


