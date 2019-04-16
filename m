Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D09AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BE320693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfDPJs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:48:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726895AbfDPJsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:48:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3G9ic8O050242
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:48:53 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rwb8v46ch-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:48:53 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <anju@linux.vnet.ibm.com>;
        Tue, 16 Apr 2019 10:48:51 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 10:48:49 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3G9mms547579232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 09:48:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 900FF4C059;
        Tue, 16 Apr 2019 09:48:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 718724C040;
        Tue, 16 Apr 2019 09:48:47 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.144.43])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Apr 2019 09:48:47 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: [PATCH v4 5/5] powerpc/perf: Trace imc PMU functions
Date:   Tue, 16 Apr 2019 15:18:31 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190416094831.7264-1-anju@linux.vnet.ibm.com>
References: <20190416094831.7264-1-anju@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19041609-0016-0000-0000-0000026F5A11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041609-0017-0000-0000-000032CBA3A6
Message-Id: <20190416094831.7264-6-anju@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMU functions to support trace-imc.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 205 +++++++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 3fe0222885bc..cc9724561bf2 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -53,7 +53,7 @@ static struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
 	return container_of(event->pmu, struct imc_pmu, pmu);
 }
 
-PMU_FORMAT_ATTR(event, "config:0-40");
+PMU_FORMAT_ATTR(event, "config:0-61");
 PMU_FORMAT_ATTR(offset, "config:0-31");
 PMU_FORMAT_ATTR(rvalue, "config:32");
 PMU_FORMAT_ATTR(mode, "config:33-40");
@@ -70,6 +70,25 @@ static struct attribute_group imc_format_group = {
 	.attrs = imc_format_attrs,
 };
 
+/* Format attribute for imc trace-mode */
+PMU_FORMAT_ATTR(cpmc_reserved, "config:0-19");
+PMU_FORMAT_ATTR(cpmc_event, "config:20-27");
+PMU_FORMAT_ATTR(cpmc_samplesel, "config:28-29");
+PMU_FORMAT_ATTR(cpmc_load, "config:30-61");
+static struct attribute *trace_imc_format_attrs[] = {
+	&format_attr_event.attr,
+	&format_attr_cpmc_reserved.attr,
+	&format_attr_cpmc_event.attr,
+	&format_attr_cpmc_samplesel.attr,
+	&format_attr_cpmc_load.attr,
+	NULL,
+};
+
+static struct attribute_group trace_imc_format_group = {
+.name = "format",
+.attrs = trace_imc_format_attrs,
+};
+
 /* Get the cpumask printed to a buffer "buf" */
 static ssize_t imc_pmu_cpumask_get_attr(struct device *dev,
 					struct device_attribute *attr,
@@ -1108,6 +1127,182 @@ static int trace_imc_cpu_init(void)
 			  ppc_trace_imc_cpu_offline);
 }
 
