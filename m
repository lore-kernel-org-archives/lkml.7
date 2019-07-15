Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D24C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BA6206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199791;
	bh=+/9SYzl146a33Wt7TxYvMzKsaEVFbWXSOpC8p8whxwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OHj68/0YXVxPZD0fc+JJVZPYDQ+s/TVnNGxzN/8DGMmmTeDtpa9SquHb18w7e/vDh
	 GRKYsOkR0PbtJ7IpqLzbJ2gMml9AMlxHKayk3H9fI6Ty1Fot0Qcn/PKm7t8grSGcRy
	 RTLT+NAe8G04ed6CAzwH+tXLlSQjew9oaC4a+bKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbfGOOJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387983AbfGOOJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:09:44 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A77920868;
        Mon, 15 Jul 2019 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199783;
        bh=+/9SYzl146a33Wt7TxYvMzKsaEVFbWXSOpC8p8whxwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gEaS9Y54bSgYAkdkK4Itn7pevzfhVD4srfaE5L7bcZqegNjf5cnDJZFmBB4RW5Yo
         KMuRXteA5woyOBtbkj6dcVOereL49AfwJ0vYeGLoZBskbfqQ07AqSm1l8gtcCPu9tl
         bGo2pA9lIicjPPnsnsSmuA0GXemS36DaIPWzfz1E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 104/219] perf evsel: Make perf_evsel__name() accept a NULL argument
Date:   Mon, 15 Jul 2019 10:01:45 -0400
Message-Id: <20190715140341.6443-104-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 966360844fff..7ca79cfe1aea 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -584,6 +584,9 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
 {
 	char bf[128];
 
+	if (!evsel)
+		goto out_unknown;
+
 	if (evsel->name)
 		return evsel->name;
 
@@ -620,7 +623,10 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
 
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

