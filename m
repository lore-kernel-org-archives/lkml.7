Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D18C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B239F20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221194;
	bh=i8iKHJ9QZ84Hizo773k3X1toqfJqxafGVGKcEwibLZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xfnLRxxY6pP49N1U5rDrdYVb0HBmjZkQqUO9Hdjz94N6KlmzX01bjXhQ5ulrjFYWh
	 xu7HYZOUevcO/w96u+IDxHmoAmaHh6Y4DLYEffsNCkkD1qeF2oq94B4Pc5RQLoodbo
	 nXCZRaN3whkLyGIQzB2R0oUatFKYe8soFUC5KPqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfDBQGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbfDBQGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:31 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49F692147C;
        Tue,  2 Apr 2019 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221190;
        bh=i8iKHJ9QZ84Hizo773k3X1toqfJqxafGVGKcEwibLZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wsDiAggogrTgLCYJGMw4MurdJU7E0EHPcC6WF01xTNMzwlbEwKrAn8pw0cbMdghH4
         BYHvbySgo1VBXAmEeekPG76bDao/JvPkcTfjA/JNY9HUFXD+Nj0p4mLxOL4ZA8LWyU
         z0R9uhr7uuKWslWWAtT4ZqwErtwua5nqPESXycWI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/44] perf evsel: Support printing evsel name for 'duration_time'
Date:   Tue,  2 Apr 2019 13:05:14 -0300
Message-Id: <20190402160549.13544-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Implement printing the correct name for duration_time

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190326221823.11518-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66d066f18b5b..84cfb9fe2fc6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -580,6 +580,12 @@ static int perf_evsel__raw_name(struct perf_evsel *evsel, char *bf, size_t size)
 	return ret + perf_evsel__add_modifiers(evsel, bf + ret, size - ret);
 }
 
+static int perf_evsel__tool_name(char *bf, size_t size)
+{
+	int ret = scnprintf(bf, size, "duration_time");
+	return ret;
+}
+
 const char *perf_evsel__name(struct perf_evsel *evsel)
 {
 	char bf[128];
@@ -601,7 +607,10 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
 		break;
 
 	case PERF_TYPE_SOFTWARE:
-		perf_evsel__sw_name(evsel, bf, sizeof(bf));
+		if (evsel->tool_event)
+			perf_evsel__tool_name(bf, sizeof(bf));
+		else
+			perf_evsel__sw_name(evsel, bf, sizeof(bf));
 		break;
 
 	case PERF_TYPE_TRACEPOINT:
-- 
2.20.1

