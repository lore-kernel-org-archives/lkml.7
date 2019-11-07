Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF28BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C7321D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153727;
	bh=bF0ieVLynPVfpRI3uza2Ep6/EQoogfBhLtpxBy+wZlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pqmw8bzIh+A9vifb97Z5k0AY7zvYu/mgmNMZwmfe3zW8+nduLZO0uztA3AxshD/T1
	 ENqUM/hjYOK5QeHS59+fRbPm2GFqZYHKe9CYhqc6vZ0SOhhW3FT6qgJFVxEsAJVXgB
	 z7nAaDkz2w/1cwjbrkQZfeDoKzm3j++wf/v3c66A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfKGTIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfKGTIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:42 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D448621D6C;
        Thu,  7 Nov 2019 19:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153721;
        bh=bF0ieVLynPVfpRI3uza2Ep6/EQoogfBhLtpxBy+wZlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjgK1tJN6CFeeskkeLRbHVc2G3QssrL8Gq3cQzcGLCjZVVOUPNo824yMKwZ8/ETyt
         8O9vLVzQxETdHCYXKuWwhoXvVm9s7wQnF561eaQuHDz5wcGd+8prZSCxiMt9iGi4ly
         r3YL4rMKGKE7DngxcEiqMYqH+jIqjmOAFJK6SNCI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 54/63] perf probe: Skip overlapped location on searching variables
Date:   Thu,  7 Nov 2019 16:00:02 -0300
Message-Id: <20191107190011.23924-55-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

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
---
 tools/perf/util/probe-finder.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 582f8c34d93a..9ecea45da4ca 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1428,6 +1428,18 @@ static int collect_variables_cb(Dwarf_Die *die_mem, void *data)
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
@@ -1438,6 +1450,14 @@ static int add_available_vars(Dwarf_Die *sc_die, struct probe_finder *pf)
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
2.21.0

