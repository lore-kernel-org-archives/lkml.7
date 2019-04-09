Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D0C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4020857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554804123;
	bh=+EbZEjv0VmA/3o4iXAsAfIYhp3cC+fB64TrPOz+Cd6o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ja7W9+7ndtasiWBl93VoBPlyfEWvRy8BNHchv0KeEAK5J+M2FhY72OhL045Z5jcIl
	 ja/j8dA5QhjcCaaoeKRopzs6DgYk1UynKC3KDRwGyN49ZoPlVhq+WGzvSg10ebOmNC
	 RLKoS0PAwuWI1pk8Df0d60okS6oc0glPJNzpO3pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfDIKCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:02:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfDIKCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB425301988C;
        Tue,  9 Apr 2019 10:02:00 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.205.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 440ED5D9C9;
        Tue,  9 Apr 2019 10:01:57 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf stat: Disable DIR_FORMAT feature for record
Date:   Tue,  9 Apr 2019 12:01:56 +0200
Message-Id: <20190409100156.20303-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 09 Apr 2019 10:02:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo reported assertion in perf stat record:

  assertion failed at util/header.c:875

There's no support for this in perf state record
command, disabling the feature.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/n/tip-2uhyh815jfwikg5uhve8log6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7f9c4b7f5d69..a3c060878faa 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1322,6 +1322,7 @@ static void init_features(struct perf_session *session)
 	for (feat = HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat++)
 		perf_header__set_feat(&session->header, feat);
 
+	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
 	perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
 	perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
 	perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
-- 
2.17.2

