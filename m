Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B9CC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC097205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564431262;
	bh=2o22tR3EhmUoGO81eu0w4DIxcCBKxG35WXyGeRSq6xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XSJuMkWvRWoflfmlU2lsNPJrroQIepeZt2zb6wyiBHdqW95WowXMQ5G692fSBQTkn
	 x3uSta2v7X/qytEQd9bbmCV3L211ylwjG39q++RoPZdnFBwY5lNkxljTIMilfmhUKk
	 6zUODQDD2wL0XneRlzVKvKRusE2N1g2thC0EXHb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfG2UOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbfG2T2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:28:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF3F421655;
        Mon, 29 Jul 2019 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428494;
        bh=2o22tR3EhmUoGO81eu0w4DIxcCBKxG35WXyGeRSq6xM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4SQrCaogZ9ulT/8AjByxn4+Tdm0NYr+h6wi8mB95BZPoqx17FNiGkA+Ny3iClXgd
         UnTZBpovxK+8178tT6+R8QiT67/Vv7r4RspUXRJRnJ27bsOisv/HaNEpdebrlFXvGl
         dIf6VhSi3DQ7rMnnfGtc7vT19fbxL8Y/kQDtW2rk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 093/293] perf stat: Make metric event lookup more robust
Date:   Mon, 29 Jul 2019 21:19:44 +0200
Message-Id: <20190729190831.731409775@linuxfoundation.org>
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



