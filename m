Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A59DC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5D921881
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956904;
	bh=m9HQn2IXb0oVwD8BfJPkuDze4fZDMui3z6Uwr7B3QVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K0SXlLVnqvyRS4m6vUp/t+n2uVWYYnPZx98cDe7e5ypOPYSzwxiZzYyuk7MdmPOzs
	 uEOUe7pozWulUKixORi6y81ZitD2wyrjsWJyXcPZbXQWytFc722pkVd9/J5UI21TzP
	 GqArOnnhaEmke4LDttlo393OVSTmblw/gA/b8wxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfFSPIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfFSPIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:08:22 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3458C21897;
        Wed, 19 Jun 2019 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956902;
        bh=m9HQn2IXb0oVwD8BfJPkuDze4fZDMui3z6Uwr7B3QVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGmoJG8RQMFGOgbh4gRNvM/wFq0M7p4UnrWNMkrkStkWBQ2+Nu3G3XvdGZsmgBJS0
         e/rOktb4fsBg6TRJ+9LJRocRl+VbuIFgCei7guqS3oo9tTJUtaKCB6HVSsy1iuTqgR
         DyTkwNsX7JJ8VMzP7iBOKaQfippGPYlG97jtwPwk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 07/12] tracing/uprobe: Add per-probe delete from event
Date:   Thu, 20 Jun 2019 00:08:18 +0900
Message-Id: <156095689811.28024.221706761151739433.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156095682948.28024.14190188071338900568.stgit@devnote2>
References: <156095682948.28024.14190188071338900568.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add per-probe delete method from one event passing the head of
definition. In other words, the events which match the head
N parameters are deleted.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Swap the checking order of filename for avoiding unexpected memory
    access.
---
 kernel/trace/trace_uprobe.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c568f7b16f5c..878219552177 100644
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
+	if (strncmp(tu->filename, argv[0], len) || argv[0][len] != ':')
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

