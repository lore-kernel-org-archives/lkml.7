Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064E8C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DE4206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfD0PQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:16:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33938 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727586AbfD0PPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:34 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP35-0000z8-CE; Sat, 27 Apr 2019 16:15:31 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004Vh-BE; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Julien Thierry" <julien.thierry@arm.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.324569248@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 091/202] perf/core: Don't WARN() for impossible
 ring-buffer sizes
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 9dff0aa95a324e262ffb03f425d00e4751f3294e upstream.

The perf tool uses /proc/sys/kernel/perf_event_mlock_kb to determine how
large its ringbuffer mmap should be. This can be configured to arbitrary
values, which can be larger than the maximum possible allocation from
kmalloc.

When this is configured to a suitably large value (e.g. thanks to the
perf fuzzer), attempting to use perf record triggers a WARN_ON_ONCE() in
__alloc_pages_nodemask():

   WARNING: CPU: 2 PID: 5666 at mm/page_alloc.c:4511 __alloc_pages_nodemask+0x3f8/0xbc8

Let's avoid this by checking that the requested allocation is possible
before calling kzalloc.

Reported-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190110142745.25495-1-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/events/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -282,6 +282,9 @@ struct ring_buffer *rb_alloc(int nr_page
 	size = sizeof(struct ring_buffer);
 	size += nr_pages * sizeof(void *);
 
+	if (order_base_2(size) >= MAX_ORDER)
+		goto fail;
+
 	rb = kzalloc(size, GFP_KERNEL);
 	if (!rb)
 		goto fail;

