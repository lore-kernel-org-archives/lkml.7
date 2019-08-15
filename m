Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A963C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E75121873
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gJl0AMQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfHOJXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:23:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45199 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbfHOJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:23:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9NAf72271411
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:23:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9NAf72271411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860990;
        bh=3z3ax8l2ofM7oHT0xEJktpDpwf9xQNhXugjbZKiBvLs=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=gJl0AMQPiQpBgayG3Elum6w9VCPGuYezCTb43ReTLPwKsg4KtBwK9fT70fWJu6vV5
         SV6O6Xx8dK3k0nyCmRJNZFUo+JZ5WvY7XoeWHTjddXHslH9ysOOrSI24KVpm+OKhc+
         jz9YEtxbkgSQT9eOI1fJnljNtu6qe0MY0f/VgbRJB04vpN9hZ8gF9CgkC1fSvYaKaf
         P/IksN/0b5jbQjd3OALRWtR0uepeaPWIB23zAgSLnP0jY55vWWhwEbS3PzNQvdL7WJ
         o41xOGkQrwd21OF5w5u7/7xGQX/k+SY/zkvVLWIGvfZNj8DLPDY1lg7+d0UJ72NyQw
         T+6ChA4IuLiuQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9N9u42271408;
        Thu, 15 Aug 2019 02:23:09 -0700
Date:   Thu, 15 Aug 2019 02:23:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-dwvtjqqifsbsczeb35q6mqkk@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, namhyung@kernel.org, acme@redhat.com,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          adrian.hunter@intel.com, namhyung@kernel.org, jolsa@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf hist: Remove dummy entries when finding real
 ones.
Git-Commit-ID: 5f8b4d5d237a3e2e35509da4e63769ae5c82c085
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

Commit-ID:  5f8b4d5d237a3e2e35509da4e63769ae5c82c085
Gitweb:     https://git.kernel.org/tip/5f8b4d5d237a3e2e35509da4e63769ae5c82c085
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 9 Aug 2019 17:56:06 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf hist: Remove dummy entries when finding real ones.

When he have an event group we have multiple struct hist instances, one
per evsel, and in each of these hists we may have hist_entries that
point to the same thing being observed, say a symbol, i.e. if we're
looking at instructions and cycles, then we'll have one hist_entry in
the "instructions" evsel and another in the "cycles" evsel.

We need to link those to then show one column for each. When we're
looking at some other pair of events, say instructions and cache misses,
we may have just the "instructions" hist entry and not one for "cache
misses", as instructions not necessarily generate cache misses, as the
logic expects one hist_entry per evsel, we end up adding "dummy"
hist_entries.

This is enough for 'perf report', that does this matching operation
(hists__match()) just once after processing all events, but for 'perf
top', we do this at each refresh, so we may finally find events matching
and then we need to trow away the dummies and link with the real events.

So if we find a match, traverse the link of matches and trow away
dummies for that hists.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dwvtjqqifsbsczeb35q6mqkk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index d923a5bb7b48..8efbf58dc3d0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2436,7 +2436,7 @@ void hists__match(struct hists *leader, struct hists *other)
 {
 	struct rb_root_cached *root;
 	struct rb_node *nd;
-	struct hist_entry *pos, *pair;
+	struct hist_entry *pos, *pair, *pos_pair, *tmp_pair;
 
 	if (symbol_conf.report_hierarchy) {
 		/* hierarchy report always collapses entries */
@@ -2453,8 +2453,24 @@ void hists__match(struct hists *leader, struct hists *other)
 		pos  = rb_entry(nd, struct hist_entry, rb_node_in);
 		pair = hists__find_entry(other, pos);
 
-		if (pair && list_empty(&pair->pairs.node))
+		if (pair && list_empty(&pair->pairs.node)) {
+			list_for_each_entry_safe(pos_pair, tmp_pair, &pos->pairs.head, pairs.node) {
+				if (pos_pair->hists == other) {
+					/*
+					 * XXX maybe decayed entries can appear
+					 * here?  but then we would have use
+					 * after free, as decayed entries are
+					 * freed see hists__delete_entry
+					 */
+					BUG_ON(!pos_pair->dummy);
+					list_del_init(&pos_pair->pairs.node);
+					hist_entry__delete(pos_pair);
+					break;
+				}
+			}
+
 			hist_entry__add_pair(pair, pos);
+		}
 	}
 }
 
