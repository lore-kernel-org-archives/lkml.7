Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F96C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E7920863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfCZMmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:42:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbfCZMmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:42:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD9120866;
        Tue, 26 Mar 2019 12:42:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1h8lP5-0005Zk-F8; Tue, 26 Mar 2019 08:42:07 -0400
Message-Id: <20190326124207.357135482@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 26 Mar 2019 08:41:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        stable@vger.kernel.org, Frank Rowand <frank.rowand@sony.com>
Subject: [PATCH 2/3] tracing: initialize variable in create_dyn_event()
References: <20190326124143.521905652@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Fix compile warning in create_dyn_event(): 'ret' may be used uninitialized
in this function [-Wuninitialized].

Link: http://lkml.kernel.org/r/1553237900-8555-1-git-send-email-frowand.list@gmail.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 5448d44c3855 ("tracing: Add unified dynamic event framework")
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_dynevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index dd1f43588d70..fa100ed3b4de 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -74,7 +74,7 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 static int create_dyn_event(int argc, char **argv)
 {
 	struct dyn_event_operations *ops;
-	int ret;
+	int ret = -ENODEV;
 
 	if (argv[0][0] == '-' || argv[0][0] == '!')
 		return dyn_event_release(argc, argv, NULL);
-- 
2.20.1


