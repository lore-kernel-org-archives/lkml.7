Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722FFC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E9B20644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="13jR2mQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfHOJVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:21:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34261 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfHOJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:21:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9LeqY2271251
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:21:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9LeqY2271251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860901;
        bh=2YSlfP1BdVO4encMNyt2IbdcLRq5KmMZEDyQZRuI8xM=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=13jR2mQZxO+6KvHdSwNyL9tROhXKnwbxs0FrmV+iFgsAGrWBO8lZjCLXa2t1qPN6k
         1gW9vrZZkgs4fmChyt+6TDsuQWm0kDYi70HMQd24YUbWRS5a7VICudyTl/iEvwp+1m
         zFaBWZN5woZON3c7vKDqBp1w9/l9C4QPMkNBpwXH2qNzceHiuEIdyPjXniMx3yqJsj
         +dSU8w2J25L8Oi4siYnbURvNTHcJ7b9YbEI6lv5V0aLV+Ye9K8YxPcp50kVunPYuVE
         5wUSqVRyuT3ypyAXgnPrxms6IBTn/00k+kiqsw7Ts5fdF2gREInTdrib8O9cjX34aK
         kO9JVg4D42gMA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9LeI12271248;
        Thu, 15 Aug 2019 02:21:40 -0700
Date:   Thu, 15 Aug 2019 02:21:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-iwvb37rgb7upswhruwpcdnhw@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, adrian.hunter@intel.com
Reply-To: mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
          namhyung@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf hists: Do not link a pair if already linked
Git-Commit-ID: 7d1a5efa20dbfea97cb93b99c67ce5cd5c4a4dbc
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

Commit-ID:  7d1a5efa20dbfea97cb93b99c67ce5cd5c4a4dbc
Gitweb:     https://git.kernel.org/tip/7d1a5efa20dbfea97cb93b99c67ce5cd5c4a4dbc
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 7 Aug 2019 10:45:30 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf hists: Do not link a pair if already linked

When we have multiple events in a group we link hist_entries in the
non-leader evsel hists to the one in the leader that points to the same
sorting criteria, in hists__match().

For 'perf report' we do this just once and then print the results, but
for 'perf top' we need to look if this was already done in the previous
refresh of the screen, so check for that and don't try to link again.

This is part of having 'perf top' using the hists browser for showing
multiple events in multiple columns.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-iwvb37rgb7upswhruwpcdnhw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 4297f56b1e05..d923a5bb7b48 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2453,7 +2453,7 @@ void hists__match(struct hists *leader, struct hists *other)
 		pos  = rb_entry(nd, struct hist_entry, rb_node_in);
 		pair = hists__find_entry(other, pos);
 
-		if (pair)
+		if (pair && list_empty(&pair->pairs.node))
 			hist_entry__add_pair(pair, pos);
 	}
 }
