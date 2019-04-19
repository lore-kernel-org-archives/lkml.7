Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC2DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01E1204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698781;
	bh=KKUBh5N05ckMoo0dTWDtJ0nG1FNJD92WctiTP2uyAfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pAMK2P85IaqOl/+LqT3LyK/3wALn0fVDLsezktmZ475wl42kOjAiRcpkqHKj86iHx
	 nKEFwCnZ1Wis9kAvg/Vl22O00bY9kOX0fskyXg7LpdRmYqoeTZHLK7XSp5q5RHRf7W
	 6dhiukDr4GPu0dLJNoUNu+OWTpiboHG3zFehjOVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfDSSc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbfDSS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from quaco.ghostprotocols.net (unknown [177.102.80.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B282192B;
        Fri, 19 Apr 2019 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555677043;
        bh=KKUBh5N05ckMoo0dTWDtJ0nG1FNJD92WctiTP2uyAfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENG2YY1T9QeLk4w3GuEn4HcPH0YvSQL+8Q/hNX8bSIJgDilThfXmTzY8nz+MZsRuT
         e/zIc5Bqr+IE+dP7uVhsySPrH/R/o08wCOT+Vd9zvopvXa6K26yIN5zFat5Ujw0sE2
         IW715gkivrt85tUPFXqsEPALCY5IdtUCqhZNbPEM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Bastian Beischer <bastian.beischer@rwth-aachen.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/7] perf top: Always sample time to satisfy needs of use of ordered queuing
Date:   Fri, 19 Apr 2019 09:30:23 -0300
Message-Id: <20190419123029.11328-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Bastian reported broken 'perf top -p PID' command, it won't display any
data.

The problem is that for -p option we monitor single thread, so we don't
enable time in samples, because it's not needed.

However since commit 16c66bc167cc we use ordered queues to stash data
plus later commits added logic for dropping samples in case there's big
load and we don't keep up. All this needs timestamp for sample. Enabling
it unconditionally for perf top.

Reported-by: Bastian Beischer <bastian.beischer@rwth-aachen.de>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bastian beischer <bastian.beischer@rwth-aachen.de>
Fixes: 16c66bc167cc ("perf top: Add processing thread")
Link: http://lkml.kernel.org/r/20190415125333.27160-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1999d6533d12..fbbb0da43abb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1377,6 +1377,7 @@ int cmd_top(int argc, const char **argv)
 			 * */
 			.overwrite	= 0,
 			.sample_time	= true,
+			.sample_time_set = true,
 		},
 		.max_stack	     = sysctl__max_stack(),
 		.annotation_opts     = annotation__default_options,
-- 
2.20.1

