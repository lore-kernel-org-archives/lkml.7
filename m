Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ABEC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87E821841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="argT+2iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfGQWxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:53:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfGQWxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:53:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMrQ6T1721917
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:53:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMrQ6T1721917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404007;
        bh=2IX17TrEU4azZoDjOCQkx4SEmoEpvql5e49VsR/GCEs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=argT+2iP32Hn1pb2aSmm0V0XXqXlk1yX7c7wCs6CvOXgnt/RZdY2ouET8Zl3hXWkl
         CAmeIa1S5RdvMwe8S47P89uvp7wE/ggxSM8a1ECOak2Hqwyql96ljgy5waCWMSTeb0
         IG79nTmjxasjHHIxHm2h0Xmgb0fXJ8OtlBBtw6ckVPJg8QK8TOsOGGw9af8+jvylvt
         /cDWl2itrIBltgSN5RkcnejfHYpVj2eZfBGVHjWO19l5NGsNts9aWzxZNFnglSgsE7
         FJCq7rHo1VUr66ctq1PCC+WNkAoZ9hSFGLc841/ya04Gc0maXPEuWy+ElXuKHutiXH
         0ATxQoGh1V0Ig==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMrPe41721914;
        Wed, 17 Jul 2019 15:53:25 -0700
Date:   Wed, 17 Jul 2019 15:53:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-19207d86940db9dad5f2e0a270a2490f7da451e3@git.kernel.org>
Cc:     mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        acme@redhat.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, jolsa@redhat.com, mingo@kernel.org,
          adrian.hunter@intel.com
In-Reply-To: <20190710085810.1650-5-adrian.hunter@intel.com>
References: <20190710085810.1650-5-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Export main_thread in
 db_export__sample()
Git-Commit-ID: 19207d86940db9dad5f2e0a270a2490f7da451e3
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

Commit-ID:  19207d86940db9dad5f2e0a270a2490f7da451e3
Gitweb:     https://git.kernel.org/tip/19207d86940db9dad5f2e0a270a2490f7da451e3
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:57:53 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:12:05 -0300

perf db-export: Export main_thread in db_export__sample()

Export main_thread in db_export__sample() because it makes the code
easier to understand, and prepares db_export__thread() for further
simplification.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 14501236c046..63f9edf65eee 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -71,16 +71,10 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 	thread->db_id = ++dbe->thread_last_db_id;
 
 	if (main_thread) {
-		if (main_thread != thread) {
-			err = db_export__thread(dbe, main_thread, machine,
-						comm, main_thread);
+		if (main_thread != thread && comm) {
+			err = db_export__comm_thread(dbe, comm, thread);
 			if (err)
 				return err;
-			if (comm) {
-				err = db_export__comm_thread(dbe, comm, thread);
-				if (err)
-					return err;
-			}
 		}
 		main_thread_db_id = main_thread->db_id;
 	}
@@ -308,12 +302,24 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		return err;
 
 	main_thread = thread__main_thread(al->machine, thread);
-	if (main_thread)
+	if (main_thread) {
 		comm = machine__thread_exec_comm(al->machine, main_thread);
+		/*
+		 * A thread has a reference to the main thread, so export the
+		 * main thread first.
+		 */
+		err = db_export__thread(dbe, main_thread, al->machine, comm,
+					main_thread);
+		if (err)
+			goto out_put;
+	}
 
-	err = db_export__thread(dbe, thread, al->machine, comm, main_thread);
-	if (err)
-		goto out_put;
+	if (thread != main_thread) {
+		err = db_export__thread(dbe, thread, al->machine, comm,
+					main_thread);
+		if (err)
+			goto out_put;
+	}
 
 	if (comm) {
 		err = db_export__exec_comm(dbe, comm, main_thread);
