Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F123C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5171C20693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225270;
	bh=7gF33XVGPWPehjsDTM+Wd6unH/O+yYsqP9r8KeEOR5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m2op7jD8i9MbLwHywiWCgop2YkwG6y8KD/Er+xhDS4mkIN71VzT/DJPB/0wXTJab6
	 Au5TeH49xCuvSTGq38ZrBkToEBfggj7QTqrEi5xS4aoXs0w6FFlPyOB3I6jMf0ozsk
	 fWqfX/ugxqMoY9BacHfMMSdPbBEOMypTarEOGHoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbfGOVO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732818AbfGOVO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:14:27 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BA82173C;
        Mon, 15 Jul 2019 21:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225267;
        bh=7gF33XVGPWPehjsDTM+Wd6unH/O+yYsqP9r8KeEOR5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6BvSvBtkrtPOoEh4mcgu0/G9qLKqc47wrDqxvhb6L3iwhQTG8S9PGJg48OR/yrGJ
         hLDyk7oVhm6SVpUeqDoLC90CwHS9nZZEo9CNUc009OIedGvImOk8DxV7PD/+NivQV9
         FNuRNlmIzwGfHH6PBDJD7IGeIARrpK/XpIkpo5RQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/28] perf cs-etm: Return errcode in cs_etm__process_auxtrace_info()
Date:   Mon, 15 Jul 2019 18:11:58 -0300
Message-Id: <20190715211200.10984-27-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

The 'err' variable is set in the error path, but it's not returned to
callers.  Don't always return -EINVAL, return err.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
Link: http://lkml.kernel.org/r/20190321023122.21332-3-yuehaibing@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2e9f5bc45550..3d1c34fc4d68 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2517,8 +2517,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	session->auxtrace = &etm->auxtrace;
 
 	etm->unknown_thread = thread__new(999999999, 999999999);
-	if (!etm->unknown_thread)
+	if (!etm->unknown_thread) {
+		err = -ENOMEM;
 		goto err_free_queues;
+	}
 
 	/*
 	 * Initialize list node so that at thread__zput() we can avoid
@@ -2530,8 +2532,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
-	if (thread__init_map_groups(etm->unknown_thread, etm->machine))
+	if (thread__init_map_groups(etm->unknown_thread, etm->machine)) {
+		err = -ENOMEM;
 		goto err_delete_thread;
+	}
 
 	if (dump_trace) {
 		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
@@ -2575,5 +2579,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 err_free_hdr:
 	zfree(&hdr);
 
-	return -EINVAL;
+	return err;
 }
-- 
2.21.0

