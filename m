Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EC2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5E420821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555430502;
	bh=fa+Wq+ZI19E4co8NlRyWoHnj5Las2q/r+4tUqv/fI/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ngEVG+SpP6iKCFlq7NDx8sX9zgk3lgau3Z/BMQSuei/f33VdUQ3Vks1+WcHWEeeGU
	 AhmTcsitgYJ5EloD9EOmrAG/1Y1AyI+j1bHJK3PLeN2zJ48Gbo8SFCVjTVb/fsZbXt
	 IqVIMjIOyuTjmIBP6L2eQiNfH9Zem5QOmMZecE9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfDPQBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfDPQBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:01:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76F9B3092676;
        Tue, 16 Apr 2019 16:01:39 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A9DA5D71B;
        Tue, 16 Apr 2019 16:01:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 01/12] perf tools: Separate generic code in dso__data_file_size
Date:   Tue, 16 Apr 2019 18:01:16 +0200
Message-Id: <20190416160127.30203-2-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-1-jolsa@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 16 Apr 2019 16:01:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving file specific code in dso__data_file_size function
into separate file_size function. I'll add bpf specific
code in following patches.

Link: http://lkml.kernel.org/n/tip-rkcsft4a0f8sw33p67llxf0d@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
@@ -938,6 +932,17 @@ int dso__data_file_size(struct dso *dso, struct machine *machine)
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
-- 
2.17.2