+static u64 get_trace_imc_event_base_addr(void)
+{
+	return (u64)per_cpu(trace_imc_mem, smp_processor_id());
+}
+
+/*
+ * Function to parse trace-imc data obtained
+ * and to prepare the perf sample.
+ */
+static int trace_imc_prepare_sample(struct trace_imc_data *mem,
+				    struct perf_sample_data *data,
+				    u64 *prev_tb,
+				    struct perf_event_header *header,
+				    struct perf_event *event)
+{
+	/* Sanity checks for a valid record */
+	if (be64_to_cpu(READ_ONCE(mem->tb1)) > *prev_tb)
+		*prev_tb = be64_to_cpu(READ_ONCE(mem->tb1));
+	else
+		return -EINVAL;
+
+	if ((be64_to_cpu(READ_ONCE(mem->tb1)) & IMC_TRACE_RECORD_TB1_MASK) !=
+			 be64_to_cpu(READ_ONCE(mem->tb2)))
+		return -EINVAL;
+
+	/* Prepare perf sample */
+	data->ip =  be64_to_cpu(READ_ONCE(mem->ip));
+	data->period = event->hw.last_period;
+
+	header->type = PERF_RECORD_SAMPLE;
+	header->size = sizeof(*header) + event->header_size;
+	header->misc = 0;
+
+	if (is_kernel_addr(data->ip))
+		header->misc |= PERF_RECORD_MISC_KERNEL;
+	else
+		header->misc |= PERF_RECORD_MISC_USER;
+
+	perf_event_header__init_id(header, data, event);
+
+	return 0;
+}
+
+static void dump_trace_imc_data(struct perf_event *event)
+{
+	struct trace_imc_data *mem;
+	int i, ret;
+	u64 prev_tb = 0;
+
+	mem = (struct trace_imc_data *)get_trace_imc_event_base_addr();
+	for (i = 0; i < (trace_imc_mem_size / sizeof(struct trace_imc_data));
+		i++, mem++) {
+		struct perf_sample_data data;
+		struct perf_event_header header;
+
+		ret = trace_imc_prepare_sample(mem, &data, &prev_tb, &header, event);
+		if (ret) /* Exit, if not a valid record */
+			break;
+		else {
+			/* If this is a valid record, create the sample */
+			struct perf_output_handle handle;
+
+			if (perf_output_begin(&handle, event, header.size))
+				return;
+
+			perf_output_sample(&handle, &header, &data, event);
+			perf_output_end(&handle);
+		}
+	}
+}
+
+static int trace_imc_event_add(struct perf_event *event, int flags)
+{
+	int core_id = smp_processor_id() / threads_per_core;
+	struct imc_pmu_ref *ref = NULL;
+	u64 local_mem, ldbar_value;
+
+	/* Set trace-imc bit in ldbar and load ldbar with per-thread memory address */
+	local_mem = get_trace_imc_event_base_addr();
+	ldbar_value = ((u64)local_mem & THREAD_IMC_LDBAR_MASK) | TRACE_IMC_ENABLE;
+
+	if (core_imc_refc)
+		ref = &core_imc_refc[core_id];
+	if (!ref) {
+		/* If core-imc is not enabled, use trace-imc reference count */
+		if (trace_imc_refc)
+			ref = &trace_imc_refc[core_id];
+		if (!ref)
+			return -EINVAL;
+	}
+	mtspr(SPRN_LDBAR, ldbar_value);
+	mutex_lock(&ref->lock);
+	if (ref->refc == 0) {
+		if (opal_imc_counters_start(OPAL_IMC_COUNTERS_TRACE,
+				get_hard_smp_processor_id(smp_processor_id()))) {
+			mutex_unlock(&ref->lock);
+			pr_err("trace-imc: Unable to start the counters for core %d\n", core_id);
+			mtspr(SPRN_LDBAR, 0);
+			return -EINVAL;
+		}
+	}
+	++ref->refc;
+	mutex_unlock(&ref->lock);
+
+	return 0;
+}
+
+static void trace_imc_event_read(struct perf_event *event)
+{
+	return;
+}
+
+static void trace_imc_event_stop(struct perf_event *event, int flags)
+{
+	u64 local_mem = get_trace_imc_event_base_addr();
+	dump_trace_imc_data(event);
+	memset((void *)local_mem, 0, sizeof(u64));
+}
+
+static void trace_imc_event_start(struct perf_event *event, int flags)
+{
+	return;
+}
+
+static void trace_imc_event_del(struct perf_event *event, int flags)
+{
+	int core_id = smp_processor_id() / threads_per_core;
+	struct imc_pmu_ref *ref = NULL;
+
+	if (core_imc_refc)
+		ref = &core_imc_refc[core_id];
+	if (!ref) {
+		/* If core-imc is not enabled, use trace-imc reference count */
+		if (trace_imc_refc)
+			ref = &trace_imc_refc[core_id];
+		if (!ref)
+			return;
+	}
+	mtspr(SPRN_LDBAR, 0);
+	mutex_lock(&ref->lock);
+	ref->refc--;
+	if (ref->refc == 0) {
+		if (opal_imc_counters_stop(OPAL_IMC_COUNTERS_TRACE,
+				get_hard_smp_processor_id(smp_processor_id()))) {
+			mutex_unlock(&ref->lock);
+			pr_err("trace-imc: Unable to stop the counters for core %d\n", core_id);
+			return;
+		}
+	} else if (ref->refc < 0) {
+		ref->refc = 0;
+	}
+	mutex_unlock(&ref->lock);
+	trace_imc_event_stop(event, flags);
+}
+
+static int trace_imc_event_init(struct perf_event *event)
+{
+	struct task_struct *target;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	/* Return if this is a couting event */
+	if (event->attr.sample_period == 0)
+		return -ENOENT;
+
+	event->hw.idx = -1;
+	target = event->hw.target;
+
+	event->pmu->task_ctx_nr = perf_hw_context;
+	return 0;
+}
+
 /* update_pmu_ops : Populate the appropriate operations for "pmu" */
 static int update_pmu_ops(struct imc_pmu *pmu)
 {
@@ -1138,6 +1333,14 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 		pmu->pmu.cancel_txn = thread_imc_pmu_cancel_txn;
 		pmu->pmu.commit_txn = thread_imc_pmu_commit_txn;
 		break;
+	case IMC_DOMAIN_TRACE:
+		pmu->pmu.event_init = trace_imc_event_init;
+		pmu->pmu.add = trace_imc_event_add;
+		pmu->pmu.del = trace_imc_event_del;
+		pmu->pmu.start = trace_imc_event_start;
+		pmu->pmu.stop = trace_imc_event_stop;
+		pmu->pmu.read = trace_imc_event_read;
+		pmu->attr_groups[IMC_FORMAT_ATTR] = &trace_imc_format_group;
 	default:
 		break;
 	}
-- 
2.17.2

