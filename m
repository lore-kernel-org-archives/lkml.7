Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BFDC43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15BB20850
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfKQWNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 17:13:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfKQWNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:13:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF0E82084C;
        Sun, 17 Nov 2019 22:13:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iWSn9-0002sK-14; Sun, 17 Nov 2019 17:13:11 -0500
Message-Id: <20191117221310.917990004@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 17 Nov 2019 17:13:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 6/7] ftrace: Add another check for match in register_ftrace_direct()
References: <20191117221256.228674565@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As an instruction pointer passed into register_ftrace_direct() may just
exist on the ftrace call site, but may not be the start of the call site
itself, register_ftrace_direct() still needs to update test if a direct call
exists on the normalized site, as only one direct call is allowed at any one
time.

Fixes: 763e34e74bb7d ("ftrace: Add register_ftrace_direct()")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 32e4e5ffdd97..9fe33ebaf914 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5030,7 +5030,12 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 		goto out_unlock;
 
 	/* Make sure the ip points to the exact record */
-	ip = rec->ip;
+	if (ip != rec->ip) {
+		ip = rec->ip;
+		/* Need to check this ip for a direct. */
+		if (find_rec_direct(ip))
+			goto out_unlock;
+	}
 
 	ret = -ENOMEM;
 	if (ftrace_hash_empty(direct_functions) ||
-- 
2.24.0


