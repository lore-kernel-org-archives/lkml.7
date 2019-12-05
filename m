Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78996C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E0524655
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575574361;
	bh=weL3bUV0PDOHU1hQmGLuBVvurK0V+4GUMjjNTj/JUso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U1OwHgGCNTpU+a6I/xUQntEL2hDD4P/NUcTeCUjrPlCZh0WhHZ2U0DaIOPNFJ9iDM
	 w6mCx6T962qgOC97soV6FLpqLbjQ5VVRzwwk3kQjWkR0Y9zZu2XK47l0k6EaNjvuEJ
	 1awD2LabhuFHRdCbz+ewcuEGB4dIky1loQahdk5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfLETck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLETci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:32:38 -0500
Received: from quaco.ghostprotocols.net (179-240-141-74.3g.claro.net.br [179.240.141.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28D8206D9;
        Thu,  5 Dec 2019 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575574357;
        bh=weL3bUV0PDOHU1hQmGLuBVvurK0V+4GUMjjNTj/JUso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPo6nR3JEwhgFR4hXCeurHSjRxDVri/Ew54csKqfjYIWa9fpXhzW0J/yVs8Ahy0Bw
         3xC0k3Mp/0bXk71NWCMYs63jTsR6yFThAila3biOB9m6ZqzjFEbAo7VTF7somO/2ej
         LTT0nnbuDmIqfCwtVuJIAcTgWkijtmNxzXkvp0lQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/6] perf report/top TUI: Replace pr_err() with ui__error()
Date:   Thu,  5 Dec 2019 16:32:19 -0300
Message-Id: <20191205193224.24629-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

pr_err() in TUI mode does not print anyting on the screen and just
quits.

Replace such pr_err() with ui__error().

Before:

  $ perf report -s +
  $

After:

  $ perf report -s +

    ┌─Error:────────────────┐
    │Invalid --sort key: `+'│
    │                       │
    │Press any key...       │
    └───────────────────────┘

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191114132213.5419-2-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 345b5ccc90f6..106d795574ba 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2681,12 +2681,12 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
 			ret = sort_dimension__add(list, tok, evlist, level);
 			if (ret == -EINVAL) {
 				if (!cacheline_size() && !strncasecmp(tok, "dcacheline", strlen(tok)))
-					pr_err("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
+					ui__error("The \"dcacheline\" --sort key needs to know the cacheline size and it couldn't be determined on this system");
 				else
-					pr_err("Invalid --sort key: `%s'", tok);
+					ui__error("Invalid --sort key: `%s'", tok);
 				break;
 			} else if (ret == -ESRCH) {
-				pr_err("Unknown --sort key: `%s'", tok);
+				ui__error("Unknown --sort key: `%s'", tok);
 				break;
 			}
 		}
@@ -2743,7 +2743,7 @@ static int setup_sort_order(struct evlist *evlist)
 		return 0;
 
 	if (sort_order[1] == '\0') {
-		pr_err("Invalid --sort key: `+'");
+		ui__error("Invalid --sort key: `+'");
 		return -EINVAL;
 	}
 
@@ -3034,7 +3034,7 @@ static int __setup_output_field(void)
 		strp++;
 
 	if (!strlen(strp)) {
-		pr_err("Invalid --fields key: `+'");
+		ui__error("Invalid --fields key: `+'");
 		goto out;
 	}
 
-- 
2.21.0

