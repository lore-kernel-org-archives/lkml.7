Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA98C04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8FD255E2
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfFDCZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 22:25:17 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55500 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbfFDCZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 22:25:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.235987-0.0191047-0.744908;FP=15482037039677506937|2|2|3|0|-1|-1|-1;HT=e02c03267;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Eh74quv_1559615108;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.Eh74quv_1559615108)
          by smtp.aliyun-inc.com(10.147.42.16);
          Tue, 04 Jun 2019 10:25:08 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V4 3/6] csky: Add pmu interrupt support
Date:   Tue,  4 Jun 2019 10:23:57 +0800
Message-Id: <c4c5ff7a919cb00e51edb36e66185e487fb54a7f.1559614824.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559614824.git.han_mao@c-sky.com>
References: <cover.1559614824.git.han_mao@c-sky.com>
In-Reply-To: <cover.1559614824.git.han_mao@c-sky.com>
References: <cover.1559614824.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add interrupt request and handler for csky pmu.
perf can record on hardware event with this patch applied.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Guo Ren <guoren@kernel.org>
---
 arch/csky/kernel/perf_event.c | 292 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 276 insertions(+), 16 deletions(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 36f7f20..af09885 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -11,18 +11,50 @@
 #define CSKY_PMU_MAX_EVENTS 32
 #define DEFAULT_COUNT_WIDTH 48
 
-#define HPCR		"<0, 0x0>"	/* PMU Control reg */
-#define HPCNTENR	"<0, 0x4>"	/* Count Enable reg */
+#define HPCR		"<0, 0x0>"      /* PMU Control reg */
+#define HPSPR		"<0, 0x1>"      /* Start PC reg */
+#define HPEPR		"<0, 0x2>"      /* End PC reg */
+#define HPSIR		"<0, 0x3>"      /* Soft Counter reg */
+#define HPCNTENR	"<0, 0x4>"      /* Count Enable reg */
+#define HPINTENR	"<0, 0x5>"      /* Interrupt Enable reg */
+#define HPOFSR		"<0, 0x6>"      /* Interrupt Status reg */
+
+/* The events for a given PMU register set. */
+struct pmu_hw_events {
+	/*
+	 * The events that are active on the PMU for the given index.
+	 */
+	struct perf_event *events[CSKY_PMU_MAX_EVENTS];
+
+	/*
+	 * A 1 bit for an index indicates that the counter is being used for
+	 * an event. A 0 means that the counter can be used.
+	 */
+	unsigned long used_mask[BITS_TO_LONGS(CSKY_PMU_MAX_EVENTS)];
+
+	/*
+	 * Hardware lock to serialize accesses to PMU registers. Needed for the
+	 * read/modify/write sequences.
+	 */
+	raw_spinlock_t pmu_lock;
+};
 
 static uint64_t (*hw_raw_read_mapping[CSKY_PMU_MAX_EVENTS])(void);
 static void (*hw_raw_write_mapping[CSKY_PMU_MAX_EVENTS])(uint64_t val);
 
 struct csky_pmu_t {
-	struct pmu	pmu;
-	uint32_t	count_width;
-	uint32_t	hpcr;
+	struct pmu			pmu;
+	irqreturn_t			(*handle_irq)(int irq_num);
+	void				(*reset)(void *info);
+	struct pmu_hw_events __percpu	*hw_events;
+	struct platform_device		*plat_device;
+	uint32_t			count_width;
+	uint32_t			hpcr;
+	u64				max_period;
 } csky_pmu;
+static int csky_pmu_irq;
 
+#define to_csky_pmu(p)  (container_of(p, struct csky_pmu, pmu))
 typedef int (*csky_pmu_init)(struct csky_pmu_t *);
 
 #define cprgr(reg)				\
@@ -804,6 +836,51 @@ static const int csky_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	},
 };
 
