Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4C4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC3D20675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfEHUY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728832AbfEHUYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:24:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5829821726;
        Wed,  8 May 2019 20:24:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOT7V-0007jE-D2; Wed, 08 May 2019 16:24:53 -0400
Message-Id: <20190508202453.294437486@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 16:24:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [for-next][PATCH 10/13] tracing: Allow RCU to run between postponed startup tests
References: <20190508202427.252736423@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

When building a allmodconfig kernel for arm64 and boot that in qemu,
CONFIG_FTRACE_STARTUP_TEST gets enabled and that takes time so the
watchdog expires and prints out a message like this:
'watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]'
Depending on what the what test gets called from init_trace_selftests()
it stays minutes in the loop.
Rework so that function cond_resched() gets called in the
init_trace_selftests loop.

Link: http://lkml.kernel.org/r/20181130145622.26334-1-anders.roxell@linaro.org

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3259019cc66d..4269af5905e4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1722,6 +1722,10 @@ static __init int init_trace_selftests(void)
 	pr_info("Running postponed tracer tests:\n");
 
 	list_for_each_entry_safe(p, n, &postponed_selftests, list) {
+		/* This loop can take minutes when sanitizers are enabled, so
+		 * lets make sure we allow RCU processing.
+		 */
+		cond_resched();
 		ret = run_tracer_selftest(p->type);
 		/* If the test fails, then warn and remove from available_tracers */
 		if (ret < 0) {
-- 
2.20.1


