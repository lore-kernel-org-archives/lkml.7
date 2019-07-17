Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FE8C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F111D21019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gBRSPDRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfGQW77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:59:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37549 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfGQW77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:59:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMxoMd1723019
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:59:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMxoMd1723019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404390;
        bh=9EismJ/LwBXO5Lo+wRVKbTAU0uPQzujpjCcd4sRcMM0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gBRSPDRfHYA/uXxqQ59bG2VEsrXKX8+uadfPeC/IN1IAq5/6nGOwMHpEJuMIkdxXO
         7WchwilsxTN9/MzXQPWj2yLVUuk9EX7v+2zOBFyEYF/MNlMnJo4pEELPvlB/tteYH8
         6uctqt3MVN/SSvEo9WkrNDIAFH5o1YK+nW5HOCa9kztLPvoA52R9C2qbDjUGRVjAQI
         nFc3cX8LyQyEiJi654WSDf8+mfywya5CYKilQ9qAoNCjRRv5jK5vbGALf3SvREaWvg
         dVx09oxddZKnwKxOXhXx0Kw1x0KQPg+I741RVv78WwpagYo+cSTTAijuI/LUOhp6Tu
         oY9iPmIhoV1YA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMxnus1723015;
        Wed, 17 Jul 2019 15:59:49 -0700
Date:   Wed, 17 Jul 2019 15:59:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-ecc8c9984dae9812a10936cb9c74957b68075e07@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@redhat.com, acme@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com
Reply-To: mingo@kernel.org, acme@redhat.com, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, tglx@linutronix.de
In-Reply-To: <20190710085810.1650-14-adrian.hunter@intel.com>
References: <20190710085810.1650-14-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-sqlite.py: Add
 has_calls column to comms table
Git-Commit-ID: ecc8c9984dae9812a10936cb9c74957b68075e07
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

Commit-ID:  ecc8c9984dae9812a10936cb9c74957b68075e07
Gitweb:     https://git.kernel.org/tip/ecc8c9984dae9812a10936cb9c74957b68075e07
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:58:02 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:23:55 -0300

perf scripts python: export-to-sqlite.py: Add has_calls column to comms table

Now that a thread's current comm is exported, it shows up in the call
graph and call tree even if it has no calls. That can happen because the
calls are recorded against the main thread's initial comm.

Add a table column to make it easy for the exported-sql-viewer.py script
to select only comms with calls.

Committer notes:

Running the export-to-sqlite.py worked without warnings and using the
exported-sql-viewer.py worked as before.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-14-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 97aa66dd2fe1..9156f6a1e5f0 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -606,6 +606,8 @@ def trace_end():
 	if perf_db_export_calls:
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
+		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
+		do_query(query, 'UPDATE comms SET has_calls = 1 WHERE comms.id IN (SELECT DISTINCT comm_id FROM calls)')
 
 	printdate("Dropping unused tables")
 	if is_table_empty("ptwrite"):
