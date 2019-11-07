Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B930C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D387721D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573144084;
	bh=jp2Xd3KgDGX3BHn6sYaRAE3SMwpPA4n6ILWP53u3h50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ieEHqBlsiODAPP6xD0oFf4v45FJP0DwaSuA/M2AC8/Bp4vGgqxh16/e79WroF67CA
	 PppStoZFbPLuhZ9myFtS8MwtiHmGNUmcmK/MnwXcWxfxCaGdEgOLHxQs5d522JWzy/
	 PUksUydy94g6LQmyAUi5d028YBv5kt9kwHdjmKUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfKGQ2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:28:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfKGQ2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:28:03 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E2D2178F;
        Thu,  7 Nov 2019 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573144082;
        bh=jp2Xd3KgDGX3BHn6sYaRAE3SMwpPA4n6ILWP53u3h50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eiRvsuIb8VcsgEm8vlPC6+iZCw28RLmyeIXNiMfyghkl7/qxvEfxb5dt/1HUqdfEA
         jQS5QTqd8SMutAqv1gwGlsEsuRc1bXywP4oRGrmaosPywKQKQziK4pP66DfNeP2SxS
         65tR+nziKHn8KG4hyXY1RCBSldM67qUdy9P7Hh04=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 1/4] perf probe: Generate event name with line number
Date:   Fri,  8 Nov 2019 01:27:58 +0900
Message-Id: <157314407850.4063.2307803945694526578.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157314406866.4063.16995747442215702109.stgit@devnote2>
References: <157314406866.4063.16995747442215702109.stgit@devnote2>
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
  # perf probe -a kernel_read:1
  Added new events:
    probe:kernel_read_L1 (on kernel_read:1)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read_L1 -aR sleep 1

But if we omit the line number or 0th line, it will
have no suffix.

  # perf probe -a kernel_read
  Added new event:
    probe:kernel_read (on kernel_read)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read -aR sleep 1

  # perf probe -l
    probe:kernel_read    (on kernel_read@linux-5.0.0/fs/read_write.c)
    probe:kernel_read_L1 (on kernel_read@linux-5.0.0/fs/read_write.c)

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
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

