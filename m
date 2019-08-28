Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABC7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A622189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000645;
	bh=XQ/1lKsBUmOIt6R2q4h+t8yBJfuE96XnhEYl1BKEicI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o6jESJbvT5Zmzwxh69t13uvKjYgnIb1OfbnZRxnsxSViLyYup/XsGlgOBsm5gA7yb
	 XllDOfabd/P7GirHJgG3Brsy7gZM9bxiiq6lqlVVUn3RMO/fSW8VUxLsx+XIJseZqH
	 Rtbs5G+EGky2iTv5BWJ71YNzYzGjyUxJSm4V35Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfH1N5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:57:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfH1N5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 526A430842B0;
        Wed, 28 Aug 2019 13:57:22 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB7591001B00;
        Wed, 28 Aug 2019 13:57:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 01/23] libperf: Add PERF_RECORD_HEADER_ATTR 'struct attr_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:56:55 +0200
Message-Id: <20190828135717.7245-2-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 28 Aug 2019 13:57:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_HEADER_ATTR event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-53ciuchxtqxz9kuntcd5vnxx@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 36ad3a4a79e6..bb66da57d366 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -109,4 +109,10 @@ struct perf_record_sample {
 	__u64			 array[];
 };
 
+struct attr_event {
+	struct perf_event_header header;
+	struct perf_event_attr	 attr;
+	__u64			 id[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 429a3fe52d6c..21fa6c2acea4 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -363,12 +363,6 @@ struct cpu_map_event {
 	struct cpu_map_data		data;
 };
 
-struct attr_event {
-	struct perf_event_header header;
-	struct perf_event_attr attr;
-	u64 id[];
-};
-
 enum {
 	PERF_EVENT_UPDATE__UNIT  = 0,
 	PERF_EVENT_UPDATE__SCALE = 1,
-- 
2.21.0

