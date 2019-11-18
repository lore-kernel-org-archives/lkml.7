Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE83C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D112084C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574064747;
	bh=Rw4DbqPrbG0yXaPzv4cd2fGUfjZk2CcZa6W0iBrXzcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y3Jn6UhVvbUbb9kO+vewdDcsZDuZP4TsGSjD0yvvIWsOlhlOkytGscKKbbohA9mPt
	 OmSfJf8+ck7tMrzPAIzoMU1vFWJe27rPXjgVihvrzxMbqK3jIN7cU/fWyhn9878260
	 vReAgXvXD4ezl4BnVH7dlx2DV2hzNhdVMjSpLWYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfKRIMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:12:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfKRIMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:12:25 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B242A20748;
        Mon, 18 Nov 2019 08:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574064744;
        bh=Rw4DbqPrbG0yXaPzv4cd2fGUfjZk2CcZa6W0iBrXzcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrvXgTbx9kQUHaQ+hl3xamijPj8z5aL+KsWtq3ZAcgAfiORAPcJIeyXmpbP7mvDyu
         +fr4NuUMJEQRgSzGNZpOEDoK5SzGrPvrXvOGxHsr96NaJ9bd2DShW2osOK0xdRtvXc
         c5Bsgy576px6emINb7ajn3WEENeLLNcMUgiL7CtY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 4/7] perf probe: Generate event name with line number
Date:   Mon, 18 Nov 2019 17:12:20 +0900
Message-Id: <157406474026.24476.2828897745502059569.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157406469983.24476.13195800716161845227.stgit@devnote2>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
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
the new event which is defined by the line number of
function (except for line 0).

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

# perf probe -l
  probe:kernel_read    (on kernel_read@linux-5.0.0/fs/read_write.c)
  probe:kernel_read_L2 (on kernel_read:2@linux-5.0.0/fs/read_write.c)

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Update samples according to previous fixes.
 Changes in v2:
  - Do not add _L* suffix for the event which has no line
    number or line #0.
---
 tools/perf/util/probe-event.c |    8 ++++++++
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

