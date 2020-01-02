Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBC3C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA0C24649
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004536;
	bh=7uIewrwMlJTMVu2DZJRYjZ+aAlxPBmbyZH4tB/oGrYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QPyqsfdK+Bjzqh6itZtooecS6dz3Ji6HqQzjiwPuaby3feb4RlOxowWOWLTxeG8zi
	 0m5N799HwDnpUcOQjwpfHPzxJJHOms3twXuHvWQenY7KE87SX9lC8cPM7Q3ey5J8Md
	 ezL1SCa/OrQa+jeuTGcI//V0+i4kJo4cxIT6fX1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbgABWff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbgABWfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:35:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6499321835;
        Thu,  2 Jan 2020 22:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004530;
        bh=7uIewrwMlJTMVu2DZJRYjZ+aAlxPBmbyZH4tB/oGrYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJf4UtR3FAtxsB2cvr+CF0i+oT2YoOdXojREXrPe2q/pJqtXSDSPikPHyNc4BIGAc
         N7NcXkFw6NFxgYpiTjot6ujhkAIsbthyQQxxbCrm70hTEX4dxVv3Tlgy8sFQH6boGU
         RlbQw4bistKR1Bl+5jG0SUjaeKShzn0OOiM3u8G8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 045/137] perf probe: Return a better scope DIE if there is no best scope
Date:   Thu,  2 Jan 2020 23:06:58 +0100
Message-Id: <20200102220552.669785035@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit c701636aeec4c173208697d68da6e4271125564b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/probe-finder.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index d917f83e8e85..5ca8836b16e7 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -746,6 +746,16 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
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
@@ -757,8 +767,13 @@ static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
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
2.20.1



