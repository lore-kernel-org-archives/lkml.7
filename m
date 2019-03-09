Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C73C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE4B206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfCIUJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:09:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCIUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:09:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K9Bh53206357
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:09:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K9BXq3206354;
        Sat, 9 Mar 2019 12:09:11 -0800
Date:   Sat, 9 Mar 2019 12:09:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-befa09b61f8bf1d7c34b8e6405f08d804640573c@git.kernel.org>
Cc:     nasastry@in.ibm.com, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        namhyung@kernel.org, hpa@zytor.com, ak@linux.intel.com,
        jonas.rabenstein@studium.uni-erlangen.de, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: nasastry@in.ibm.com, acme@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
          namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org,
          jonas.rabenstein@studium.uni-erlangen.de, ak@linux.intel.com,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de
In-Reply-To: <20190305152536.21035-8-jolsa@kernel.org>
References: <20190305152536.21035-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf session: Fix double free in perf_data__close
Git-Commit-ID: befa09b61f8bf1d7c34b8e6405f08d804640573c
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

Commit-ID:  befa09b61f8bf1d7c34b8e6405f08d804640573c
Gitweb:     https://git.kernel.org/tip/befa09b61f8bf1d7c34b8e6405f08d804640573c
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 5 Mar 2019 16:25:35 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:20:33 -0300

perf session: Fix double free in perf_data__close

We can't call perf_data__close and subsequently perf_session__delete,
because it will call perf_data__close again and cause double free for
data->file.path.

  $ perf report -i .
  incompatible file format (rerun with -v to learn more)
  free(): double free detected in tcache 2
  Aborted (core dumped)

In fact we don't need to call perf_data__close at all, because at the
time the got out_close is reached, session->data is already initialized,
so the perf_data__close call will be triggered from
perf_session__delete.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Fixes: 2d4f27999b88 ("perf data: Add global path holder")
Link: http://lkml.kernel.org/r/20190305152536.21035-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c764bbc91009..db643f3c2b95 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -140,7 +140,7 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
 		if (perf_data__is_read(data)) {
 			if (perf_session__open(session) < 0)
-				goto out_close;
+				goto out_delete;
 
 			/*
 			 * set session attributes that are present in perf.data
@@ -181,8 +181,6 @@ struct perf_session *perf_session__new(struct perf_data *data,
 
 	return session;
 
- out_close:
-	perf_data__close(data);
  out_delete:
 	perf_session__delete(session);
  out:
