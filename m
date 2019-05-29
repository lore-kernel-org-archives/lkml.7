Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C70EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76FB218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559136989;
	bh=lUJD0QMdCL24WJ6eSGKaL2acm5vw808Ri1YvfXLiJow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1IlUwDZ1TNTxyXlyhF9XXMFE8C7ZVPJzcuD18yvsww7yCpxtGhvHSADwRzkY/rjm
	 l2qEVYbGmvxGw7VYKFo7Rml/zXo7A1yjJ1ZQJwu9jH8ww/6W6WtjlFyiYDS/A+Bq7W
	 pZ+3F3acg5HRLtQ300qUZQeCE88xssbxf9uvMggY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfE2Ng1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfE2NgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:36:25 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 178E4218BB;
        Wed, 29 May 2019 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559136985;
        bh=lUJD0QMdCL24WJ6eSGKaL2acm5vw808Ri1YvfXLiJow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ta5bzuQy0348TpxCrlPbDLdq35p09wxiMq24IqdNPSLbRo0ugbXEcRQX912Ez53PQ
         WD0hBf4VkeOO6v1xeBa6uzJ8zHyZALlMUbKW25WhMmas5/gzEdZMeltosdOgbhdqT3
         9gCEZkjVn8vD6EZOjPkPtzJnI5dKizZEjM0glNWA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 02/41] perf intel-pt: Fix itrace defaults for perf script
Date:   Wed, 29 May 2019 10:35:26 -0300
Message-Id: <20190529133605.21118-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Commit 4eb068157121 ("perf script: Make itrace script default to all
calls") does not work because 'use_browser' is being used to determine
whether to default to periodic sampling (i.e. better for perf report).
The result is that nothing but CBR events display for perf script when
no --itrace option is specified.

Fix by using 'default_no_sample' and 'inject' instead.

Example:

 Before:

  $ perf record -e intel_pt/cyc/u ls
  $ perf script > cmp1.txt
  $ perf script --itrace=cepwx > cmp2.txt
  $ diff -sq cmp1.txt cmp2.txt
  Files cmp1.txt and cmp2.txt differ

 After:

  $ perf script > cmp1.txt
  $ perf script --itrace=cepwx > cmp2.txt
  $ diff -sq cmp1.txt cmp2.txt
  Files cmp1.txt and cmp2.txt are identical

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org # v4.20+
Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
Link: http://lkml.kernel.org/r/20190520113728.14389-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6d288237887b..03b1da6d1da4 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2588,7 +2588,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	} else {
 		itrace_synth_opts__set_default(&pt->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
-		if (use_browser != -1) {
+		if (!session->itrace_synth_opts->default_no_sample &&
+		    !session->itrace_synth_opts->inject) {
 			pt->synth_opts.branches = false;
 			pt->synth_opts.callchain = true;
 		}
-- 
2.20.1

