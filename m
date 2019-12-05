Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010FBC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC732206D9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575574370;
	bh=yNSs6tj0nJ6GOwxEeF7ogJizlRezTsl3fsV+yHVbO3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j8uoEl9ymuJIF4o6lY7UDnVdhLzys1BLicVy7fEQilfc4xQ5z08oLmv8tQOWrgiCM
	 aqSnKDQMi58KKin8WtmtbZYvjn/iah71srpaxhxQN2hv+AxchOmsHnK65i6YgbnaZO
	 oDrrISNtZ50e1v0gV8HrsMGf52yDWh8Ex72hT5x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfLETct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:32:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLETcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:32:47 -0500
Received: from quaco.ghostprotocols.net (179-240-141-74.3g.claro.net.br [179.240.141.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A8924652;
        Thu,  5 Dec 2019 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575574367;
        bh=yNSs6tj0nJ6GOwxEeF7ogJizlRezTsl3fsV+yHVbO3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vANjXxuLg2nnSLNdcjwx/nMlb1wpxMK1AnfTA5jJFEVBy7g7sx8ahxpwhxUIL846u
         bydhK8eMyVq/2GoheXOcnzROaG6/RBgiNLaSfacN5Bs0OmBseCXvGvXcMJlwX8wvTv
         ew1N7exiN7RaxzfT3wS/eAcG4P2SGegPQBW4vEss=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/6] perf report: Bail out --mem-mode if mem info is not available
Date:   Thu,  5 Dec 2019 16:32:21 -0300
Message-Id: <20191205193224.24629-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

If perf.data is recorded without -d, don't allow user to use --mem-mode
with 'perf report'. symbol_daddr and phys_daddr can be recorded
separately and may be present in the perf.data but at the report time
they are associated with mem-mode fields and thus this restriction
applies to them as well.

Before:
  $ perf record ls
  $ perf report --mem-mode --stdio
  # Overhead  Local Weight  Memory access  Symbol
  # ........  ............  .............  .......................
      55.56%  0             N/A            [k] 0xffffffff81a00ae7

After:
  $ perf report --mem-mode --stdio
  Error:
  Selected --mem-mode but no mem data. Did you call perf record without -d?

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191114132213.5419-4-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 830d563de889..387311c67264 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -388,6 +388,14 @@ static int report__setup_sample_type(struct report *rep)
 		}
 	}
 
+	if (sort__mode == SORT_MODE__MEMORY) {
+		if (!is_pipe && !(sample_type & PERF_SAMPLE_DATA_SRC)) {
+			ui__error("Selected --mem-mode but no mem data. "
+				  "Did you call perf record without -d?\n");
+			return -1;
+		}
+	}
+
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
 		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
 		    (sample_type & PERF_SAMPLE_STACK_USER)) {
-- 
2.21.0

