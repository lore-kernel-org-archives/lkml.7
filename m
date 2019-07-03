Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB464C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E59D218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124511;
	bh=VxvpiBC+QnJPHcfTnLTIhpv/LyqizBpUNzFdzL769SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PnZTF2SBgEkXenY4IT6aIDZb3aOy3OThYtkeuNfe0tBiL1FNCZq9edavqzGwDDOyh
	 dVY5oy0Pb/2rsF6pTLqbuwIPqLk1/iPR253XtrOc4GuQW5zv56WjZJO8q3/wGocxAg
	 Nz1fmOiYpSOBXRdxxstZADejzmUIdvIvcl8ANDEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfGCD2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfGCD20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C8F2054F;
        Wed,  3 Jul 2019 03:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124505;
        bh=VxvpiBC+QnJPHcfTnLTIhpv/LyqizBpUNzFdzL769SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EkLRPEni81IMZ9NRcCu5sRl6Mw6LTuH+VdDi4d8Zu7vby6IWm3WyQuCtzt4srEJWA
         Jqu68shoi/53JzYgU53zITlqTat4P1mcdveKnbkD1KnDHRXIXZaCG68OfFeZawMeoZ
         XoTzdYPqHWl479jYss9nuLt0QXKypFOsEIzxNDMk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/18] perf diff: Documentation -c cycles option
Date:   Wed,  3 Jul 2019 00:27:36 -0300
Message-Id: <20190703032746.21692-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Documentation the new computation selection 'cycles'.

 v4:
 ---
 Change the column 'Block cycles diff [start:end]' to
 '[Program Block Range] Cycles Diff'

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1561713784-30533-8-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-diff.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index facd91e4e945..d5cc15e651cf 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -90,9 +90,10 @@ OPTIONS
 
 -c::
 --compute::
-        Differential computation selection - delta, ratio, wdiff, delta-abs
-        (default is delta-abs).  Default can be changed using diff.compute
-        config option.  See COMPARISON METHODS section for more info.
+        Differential computation selection - delta, ratio, wdiff, cycles,
+        delta-abs (default is delta-abs).  Default can be changed using
+        diff.compute config option.  See COMPARISON METHODS section for
+        more info.
 
 -p::
 --period::
@@ -280,6 +281,16 @@ If specified the 'Weighted diff' column is displayed with value 'd' computed as:
     - WEIGHT-A being the weight of the data file
     - WEIGHT-B being the weight of the baseline data file
 
+cycles
+~~~~~~
+If specified the '[Program Block Range] Cycles Diff' column is displayed.
+It displays the cycles difference of same program basic block amongst
+two perf.data. The program basic block is the code between two branches.
+
+'[Program Block Range]' indicates the range of a program basic block.
+Source line is reported if it can be found otherwise uses symbol+offset
+instead.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
-- 
2.20.1

