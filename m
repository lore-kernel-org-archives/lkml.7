Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC16C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA7D21841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KKOzDMiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfGQXCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:02:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59847 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfGQXCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:02:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN1w0s1723403
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:01:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN1w0s1723403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404519;
        bh=CsNPApDs3Eusg+puv622VArvKvbfN+jFZGFjqzFiQGo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KKOzDMiEVZ011gYrJri4z9xNatEuhMd/zhov/nP3PMeUpvcxHl8KNWzDY8Y5qS/Tw
         EVFXlajuyjj+CjLChbl2l862/V8NpsGxtiOnpgsW3xEtbpBneWj9w5c6e5cYFF5sDA
         BgCWypDf0ILGOzmfFstgok50GOdhfw6woQerIQ1FIsWKTEJSk7jVgm+8r/tUfBZeBl
         8FqDlnu631Hb4wvrHeZN4xrFHr7dU+UNkYwXMWcv7lB5d7gala7+yI5Ha0gz4KJVGC
         IZftkj/0eYAqYukoJ8pDtLayRXhcGJXzpXQZd+C/mYZOl8Ki3Gi/G85YcLZP97yiZL
         2yN74sJ1JJ0bA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN1vCE1723400;
        Wed, 17 Jul 2019 16:01:57 -0700
Date:   Wed, 17 Jul 2019 16:01:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-26c11206f433ea507a7541f48cb472b85870577e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        jolsa@redhat.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, jolsa@redhat.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, acme@redhat.com
In-Reply-To: <20190710085810.1650-17-adrian.hunter@intel.com>
References: <20190710085810.1650-17-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py: Use
 new 'has_calls' column
Git-Commit-ID: 26c11206f433ea507a7541f48cb472b85870577e
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

Commit-ID:  26c11206f433ea507a7541f48cb472b85870577e
Gitweb:     https://git.kernel.org/tip/26c11206f433ea507a7541f48cb472b85870577e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:58:05 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:31:25 -0300

perf scripts python: exported-sql-viewer.py: Use new 'has_calls' column

If the new 'has_calls' column is present, use it with the call graph and
call tree to select only comms that have calls.

Committer testing:

Just started the exported-sql-view.py and accessed all the reports, no
backtraces.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-17-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index dbbd7a5d9b60..61b3911d91e6 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -623,8 +623,11 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 		super(CallGraphRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
 		self.query_done = True
+		if_has_calls = ""
+		if IsSelectable(glb.db, "comms", columns = "has_calls"):
+			if_has_calls = " WHERE has_calls = TRUE"
 		query = QSqlQuery(glb.db)
-		QueryExec(query, "SELECT id, comm FROM comms")
+		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
 		while query.next():
 			if not query.value(0):
 				continue
@@ -900,8 +903,11 @@ class CallTreeRootItem(CallGraphLevelItemBase):
 		super(CallTreeRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
 		self.query_done = True
+		if_has_calls = ""
+		if IsSelectable(glb.db, "comms", columns = "has_calls"):
+			if_has_calls = " WHERE has_calls = TRUE"
 		query = QSqlQuery(glb.db)
-		QueryExec(query, "SELECT id, comm FROM comms")
+		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
 		while query.next():
 			if not query.value(0):
 				continue
