Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C7C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800542147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfCKUZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:25:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:56129 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfCKUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:24:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:24:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="281727413"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2019 13:24:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B6F3F301E34; Mon, 11 Mar 2019 13:24:48 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 04/10] perf, tools, record: Clarify help for --switch-output
Date:   Mon, 11 Mar 2019 13:24:40 -0700
Message-Id: <20190311202446.10210-5-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The help description for --switch-output looks like there
are multiple comma separated fields. But it's actually a choice
of different options. Make it clear and less confusing.

Before:

% perf report -h
...
        --switch-output[=<signal,size,time>]
                          Switch output when receive SIGUSR2 or cross size,time threshold

After:

% perf report -h
...

        --switch-output[=<signal or size[BKMG] or time[smhd]>]
                          Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 02d7c40b2d10..e7144a1c1c82 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1989,8 +1989,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
 		    "Record timestamp boundary (time of first/last samples)"),
 	OPT_STRING_OPTARG_SET(0, "switch-output", &record.switch_output.str,
-			  &record.switch_output.set, "signal,size,time",
-			  "Switch output when receive SIGUSR2 or cross size,time threshold",
+			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
+			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
 			  "signal"),
 	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
 		   "Limit number of switch output generated files"),
-- 
2.20.1

