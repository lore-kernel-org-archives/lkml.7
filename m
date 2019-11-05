Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F5CCA9EC9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F91320717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572913025;
	bh=8g70eXRyYXIqGEgWIjaCNpc6AKzQAc3G/HC+vZHUAso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HVWm/S0SuAOJYRGH8il/xd1LtieiahHw81+dosbUDjSFVTKD2Dj3sz+tofaQmucx4
	 ewUB8bCroQ6ZCsEfl1qkvlXOueXjjQgRYd+gG+Ac2/TCnLlJgz4GGpiBa0k3ME/Sfm
	 ci/1YSDp7Y3p+yF6BWs2MdJPlGG75NDZHUYhHz0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbfKEARE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:17:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbfKEARE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:17:04 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ADB320650;
        Tue,  5 Nov 2019 00:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572913023;
        bh=8g70eXRyYXIqGEgWIjaCNpc6AKzQAc3G/HC+vZHUAso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=roztk8C1XT5uDSC1Fda32WgQkuiyAt00eYqkuTnnt0EqlLSeXyTwCWWbv05Xpyz7A
         PnXtQWEXoPLXqghweAhWWeekBwz3j2tEa4g1sQ5V9lS6LD4tc0Gmtgf/V1xUCR5wcp
         Cd4deDlamfKtXlI3VKzr7tQ3LZ6aIflJDCEED5QM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 2/5] perf probe: Generate event name with line number
Date:   Tue,  5 Nov 2019 09:16:59 +0900
Message-Id: <157291301924.19771.11830065569894242974.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157291299825.19771.5190465639558208592.stgit@devnote2>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generate event name from function name with line number
as <function>_L<line_number>. Note that this is only for
the new event which is defined by function and lines.

If there is another event on same line, you have to use
"-f" option. In that case, the new event has "_1" suffix.

 e.g.
  # perf probe -a kernel_read
  Added new event:
    probe:kernel_read_L0 (on kernel_read)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read_L0 -aR sleep 1

  # perf probe -a kernel_read:1
  Added new events:
    probe:kernel_read_L1 (on kernel_read:1)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read_L1_1 -aR sleep 1

  # perf probe -l
    probe:kernel_read_L0 (on kernel_read@linux/linux/fs/read_write.c)
    probe:kernel_read_L1 (on kernel_read@linux/linux/fs/read_write.c)

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 91cab5f669d2..d14b970a6461 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1679,6 +1679,14 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
 	if (ret < 0)
 		goto out;
 
+	/* Generate event name if needed */
+	if (!pev->event && pev->point.function
+			&& !pev->point.lazy_line && !pev->point.offset) {
+		if (asprintf(&pev->event, "%s_L%d", pev->point.function,
+			pev->point.line) < 0)
+			return -ENOMEM;
+	}
+
 	/* Copy arguments and ensure return probe has no C argument */
 	pev->nargs = argc - 1;
 	pev->args = zalloc(sizeof(struct perf_probe_arg) * pev->nargs);

