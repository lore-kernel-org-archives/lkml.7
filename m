Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB79C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DDF20578
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708790;
	bh=q8yvGy6sZ0XG4U0IK8/LYFzjpqBRCdN0b3lFEkDs5Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aXLO9rjGcdV3v5eOXJ00ENZw+gAlVdzmTJjUH7+zQCRwRnvncdHYZ+qHmXjBYD+Ng
	 wNl+4YRRH9BYjKpprwipM29yWDLDHdPxoaL0FmrUWsl2cx56Df/23nBjY8t5cTb/SQ
	 JkJahN2F6S4cr9jmWzXA0oYQ/Lam0SmgOA5zSfGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfGULdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:33:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:33:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07180C18B2C6;
        Sun, 21 Jul 2019 11:33:09 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE04C5D9D3;
        Sun, 21 Jul 2019 11:33:04 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 78/79] libperf: Add perf_evsel__enable/disable test
Date:   Sun, 21 Jul 2019 13:25:05 +0200
Message-Id: <20190721112506.12306-79-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 21 Jul 2019 11:33:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add simple perf_evsel enable/disable test together with
evsel counter reading interface.

Link: http://lkml.kernel.org/n/tip-fsqjctyzhrzw5e085h3bvvhi@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/tests/test-evsel.c | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/perf/lib/tests/test-evsel.c b/tools/perf/lib/tests/test-evsel.c
index 268712292f60..2c648fe5617e 100644
--- a/tools/perf/lib/tests/test-evsel.c
+++ b/tools/perf/lib/tests/test-evsel.c
@@ -70,12 +70,55 @@ static int test_stat_thread(void)
 	return 0;
 }
 
+static int test_stat_thread_enable(void)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type	  = PERF_TYPE_SOFTWARE,
+		.config	  = PERF_COUNT_SW_TASK_CLOCK,
+		.disabled = 1,
+	};
+	int err;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	__T("failed to open evsel", err == 0);
+
+	perf_evsel__read(evsel, 0, 0, &counts);
+	__T("failed to read value for evsel", counts.val == 0);
+
+	err = perf_evsel__enable(evsel);
+	__T("failed to enable evsel", err == 0);
+
+	perf_evsel__read(evsel, 0, 0, &counts);
+	__T("failed to read value for evsel", counts.val != 0);
+
+	err = perf_evsel__disable(evsel);
+	__T("failed to enable evsel", err == 0);
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	__T_START;
 
 	test_stat_cpu();
 	test_stat_thread();
+	test_stat_thread_enable();
 
 	__T_OK;
 	return 0;
-- 
2.21.0

