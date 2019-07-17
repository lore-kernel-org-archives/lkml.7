Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E22C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C4D21019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tq0526O6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbfGQW7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:59:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39711 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfGQW7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:59:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMx6pG1722935
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:59:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMx6pG1722935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404346;
        bh=1z7PnNcU//F2XTxZOh62vd7RsSskdP38Rm9idDPjxik=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tq0526O6MTdxlGvnYcGAzmlQRO7oInQg7Nv7BTwBwqYrH4seu3cvar2/SXU4CtEfV
         +dJZVZS1E/RXAy4WhNMj+a3Y0xASgToR2yUNxld/nrAE+2l34Steg6NMeyD29xs4Zg
         pewxKC1Pdg70AhQXVjEcvTRCtbIxGq9iHdPaX9c3TRec6Qk+qZC4ponN5P5+kX64+w
         e7LvNmeLTlCupAWqPuTpB5GxobEEyiVhSpLxJHKY8xP9XHs1hrvLzAeQQMOogbnRHH
         uz1HWHtyxCMNVms6THaFF9L+f9VJQOaJ6lbK32bUYDfiu8tqCdsHfX6oT2IPRfJb88
         0+lDzllNrjaxg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMx5o91722932;
        Wed, 17 Jul 2019 15:59:05 -0700
Date:   Wed, 17 Jul 2019 15:59:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4650c7bed79582c74452d284e45d5b76987c0ef3@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@redhat.com,
          acme@redhat.com
In-Reply-To: <20190710085810.1650-13-adrian.hunter@intel.com>
References: <20190710085810.1650-13-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Also export thread's current comm
Git-Commit-ID: 4650c7bed79582c74452d284e45d5b76987c0ef3
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

Commit-ID:  4650c7bed79582c74452d284e45d5b76987c0ef3
Gitweb:     https://git.kernel.org/tip/4650c7bed79582c74452d284e45d5b76987c0ef3
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:58:01 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:14:07 -0300

perf db-export: Also export thread's current comm

Currently, the initial comm of the main thread is exported. Export also
a thread's current comm. That better supports the tracing of
multi-threaded applications that set different comms for different
threads to make it easier to distinguish them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-13-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index b1e581c13963..5057fdd7f62d 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -299,6 +299,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	};
 	struct thread *main_thread;
 	struct comm *comm = NULL;
+	struct comm *curr_comm;
 	int err;
 
 	err = db_export__evsel(dbe, evsel);
@@ -350,6 +351,13 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		}
 	}
 
+	curr_comm = thread__comm(thread);
+	if (curr_comm) {
+		err = db_export__comm(dbe, curr_comm, thread);
+		if (err)
+			goto out_put;
+	}
+
 	es.db_id = ++dbe->sample_last_db_id;
 
 	err = db_ids_from_al(dbe, al, &es.dso_db_id, &es.sym_db_id, &es.offset);
