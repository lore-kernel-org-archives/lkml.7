Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E338CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FF423402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507750;
	bh=yyZlexJrl5PvrPUybgaNHr0zhvmhP4F8MTTlYnN7vdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q+PNmq4jIc4rUK/XBwgBumsrTOQjc50dAy/D49LNXqkJiseu2lLs1MMVt+MKiCROi
	 weIUhzLEHVm4+ESj9BiW9OMVq/CQlHiUOoDjv2P2GWaWhEJzsExWTWyCSBlW5GHET6
	 2MxoXaNPErEd01kBpIKudOSiUCQs9qHxTvhuRPw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393497AbfHVVC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388169AbfHVVC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:27 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6758923401;
        Thu, 22 Aug 2019 21:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507746;
        bh=yyZlexJrl5PvrPUybgaNHr0zhvmhP4F8MTTlYnN7vdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/4tSUcJpRoe8qVAvIjoyTfiJkaoBOkABvhR1doVcK0ksYyJ2SLOi3Urzq3pn3qa0
         dcc3ZHqCypvkwfEbx8b43wZ8sAcfXoD5+xet5h/eZgosHsbjhjZOGUZ7OUACtjzzGq
         9bkDKJKorJ/YMqUNqPx4F4+MCSGzTk6pktPM4Vuc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 18/25] perf evsel: Remove needless stddef.h from util/evsel.h
Date:   Thu, 22 Aug 2019 18:00:53 -0300
Message-Id: <20190822210100.3461-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We added it in 07ac002f2fcc ("perf evsel: Introduce is_group_member
method") but we already ditched that function, and there was nothing
else left that needed NULL nor anything else from stddef.h, ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1zy0xfsy61x81f3fpyx5znco@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 296390541030..1f749a783d8f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -4,7 +4,6 @@
 
 #include <linux/list.h>
 #include <stdbool.h>
-#include <stddef.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <internal/evsel.h>
-- 
2.21.0

