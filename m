Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42CCC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7956523401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507742;
	bh=6DLuWqVAilt07lXJ0ps9lLLQjFJex1jF05xqTySiZ88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PIaxhEubV1yNl5STPTkrFh1rZPqXGmSsMImfJohXkmudBl2jedDMe+oFgULWnq7N+
	 6zoihI9jHErl1WlbgA4DtBEc//fkPfsbHP6tk3LA2BS+fiViWSqlK4MG/WcZB6mCT1
	 VB4ugX42iNmhw6yZHbJZRArUoUyOHglt7ZS9lM0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393481AbfHVVCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393445AbfHVVCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:17 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2CDE233FC;
        Thu, 22 Aug 2019 21:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507737;
        bh=6DLuWqVAilt07lXJ0ps9lLLQjFJex1jF05xqTySiZ88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPrAlCb6h+spb36t8mhlu3xnL+yVKZbRriMGQZ2w+4a0HaVIYKIwTm4FZs6BiTpXi
         qk71wBdE4g5FPmKOlSin4SJUNf+DVA/81eCNG1r/yUYGVnGR9ELIpsitdNz1GruIHJ
         Ew/DWlsv3y6D9TrlNiypMbHmRcwKaaZ0hqXdK/yc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 16/25] perf evsel: Add missing perf/evsel.h header in util/evsel.h
Date:   Thu, 22 Aug 2019 18:00:51 -0300
Message-Id: <20190822210100.3461-17-acme@kernel.org>
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

Since util/evsel.h uses perf_evsel__cpus() that has its prototype in
libperf's perf/evsel.h file, we need it explicitely included.

This was working by luck as util/evsel.h includes counts.h, but that is
not necessary, just some forward declarations, so, before we remove
counts.h from util/evsel.h, add what is realli needed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-nfb9e0t4jm9zhvr0q86hc29d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 2928eee78427..da91d6f57f44 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -8,6 +8,7 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <internal/evsel.h>
+#include <perf/evsel.h>
 #include "symbol_conf.h"
 #include "cpumap.h"
 #include "counts.h"
-- 
2.21.0

