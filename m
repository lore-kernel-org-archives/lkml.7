Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FEB20848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551799566;
	bh=IAXYBMiCCai2LS9MFgEROxIiTLQmge00fOtaWD2sg0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fr1Hqw8QpN+5fzKRAsgWfel20OBDqaULPOJHq43dvD4B1ueoAwbJ5E0P2bXSQjBjE
	 YajUX6hlvo5WPgZs9bUZAREiGRSFnA82TlLcxI8AjBDz43i5vV268/rduBFE1mSMDo
	 Qgqe2m9X04bIV52Zx8G3DLMVp2MX+Yr/rSJIY3rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfCEP0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:26:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbfCEP0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:26:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E98730833C5;
        Tue,  5 Mar 2019 15:26:00 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC1951001DF0;
        Tue,  5 Mar 2019 15:25:57 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 8/8] perf tools: Force perf_data__open|close zero data->file.path
Date:   Tue,  5 Mar 2019 16:25:36 +0100
Message-Id: <20190305152536.21035-9-jolsa@kernel.org>
In-Reply-To: <20190305152536.21035-1-jolsa@kernel.org>
References: <20190305152536.21035-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 05 Mar 2019 15:26:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making sure the data->file.path is zeroed on perf_data__open
error path and in perf_data__close, so we don't double free
it in case someone call it twice.

Link: http://lkml.kernel.org/n/tip-yt0yz1y9h5vdppsj8nkiuh07@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
 
-- 
2.17.2

