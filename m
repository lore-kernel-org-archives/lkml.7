Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3CDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4042E2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980838;
	bh=UC/A8hwML17cSvKT6ohKHKO4g5rz9Rgs+JxWyc8vp3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jhqY6xJoM7AO+Mm9Wq7JoF2BbOgFssGh9PDYZ89MU81SrBzZwDg70R6xoWn0NXm5N
	 mEMfmsqAhG/pFUw14c6nHfVRFvnH0g+hQZaZ6nVJbfCXNs4RClU0SOR4LGQgpXeNxR
	 JGGiKElNFvDrc6XwlBo52GZTrpbpWb/E7ikfWrk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCGRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:47:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfCGRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:47:14 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB8320661;
        Thu,  7 Mar 2019 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980833;
        bh=UC/A8hwML17cSvKT6ohKHKO4g5rz9Rgs+JxWyc8vp3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1bQHTUBeem6bNiK+KRvwlWYOIgiiX0MhPs7OTTFwc9VEDv2HkoWZSPQDPgxBVaj94
         XyY277QxlgYqsJBYqAM1Aovm/TsX+Y6CliKM96sBR4wSI61zspDnG+PrmCdWiGQgzU
         daBsLenZ+tuY7RU4IbwdIlIqo1QHNwIrFKcY2v1M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/35] perf session: Fix double free in perf_data__close
Date:   Thu,  7 Mar 2019 14:44:32 -0300
Message-Id: <20190307174433.28819-35-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.20.1

