Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7C6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE0A22350
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163268;
	bh=Pf7UDG6n6dOKrh5Z/+DMFuxT87dU64HgWuHRfhfue1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zw6SI/2N6IsASUVT9jZaQh4hg7tiCVuDIIPmKAI/gHrHkEfIJB892op72WEPzIlWJ
	 E1fzTiHm/90v0NkpNOFSga+JYC/beLWHg9K4Rw91ccnO/bK960onSpNlcJejKVb7Md
	 x0c0rDJVxbsX6z4fpVYVE/WvmIMkxKc5uQlN4ZlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfKSLe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:34:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbfKSLeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:34:22 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A892B219F6;
        Tue, 19 Nov 2019 11:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163261;
        bh=Pf7UDG6n6dOKrh5Z/+DMFuxT87dU64HgWuHRfhfue1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhDmJkwN7OF+HJQ+IltHG/jMUNpA/upNC7G8Dyrtscglg/matcxJFhvOIvWke4lus
         s6mh5PvtNnJGD3Vw9vnIeAPE4/48SqNu+vTLDkfRFCftHE1oudso06z/n/CGbAbQhs
         8JAfqIJ5ObQQJEdfJIUPJPazNDRdCQ8xGiLOEoWc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 21/25] perf probe: Generate event name with line number
Date:   Tue, 19 Nov 2019 08:32:41 -0300
Message-Id: <20191119113245.19593-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Generate event name from function name with line number as
<function>_L<line_number>. Note that this is only for the new event
which is defined by the line number of function (except for line 0).

If there is another event on same line, you have to use
"-f" option. In that case, the new event has "_1" suffix.

 e.g.
  # perf probe -a kernel_read:2
  Added new event:
    probe:kernel_read_L2 (on kernel_read:2)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read_L2 -aR sleep 1

But if we omit the line number or 0th line, it will
have no suffix.

  # perf probe -a kernel_read:0
  Added new event:
    probe:kernel_read (on kernel_read)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read -aR sleep 1

  probe:kernel_read    (on kernel_read@linux-5.0.0/fs/read_write.c)
  probe:kernel_read_L2 (on kernel_read:2@linux-5.0.0/fs/read_write.c)

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406474026.24476.2828897745502059569.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e29948b8fcab..5c86d2cf6338 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1679,6 +1679,14 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
 	if (ret < 0)
 		goto out;
 
+	/* Generate event name if needed */
+	if (!pev->event && pev->point.function && pev->point.line
+			&& !pev->point.lazy_line && !pev->point.offset) {
+		if (asprintf(&pev->event, "%s_L%d", pev->point.function,
+			pev->point.line) < 0)
+			return -ENOMEM;
+	}
+
 	/* Copy arguments and ensure return probe has no C argument */
 	pev->nargs = argc - 1;
 	pev->args = zalloc(sizeof(struct perf_probe_arg) * pev->nargs);
-- 
2.21.0

