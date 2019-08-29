Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EDFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A2423428
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089679;
	bh=mNg3ZVNRFs/cRdkBA7eEvw3ckJ6vB0AqJNYhHUeML5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KKtgGIKnYqY5VSLFFgP29GJyndqwVgwQR2m6edkHofBTqELnenfMrKGPZ4i8MUqHr
	 L8C+JNQ/b/ZCl2BKJdG0SfEx7CHmsiVLDwW8fvEJOuOjs93WE+r7/aP8V7SQEhxZcG
	 yaXyvYAnUIUj+twSQ2u7T7/jw2jaIvQ1htemaA3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfH2OlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbfH2OlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:41:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FC6022CED;
        Thu, 29 Aug 2019 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089675;
        bh=mNg3ZVNRFs/cRdkBA7eEvw3ckJ6vB0AqJNYhHUeML5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCMpu9iMBnxCFjFyn0TjyKLKhviXhHOvI0UqtUO+X6XQ+RtPufnRQbH8acyPZBtze
         W58Hh62yntT7E/F8xEUfUj2EDk4TeBar3l4y/Q/xc6bJu1KbQL3G0AjEI/eB5T0FdU
         feHGcBz9d+rToHq9gNcz/99+16HkZVPZHajVpv8I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/37] libperf: Add PERF_RECORD_COMPRESSED 'struct compressed_event' to perf/event.h
Date:   Thu, 29 Aug 2019 11:39:11 -0300
Message-Id: <20190829143917.29745-32-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the PERF_RECORD_COMPRESSED event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-21-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

