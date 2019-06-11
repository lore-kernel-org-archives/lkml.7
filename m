Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D46C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B466A2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279740;
	bh=Qhd6bVtVoT9QbbazKZOFnIspsu4pUvCgE79I8j9p3yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Md+CfsqTLX8NO4oJUYT133VeGHMKpBUkqh7R556aUQIHqq9WYwj2N/kNjwF2A4ePl
	 J+Y81xADYMDmuF0azHCAijSzQiix0QckejUcw+ySROjaTxzHtk+WdKjQtG8fZ1vQun
	 2IhCGh6ixvktXjAMro+B3YYwAsReKAoEZirkKyZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392373AbfFKTCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391736AbfFKTCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68F0C2184E;
        Tue, 11 Jun 2019 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279738;
        bh=Qhd6bVtVoT9QbbazKZOFnIspsu4pUvCgE79I8j9p3yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+9MkASYJuO+Q1mu5YtJloZrYVKLk3PIdu6DTxlxGtyMxpR6G8rEzop1fsRizLzhw
         uwfbiBgHHxA+ED4GlZeBdsAT/uPfzMIwhqBlc3EqjAmVQzjM501rK+esRa+m5tfvCL
         LAQ2NPmxUQodA6uEOzIUAX/nbtYLpTWXGkyKqSNc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 39/85] perf cs-etm: Configure SWITCH_EVENTS in CPU-wide mode
Date:   Tue, 11 Jun 2019 15:58:25 -0300
Message-Id: <20190611185911.11645-40-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Ask the perf core to generate an event when processes are swapped in/out
of context.  That way proper action can be taken by the decoding code
when faced with such event.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-4-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index be1e4f20affa..cc7f1cd23b14 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -257,6 +257,9 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	ptr->evlist = evlist;
 	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
 
+	if (perf_can_record_switch_events())
+		opts->record_switch_events = true;
+
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->attr.type == cs_etm_pmu->type) {
 			if (cs_etm_evsel) {
-- 
2.20.1

