Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CB0C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B965F21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428388;
	bh=R52ornbeCZWB1HwdSHHmV6LWHaK0iQcjDXON9+mDX+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LszMM8t43JJ+A97dYhxkWtVWuCFPs9bkVjacNTGqu9sxbkvetud/W1Cff3G9FAJVi
	 3+EQnvaMm805nb9MxatXwL5sCgzmzgO0Lvu6RdQPURkXIix7nUr3NuQsLPiTVWSieQ
	 NBFqU9s5LijqOyZLJo166pkB80FL/3UgyrVb+jO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfG2T01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfG2T0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:26:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6233520C01;
        Mon, 29 Jul 2019 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428383;
        bh=R52ornbeCZWB1HwdSHHmV6LWHaK0iQcjDXON9+mDX+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjeICQpZ70hceBLepzBljv02igRCg6xEkzoIF6XLJLFFT9dBl54Ja3cvl0rR3Tj94
         tyREzANr3Ai+Lr4PZByNYibrAPQvRji6O7XAPDdtV8ajF5PUAVr6/UMU5d/tL4r3nI
         Al2TeeN+jYanVsexxeLXgVg4arKhOgNDr5ywpyX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 056/293] perf evsel: Make perf_evsel__name() accept a NULL argument
Date:   Mon, 29 Jul 2019 21:19:07 +0200
Message-Id: <20190729190828.351725502@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fdbdd7e8580eac9bdafa532746c865644d125e34 ]

In which case it simply returns "unknown", like when it can't figure out
the evsel->name value.

This makes this code more robust and fixes a problem in 'perf trace'
where a NULL evsel was being passed to a routine that only used the
evsel for printing its name when a invalid syscall id was passed.

Reported-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-f30ztaasku3z935cn3ak3h53@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/evsel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0cf6f537f980..3ab81e8e079e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -587,6 +587,9 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
 {
 	char bf[128];
 
+	if (!evsel)
+		goto out_unknown;
+
 	if (evsel->name)
 		return evsel->name;
 
@@ -623,7 +626,10 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
 
 	evsel->name = strdup(bf);
 
-	return evsel->name ?: "unknown";
+	if (evsel->name)
+		return evsel->name;
+out_unknown:
+	return "unknown";
 }
 
 const char *perf_evsel__group_name(struct perf_evsel *evsel)
-- 
2.20.1



