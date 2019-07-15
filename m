Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF60FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8EB206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563201275;
	bh=IeHXztZ6+8DTh3OZHBhDrda/RtZSBQaGpss8FB487qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hWOj25J/Y0xfm0/Wd7e7SDcEFxv0QUd8f4EM3L+AfrpeB6vhLukMog6NF9OqDcYab
	 Fn368IbtPNZL8B8qMY3nGz2dyMoq8mAXOt4xDge80XIhfXyaygbYlA3fr7jFDuFW99
	 Qm0dP536CUeBhAenHHgnjjbgwwCoimdd1iI+NbvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392044AbfGOOee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391048AbfGOOeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:34:31 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E73204FD;
        Mon, 15 Jul 2019 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563201270;
        bh=IeHXztZ6+8DTh3OZHBhDrda/RtZSBQaGpss8FB487qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIiTzWLo+QO6CNgoqcmTmhbybC7kZe+VMlfti3nYEk9E+HmuZUB2LHdYqxCTEIapr
         MdKKeySwzhbvNy1R+gaZp19WPjByU8jVgJ54c/msoKpfzZopAm6OuzfRKeJbGjM4Mp
         uwxVyUsydC308Y8vuBfPljk+duCvedL9K5n3t+jg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 093/105] perf stat: Make metric event lookup more robust
Date:   Mon, 15 Jul 2019 10:28:27 -0400
Message-Id: <20190715142839.9896-93-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715142839.9896-1-sashal@kernel.org>
References: <20190715142839.9896-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

[ Upstream commit 145c407c808352acd625be793396fd4f33c794f8 ]

After setting up metric groups through the event parser, the metricgroup
code looks them up again in the event list.

Make sure we only look up events that haven't been used by some other
metric. The data structures currently cannot handle more than one metric
per event. This avoids problems with multiple events partially
overlapping.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Link: http://lkml.kernel.org/r/20190624193711.35241-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/stat-shadow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 37363869c9a1..eadc9a2aef16 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -271,7 +271,7 @@ static struct perf_evsel *perf_stat__find_event(struct perf_evlist *evsel_list,
 	struct perf_evsel *c2;
 
 	evlist__for_each_entry (evsel_list, c2) {
-		if (!strcasecmp(c2->name, name))
+		if (!strcasecmp(c2->name, name) && !c2->collect_stat)
 			return c2;
 	}
 	return NULL;
@@ -310,7 +310,8 @@ void perf_stat__collect_metric_expr(struct perf_evlist *evsel_list)
 			if (leader) {
 				/* Search in group */
 				for_each_group_member (oc, leader) {
-					if (!strcasecmp(oc->name, metric_names[i])) {
+					if (!strcasecmp(oc->name, metric_names[i]) &&
+						!oc->collect_stat) {
 						found = true;
 						break;
 					}
-- 
2.20.1

