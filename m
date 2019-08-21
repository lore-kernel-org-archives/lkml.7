Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B67EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7A82089E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfHUMsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:48:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:30844 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfHUMsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:48:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="207724892"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2019 05:48:03 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v0 1/6] perf/x86/intel/pt: Clean up ToPA allocation path
Date:   Wed, 21 Aug 2019 15:47:22 +0300
Message-Id: <20190821124727.73310-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
References: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the allocation parameters are passed as function arguments,
while the CPU number for per-cpu allocation is passed via the buffer
object. There's no reason for this.

Pass the CPU as a function argument instead.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 15 +++++++--------
 arch/x86/events/intel/pt.h |  2 --
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index a7318c29242e..b029f32edae2 100644
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
index 63fe4063fbd6..8de8ed089697 100644
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
-- 
2.23.0.rc1

