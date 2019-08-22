Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D95C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1747E2341E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507763;
	bh=/g4E6hvg7DvFOv70NHBrCbKss/GO1zqWmw7zoc3I8iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1cgE5I3mDiQWYvQy+0E9ZsjuEquymwhLoHr0gOwbzr67Zv1ereXgIG39EMGz9dwQH
	 0j7BlXM4qU5cz4aFhBRClV/TkqZuUE0IQrCKHfHY7arIW4dxG3DoH9fLO5wmOkCw//
	 nUb16aDWRAsBI46xiQs6wA5DBw0FbQ/4Bew3LnrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393524AbfHVVCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388493AbfHVVCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:39 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC83323401;
        Thu, 22 Aug 2019 21:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507759;
        bh=/g4E6hvg7DvFOv70NHBrCbKss/GO1zqWmw7zoc3I8iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rz5YkM1832UVqZWDASAGXKy2QnMaSH4+fVQIsMVm8cLBi6cqsh9tVLrm62PlpisOo
         +niUV0xaffKyHR97YNO9hgZX2QH7iEHWtMW8upQ1MYzTtJdI7OAeumfuELlfqVGTjG
         fWhVDl9Fzn1FTdWvHnYDQdV17IXldIxgkxsZkeRY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 21/25] perf evsel: Switch to libperf's cpumap.h
Date:   Thu, 22 Aug 2019 18:00:56 -0300
Message-Id: <20190822210100.3461-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We don't need what is in perf's util/cpumap.h, just the struct cpu_map
that is in libperf's internal/cpumap.h file to cover this one case:

  tools/perf/util/evsel.h:215:27: error: dereferencing pointer to incomplete type ‘struct perf_cpu_map’
  215 |  return evsel__cpus(evsel)->nr;

So switch to libperf's cpumap.h and add some missing struct foward
declarations and include sys/types.h to get pid_t.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ufjkpohijti05ggk69s91ktf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cd336cf2eaa9..5a351cae66df 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -5,14 +5,17 @@
 #include <linux/list.h>
 #include <stdbool.h>
 #include <stdio.h>
+#include <sys/types.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <internal/evsel.h>
 #include <perf/evsel.h>
 #include "symbol_conf.h"
-#include "cpumap.h"
+#include <internal/cpumap.h>
 
+struct addr_location;
 struct evsel;
+union perf_event;
 
 /*
  * Per fd, to map back from PERF_SAMPLE_ID to evsel, only used when there are
-- 
2.21.0

