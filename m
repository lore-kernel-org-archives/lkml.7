Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC71C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AD5206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfCIUKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:10:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCIUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:10:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K9pLj3206416
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:09:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K9p3g3206413;
        Sat, 9 Mar 2019 12:09:51 -0800
Date:   Sat, 9 Mar 2019 12:09:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b8f7d86b5849ea7bb84bddc0345a3799049764d4@git.kernel.org>
Cc:     ravi.bangoria@linux.ibm.com, acme@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        jonas.rabenstein@studium.uni-erlangen.de, mingo@kernel.org,
        peterz@infradead.org, ak@linux.intel.com, hpa@zytor.com,
        nasastry@in.ibm.com
Reply-To: ravi.bangoria@linux.ibm.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, acme@redhat.com,
          jonas.rabenstein@studium.uni-erlangen.de, mingo@kernel.org,
          jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, nasastry@in.ibm.com, ak@linux.intel.com,
          hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20190305152536.21035-9-jolsa@kernel.org>
References: <20190305152536.21035-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf data: Force perf_data__open|close zero
 data->file.path
Git-Commit-ID: b8f7d86b5849ea7bb84bddc0345a3799049764d4
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

Commit-ID:  b8f7d86b5849ea7bb84bddc0345a3799049764d4
Gitweb:     https://git.kernel.org/tip/b8f7d86b5849ea7bb84bddc0345a3799049764d4
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 5 Mar 2019 16:25:36 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:21:00 -0300

perf data: Force perf_data__open|close zero data->file.path

Making sure the data->file.path is zeroed on perf_data__open error path
and in perf_data__close, so we don't double free it in case someone call
it twice.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190305152536.21035-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 7bd5ddeb7a41..e098e189f93e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -237,7 +237,7 @@ static int open_file(struct perf_data *data)
 	     open_file_read(data) : open_file_write(data);
 
 	if (fd < 0) {
-		free(data->file.path);
+		zfree(&data->file.path);
 		return -1;
 	}
 
@@ -270,7 +270,7 @@ int perf_data__open(struct perf_data *data)
 
 void perf_data__close(struct perf_data *data)
 {
-	free(data->file.path);
+	zfree(&data->file.path);
 	close(data->file.fd);
 }
 
