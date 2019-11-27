Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1432C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71D121736
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfK0X06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 18:26:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:47426 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfK0X06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:26:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 15:26:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="211837656"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 27 Nov 2019 15:26:57 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 889E1300FE1; Wed, 27 Nov 2019 15:26:57 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:26:57 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Optimize perf stat for large number of events/cpus
Message-ID: <20191127232657.GL84886@tassilo.jf.intel.com>
References: <20191121001522.180827-1-andi@firstfloor.org>
 <20191127151657.GE22719@kernel.org>
 <20191127154305.GJ22719@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127154305.GJ22719@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:43:05PM -0300, Arnaldo Carvalho de Melo wrote:
> So, have you tried running 'perf test' after each cset is applied and
> built?

I ran it at the end, but there are quite a few fails out of the box,
so I missed that one thanks.

This patch fixes it. Let me know if I should submit it in a more
formal way.

---

Fix event times test case

Reported-by: Arnaldo
Signed-off-by: Andi Kleen <ak@linux.intel.com>

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 4c6485fc31b9..4dc06289f4c7 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -224,7 +224,7 @@ int perf_evsel__enable(struct perf_evsel *evsel)
 	int i;
 	int err = 0;
 
-	for (i = 0; i < evsel->cpus->nr && !err; i++)
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
 	return err;
 }
@@ -239,7 +239,7 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	int i;
 	int err = 0;
 
-	for (i = 0; i < evsel->cpus->nr && !err; i++)
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
 	return err;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 59b9b4f3fe34..0844e3e29fb0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1853,6 +1853,10 @@ int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus,
 			     int cpu)
 {
+	if (cpu == -1)
+		return evsel__open_cpu(evsel, cpus, NULL, 0,
+					cpus ? cpus->nr : 1);
+
 	return evsel__open_cpu(evsel, cpus, NULL, cpu, cpu + 1);
 }
 
