Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6959FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D3020854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980720;
	bh=3Wy+0CezS4nhz8tuSbpEx5UNaO/YUV8XnS1v6THtFfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GMtogfk6++XGsky/GIzT8S4APrcn95qylxSz+pTylG6WkfiKx76JomljN+6Zsg0VQ
	 4pmhqgOJDnDjDsBbAPEjt/qDNI+ef2ghZ/cmygSmmtCftgEkjFtdM4ehAs8EkIpCK+
	 bY+ClvZw9lBi+kqvntKlUa7H8uf3BgVftesy7YZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCGRpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfCGRpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:16 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E669B20854;
        Thu,  7 Mar 2019 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980716;
        bh=3Wy+0CezS4nhz8tuSbpEx5UNaO/YUV8XnS1v6THtFfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TYN9trXqD39xKSdrUbOwXaXymLH/a0sfMuGzK5VRE6RUB5UqYtAO7+X4L8SWg1B0n
         kpQOCkekMr2hBQqBwz2MmHtWsfQ63An+BrTao08xK00QDrWd/UPMDeNzUREzFb0+Ir
         RrltaN4J967G8I1p4ad2Zj7kbc4y6P8Ah+HD09+w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/35] perf intel-pt: Fix divide by zero when TSC is not available
Date:   Thu,  7 Mar 2019 14:44:05 -0300
Message-Id: <20190307174433.28819-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

When TSC is not available, "timeless" decoding is used but a divide by
zero occurs if perf_time_to_tsc() is called.

Ensure the divisor is not zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org # v4.9+
Link: https://lkml.kernel.org/n/tip-1i4j0wqoc8vlbkcizqqxpsf4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 3b497bab4324..6d288237887b 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2531,6 +2531,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	}
 
 	pt->timeless_decoding = intel_pt_timeless_decoding(pt);
+	if (pt->timeless_decoding && !pt->tc.time_mult)
+		pt->tc.time_mult = 1;
 	pt->have_tsc = intel_pt_have_tsc(pt);
 	pt->sampling_mode = false;
 	pt->est_tsc = !pt->timeless_decoding;
-- 
2.20.1

