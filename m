Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47CBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC272189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000714;
	bh=IM9pceEfeC+YysU0Yc/dlkOsFeO34RQg9zeWxZsuMkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YRzcK+CcdjlXMgHsl9jaKXtfXkWeJ6EvSUBo3RA5iWNxsvIUPMFZOux9AwbWvMdFH
	 XcuwIRDkEmGqinir7pJM4NNFhRyFbhZuom1puNSj7E5M2kiaqiDMsjZNXM+wDDC9UK
	 xl7yWAAaeSnKCSRpL1D1U5otgM6twYj1ghZdxp/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfH1N6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:58:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbfH1N6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:58:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDEBF356F9;
        Wed, 28 Aug 2019 13:58:03 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 243241001B05;
        Wed, 28 Aug 2019 13:58:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 20/23] libperf: Add PERF_RECORD_COMPRESSED 'struct compressed_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:14 +0200
Message-Id: <20190828135717.7245-21-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 28 Aug 2019 13:58:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_COMPRESSED event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-czl9nuv0c9tpdkzby92lxii1@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 5 +++++
 tools/perf/util/event.h             | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ed1c22e650e2..ef7a46e82a6d 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -318,4 +318,9 @@ struct feature_event {
 	char			 data[];
 };
 
+struct compressed_event {
+	struct perf_event_header header;
+	char			 data[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 94777ee435c2..ee2ee23e4c46 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,11 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-struct compressed_event {
-	struct perf_event_header	header;
-	char				data[];
-};
-
 union perf_event {
 	struct perf_event_header	header;
 	struct perf_record_mmap		mmap;
-- 
2.21.0

