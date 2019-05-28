Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC67C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAF02075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NbUdK7q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfE1V21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:28:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfE1V21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:28:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLSJIe2240637
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:28:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLSJIe2240637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078899;
        bh=Bt5J+EsvFH3qvx1qAg47/7/iv3RMbgLKff9eXUtcgJs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=NbUdK7q2/pcKZzJRu3cumvienVbzu60/RzjjvzuFP5zq6LiO3sKCbIoyADjfnuzuu
         jwxIKKKMhfZJ+SomTZ29dHhPrFYQq39SAenJuo9Vpfj9aSVy3PjgvqdvZCYda1foHt
         QkQ0dTKNEEEwoLpiIOIlJc4rLgKSKlyzfSKdRLU4HhyhByiPoj9ZG6FFgfAYtMDj7Q
         fPurcbrd1z0HvE/TXTUcHD/AZc7RhK1Qq4VWZVyiAlu02HTdPWG9hxfaSD0winR+uI
         cfRjRtMo+G7nA+nYYHMlgZM1MSXQddNOFc8r5SZOz9gVyPVfk/iCzw33+20wfMiABp
         xc9831IrHj+yw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLSJ5w2240634;
        Tue, 28 May 2019 14:28:19 -0700
Date:   Tue, 28 May 2019 14:28:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Namhyung Kim <tipbot@zytor.com>
Message-ID: <tip-acd244b84b80d53fa2cee98659b55d3f09b4f5a7@git.kernel.org>
Cc:     jolsa@redhat.com, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        hbathini@linux.vnet.ibm.com, kjlx@templeofstupid.com,
        mingo@kernel.org, namhyung@kernel.org
Reply-To: jolsa@redhat.com, tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          kjlx@templeofstupid.com, hbathini@linux.vnet.ibm.com,
          namhyung@kernel.org, mingo@kernel.org
In-Reply-To: <20190522053250.207156-3-namhyung@kernel.org>
References: <20190522053250.207156-3-namhyung@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf session: Add missing swap ops for namespace
 events
Git-Commit-ID: acd244b84b80d53fa2cee98659b55d3f09b4f5a7
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

Commit-ID:  acd244b84b80d53fa2cee98659b55d3f09b4f5a7
Gitweb:     https://git.kernel.org/tip/acd244b84b80d53fa2cee98659b55d3f09b4f5a7
Author:     Namhyung Kim <namhyung@kernel.org>
AuthorDate: Wed, 22 May 2019 14:32:49 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:52:23 -0300

perf session: Add missing swap ops for namespace events

In case it's recorded in a different arch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com> <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Fixes: f3b3614a284d ("perf tools: Add PERF_RECORD_NAMESPACES to include namespaces related info")
Link: http://lkml.kernel.org/r/20190522053250.207156-3-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2310a1752983..54cf163347f7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -647,6 +647,26 @@ static void perf_event__throttle_swap(union perf_event *event,
 		swap_sample_id_all(event, &event->throttle + 1);
 }
 
+static void perf_event__namespaces_swap(union perf_event *event,
+					bool sample_id_all)
+{
+	u64 i;
+
+	event->namespaces.pid		= bswap_32(event->namespaces.pid);
+	event->namespaces.tid		= bswap_32(event->namespaces.tid);
+	event->namespaces.nr_namespaces	= bswap_64(event->namespaces.nr_namespaces);
+
+	for (i = 0; i < event->namespaces.nr_namespaces; i++) {
+		struct perf_ns_link_info *ns = &event->namespaces.link_info[i];
+
+		ns->dev = bswap_64(ns->dev);
+		ns->ino = bswap_64(ns->ino);
+	}
+
+	if (sample_id_all)
+		swap_sample_id_all(event, &event->namespaces.link_info[i]);
+}
+
 static u8 revbyte(u8 b)
 {
 	int rev = (b >> 4) | ((b & 0xf) << 4);
@@ -887,6 +907,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_LOST_SAMPLES]	  = perf_event__all64_swap,
 	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
 	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
+	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