+int  csky_pmu_event_set_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left = local64_read(&hwc->period_left);
+	s64 period = hwc->sample_period;
+	int ret = 0;
+
+	if (unlikely(left <= -period)) {
+		left = period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (unlikely(left <= 0)) {
+		left += period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (left > (s64)csky_pmu.max_period)
+		left = csky_pmu.max_period;
+
+	/* Interrupt may lose when period is too small. */
+	if (left < 10)
+		left = 10;
+
+	/*
+	 * The hw event starts counting from this event offset,
+	 * mark it to be able to extract future "deltas":
+	 */
+	local64_set(&hwc->prev_count, (u64)(-left));
+
+	if (hw_raw_write_mapping[hwc->idx] != NULL)
+		hw_raw_write_mapping[hwc->idx]((u64)(-left) &
+						csky_pmu.max_period);
+
+	cpwcr(HPOFSR, ~BIT(hwc->idx) & cprcr(HPOFSR));
+
+	perf_event_update_userpage(event);
+
+	return ret;
+}
+
 static void csky_perf_event_update(struct perf_event *event,
 				   struct hw_perf_event *hwc)
 {
@@ -825,6 +902,11 @@ static void csky_perf_event_update(struct perf_event *event,
 	local64_sub(delta, &hwc->period_left);
 }
 
+static void csky_pmu_reset(void *info)
+{
+	cpwcr(HPCR, BIT(31) | BIT(30) | BIT(1));
+}
+
 static void csky_pmu_read(struct perf_event *event)
 {
 	csky_perf_event_update(event, &event->hw);
@@ -901,7 +983,9 @@ static void csky_pmu_disable(struct pmu *pmu)
 
 static void csky_pmu_start(struct perf_event *event, int flags)
 {
+	unsigned long irq_flags;
 	struct hw_perf_event *hwc = &event->hw;
+	struct pmu_hw_events *events = this_cpu_ptr(csky_pmu.hw_events);
 	int idx = hwc->idx;
 
 	if (WARN_ON_ONCE(idx == -1))
@@ -912,16 +996,35 @@ static void csky_pmu_start(struct perf_event *event, int flags)
 
 	hwc->state = 0;
 
+	csky_pmu_event_set_period(event);
+
+	raw_spin_lock_irqsave(&events->pmu_lock, irq_flags);
+
+	cpwcr(HPINTENR, BIT(idx) | cprcr(HPINTENR));
 	cpwcr(HPCNTENR, BIT(idx) | cprcr(HPCNTENR));
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, irq_flags);
 }
 
-static void csky_pmu_stop(struct perf_event *event, int flags)
+static void csky_pmu_stop_event(struct perf_event *event)
 {
+	unsigned long irq_flags;
 	struct hw_perf_event *hwc = &event->hw;
+	struct pmu_hw_events *events = this_cpu_ptr(csky_pmu.hw_events);
 	int idx = hwc->idx;
 
+	raw_spin_lock_irqsave(&events->pmu_lock, irq_flags);
+
+	cpwcr(HPINTENR, ~BIT(idx) & cprcr(HPINTENR));
+	cpwcr(HPCNTENR, ~BIT(idx) & cprcr(HPCNTENR));
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, irq_flags);
+}
+
+static void csky_pmu_stop(struct perf_event *event, int flags)
+{
 	if (!(event->hw.state & PERF_HES_STOPPED)) {
-		cpwcr(HPCNTENR, ~BIT(idx) & cprcr(HPCNTENR));
+		csky_pmu_stop_event(event);
 		event->hw.state |= PERF_HES_STOPPED;
 	}
 
@@ -934,7 +1037,11 @@ static void csky_pmu_stop(struct perf_event *event, int flags)
 
 static void csky_pmu_del(struct perf_event *event, int flags)
 {
+	struct pmu_hw_events *hw_events = this_cpu_ptr(csky_pmu.hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+
 	csky_pmu_stop(event, PERF_EF_UPDATE);
+	hw_events->events[hwc->idx] = NULL;
 
 	perf_event_update_userpage(event);
 }
@@ -942,12 +1049,10 @@ static void csky_pmu_del(struct perf_event *event, int flags)
 /* allocate hardware counter and optionally start counting */
 static int csky_pmu_add(struct perf_event *event, int flags)
 {
+	struct pmu_hw_events *hw_events = this_cpu_ptr(csky_pmu.hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
-	local64_set(&hwc->prev_count, 0);
-
-	if (hw_raw_write_mapping[hwc->idx] != NULL)
-		hw_raw_write_mapping[hwc->idx](0);
+	hw_events->events[hwc->idx] = event;
 
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 	if (flags & PERF_EF_START)
@@ -958,8 +1063,118 @@ static int csky_pmu_add(struct perf_event *event, int flags)
 	return 0;
 }
 
+static irqreturn_t csky_pmu_handle_irq(int irq_num)
+{
+	struct perf_sample_data data;
+	struct pmu_hw_events *cpuc = this_cpu_ptr(csky_pmu.hw_events);
+	struct pt_regs *regs;
+	int idx;
+
+	/*
+	 * Did an overflow occur?
+	 */
+	if (!cprcr(HPOFSR))
+		return IRQ_NONE;
+
+	/*
+	 * Handle the counter(s) overflow(s)
+	 */
+	regs = get_irq_regs();
+
+	csky_pmu_disable(&csky_pmu.pmu);
+	for (idx = 0; idx < CSKY_PMU_MAX_EVENTS; ++idx) {
+		struct perf_event *event = cpuc->events[idx];
+		struct hw_perf_event *hwc;
+
+		/* Ignore if we don't have an event. */
+		if (!event)
+			continue;
+		/*
+		 * We have a single interrupt for all counters. Check that
+		 * each counter has overflowed before we process it.
+		 */
+		if (!(cprcr(HPOFSR) & 1 << idx))
+			continue;
+
+		hwc = &event->hw;
+		csky_perf_event_update(event, &event->hw);
+		perf_sample_data_init(&data, 0, hwc->last_period);
+		csky_pmu_event_set_period(event);
+
+		if (perf_event_overflow(event, &data, regs))
+			csky_pmu_stop_event(event);
+	}
+	csky_pmu_enable(&csky_pmu.pmu);
+	/*
+	 * Handle the pending perf events.
+	 *
+	 * Note: this call *must* be run with interrupts disabled. For
+	 * platforms that can have the PMU interrupts raised as an NMI, this
+	 * will not work.
+	 */
+	irq_work_run();
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t csky_pmu_dispatch_irq(int irq, void *dev)
+{
+	int ret;
+
+	ret = csky_pmu.handle_irq(irq);
+
+	return ret;
+}
+
+static int csky_pmu_request_irq(irq_handler_t handler)
+{
+	int err, irq, irqs;
+	struct platform_device *pmu_device = csky_pmu.plat_device;
+
+	if (!pmu_device)
+		return -ENODEV;
+
+	irqs = min(pmu_device->num_resources, num_possible_cpus());
+	if (irqs < 1) {
+		pr_err("no irqs for PMUs defined\n");
+		return -ENODEV;
+	}
+
+	irq = platform_get_irq(pmu_device, 0);
+	if (irq < 0)
+		return -ENODEV;
+	err = request_percpu_irq(irq, handler, "csky-pmu",
+				 this_cpu_ptr(csky_pmu.hw_events));
+	if (err) {
+		pr_err("unable to request IRQ%d for CSKY PMU counters\n",
+		       irq);
+		return err;
+	}
+
+	return 0;
+}
+
+static void csky_pmu_free_irq(void)
+{
+	int irq;
+	struct platform_device *pmu_device = csky_pmu.plat_device;
+
+	irq = platform_get_irq(pmu_device, 0);
+	if (irq >= 0)
+		free_percpu_irq(irq, this_cpu_ptr(csky_pmu.hw_events));
+}
+
 int __init init_hw_perf_events(void)
 {
+	int cpu;
+
+	csky_pmu.hw_events = alloc_percpu_gfp(struct pmu_hw_events,
+					      GFP_KERNEL);
+	if (!csky_pmu.hw_events) {
+		pr_info("failed to allocate per-cpu PMU data.\n");
+		return -ENOMEM;
+	}
+
 	csky_pmu.pmu = (struct pmu) {
 		.pmu_enable	= csky_pmu_enable,
 		.pmu_disable	= csky_pmu_disable,
@@ -971,6 +1186,16 @@ int __init init_hw_perf_events(void)
 		.read		= csky_pmu_read,
 	};
 
+	csky_pmu.handle_irq = csky_pmu_handle_irq;
+	csky_pmu.reset = csky_pmu_reset;
+
+	for_each_possible_cpu(cpu) {
+		struct pmu_hw_events *events;
+
+		events = per_cpu_ptr(csky_pmu.hw_events, cpu);
+		raw_spin_lock_init(&events->pmu_lock);
+	}
+
 	memset((void *)hw_raw_read_mapping, 0,
 		sizeof(hw_raw_read_mapping[CSKY_PMU_MAX_EVENTS]));
 
@@ -1031,11 +1256,19 @@ int __init init_hw_perf_events(void)
 	hw_raw_write_mapping[0x1a] = csky_pmu_write_l2wac;
 	hw_raw_write_mapping[0x1b] = csky_pmu_write_l2wmc;
 
-	csky_pmu.pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+	return 0;
+}
 
-	cpwcr(HPCR, BIT(31) | BIT(30) | BIT(1));
+static int csky_pmu_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(csky_pmu_irq, 0);
+	return 0;
+}
 
-	return perf_pmu_register(&csky_pmu.pmu, "cpu", PERF_TYPE_RAW);
+static int csky_pmu_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(csky_pmu_irq);
+	return 0;
 }
 
 int csky_pmu_device_probe(struct platform_device *pdev,
@@ -1052,14 +1285,41 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 		ret = init_fn(&csky_pmu);
 	}
 
+	if (ret) {
+		pr_notice("[perf] failed to probe PMU!\n");
+		return ret;
+	}
+
 	if (!of_property_read_u32(node, "count-width",
 				  &csky_pmu.count_width)) {
 		csky_pmu.count_width = DEFAULT_COUNT_WIDTH;
 	}
+	csky_pmu.max_period = ((u64)1 << csky_pmu.count_width) - 1;
 
+	csky_pmu.plat_device = pdev;
+
+	/* Ensure the PMU has sane values out of reset. */
+	if (csky_pmu.reset)
+		on_each_cpu(csky_pmu.reset, &csky_pmu, 1);
+
+	ret = csky_pmu_request_irq(csky_pmu_dispatch_irq);
 	if (ret) {
-		pr_notice("[perf] failed to probe PMU!\n");
-		return ret;
+		csky_pmu.pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+		pr_notice("[perf] PMU request irq fail!\n");
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_ONLINE, "AP_PERF_ONLINE",
+				csky_pmu_starting_cpu,
+				csky_pmu_dying_cpu);
+	if (ret) {
+		csky_pmu_free_irq();
+		free_percpu(csky_pmu.hw_events);
+	}
+
+	ret = perf_pmu_register(&csky_pmu.pmu, "cpu", PERF_TYPE_RAW);
+	if (ret) {
+		csky_pmu_free_irq();
+		free_percpu(csky_pmu.hw_events);
 	}
 
 	return ret;
-- 
2.7.4

