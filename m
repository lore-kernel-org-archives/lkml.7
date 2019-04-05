Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C7EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D7B21871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfDELlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:41:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbfDELlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:41:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BdvXG2734759
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:39:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35Bdvau2734756;
        Fri, 5 Apr 2019 04:39:57 -0700
Date:   Fri, 5 Apr 2019 04:39:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-3371f389e4be6efc496ca395b21911a8f2c2d23f@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, ak@linux.intel.com,
        hpa@zytor.com
Reply-To: ak@linux.intel.com, jolsa@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20190326221823.11518-4-andi@firstfloor.org>
References: <20190326221823.11518-4-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Support printing evsel name for
 'duration_time'
Git-Commit-ID: 3371f389e4be6efc496ca395b21911a8f2c2d23f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3371f389e4be6efc496ca395b21911a8f2c2d23f
Gitweb:     https://git.kernel.org/tip/3371f389e4be6efc496ca395b21911a8f2c2d23f
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Tue, 26 Mar 2019 15:18:22 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 14:49:24 -0300

perf evsel: Support printing evsel name for 'duration_time'

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
