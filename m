Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC19C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 21:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8109206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 21:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfLUVLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbfLUVLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 16:11:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 867482072B;
        Sat, 21 Dec 2019 21:11:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iim29-000o2r-LO; Sat, 21 Dec 2019 16:11:33 -0500
Message-Id: <20191221211133.527681273@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 21 Dec 2019 16:11:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [for-linus][PATCH 4/5] samples/trace_printk: Wait for IRQ work to finish
References: <20191221211106.338673631@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

trace_printk schedules work via irq_work_queue(), but doesn't
wait until it was processed. The kprobe_module.tc testcase does:

:;: "Load module again, which means the event1 should be recorded";:
modprobe trace-printk
grep "event1:" trace

so the grep which checks the trace file might run before the irq work
was processed. Fix this by adding a irq_work_sync().

Link: http://lore.kernel.org/linux-trace-devel/20191218074427.96184-3-svens@linux.ibm.com

Cc: stable@vger.kernel.org
Fixes: af2a0750f3749 ("selftests/ftrace: Improve kprobe on module testcase to load/unload module")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/trace_printk/trace-printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/trace_printk/trace-printk.c b/samples/trace_printk/trace-printk.c
index 7affc3b50b61..cfc159580263 100644
--- a/samples/trace_printk/trace-printk.c
+++ b/samples/trace_printk/trace-printk.c
@@ -36,6 +36,7 @@ static int __init trace_printk_init(void)
 
 	/* Kick off printing in irq context */
 	irq_work_queue(&irqwork);
+	irq_work_sync(&irqwork);
 
 	trace_printk("This is a %s that will use trace_bprintk()\n",
 		     "static string");
-- 
2.24.0


