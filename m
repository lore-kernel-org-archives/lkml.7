Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97630C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC1A26B96
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315963;
	bh=PPA77UhfqwfqV9DRVF6HwkKX2nvySm7IR28fGmthLwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aYYBb+3TPrFOKybYoL+C2NVwIojKys1y+bwpDhcaE89RQ1OrLrKvvUNyyi5KTXF+h
	 g0/LMaBeRWng4csO20uyFO2Su8tbodc9RGA6OQlvPSquF7Q3CkSzc9rMLSSEjTi2eN
	 aYi+HIFuinXQfrD0V3vcFvsZlUJB61Kx4sGTXMgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfEaPTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEaPTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:19:21 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69BBC26B9B;
        Fri, 31 May 2019 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315961;
        bh=PPA77UhfqwfqV9DRVF6HwkKX2nvySm7IR28fGmthLwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S101Pz4s2vhCyW9Gz3LEgkAefnGs8vuUYuoMq24jpkS+lfvnbcWOiydtf6N80/Oso
         myvceZjOOGMejpHFAYTBuD9fCf+g2bKuNcOJVkZsy+R2ayA5BtkTNgIMUM2BEm7w++
         MR6BV7fkqhy9RbqVflDW5wbVSCulRH8Oga27lG58=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/21] tracing/uprobe: Add per-probe delete from event
Date:   Sat,  1 Jun 2019 00:19:17 +0900
Message-Id: <155931595698.28323.17594202275209962525.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155931578555.28323.16360245959211149678.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add per-probe delete method from one event passing the head of
definition. In other words, the events which match the head
N parameters are deleted.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_uprobe.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 1bd6c29cc0f3..d2e200729c23 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -284,13 +284,42 @@ static bool trace_uprobe_is_busy(struct dyn_event *ev)
 	return trace_probe_is_enabled(&tu->tp);
 }
 
+static bool trace_uprobe_match_command_head(struct trace_uprobe *tu,
+					    int argc, const char **argv)
+{
+	char buf[MAX_ARGSTR_LEN + 1];
+	int len;
+
+	if (!argc)
+		return true;
+
+	len = strlen(tu->filename);
+	if (argv[0][len] != ':' || strncmp(tu->filename, argv[0], len))
+		return false;
+
+	if (tu->ref_ctr_offset == 0)
+		snprintf(buf, sizeof(buf), "0x%0*lx",
+				(int)(sizeof(void *) * 2), tu->offset);
+	else
+		snprintf(buf, sizeof(buf), "0x%0*lx(0x%lx)",
+				(int)(sizeof(void *) * 2), tu->offset,
+				tu->ref_ctr_offset);
+	if (strcmp(buf, &argv[0][len + 1]))
+		return false;
+
+	argc--; argv++;
+
+	return trace_probe_match_command_args(&tu->tp, argc, argv);
+}
+
 static bool trace_uprobe_match(const char *system, const char *event,
 			int argc, const char **argv, struct dyn_event *ev)
 {
 	struct trace_uprobe *tu = to_trace_uprobe(ev);
 
 	return strcmp(trace_probe_name(&tu->tp), event) == 0 &&
-	    (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0);
+	   (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0) &&
+	   trace_uprobe_match_command_head(tu, argc, argv);
 }
 
 static nokprobe_inline struct trace_uprobe *

