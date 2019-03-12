Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA95C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A99721734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356142;
	bh=j/Ni8uPUl8DiPELyPg0Mc5kxmHEnHl2PYYBfQTR6zmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Anbp9lhnHwtm7ct4D2Q4pU6cA0Ab6+McZCQUpp5b1vqllS9A+9HZ12a+vysmfpY+8
	 b09OVzfpc6e4Dn8zalQGm+YgF2PTgmbIQiOVxyigghgQpOuMnb4H6oM2VudOa7yW3h
	 +rNEPlf4v8J/MWQzCg8vPAtMzJTy5IAzd470QoEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCLCCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfCLCCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:02:18 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B151F214AF;
        Tue, 12 Mar 2019 02:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356137;
        bh=j/Ni8uPUl8DiPELyPg0Mc5kxmHEnHl2PYYBfQTR6zmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQmwQQvy6yMQQ+H3BCZlNX4NrP3lEnv7aSZIvbmmyY3HGq9uYUC0yHKxTPV2EF1wE
         EsR0HG/04YpF5Njj7nokTYzK0Gm7RfZLXjXDQ+FS03gPkPjDGBkMaVjUmnPCJ1b4WL
         j5vUqvp28hru7/mBO40sxYBTuzwZXBemXgbcpbdU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/30] perf/core: Restore mmap record type correctly
Date:   Mon, 11 Mar 2019 23:01:35 -0300
Message-Id: <20190312020204.22092-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

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
-- 
2.20.1

