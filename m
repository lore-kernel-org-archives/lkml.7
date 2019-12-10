Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89118C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFE7206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfLJJPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:15:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:29109 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfLJJO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:14:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 01:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="scan'208";a="244777905"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by fmsmga002.fm.intel.com with ESMTP; 10 Dec 2019 01:14:55 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH v2 1/3] perf x86: Infrastructure for exposing an Uncore unit to PMON mapping
Date:   Tue, 10 Dec 2019 12:14:49 +0300
Message-Id: <20191210091451.6054-2-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191210091451.6054-1-roman.sudarikov@linux.intel.com>
References: <20191210091451.6054-1-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

Intel® Xeon® Scalable processor family (code name Skylake-SP) makes
significant changes in the integrated I/O (IIO) architecture. The new
solution introduces IIO stacks which are responsible for managing traffic
between the PCIe domain and the Mesh domain. Each IIO stack has its own
PMON block and can handle either DMI port, x16 PCIe root port, MCP-Link
or various built-in accelerators. IIO PMON blocks allow concurrent
monitoring of I/O flows up to 4 x4 bifurcation within each IIO stack.

Software is supposed to program required perf counters within each IIO
stack and gather performance data. The tricky thing here is that IIO PMON
reports data per IIO stack but users have no idea what IIO stacks are -
they only know devices which are connected to the platform.

Understanding IIO stack concept to find which IIO stack that particular
IO device is connected to, or to identify an IIO PMON block to program
for monitoring specific IIO stack assumes a lot of implicit knowledge
about given Intel server platform architecture.

Usage example:
    /sys/devices/uncore_<type>_<pmu_idx>/platform_mapping

Each Uncore unit type, by its nature, can be mapped to its own context,
for example:
1. CHA - each uncore_cha_<pmu_idx> is assigned to manage a distinct slice
   of LLC capacity;
2. UPI - each uncore_upi_<pmu_idx> is assigned to manage one link of Intel
   UPI Subsystem;
3. IIO - each uncore_iio_<pmu_idx> is assigned to manage one stack of the
   IIO module;
4. IMC - each uncore_imc_<pmu_idx> is assigned to manage one channel of
   Memory Controller.

Implementation details:
Two callbacks added to struct intel_uncore_type to discover and map Uncore
units to PMONs:
    int (*get_topology)(void)
    int (*set_mapping)(struct intel_uncore_pmu *pmu)

Details of IIO Uncore unit mapping to IIO PMON:
Each IIO stack is either DMI port, x16 PCIe root port, MCP-Link or various
built-in accelerators. For Uncore IIO Unit type, the platform_mapping file
holds bus numbers of devices, which can be monitored by that IIO PMON block
on each die.

Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 26 ++++++++++++++++++++++++++
 arch/x86/events/intel/uncore.h |  9 ++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 86467f85c383..24e120289018 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -816,6 +816,15 @@ static ssize_t uncore_get_attr_cpumask(struct device *dev,
 
 static DEVICE_ATTR(cpumask, S_IRUGO, uncore_get_attr_cpumask, NULL);
 
+static ssize_t platform_mapping_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct intel_uncore_pmu *pmu = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE - 1, "%s\n", (char *)pmu->mapping);
+}
+static DEVICE_ATTR_RO(platform_mapping);
+
 static struct attribute *uncore_pmu_attrs[] = {
 	&dev_attr_cpumask.attr,
 	NULL,
@@ -825,6 +834,15 @@ static const struct attribute_group uncore_pmu_attr_group = {
 	.attrs = uncore_pmu_attrs,
 };
 
+static struct attribute *mapping_attrs[] = {
+	&dev_attr_platform_mapping.attr,
+	NULL,
+};
+
+static const struct attribute_group uncore_mapping_group = {
+	.attrs = mapping_attrs,
+};
+
 static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 {
 	int ret;
@@ -954,6 +972,14 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 
 	type->pmu_group = &uncore_pmu_attr_group;
 
+	/*
+	 * Exposing mapping of Uncore units to corresponding Uncore PMUs
+	 * through /sys/devices/uncore_<type>_<idx>/platform_mapping
+	 */
+	if (type->get_topology && type->set_mapping)
+		if (!type->get_topology(type) && !type->set_mapping(type))
+			type->mapping_group = &uncore_mapping_group;
+
 	return 0;
 
 err:
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index bbfdaa720b45..31008e5cea57 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -71,13 +71,19 @@ struct intel_uncore_type {
 	struct intel_uncore_ops *ops;
 	struct uncore_event_desc *event_descs;
 	struct freerunning_counters *freerunning;
-	const struct attribute_group *attr_groups[4];
+	const struct attribute_group *attr_groups[5];
 	struct pmu *pmu; /* for custom pmu ops */
+	u64 *topology;
+	/* finding Uncore units */
+	int (*get_topology)(struct intel_uncore_type *type);
+	/* mapping Uncore units to PMON ranges */
+	int (*set_mapping)(struct intel_uncore_type *type);
 };
 
 #define pmu_group attr_groups[0]
 #define format_group attr_groups[1]
 #define events_group attr_groups[2]
+#define mapping_group attr_groups[3]
 
 struct intel_uncore_ops {
 	void (*init_box)(struct intel_uncore_box *);
@@ -99,6 +105,7 @@ struct intel_uncore_pmu {
 	int				pmu_idx;
 	int				func_id;
 	bool				registered;
+	void				*mapping;
 	atomic_t			activeboxes;
 	struct intel_uncore_type	*type;
 	struct intel_uncore_box		**boxes;
-- 
2.19.1

