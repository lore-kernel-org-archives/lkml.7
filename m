Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825C8C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61537222C9
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfJBQqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:46:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:42926 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfJBQqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:46:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 09:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="221461292"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 02 Oct 2019 09:46:46 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A12EA301A2F; Wed,  2 Oct 2019 09:46:46 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf script: Allow --time with --reltime
Date:   Wed,  2 Oct 2019 09:46:42 -0700
Message-Id: <20191002164642.1719-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The original --reltime patch forbid --time with --reltime.

But it turns out --time doesn't really care about --reltime, because
the relative time is only used at final output, while
the time filtering always works earlier on absolute time.

So just remove the check and allow combining the two options.

Fixes: 90b10f47c0ee ("perf script: Support relative time")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 32b17d51c982..7481003b2761 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3601,11 +3601,6 @@ int cmd_script(int argc, const char **argv)
 		}
 	}
 
-	if (script.time_str && reltime) {
-		fprintf(stderr, "Don't combine --reltime with --time\n");
-		return -1;
-	}
-
 	if (itrace_synth_opts.callchain &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
-- 
2.21.0

