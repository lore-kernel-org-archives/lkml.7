Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FCAC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B922184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfHZLqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:46:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39574 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfHZLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:46:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2DRQ-0000vQ-A8; Mon, 26 Aug 2019 13:45:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E866A1C0DAE;
        Mon, 26 Aug 2019 13:45:43 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:45:42 -0000
From:   tip-bot2 for Alexander Shishkin <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Clean up ToPA allocation path
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190821124727.73310-2-alexander.shishkin@linux.intel.com>
References: <20190821124727.73310-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156681994258.3120.6665983400581475472.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     90583af61d0c0d2826f42a297a03645b35c49085
Gitweb:        https://git.kernel.org/tip/90583af61d0c0d2826f42a297a03645b35c49085
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Wed, 21 Aug 2019 15:47:22 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Aug 2019 12:00:12 +02:00

perf/x86/intel/pt: Clean up ToPA allocation path

Some of the allocation parameters are passed as function arguments,
while the CPU number for per-cpu allocation is passed via the buffer
object. There's no reason for this.

Pass the CPU as a function argument instead.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20190821124727.73310-2-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/pt.c | 15 +++++++--------
 arch/x86/events/intel/pt.h |  2 --
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index d3dc227..9d9258f 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -670,7 +670,7 @@ static bool topa_table_full(struct topa *topa)
  *
  * Return:	0 on success or error code.
  */
-static int topa_insert_pages(struct pt_buffer *buf, gfp_t gfp)
+static int topa_insert_pages(struct pt_buffer *buf, int cpu, gfp_t gfp)
 {
 	struct topa *topa = buf->last;
 	int order = 0;
@@ -681,7 +681,7 @@ static int topa_insert_pages(struct pt_buffer *buf, gfp_t gfp)
 		order = page_private(p);
 
 	if (topa_table_full(topa)) {
-		topa = topa_alloc(buf->cpu, gfp);
+		topa = topa_alloc(cpu, gfp);
 		if (!topa)
 			return -ENOMEM;
 
@@ -1061,20 +1061,20 @@ static void pt_buffer_fini_topa(struct pt_buffer *buf)
  * @size:	Total size of all regions within this ToPA.
  * @gfp:	Allocation flags.
  */
-static int pt_buffer_init_topa(struct pt_buffer *buf, unsigned long nr_pages,
-			       gfp_t gfp)
+static int pt_buffer_init_topa(struct pt_buffer *buf, int cpu,
+			       unsigned long nr_pages, gfp_t gfp)
 {
 	struct topa *topa;
 	int err;
 
-	topa = topa_alloc(buf->cpu, gfp);
+	topa = topa_alloc(cpu, gfp);
 	if (!topa)
 		return -ENOMEM;
 
 	topa_insert_table(buf, topa);
 
 	while (buf->nr_pages < nr_pages) {
-		err = topa_insert_pages(buf, gfp);
+		err = topa_insert_pages(buf, cpu, gfp);
 		if (err) {
 			pt_buffer_fini_topa(buf);
 			return -ENOMEM;
@@ -1124,13 +1124,12 @@ pt_buffer_setup_aux(struct perf_event *event, void **pages,
 	if (!buf)
 		return NULL;
 
-	buf->cpu = cpu;
 	buf->snapshot = snapshot;
 	buf->data_pages = pages;
 
 	INIT_LIST_HEAD(&buf->tables);
 
-	ret = pt_buffer_init_topa(buf, nr_pages, GFP_KERNEL);
+	ret = pt_buffer_init_topa(buf, cpu, nr_pages, GFP_KERNEL);
 	if (ret) {
 		kfree(buf);
 		return NULL;
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 63fe406..8de8ed0 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -53,7 +53,6 @@ struct pt_pmu {
 /**
  * struct pt_buffer - buffer configuration; one buffer per task_struct or
  *		cpu, depending on perf event configuration
- * @cpu:	cpu for per-cpu allocation
  * @tables:	list of ToPA tables in this buffer
  * @first:	shorthand for first topa table
  * @last:	shorthand for last topa table
@@ -71,7 +70,6 @@ struct pt_pmu {
  * @topa_index:	table of topa entries indexed by page offset
  */
 struct pt_buffer {
-	int			cpu;
 	struct list_head	tables;
 	struct topa		*first, *last, *cur;
 	unsigned int		cur_idx;
