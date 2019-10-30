Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B647CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A832087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572419395;
	bh=dTPfCnzoHYx2mOecyDhMTz2oglIoLfSxfaqPCiHW/d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BEKLnU4gIlFR+mV28tZ2zr00rP++wlWwEnwU/FNRgmtyCHBDFqmlxKijj0texoLRw
	 HA9WyGlZSdv2KKr5KiP4/aTbwC1+/r15wv1ZL+i8nJfQTFJ2KBwZXJZwQOco87tRC7
	 lbMvLz3gLihXsShWILkyitHsYjw+R1VjGB+4PIzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfJ3HJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfJ3HJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:09:54 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 886A92087E;
        Wed, 30 Oct 2019 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572419392;
        bh=dTPfCnzoHYx2mOecyDhMTz2oglIoLfSxfaqPCiHW/d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBXubW/DJ/qTz5xu/YhtVBfYgZfAdL7ktTthXOa/t2PelCNGZGlGpcBsEZ2brCUay
         7Zkz4iWF/ZopAzdqqoj5HDAFE5AqxE/OW43jzRZ+DJeu74GmomC2/qovARgPCtrRvK
         /tztGAhpaS++w4FBXK+3eOxIbzyWTZDvKB3khrz0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 4/4] perf probe: Skip overlapped location on searching variables
Date:   Wed, 30 Oct 2019 16:09:49 +0900
Message-Id: <157241938927.32002.4026859017790562751.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157241935028.32002.10228194508152968737.stgit@devnote2>
References: <157241935028.32002.10228194508152968737.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since debuginfo__find_probes() callback function can be called
with  the location which already passed, the callback function
must filter out such overlapped locations.

add_probe_trace_event() has already done it by commit 1a375ae7659a
("perf probe: Skip same probe address for a given line"), but
add_available_vars() doesn't. Thus perf probe -v shows same address
repeatedly as below.

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


With this fix, perf probe -V shows it correctly.
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
---
 tools/perf/util/probe-finder.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 88e17a4f5ac3..f441e0174334 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1413,6 +1413,18 @@ static int collect_variables_cb(Dwarf_Die *die_mem, void *data)
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
@@ -1423,6 +1435,14 @@ static int add_available_vars(Dwarf_Die *sc_die, struct probe_finder *pf)
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

