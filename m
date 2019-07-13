Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235F7C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA742083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SUITRGJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfGMK4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:56:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMK4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:56:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DAugcv3837980
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 03:56:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DAugcv3837980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015402;
        bh=oqD7Zy5Kc1UyPtvkgt9bJ8ZUgA6N0u40gnlH7Jj048o=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=SUITRGJR/yZjfM9+Ix6vNLxiAr+cA/P1g2j0lGkxF5UJZgFAosuQBW3VR5oKeeo0I
         JuTPgShS5M9XVsdrBRZF0e7JCJhAa5c1SjMbrJ2k9y/WYdEeGM5p8YtElyEEvfqi0n
         bTP9C8sc8ldO/mv1F8+HqHotv8kBSPX4ZNe68EseVAHVxW3+KRhjvOicgWBIUx5Lcy
         Mf+N0LqksLusxihHIzWPxV9aLyUePeJYHPyc5deuKdWad0dFZoySrPTmfqbeWFcpWG
         xTQLUp0hSIKlwFrcczb5aTIUjaOTUkJCSNUsulnsUsE0lBilUZguUWRT01JnP/TXtx
         QTaaTVSiygCZg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DAufHH3837977;
        Sat, 13 Jul 2019 03:56:41 -0700
Date:   Sat, 13 Jul 2019 03:56:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-muvb8xqyh0gysgfjfq35w642@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@kernel.org, namhyung@kernel.org,
        acme@redhat.com, leo.yan@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
          tglx@linutronix.de, acme@redhat.com, leo.yan@linaro.org,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf inject: The tool->read() call may pass a
 NULL evsel, handle it
Git-Commit-ID: 40978e9bf2137223993e70921de2731201788049
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

Commit-ID:  40978e9bf2137223993e70921de2731201788049
Gitweb:     https://git.kernel.org/tip/40978e9bf2137223993e70921de2731201788049
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 3 Jul 2019 16:02:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 09:33:55 -0300

perf inject: The tool->read() call may pass a NULL evsel, handle it

Check first, as machines__deliver_event() may have
perf_evlist__id2evsel() returning NULL.

This was found while checking a report from Leo Yan that used the smatch
tool to find places where a pointer is checked before use and then,
later in the same function gets used without checking.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-muvb8xqyh0gysgfjfq35w642@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8e0e06d3edfc..f4591a1438b4 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -224,7 +224,7 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 				     struct perf_evsel *evsel,
 				     struct machine *machine)
 {
-	if (evsel->handler) {
+	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
 		return f(tool, event, sample, evsel, machine);
 	}
