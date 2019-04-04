Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAD6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7267920820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369289;
	bh=XHJ0DU5CWmwjznxgckOjOn+LvoXGnwnYLccTnUDrCAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HrUrol9Y7OC3mSzTPg2mRylvQ5B5BSnSuP/jdlpgdepFLA5+fFUY+6gy27+RfPilC
	 My+JJC1mxPlHB3bFB+f4yFKxrpjm5PhtJD0tAeGGFJEneORJSNmXOVEFQNfaLa+Cwu
	 y9JXUxFP0HX235X0hmYwqR0o6r6xjJvLZo0ent3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfDDJOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733160AbfDDJOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A67A12147C;
        Thu,  4 Apr 2019 09:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369285;
        bh=XHJ0DU5CWmwjznxgckOjOn+LvoXGnwnYLccTnUDrCAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7CEPBXEhZBy0cqegUWQ+cG2Styo4fXmlnYVfG/VtK2jhRcVbohBn+Krn/cQy9t4q
         575cvozP8WfEcGUrAapi6zWHXeAcOLcuumvEUbCUXJmZdAiToeUfmhMHkxMuO8B9Tc
         N+rAHRu72CtQoJTqsd/oRriTp8rSdbOg+u5GtJmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 166/246] perf/aux: Make perf_event accessible to setup_aux()
Date:   Thu,  4 Apr 2019 10:47:46 +0200
Message-Id: <20190404084624.984808131@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 840018668ce2d96783356204ff282d6c9b0e5f66 ]

When pmu::setup_aux() is called the coresight PMU needs to know which
sink to use for the session by looking up the information in the
event's attr::config2 field.

As such simply replace the cpu information by the complete perf_event
structure and change all affected customers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki Poulouse <suzuki.poulose@arm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Link: http://lkml.kernel.org/r/20190131184714.20388-2-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c                  | 6 +++---
 arch/x86/events/intel/bts.c                      | 4 +++-
 arch/x86/events/intel/pt.c                       | 5 +++--
 drivers/hwtracing/coresight/coresight-etm-perf.c | 6 +++---
 drivers/perf/arm_spe_pmu.c                       | 6 +++---
 include/linux/perf_event.h                       | 2 +-
 kernel/events/ring_buffer.c                      | 2 +-
 7 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index bfabeb1889cc..1266194afb02 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1600,7 +1600,7 @@ static void aux_sdb_init(unsigned long sdb)
 
 /*
  * aux_buffer_setup() - Setup AUX buffer for diagnostic mode sampling
- * @cpu:	On which to allocate, -1 means current
+ * @event:	Event the buffer is setup for, event->cpu == -1 means current
  * @pages:	Array of pointers to buffer pages passed from perf core
  * @nr_pages:	Total pages
  * @snapshot:	Flag for snapshot mode
@@ -1612,8 +1612,8 @@ static void aux_sdb_init(unsigned long sdb)
  *
  * Return the private AUX buffer structure if success or NULL if fails.
  */
-static void *aux_buffer_setup(int cpu, void **pages, int nr_pages,
-			      bool snapshot)
+static void *aux_buffer_setup(struct perf_event *event, void **pages,
+			      int nr_pages, bool snapshot)
 {
 	struct sf_buffer *sfb;
 	struct aux_buffer *aux;
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index a01ef1b0f883..7cdd7b13bbda 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -77,10 +77,12 @@ static size_t buf_size(struct page *page)
 }
 
 static void *
-bts_buffer_setup_aux(int cpu, void **pages, int nr_pages, bool overwrite)
+bts_buffer_setup_aux(struct perf_event *event, void **pages,
+		     int nr_pages, bool overwrite)
 {
 	struct bts_buffer *buf;
 	struct page *page;
+	int cpu = event->cpu;
 	int node = (cpu == -1) ? cpu : cpu_to_node(cpu);
 	unsigned long offset;
 	size_t size = nr_pages << PAGE_SHIFT;
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 9494ca68fd9d..c0e86ff21f81 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1114,10 +1114,11 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, unsigned long nr_pages,
  * Return:	Our private PT buffer structure.
  */
 static void *
-pt_buffer_setup_aux(int cpu, void **pages, int nr_pages, bool snapshot)
+pt_buffer_setup_aux(struct perf_event *event, void **pages,
+		    int nr_pages, bool snapshot)
 {
 	struct pt_buffer *buf;
-	int node, ret;
+	int node, ret, cpu = event->cpu;
 
 	if (!nr_pages)
 		return NULL;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index abe8249b893b..f21eb28b6782 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -177,15 +177,15 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
-static void *etm_setup_aux(int event_cpu, void **pages,
+static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
-	int cpu;
+	int cpu = event->cpu;
 	cpumask_t *mask;
 	struct coresight_device *sink;
 	struct etm_event_data *event_data = NULL;
 
-	event_data = alloc_event_data(event_cpu);
+	event_data = alloc_event_data(cpu);
 	if (!event_data)
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 8e46a9dad2fa..7cb766dafe85 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -824,10 +824,10 @@ static void arm_spe_pmu_read(struct perf_event *event)
 {
 }
 
-static void *arm_spe_pmu_setup_aux(int cpu, void **pages, int nr_pages,
-				   bool snapshot)
+static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
+				   int nr_pages, bool snapshot)
 {
-	int i;
+	int i, cpu = event->cpu;
 	struct page **pglist;
 	struct arm_spe_pmu_buf *buf;
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e1a051724f7e..7cbbd891bfcd 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -409,7 +409,7 @@ struct pmu {
 	/*
 	 * Set up pmu-private data structures for an AUX area
 	 */
-	void *(*setup_aux)		(int cpu, void **pages,
+	void *(*setup_aux)		(struct perf_event *event, void **pages,
 					 int nr_pages, bool overwrite);
 					/* optional */
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5ab4fe3b1dcc..878c62ec0190 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -658,7 +658,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 			goto out;
 	}
 
-	rb->aux_priv = event->pmu->setup_aux(event->cpu, rb->aux_pages, nr_pages,
+	rb->aux_priv = event->pmu->setup_aux(event, rb->aux_pages, nr_pages,
 					     overwrite);
 	if (!rb->aux_priv)
 		goto out;
-- 
2.19.1



