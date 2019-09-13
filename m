Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80729C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5132820640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381197;
	bh=tfZXGUlkDbJzY4S23vpohfcmFv9jJaIhF1fH22oJYzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G+ButRcTA44965u7VvcZMs4WFotYKvRMf5mb7Jl4kDY5uyrTDg/xBEJ490ZIb8bIX
	 qTv5Yq2kPWPx/+Clde7DRCELmNfztoNe/01qCMBOEzeS0cgAHvtM2/w3y74F2c9VXY
	 ImJROgEEJZd/hjWp9OznHzkctKMtjtQDna3UlBh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391573AbfIMN0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390232AbfIMN0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 769E151EE6;
        Fri, 13 Sep 2019 13:26:33 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D32005C219;
        Fri, 13 Sep 2019 13:26:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 64/73] libperf: Call perf_evlist__munmap/close on perf_evlist__delete
Date:   Fri, 13 Sep 2019 15:23:46 +0200
Message-Id: <20190913132355.21634-65-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 13 Sep 2019 13:26:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let perf_evlist__delete do all the necessary cleanup.

All the cleanup functions check if the their data is
created before cleaning it up, so it's ok to call any
of them separately before perf_evlist__delete.

Link: http://lkml.kernel.org/n/tip-9l1dsswu6rkejfbjg9zm4dld@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 1c8a9e283adc..8920833afa9e 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -132,6 +132,11 @@ void perf_evlist__exit(struct perf_evlist *evlist)
 
 void perf_evlist__delete(struct perf_evlist *evlist)
 {
+	if (evlist == NULL)
+		return;
+
+	perf_evlist__munmap(evlist);
+	perf_evlist__close(evlist);
 	perf_evlist__purge(evlist);
 	perf_evlist__exit(evlist);
 	free(evlist);
-- 
2.21.0

