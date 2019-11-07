Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A89C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C90F2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153706;
	bh=/C3nLUJIdUuaUnnMf2d3nrdNhD0ts8jtkEY8senWH/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OoLFMjNFFYHTgNYj44VJY653LF/keSBIGuUd7vE//kSILKCrm5ibZMbSembXnVao0
	 8Hwo3qH6OeS4dTbv5ZkIwMYg075W0ietZYcAL43u8MDng9D/o11qrG9zsDejCxYuLU
	 VQfUNLjxUoUbaeCngW21FAC7YIluruAWR5W6Oxnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfKGTIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfKGTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:24 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3502F2084D;
        Thu,  7 Nov 2019 19:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153703;
        bh=/C3nLUJIdUuaUnnMf2d3nrdNhD0ts8jtkEY8senWH/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOUY63MK5VtmMJVtMDras9pnHJmM0xaGpnPd6h86SlfOh61bZ5lDWWLNUTZcu4ukP
         I5nP+3HbvztfrcAWFDJYES4Ydx83GyQ5VUYtLl3mTs8+awna2/OTwck1j97yY5PQ+w
         7Fcf3PEFdWzNNq79r8MbbPioWahqxuMULPXNN6mw=
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
Subject: [PATCH 50/63] perf probe: Return a better scope DIE if there is no best scope
Date:   Thu,  7 Nov 2019 15:59:58 -0300
Message-Id: <20191107190011.23924-51-acme@kernel.org>
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

Make find_best_scope() returns innermost DIE at given address if there
is no best matched scope DIE. Since Gcc sometimes generates intuitively
strange line info which is out of inlined function address range, we
need this fixup.

Without this, sometimes perf probe failed to probe on a line inside an
inlined function:

  # perf probe -D ksys_open:3
  Failed to find scope of probe point.
    Error: Failed to add events.

With this fix, 'perf probe' can probe it:

  # perf probe -D ksys_open:3
  p:probe/ksys_open _text+25707308
  p:probe/ksys_open_1 _text+25710596
  p:probe/ksys_open_2 _text+25711114
  p:probe/ksys_open_3 _text+25711343
  p:probe/ksys_open_4 _text+25714058
  p:probe/ksys_open_5 _text+2819653
  p:probe/ksys_open_6 _text+2819701

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157291300887.19771.14936015360963292236.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 88e17a4f5ac3..582f8c34d93a 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -744,6 +744,16 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
 	return 0;
 }
 
+/* Return innermost DIE */
+static int find_inner_scope_cb(Dwarf_Die *fn_die, void *data)
+{
+	struct find_scope_param *fsp = data;
+
+	memcpy(fsp->die_mem, fn_die, sizeof(Dwarf_Die));
+	fsp->found = true;
+	return 1;
+}
+
 /* Find an appropriate scope fits to given conditions */
 static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
 {
@@ -755,8 +765,13 @@ static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
 		.die_mem = die_mem,
 		.found = false,
 	};
+	int ret;
 
-	cu_walk_functions_at(&pf->cu_die, pf->addr, find_best_scope_cb, &fsp);
+	ret = cu_walk_functions_at(&pf->cu_die, pf->addr, find_best_scope_cb,
+				   &fsp);
+	if (!ret && !fsp.found)
+		cu_walk_functions_at(&pf->cu_die, pf->addr,
+				     find_inner_scope_cb, &fsp);
 
 	return fsp.found ? die_mem : NULL;
 }
-- 
2.21.0

