Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DFAC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19867217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279821;
	bh=gUArbViGRfQEMwvP3DCJGr920LUd5bo6dTd9erfL3Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uIYPh3TdrfbYCbJqNB5fLumK7Bu/bj4SjFoHKBJmJI9EUyPT6a2nRtmdN+nTWLRrJ
	 GF8s9m2IlyECjuglofaY8gBOu9OZk9JCrWvFDtjSkUhaFxlBjJUPKzf/lZmG89GvMb
	 P1x2SXh1rGCep/NwvlXa9ZGIf/VkWJ14BCtTShjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405086AbfFKTDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392579AbfFKTDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF4F2184C;
        Tue, 11 Jun 2019 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279819;
        bh=gUArbViGRfQEMwvP3DCJGr920LUd5bo6dTd9erfL3Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILR3dHCl/lBVccYgCKrBaqiVkYrfZZL6DK0w3/f1dlwPxIVoHWPV43irFZk236Zvo
         CRba+wZq51B2cFewNoijXgt/wldOe5RdfyLIzwSdGsCYen70RN0sWn8j8VUzzS9Yh8
         Q464NITBvUxAXY6mdIpMyMLcjoAGW/7nOsANQC14=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 59/85] perf data: Fix perf.data documentation for HEADER_CPU_TOPOLOGY
Date:   Tue, 11 Jun 2019 15:58:45 -0300
Message-Id: <20190611185911.11645-60-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'die' info isn't in the same array as core and socket ids, and we
missed the 'dies' string list, that comes right after the 'core' +
'socket' id variable length array, followed by the VLA for the dies.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: c9cb12c5ba08 ("perf header: Add die information in CPU topology")
Link: https://lkml.kernel.org/n/tip-nubi6mxp2n8ofvlx7ph6k3h6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/perf.data-file-format.txt   | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index de78183f6881..5f54feb19977 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -151,20 +151,35 @@ struct {
 
 	HEADER_CPU_TOPOLOGY = 13,
 
-String lists defining the core and CPU threads topology.
-The string lists are followed by a variable length array
-which contains core_id, die_id (for x86) and socket_id of each cpu.
-The number of entries can be determined by the size of the
-section minus the sizes of both string lists.
-
 struct {
+	/*
+	 * First revision of HEADER_CPU_TOPOLOGY
+	 *
+	 * See 'struct perf_header_string_list' definition earlier
+	 * in this file.
+	 */
+
        struct perf_header_string_list cores; /* Variable length */
        struct perf_header_string_list threads; /* Variable length */
+
+       /*
+        * Second revision of HEADER_CPU_TOPOLOGY, older tools
+        * will not consider what comes next
+        */
+
        struct {
 	      uint32_t core_id;
-	      uint32_t die_id;
 	      uint32_t socket_id;
        } cpus[nr]; /* Variable length records */
+       /* 'nr' comes from previously processed HEADER_NRCPUS's nr_cpu_avail */
+
+        /*
+	 * Third revision of HEADER_CPU_TOPOLOGY, older tools
+	 * will not consider what comes next
+	 */
+
+	struct perf_header_string_list dies; /* Variable length */
+	uint32_t die_id[nr_cpus_avail]; /* from previously processed HEADER_NR_CPUS, VLA */
 };
 
 Example:
-- 
2.20.1

