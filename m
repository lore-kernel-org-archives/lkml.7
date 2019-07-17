Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C29C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515A321019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tdsW1prP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfGQWyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:54:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfGQWyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:54:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMs8TI1722204
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:54:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMs8TI1722204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404048;
        bh=JcP5jc20u3M/HbhrvKUWQROCca5+BZ6fn9yqIzPCabE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tdsW1prPKiXaY0qhPDs5TiDujprsBIa1YGyjnWpA6KIiHO0BZc7RT/JCLdO02WoD5
         fo+EIx3Hoxdra08bAZOkedBvfQd+nzsRGF8TrGgXk3GvXCZDE9OPWes1PnX6Sr/B5b
         WQR+pT9/aHugWTWXH3YE2tFabUQkS56XJN7otKuACX3n7Wk3kEO7ijpeiK8U9TmiRm
         VYrBnTXKg8rTbwib9Mz7bHkXz5z8Rdy6T1x37896xc7PF7sZIZZK3Hwrq2yVffgxuv
         4YM6ku4N1VA0XzKDLPsihNZsy7ANYrSotYMROTBPr8qZhrF6QqU+0R6JiQ7mUvaw2W
         8/GiZtko33Dnw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMs7Ek1722198;
        Wed, 17 Jul 2019 15:54:07 -0700
Date:   Wed, 17 Jul 2019 15:54:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-6319790bcf825bcc4cd9bf01f01ae404a2fb7da8@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@redhat.com
Reply-To: jolsa@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
          tglx@linutronix.de
In-Reply-To: <20190710085810.1650-6-adrian.hunter@intel.com>
References: <20190710085810.1650-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Export comm before exporting
 thread
Git-Commit-ID: 6319790bcf825bcc4cd9bf01f01ae404a2fb7da8
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

Commit-ID:  6319790bcf825bcc4cd9bf01f01ae404a2fb7da8
Gitweb:     https://git.kernel.org/tip/6319790bcf825bcc4cd9bf01f01ae404a2fb7da8
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:57:54 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:12:25 -0300

perf db-export: Export comm before exporting thread

Export comm before exporting the non-main thread because
db_export__thread() also exports the comm_thread.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 63f9edf65eee..99ad759561de 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -312,6 +312,12 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 					main_thread);
 		if (err)
 			goto out_put;
+		if (comm) {
+			err = db_export__exec_comm(dbe, comm, main_thread);
+			if (err)
+				goto out_put;
+			es.comm_db_id = comm->db_id;
+		}
 	}
 
 	if (thread != main_thread) {
@@ -321,13 +327,6 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 			goto out_put;
 	}
 
-	if (comm) {
-		err = db_export__exec_comm(dbe, comm, main_thread);
-		if (err)
-			goto out_put;
-		es.comm_db_id = comm->db_id;
-	}
-
 	es.db_id = ++dbe->sample_last_db_id;
 
 	err = db_ids_from_al(dbe, al, &es.dso_db_id, &es.sym_db_id, &es.offset);
