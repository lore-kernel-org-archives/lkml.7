Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7DAC43630
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7317222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569457999;
	bh=H1P8YpwETNve9I0/jsWQxVsdnQvvysp6oIZRcfrJ58c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wLxQLI2TuoPBtVXI7me/XWRy4qoT9ebxQ3ihJPAaLkudPWjvFNqQrCdgKrV17XrmK
	 92TKb6iU/s3aYoUrvVLQDQvBrttGWsnm51NK3YX6fsHpENfUpf2VlnMIoTdPD05QQc
	 d9SfRqOAj9HQ+8OXniHBc/oK6oJN97gayXO0AdVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfIZAdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfIZAdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:16 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A8A217F4;
        Thu, 26 Sep 2019 00:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569457996;
        bh=H1P8YpwETNve9I0/jsWQxVsdnQvvysp6oIZRcfrJ58c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0lVq1njg1ORwK+X+Fpm3pT6cjV+7u396zuP8ySKe6L1RI4GUgv3cmJjlaYAjTR248
         EDpTuPffgK7uHelKxcso7OoxekOAybbaWOUioZYr9PnexDVxFMZfT5FzGWSyxzAEb3
         MgwQwnz0uWfFe6GoOat7mjpu6fI1K3QDjx16IIDI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Janakarajan Natarajan <janakarajan.natarajan@amd.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Luke Mujica <lukemujica@google.com>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/66] perf vendor events amd: Remove redundant '['
Date:   Wed, 25 Sep 2019 21:31:42 -0300
Message-Id: <20190926003244.13962-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

Remove the redundant '['.

'perf list' output before:

  ex_ret_brn
       [[Retired Branch Instructions]

'perf list' output after:

  ex_ret_brn
       [Retired Branch Instructions]

Fixes: 98c07a8f74f8 ("perf vendor events amd: perf PMU events for AMD Family 17h")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Janakarajan Natarajan <janakarajan.natarajan@amd.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190919204306.12598-2-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/amdfam17h/core.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json b/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
index 7b285b0a7f35..1079544eeed5 100644
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
@@ -13,7 +13,7 @@
   {
     "EventName": "ex_ret_brn",
     "EventCode": "0xc2",
-    "BriefDescription": "[Retired Branch Instructions.",
+    "BriefDescription": "Retired Branch Instructions.",
     "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
   },
   {
-- 
2.21.0

