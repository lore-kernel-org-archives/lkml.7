Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458C1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1536025706
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X6gOyY60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfE3IIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:08:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56423 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbfE3IIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:08:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U88Na72903745
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:08:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U88Na72903745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203704;
        bh=QW8/f4d3cLkTpwgLPVjEsGLmjMBqUMMP9MYJKTbMTIw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=X6gOyY60kxMfoyjTJVwfmAADMG5vNoNcjjUBdE4g8ZlZmpSy4nVLyiE8L5thoQtSo
         SeuPjcK4Uz4xUE+VD/UMhOP0q/jsrpQsmKIIQTykH0N5mlMcsabILoUQbo54kulp5w
         DleBtNnpIJy3pqDP5hXR+p+1uYE1NAeZRjkxZ8PZ5iU5cAtVoVgDQtBQCxxagW7Znl
         z+TdxrGL7sIp8kKg9/Ci6Z9pQe9Fs7fMzwHzW7DwBR2OFWXOuFlvoCW+0DcaHXkFnA
         eCQ3NIiaNw8wIT4lwAQHt5wXqJDX8lpzaQBplAIOcIzySQ+kHsA7ehC1wfUYCZJaHZ
         aiZdiYyCstCHg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U88N8Y2903742;
        Thu, 30 May 2019 01:08:23 -0700
Date:   Thu, 30 May 2019 01:08:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5523769ee15f27a1bc2009346736b22cb907bff8@git.kernel.org>
Cc:     sdf@google.com, acme@redhat.com, adrian.hunter@intel.com,
        peterz@infradead.org, songliubraving@fb.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        ak@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: sdf@google.com, adrian.hunter@intel.com, peterz@infradead.org,
          songliubraving@fb.com, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, acme@redhat.com, jolsa@kernel.org,
          ak@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com
In-Reply-To: <20190508132010.14512-2-jolsa@kernel.org>
References: <20190508132010.14512-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf dso: Separate generic code in
 dso__data_file_size()
Git-Commit-ID: 5523769ee15f27a1bc2009346736b22cb907bff8
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

Commit-ID:  5523769ee15f27a1bc2009346736b22cb907bff8
Gitweb:     https://git.kernel.org/tip/5523769ee15f27a1bc2009346736b22cb907bff8
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:19:59 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf dso: Separate generic code in dso__data_file_size()

Moving file specific code in dso__data_file_size function into separate
file_size function. I'll add bpf specific code in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e059976d9d93..cb6199c1390a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -898,18 +898,12 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
 	return r;
 }
 
-int dso__data_file_size(struct dso *dso, struct machine *machine)
+static int file_size(struct dso *dso, struct machine *machine)
 {
 	int ret = 0;
 	struct stat st;
 	char sbuf[STRERR_BUFSIZE];
 
-	if (dso->data.file_size)
-		return 0;
-
-	if (dso->data.status == DSO_DATA_STATUS_ERROR)
-		return -1;
-
 	pthread_mutex_lock(&dso__data_open_lock);
 
 	/*
@@ -938,6 +932,17 @@ out:
 	return ret;
 }
 
+int dso__data_file_size(struct dso *dso, struct machine *machine)
+{
+	if (dso->data.file_size)
+		return 0;
+
+	if (dso->data.status == DSO_DATA_STATUS_ERROR)
+		return -1;
+
+	return file_size(dso, machine);
+}
+
 /**
  * dso__data_size - Return dso data size
  * @dso: dso object
