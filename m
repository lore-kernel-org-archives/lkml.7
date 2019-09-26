Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE8C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45BB222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfIZJJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfIZJJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:09:32 -0400
Received: from oasis.local.home (unknown [65.39.69.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC340222C0;
        Thu, 26 Sep 2019 09:09:30 +0000 (UTC)
Date:   Thu, 26 Sep 2019 05:09:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [GIT PULL] tracing/probe: Fix same probe event argument matching
Message-ID: <20190926050926.03f37f77@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Srikar Dronamraju fixed a bug in the new multi probe code.


Please pull the latest trace-v5.4-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.4-2

Tag SHA1: ba75d3b05b6e1e995b9c934f8e387c93e879c18b
Head SHA1: f8d7ab2bded897607bff6324d5c6ea6b4aecca0c


Srikar Dronamraju (1):
      tracing/probe: Fix same probe event argument matching

----
 kernel/trace/trace_kprobe.c | 5 +++--
 kernel/trace/trace_uprobe.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)
---------------------------
commit f8d7ab2bded897607bff6324d5c6ea6b4aecca0c
Author: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date:   Tue Sep 24 17:19:06 2019 +0530

    tracing/probe: Fix same probe event argument matching
    
    Commit fe60b0ce8e73 ("tracing/probe: Reject exactly same probe event")
    tries to reject a event which matches an already existing probe.
    
    However it currently continues to match arguments and rejects adding a
    probe even when the arguments don't match. Fix this by only rejecting a
    probe if and only if all the arguments match.
    
    Link: http://lkml.kernel.org/r/20190924114906.14038-1-srikar@linux.vnet.ibm.com
    
    Fixes: fe60b0ce8e73 ("tracing/probe: Reject exactly same probe event")
    Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a6697e28ddda..402dc3ce88d3 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -549,10 +549,11 @@ static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
 		for (i = 0; i < orig->tp.nr_args; i++) {
 			if (strcmp(orig->tp.args[i].comm,
 				   comp->tp.args[i].comm))
-				continue;
+				break;
 		}
 
-		return true;
+		if (i == orig->tp.nr_args)
+			return true;
 	}
 
 	return false;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 34dd6d0016a3..dd884341f5c5 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -431,10 +431,11 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
 		for (i = 0; i < orig->tp.nr_args; i++) {
 			if (strcmp(orig->tp.args[i].comm,
 				   comp->tp.args[i].comm))
-				continue;
+				break;
 		}
 
-		return true;
+		if (i == orig->tp.nr_args)
+			return true;
 	}
 
 	return false;
