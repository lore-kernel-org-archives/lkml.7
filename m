Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D82C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7942F20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfCFWcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:32:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfCFWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:32:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x26MVntt1911363
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 14:31:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x26MVmaQ1911360;
        Wed, 6 Mar 2019 14:31:48 -0800
Date:   Wed, 6 Mar 2019 14:31:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-ac5ceccce5501e43d217c596e4ee859f2a3fef79@git.kernel.org>
Cc:     bp@alien8.de, mingo@kernel.org, jpoimboe@redhat.com,
        michal.lkml@markovi.net, hpa@zytor.com, jannh@google.com,
        syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, yamada.masahiro@socionext.com
Reply-To: yamada.masahiro@socionext.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          jannh@google.com, michal.lkml@markovi.net, hpa@zytor.com,
          syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com,
          jpoimboe@redhat.com, mingo@kernel.org, bp@alien8.de
In-Reply-To: <20190301031201.7416-2-jannh@google.com>
References: <20190301031201.7416-2-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/unwind: Add hardcoded ORC entry for NULL
Git-Commit-ID: ac5ceccce5501e43d217c596e4ee859f2a3fef79
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ac5ceccce5501e43d217c596e4ee859f2a3fef79
Gitweb:     https://git.kernel.org/tip/ac5ceccce5501e43d217c596e4ee859f2a3fef79
Author:     Jann Horn <jannh@google.com>
AuthorDate: Fri, 1 Mar 2019 04:12:01 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 23:03:26 +0100

x86/unwind: Add hardcoded ORC entry for NULL

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

---
 arch/x86/kernel/unwind_orc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 26038eacf74a..89be1be1790c 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -113,6 +113,20 @@ static struct orc_entry *orc_ftrace_find(unsigned long ip)
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
@@ -120,6 +134,9 @@ static struct orc_entry *orc_find(unsigned long ip)
 	if (!orc_init)
 		return NULL;
 
+	if (ip == 0)
+		return &null_orc_entry;
+
 	/* For non-init vmlinux addresses, use the fast lookup table: */
 	if (ip >= LOOKUP_START_IP && ip < LOOKUP_STOP_IP) {
 		unsigned int idx, start, stop;
