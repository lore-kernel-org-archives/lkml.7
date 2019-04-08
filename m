Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394AEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0831C20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDHQ1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:27:50 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.48]:16991 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726921AbfDHQ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:27:50 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 6EB7311DBD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 11:27:49 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id DX7dhrfjs90onDX7dh4Olt; Mon, 08 Apr 2019 11:27:49 -0500
X-Authority-Reason: nr=8
Received: from [189.250.139.70] (port=51854 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hDX7c-002tCV-Jf; Mon, 08 Apr 2019 11:27:48 -0500
Date:   Mon, 8 Apr 2019 11:27:48 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] perf script: Fix memory leaks in list_scripts()
Message-ID: <20190408162748.GA21008@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.139.70
X-Source-L: No
X-Exim-ID: 1hDX7c-002tCV-Jf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.139.70]:51854
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for *buf* and *paths* were allocated,
jump to *out* and release them before return.

Addresses-Coverity-ID: 1444328 ("Resource leak")
Fixes: 6f3da20e151f ("perf report: Support builtin perf script in scripts menu")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 tools/perf/ui/browsers/scripts.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 27cf3ab88d13..f4edb18f67ec 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -131,8 +131,10 @@ static int list_scripts(char *script_name, bool *custom,
 		int key = ui_browser__input_window("perf script command",
 				"Enter perf script command line (without perf script prefix)",
 				script_args, "", 0);
-		if (key != K_ENTER)
-			return -1;
+		if (key != K_ENTER) {
+			ret = -1;
+			goto out;
+		}
 		sprintf(script_name, "%s script %s", perf, script_args);
 	} else if (choice < num + max_std) {
 		strcpy(script_name, paths[choice]);
-- 
2.21.0

