Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD4C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6A1218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGCOhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCOhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:37:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC6A21871;
        Wed,  3 Jul 2019 14:37:17 +0000 (UTC)
Date:   Wed, 3 Jul 2019 10:37:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190703103715.32579c25@gandalf.local.home>
In-Reply-To: <20190703102504.13344555@gandalf.local.home>
References: <20190526191828.466305460@goodmis.org>
        <20190526191848.266163206@goodmis.org>
        <20190702165008.GC34718@lakrids.cambridge.arm.com>
        <20190703100205.0b58f3bf@gandalf.local.home>
        <20190703140832.GD48312@arrakis.emea.arm.com>
        <20190703102402.1319b928@gandalf.local.home>
        <20190703102504.13344555@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This would be the official patch:

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH] kprobes: Run init_test_probes() later in boot up

It was reported that the moving of the kprobe initialization earlier in the
boot process caused arm64 to crash. This was due to arm64 depending on the
BRK handler being registered first, but the init_test_probes() can be called
before that happens.

By moving the init_test_probes() to later in the boot process, the BRK
handler is now guaranteed to be initialized before init_test_probes() is
called.

Link: http://lkml.kernel.org/r/20190702165008.GC34718@lakrids.cambridge.arm.com

Tested-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/kprobes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5471efbeb937..5a6ecd7bfd73 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2235,6 +2235,8 @@ static struct notifier_block kprobe_module_nb = {
 extern unsigned long __start_kprobe_blacklist[];
 extern unsigned long __stop_kprobe_blacklist[];
 
+static bool run_kprobe_tests __initdata;
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
@@ -2286,11 +2288,19 @@ static int __init init_kprobes(void)
 	kprobes_initialized = (err == 0);
 
 	if (!err)
-		init_test_probes();
+		run_kprobe_tests = true;
 	return err;
 }
 subsys_initcall(init_kprobes);
 
+static int __init run_init_test_probes(void)
+{
+	if (run_kprobe_tests)
+		init_test_probes();
+	return 0;
+}
+module_init(run_init_test_probes);
+
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,
 		const char *sym, int offset, char *modname, struct kprobe *pp)
-- 
2.20.1

