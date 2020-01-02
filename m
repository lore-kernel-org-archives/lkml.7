Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E7C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0EC20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005271;
	bh=WZjRBfiiNxuoLWB6inZzUgFhAkHPpl2Cb6dhL6UEsuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oLPZz3T/aBMhq8EsNsigX26Ts7AjaPia6IBPzQJOS6l4/M8HzmC6CfIP4WsoNThBe
	 B4AxMfuL6tPnxaPgX8uM1ujr9e0XDZjGd7Mq4w2LcUCDuvbRukJl1FATfmyqiKaCU0
	 2LvcEbyMV+lmd7mKmFv/S1Ac6mZXyVo1nq+XdGmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgABWru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbgABW3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:29:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24ED620866;
        Thu,  2 Jan 2020 22:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004145;
        bh=WZjRBfiiNxuoLWB6inZzUgFhAkHPpl2Cb6dhL6UEsuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCmDoQ36MoNPsUUq25gVzQP3fyXN9CAsx5WB6Idx/K6QnX0SHRw3fQKbUvxSuZQwg
         Vn64NrvypJOKU9nd06l5E484pn5RCL3aAuRun4OwjKdg5KLS10TQ0Moi4peGLd8gYu
         EyvdFfWO1VPAQSTtYCsXBnsNDSKBzXx3izcdNzSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 057/171] perf probe: Skip overlapped location on searching variables
Date:   Thu,  2 Jan 2020 23:06:28 +0100
Message-Id: <20200102220554.832386573@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit dee36a2abb67c175265d49b9a8c7dfa564463d9a ]

Since debuginfo__find_probes() callback function can be called with  the
location which already passed, the callback function must filter out
such overlapped locations.

add_probe_trace_event() has already done it by commit 1a375ae7659a
("perf probe: Skip same probe address for a given line"), but
add_available_vars() doesn't. Thus perf probe -v shows same address
repeatedly as below:

  # perf probe -V vfs_read:18
  Available variables at vfs_read:18
          @<vfs_read+217>
                  char*   buf
                  loff_t* pos
                  ssize_t ret
                  struct file*    file
          @<vfs_read+217>
                  char*   buf
                  loff_t* pos
                  ssize_t ret
                  struct file*    file
          @<vfs_read+226>
                  char*   buf
                  loff_t* pos
                  ssize_t ret
                  struct file*    file

With this fix, perf probe -V shows it correctly:

  # perf probe -V vfs_read:18
  Available variables at vfs_read:18
          @<vfs_read+217>
                  char*   buf
                  loff_t* pos
                  ssize_t ret
                  struct file*    file
          @<vfs_read+226>
                  char*   buf
                  loff_t* pos
                  ssize_t ret
                  struct file*    file

Fixes: cf6eb489e5c0 ("perf probe: Show accessible local variables")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157241938927.32002.4026859017790562751.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/probe-finder.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index cfc2e1e7cca4..440f0a92ade6 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1414,6 +1414,18 @@ error:
 	return DIE_FIND_CB_END;
 }
 
+static bool available_var_finder_overlap(struct available_var_finder *af)
+{
+	int i;
+
+	for (i = 0; i < af->nvls; i++) {
+		if (af->pf.addr == af->vls[i].point.address)
+			return true;
+	}
+	return false;
+
+}
+
 /* Add a found vars into available variables list */
 static int add_available_vars(Dwarf_Die *sc_die, struct probe_finder *pf)
 {
@@ -1424,6 +1436,14 @@ static int add_available_vars(Dwarf_Die *sc_die, struct probe_finder *pf)
 	Dwarf_Die die_mem;
 	int ret;
 
+	/*
+	 * For some reason (e.g. different column assigned to same address),
+	 * this callback can be called with the address which already passed.
+	 * Ignore it first.
+	 */
+	if (available_var_finder_overlap(af))
+		return 0;
+
 	/* Check number of tevs */
 	if (af->nvls == af->max_vls) {
 		pr_warning("Too many( > %d) probe point found.\n", af->max_vls);
-- 
2.20.1



