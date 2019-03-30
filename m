Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C341C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D549217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907457;
	bh=KRxjBywvRr6w3hN7I+Akccm3xYsi0gT6nZakM0G78BY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=F4CNpKhKWxM3lSkdbaY4Vew052tcSkfO/tVJ4IuPeD7L4w/es85JeOoA+z6JN4A+Y
	 mQOl1QjxZTKq5RoIr7ordPgg0S899zKWWWC+vOY4uqhuIzNjGEazR0GSjJck9GbSGC
	 WwdsZ58gpWZuHiOvLr9m2TI+bifla0dpvYG6T980=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfC3A5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731765AbfC3A5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:57:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC902064A;
        Sat, 30 Mar 2019 00:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907453;
        bh=KRxjBywvRr6w3hN7I+Akccm3xYsi0gT6nZakM0G78BY=;
        h=From:To:Cc:Subject:Date:From;
        b=ACLCdR8n5WDG5rld2fh7u1CogMnHMBM4qQhJyrMpkyWzuRzJxoLQ6e0hyl+YucA6X
         BoQgjl5/xl18/ZT8LwNQ8K3CCIkxXaX7OEn88Hr8jNEiy5E05mYnJ/eB9ZaVzzbPx3
         aXbQpFOpGyj0y9s4XbSiAqRuKSp2eN2F3o/h3tjw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 01/15] perf/core: Restore mmap record type correctly
Date:   Fri, 29 Mar 2019 20:57:16 -0400
Message-Id: <20190330005730.28777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

[ Upstream commit d9c1bb2f6a2157b38e8eb63af437cb22701d31ee ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fd8dea2b36ec..41d83a9aacaf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5533,6 +5533,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int size = mmap_event->event_id.header.size;
+	u32 type = mmap_event->event_id.header.type;
 	int ret;
 
 	if (!perf_event_mmap_match(event, data))
@@ -5576,6 +5577,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	perf_output_end(&handle);
 out:
 	mmap_event->event_id.header.size = size;
+	mmap_event->event_id.header.type = type;
 }
 
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
-- 
2.19.1

