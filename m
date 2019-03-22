Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03FCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EF12190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfCVV7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:59:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46011 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVV7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:59:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MLwItI744765
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 14:58:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MLwHbT744762;
        Fri, 22 Mar 2019 14:58:17 -0700
Date:   Fri, 22 Mar 2019 14:58:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-d9c1bb2f6a2157b38e8eb63af437cb22701d31ee@git.kernel.org>
Cc:     eranian@google.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com, peterz@infradead.org, jolsa@redhat.com
Reply-To: kan.liang@linux.intel.com, acme@redhat.com, mingo@kernel.org,
          hpa@zytor.com, peterz@infradead.org, jolsa@redhat.com,
          eranian@google.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, tglx@linutronix.de
In-Reply-To: <20190307185233.225521-1-eranian@google.com>
References: <20190307185233.225521-1-eranian@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Restore mmap record type correctly
Git-Commit-ID: d9c1bb2f6a2157b38e8eb63af437cb22701d31ee
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

Commit-ID:  d9c1bb2f6a2157b38e8eb63af437cb22701d31ee
Gitweb:     https://git.kernel.org/tip/d9c1bb2f6a2157b38e8eb63af437cb22701d31ee
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Thu, 7 Mar 2019 10:52:33 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:02 -0300

perf/core: Restore mmap record type correctly

On mmap(), perf_events generates a RECORD_MMAP record and then checks
which events are interested in this record. There are currently 2
versions of mmap records: RECORD_MMAP and RECORD_MMAP2. MMAP2 is larger.
The event configuration controls which version the user level tool
accepts.

If the event->attr.mmap2=1 field then MMAP2 record is returned.  The
perf_event_mmap_output() takes care of this. It checks attr->mmap2 and
corrects the record fields before putting it in the sampling buffer of
the event.  At the end the function restores the modified MMAP record
fields.

The problem is that the function restores the size but not the type.
Thus, if a subsequent event only accepts MMAP type, then it would
instead receive an MMAP2 record with a size of MMAP record.

This patch fixes the problem by restoring the record type on exit.

Signed-off-by: Stephane Eranian <eranian@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Fixes: 13d7a2410fa6 ("perf: Add attr->mmap2 attribute to an event")
Link: http://lkml.kernel.org/r/20190307185233.225521-1-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fb27b564730..514b8e014a2d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7189,6 +7189,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int size = mmap_event->event_id.header.size;
+	u32 type = mmap_event->event_id.header.type;
 	int ret;
 
 	if (!perf_event_mmap_match(event, data))
@@ -7232,6 +7233,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	perf_output_end(&handle);
 out:
 	mmap_event->event_id.header.size = size;
+	mmap_event->event_id.header.type = type;
 }
 
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
