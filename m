Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C6AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9188F2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfKZQgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:36:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:39751 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfKZQgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:36:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 08:36:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="359212514"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2019 08:36:48 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH 4/6] perf stat: New --iiostat mode to provide I/O performance metrics
Date:   Tue, 26 Nov 2019 19:36:28 +0300
Message-Id: <20191126163630.17300-5-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191126163630.17300-4-roman.sudarikov@linux.intel.com>
References: <20191126163630.17300-1-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-3-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-4-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

New --iiostat mode in perf stat is intended to provide four I/O performance
metrics per each IO device below IIO stacks:
    --Inbound Read(Mb)   - I/O device reads from the host memory, in Mb
    --Inbound Write(Mb)  - I/O device writes to the host memory, in Mb
    --Outbound Read(Mb)  - CPU reads from I/O device, in Mb
    --Outbound Write(Mb) - CPU writes to I/O device, in Mb

Each metric requires only one IIO event which increments at every 4B transfer
in the corresponding direction. The formula to compute metrics are generic:
    #EventCount * 4B / (1024 * 1024)

This implementation starts from discovering IIO stacks on the platform and
all devices below each stack. Next step is to configure a group of four events
per each device and tie each event group to its device.

Note: --iiostat introduces new perf data aggregation mode - per I/O device
hence -e and -M options are not supported.

Usage examples:

1. List all devices below IIO stacks
  ./perf stat --iiostat=show

Sample output w/o libpci:

    S0-RootPort0-uncore_iio_0<00:00.0>
    S1-RootPort0-uncore_iio_0<81:00.0>
    S0-RootPort1-uncore_iio_1<18:00.0>
    S1-RootPort1-uncore_iio_1<86:00.0>
    S1-RootPort1-uncore_iio_1<88:00.0>
    S0-RootPort2-uncore_iio_2<3d:00.0>
    S1-RootPort2-uncore_iio_2<af:00.0>
    S1-RootPort3-uncore_iio_3<da:00.0>

Sample output with libpci:

    S0-RootPort0-uncore_iio_0<00:00.0 Sky Lake-E DMI3 Registers>
    S1-RootPort0-uncore_iio_0<81:00.0 Ethernet Controller X710 for 10GbE SFP+>
    S0-RootPort1-uncore_iio_1<18:00.0 Omni-Path HFI Silicon 100 Series [discrete]>
    S1-RootPort1-uncore_iio_1<86:00.0 Ethernet Controller XL710 for 40GbE QSFP+>
    S1-RootPort1-uncore_iio_1<88:00.0 Ethernet Controller XL710 for 40GbE QSFP+>
    S0-RootPort2-uncore_iio_2<3d:00.0 Ethernet Connection X722 for 10GBASE-T>
    S1-RootPort2-uncore_iio_2<af:00.0 Omni-Path HFI Silicon 100 Series [discrete]>
    S1-RootPort3-uncore_iio_3<da:00.0 NVMe Datacenter SSD [Optane]>

2. Collect metrics for all I/O devices below IIO stack

  ./perf stat --iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
    357708+0 records in
    357707+0 records out
    375083606016 bytes (375 GB, 349 GiB) copied, 215.381 s, 1.7 GB/s

  Performance counter stats for 'system wide':

     device             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
    00:00.0                    0                    0                    0                    0
    81:00.0                    0                    0                    0                    0
    18:00.0                    0                    0                    0                    0
    86:00.0                    0                    0                    0                    0
    88:00.0                    0                    0                    0                    0
    3b:00.0                    3                    0                    0                    0
    3c:03.0                    3                    0                    0                    0
    3d:00.0                    3                    0                    0                    0
    af:00.0                    0                    0                    0                    0
    da:00.0               358559                   44                    0                   22

    215.383783574 seconds time elapsed

3. Collect metrics for comma separted list of I/O devices

  ./perf stat --iiostat=da:00.0 -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
    381555+0 records in
    381554+0 records out
    400088457216 bytes (400 GB, 373 GiB) copied, 374.044 s, 1.1 GB/s

  Performance counter stats for 'system wide':

     device             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
    da:00.0               382462                   47                    0                   23

    374.045775505 seconds time elapsed

Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
---
 tools/perf/Documentation/perf-stat.txt        |  12 +
 tools/perf/arch/x86/util/Build                |   1 +
 tools/perf/arch/x86/util/iiostat.c            | 533 +++++++++++++++++-
 tools/perf/builtin-stat.c                     |  32 +-
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/iiostat.h                     |  35 ++
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/stat-display.c                |  53 +-
 tools/perf/util/stat-shadow.c                 |  12 +-
 tools/perf/util/stat.c                        |   3 +-
 tools/perf/util/stat.h                        |   2 +
 11 files changed, 676 insertions(+), 10 deletions(-)
 create mode 100644 tools/perf/util/iiostat.h

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 930c51c01201..96a2ec8c6b55 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -262,6 +262,18 @@ See perf list output for the possble metrics and metricgroups.
 -A::
 --no-aggr::
 Do not aggregate counts across all monitored CPUs.
+--iiostat::
+This mode is intended to provide four I/O performance metrics per each
+IO device below IIO stacks:
+    --Inbound Read(Mb)   - I/O device reads from the host memory, in Mb
+    --Inbound Write(Mb)  - I/O device writes to the host memory, in Mb
+    --Outbound Read(Mb)  - CPU reads from I/O device, in Mb
+    --Outbound Write(Mb) - CPU writes to I/O device, in Mb
+
+Each metric requiries only one IIO event which increments at every 4B
+transfer in corresponding direction. The formulas to compute metrics
+are generic:
+    #EventCount * 4B / (1024 * 1024)
 
 --topdown::
 Print top down level 1 metrics if supported by the CPU. This allows to
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 47f9c56e744f..e19566e16e5d 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -6,6 +6,7 @@ perf-y += perf_regs.o
 perf-y += group.o
 perf-y += machine.o
 perf-y += event.o
+perf-y += iiostat.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/iiostat.c b/tools/perf/arch/x86/util/iiostat.c
index b93b9b9da418..058a01d3a93f 100644
--- a/tools/perf/arch/x86/util/iiostat.c
+++ b/tools/perf/arch/x86/util/iiostat.c
@@ -9,6 +9,7 @@
  */
 #include "path.h"
 #include "pci.h"
+#include "util/cpumap.h"
 #include <api/fs/fs.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
@@ -27,10 +28,89 @@
 #include <stdlib.h>
 #include <regex.h>
 
+/*
+ * The Intel® Xeon® Scalable processor family (code name Skylake-SP) makes
+ * significant changes in integrated I/O (IIO) architecture. The new solution
+ * introduces IIO stacks which are responsible for managing traffic between PCIe
+ * domain and the Mesh domain. Each IIO stack has its own PMON block and can
+ * handle either DMI port, x16 PCIe root port, MCP-Link or various built-in
+ * accelerators. IIO PMON blocks allow concurrent monitoring of I/O flows up
+ * to 4 x4 bifurcation within each IIO stack.
+ *
+ * New --iiostat mode in perf stat is intended to provide four I/O performance
+ * metrics per each IO device below IIO stacks:
+ *     --Inbound Read(Mb)   - I/O device reads from the host memory, in Mb
+ *     --Inbound Write(Mb)  - I/O device writes to the host memory, in Mb
+ *     --Outbound Read(Mb)  - CPU reads from I/O device, in Mb
+ *     --Outbound Write(Mb) - CPU writes to I/O device, in Mb
+ *
+ * Each metric requiries only one IIO event which increments at every 4B
+ * transfer in corresponding direction. The formulas to compute metrics
+ * are generic:
+ *     #EventCount * 4B / (1024 * 1024)
+ *
+ * This implementation starts from discovering IIO stacks on the platform and
+ * all devices below each stack. Next step is to configure group of four events
+ * per each device and tie each event group to its device.
+ *
+ * Sample output:
+
+./perf stat --iiostat=show
+	S0-RootPort0-uncore_iio_0<00:00.0>
+	S1-RootPort0-uncore_iio_0<81:00.0>
+	S0-RootPort1-uncore_iio_1<18:00.0>
+	S1-RootPort1-uncore_iio_1<86:00.0>
+	S1-RootPort1-uncore_iio_1<88:00.0>
+	S0-RootPort2-uncore_iio_2<3d:00.0>
+	S1-RootPort2-uncore_iio_2<af:00.0>
+	S1-RootPort3-uncore_iio_3<da:00.0>
+
+./perf stat --iiostat=af:00.0 -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
+	381555+0 records in
+	381554+0 records out
+	400088457216 bytes (400 GB, 373 GiB) copied, 374.044 s, 1.1 GB/s
+
+Performance counter stats for 'system wide':
+
+	 device  Inbound Read(MB)  Inbound Write(MB)  Outbound Read(MB)  Outbound Write(MB)
+	af:00.0    382462                47                   0                 23
+
+374.045775505 seconds time elapsed
+ */
+#define PCI_BUS_MAX_DEVICE_NUMBER 32
+#define PCI_BUS_MAX_FUNCTION_NUMBER 8
+
+#define PLATFORM_MAPPING_PATH	"devices/uncore_iio_%d/platform_mapping"
+
+typedef enum {
+	IIOSTAT_NONE		= 0,
+	IIOSTAT_SHOW		= 1,
+	IIOSTAT_RUN		= 2
+} iiostat_mode_t;
+
+static iiostat_mode_t iiostat_mode = IIOSTAT_NONE;
+
+static const char * const iiostat_metrics[] = {
+	"Inbound Read(MB)",
+	"Inbound Write(MB)",
+	"Outbound Read(MB)",
+	"Outbound Write(MB)",
+};
+
+static inline int iiostat_metrics_count(void)
+{
+	return sizeof(iiostat_metrics) / sizeof(char *);
+}
+
+static const char *get_iiostat_metric(int idx)
+{
+	return *(iiostat_metrics + idx % iiostat_metrics_count());
+}
+
 struct dev_info {
 	struct bdf bdf;
 	u8 ch_mask;
-	u8 socket;
+	u8 die;
 	u8 pmu_idx;
 	u8 root_port_nr;
 };
@@ -83,6 +163,45 @@ struct iio_devs_list {
 #define iio_device_delete_from_list(device) \
 		list_del(&(device->node))
 
+static u8 *rp_nr;
+
+static u8 get_rp_nr(u8 die)
+{
+	return rp_nr[die]++;
+}
+
+static u64 platform_mapping_build(char *buf)
+{
+	char *end;
+	u8 offset = 0;
+	unsigned long long interim = 0;
+
+	for (long mapping_byte = strtol(buf, &end, 16);
+		buf != end; mapping_byte = strtol(buf, &end, 16)) {
+		buf = end + 1;
+		if (*end == ',' || *end == '\n')
+			interim |= (u64)mapping_byte << (8 * offset++);
+	}
+	return interim;
+}
+
+static int uncore_pmu_iio_platform_mapping_read(u8 pmu_idx, u64 * const mapping)
+{
+	char *buf;
+	char path[PATH_MAX];
+	size_t size;
+
+	scnprintf(path, PATH_MAX, PLATFORM_MAPPING_PATH, pmu_idx);
+	if (sysfs__read_str(path, &buf, &size) < 0) {
+		fprintf(stderr, "iiostat is not supported\n");
+		return -1;
+	}
+	*mapping = (size == 2) ? 0 : platform_mapping_build(buf);
+	free(buf);
+
+	return 0;
+}
+
 static struct iio_device *iio_device_new(struct dev_info *info)
 {
 	struct iio_device *p =
@@ -109,7 +228,7 @@ static void iiostat_device_show(FILE *output,
 {
 	if (output && device)
 		fprintf(output, "S%d-RootPort%d-uncore_iio_%d<%02x:%02x.%x>\n",
-			device->dev_info.socket,
+			device->dev_info.die,
 			device->dev_info.root_port_nr, device->dev_info.pmu_idx,
 			device->dev_info.bdf.busno, device->dev_info.bdf.devno,
 			device->dev_info.bdf.funcno);
@@ -176,3 +295,413 @@ static void iio_devs_list_join_list(struct iio_devs_list *dest,
 		dest->nr_entries += src->nr_entries;
 	}
 }
+
+static int pci_rp_probe(struct dev_info *info, struct iio_devs_list *list)
+{
+	u8 secondary_bus_number = 0;
+	u8 subordinate_bus_number = 0;
+	struct iio_device *device = NULL;
+
+	if (!pci_device_probe(info->bdf))
+		return 0;
+
+	if (!is_pci_device_root_port(info->bdf,
+				     &secondary_bus_number,
+				     &subordinate_bus_number)) {
+		secondary_bus_number = info->bdf.busno;
+		subordinate_bus_number = info->bdf.busno;
+	}
+
+	for (u8 b = secondary_bus_number; b <= subordinate_bus_number; b++) {
+		for (u8 d = 0; d < PCI_BUS_MAX_DEVICE_NUMBER; d++) {
+			for (u8 f = 0; f < PCI_BUS_MAX_FUNCTION_NUMBER; f++) {
+				info->bdf.busno = b;
+				info->bdf.devno = d;
+				info->bdf.funcno = f;
+				if (!pci_device_probe(info->bdf) ||
+				    is_pci_device_root_port(info->bdf, NULL, NULL))
+					continue;
+				device = iio_device_new(info);
+				if (device) {
+					iio_devs_list_add_device(list, device);
+					break;
+				}
+				return -ENOMEM;
+			}
+		}
+	}
+	return 0;
+}
+
+static int pci_rp_scan(u8 rp, u8 pmu_idx, u8 die,
+			struct iio_devs_list **list)
+{
+	int ret = 0;
+	u8 part = 0;
+	struct dev_info info;
+	struct iio_device *device = NULL;
+
+	struct iio_devs_list *interim_list = iio_devs_list_new();
+
+	if (!interim_list)
+		return -ENOMEM;
+
+	info.bdf.busno = rp;
+	info.bdf.funcno = 0;
+	info.pmu_idx = pmu_idx;
+	info.die = die;
+	info.root_port_nr = get_rp_nr(die);
+
+	/* Extra case for root port 0x00*/
+	if (info.bdf.busno == 0x00) {
+		info.bdf.devno = 0;
+		device = iio_device_new(&info);
+		if (device)
+			iio_devs_list_add_device(interim_list, device);
+		else {
+			iio_devs_list_free(interim_list);
+			return -ENOMEM;
+		}
+	} else {
+		for (part = 0; part < 4; part++) {
+			info.bdf.devno = part;
+			info.ch_mask = (1 << part);
+			ret = pci_rp_probe(&info, interim_list);
+			if (ret) {
+				iio_devs_list_free(interim_list);
+				return ret;
+			}
+		}
+	}
+
+	if (interim_list->nr_entries)
+		*list = interim_list;
+	else
+		iio_devs_list_free(interim_list);
+
+	return 0;
+}
+
+static int pmu_scan(u8 pmu_idx, u64 mapping, struct iio_devs_list **list)
+{
+	int ret;
+	u8 rp;
+	struct iio_devs_list *interim_list, *rp_list = NULL;
+
+	interim_list = iio_devs_list_new();
+	if (!interim_list)
+		return -ENOMEM;
+
+	for (u8 die = 0; die < cpu__max_node(); die++) {
+		rp = (u8)(mapping >> (die * 8));
+		if (!rp && die)
+			break;
+
+		ret = pci_rp_scan(rp, pmu_idx, die, &rp_list);
+		if (ret) {
+			iio_devs_list_free(interim_list);
+			return ret;
+		}
+		if (rp_list) {
+			iio_devs_list_join_list(interim_list, rp_list);
+			free(rp_list);
+			rp_list = NULL;
+		}
+	}
+	if (interim_list->nr_entries)
+		*list = interim_list;
+	else
+		iio_devs_list_free(interim_list);
+	return 0;
+}
+
+static int iio_devs_scan(struct iio_devs_list **list)
+{
+	u64 mapping;
+	int ret;
+	struct iio_devs_list *pmu_dev_list = NULL;
+	struct iio_devs_list *interim = NULL;
+
+	rp_nr = (u8 *)calloc(cpu__max_node(), 1);
+	if (!rp_nr)
+		return -ENOMEM;
+
+	interim = iio_devs_list_new();
+	if (!interim) {
+		free(rp_nr);
+		return -ENOMEM;
+	}
+
+	for (u8 pmu_idx = 0; pmu_idx < 6; pmu_idx++) {
+		ret = uncore_pmu_iio_platform_mapping_read(pmu_idx, &mapping);
+		if (ret)
+			break;
+		/* IIO stack 0 on die 0 is always on bus 0x00.*/
+		if ((mapping == 0) && pmu_idx)
+			continue;
+
+		ret = pmu_scan(pmu_idx, mapping, &pmu_dev_list);
+		if (ret)
+			break;
+
+		if (pmu_dev_list) {
+			iio_devs_list_join_list(interim, pmu_dev_list);
+			free(pmu_dev_list);
+			pmu_dev_list = NULL;
+		}
+	}
+
+	if (!ret)
+		*list = interim;
+	else
+		iio_devs_list_free(interim);
+
+	free(rp_nr);
+
+	return ret;
+}
+
+static int iio_dev_parse_bdf_str(struct bdf *bdf, char *str)
+{
+	int ret = 0;
+	regex_t regex;
+	/*
+	 * Expected format bus:device.function:
+	 * Valid bus range [0:ff]
+	 * Valid device range [0:1f]
+	 * Valid function range [0:7]
+	 * Example: af:00.0, d:0.0, 5e:0.0
+	 */
+	regcomp(&regex,
+		"^([a-f0-9A-F]{1,2}):(([0|1]{0,1})([0-9a-fA-F]{1})).([0-7]{1})$",
+		REG_EXTENDED);
+	ret = regexec(&regex, str, 0, NULL, 0);
+	if (!ret)
+		sscanf(str, "%02hhx:%02hhx.%hhx",
+		       &bdf->busno, &bdf->devno, &bdf->funcno);
+	else
+		pr_warning("Unrecognized device format: %s\n", str);
+
+	regfree(&regex);
+	return ret;
+}
+
+static struct iio_device *pci_devs_list_find_device_by_bdf(
+			   const struct iio_devs_list * const list,
+			   struct bdf bdf)
+{
+	struct iio_device *it;
+
+	if (list) {
+		iio_devs_list_for_each_device(list, it) {
+			if (is_same_iio_device(it->dev_info.bdf, bdf))
+				return it;
+		}
+	}
+	return NULL;
+}
+
+static int iio_devs_list_filter_by_bdf(struct iio_devs_list **list,
+					const char *bdf_str)
+{
+	struct bdf bdf;
+	struct iio_device *device;
+	const char *delim = ",";
+	char *token = NULL;
+	char *tmp;
+	char *tmp_bdf_str = (char *)bdf_str;
+
+	struct iio_devs_list *filtered_list = iio_devs_list_new();
+
+	if (!filtered_list)
+		return -ENOMEM;
+
+	token = strtok(tmp_bdf_str, delim);
+	while (token != NULL) {
+		tmp = token;
+		if (!iio_dev_parse_bdf_str(&bdf, tmp)) {
+			if (!pci_devs_list_find_device_by_bdf(filtered_list, bdf)) {
+				device = pci_devs_list_find_device_by_bdf(*list, bdf);
+				if (device) {
+					iio_device_delete_from_list(device);
+					iio_devs_list_add_device(filtered_list, device);
+				} else
+					pr_warning("Device %02x:%02x.%x not found\n",
+						   bdf.busno, bdf.devno, bdf.funcno);
+			}
+		}
+		token = strtok(NULL, delim);
+	}
+	iio_devs_list_free(*list);
+	*list = filtered_list;
+	return 0;
+}
+
+static struct iio_device *iio_dev_get_by_idx(const struct iio_devs_list *list,
+					      int idx)
+{
+	struct iio_device *device = NULL;
+
+	if (idx < list->nr_entries)
+		iio_devs_list_for_each_device(list, device)
+			if (device->idx == idx)
+				break;
+
+	return device;
+}
+
+static int iiostat_event_group(struct evlist *evl,
+				struct iio_devs_list *dev_list)
+{
+	int ret = 0;
+	struct iio_device *device = NULL;
+	const char *iiostat_cmd_template =
+	"{uncore_iio_%x/event=0x83,umask=0x04,ch_mask=0x%02x,fc_mask=0x07/,\
+	uncore_iio_%x/event=0x83,umask=0x01,ch_mask=0x%02x,fc_mask=0x07/,\
+	uncore_iio_%x/event=0xc0,umask=0x04,ch_mask=0x%02x,fc_mask=0x07/,\
+	uncore_iio_%x/event=0xc0,umask=0x01,ch_mask=0x%02x,fc_mask=0x07/}";
+	const int len_template = strlen(iiostat_cmd_template) + 1;
+	struct evsel *evsel = NULL;
+	int metrics_count = iiostat_metrics_count();
+	char *iiostat_cmd = calloc(len_template, 1);
+
+	if (!iiostat_cmd)
+		return -ENOMEM;
+	iio_devs_list_for_each_device(dev_list, device) {
+		sprintf(iiostat_cmd, iiostat_cmd_template,
+			device->dev_info.pmu_idx, device->dev_info.ch_mask,
+			device->dev_info.pmu_idx, device->dev_info.ch_mask,
+			device->dev_info.pmu_idx, device->dev_info.ch_mask,
+			device->dev_info.pmu_idx, device->dev_info.ch_mask);
+		ret = parse_events(evl, iiostat_cmd, NULL);
+		if (ret)
+			goto out;
+	}
+	evlist__for_each_entry(evl, evsel)
+		evsel->perf_device = iio_dev_get_by_idx(dev_list,
+							evsel->idx / metrics_count);
+out:
+	list_del_init(&(dev_list->devices));
+	iio_devs_list_free(dev_list);
+	free(iiostat_cmd);
+	return ret;
+}
+
+int iiostat_parse(const struct option *opt,
+		  const char *str,
+		  int unset __maybe_unused)
+{
+	int ret = 0;
+	struct iio_devs_list *dev_list = NULL;
+	struct evlist *evl = *(struct evlist **)opt->value;
+	struct perf_stat_config *config = (struct perf_stat_config *)opt->data;
+
+	if (evl->core.nr_entries > 0) {
+		pr_err("unsupported event configuration\n");
+		return -1;
+	}
+	config->metric_only = true;
+	config->aggr_mode = AGGR_DEVICE;
+	config->iiostat_run = true;
+	ret = iio_devs_scan(&dev_list);
+	if (ret)
+		return ret;
+
+	if (!str)
+		iiostat_mode = IIOSTAT_RUN;
+	else if (!strcmp(str, "show"))
+		iiostat_mode = IIOSTAT_SHOW;
+	else {
+		iiostat_mode = IIOSTAT_RUN;
+		ret = iio_devs_list_filter_by_bdf(&dev_list, str);
+		if (ret) {
+			iio_devs_list_free(dev_list);
+			return ret;
+		}
+		if (dev_list->nr_entries == 0) {
+			pr_err("Requested devices were not found\n");
+			iio_devs_list_free(dev_list);
+			return -1;
+		}
+	}
+	return iiostat_event_group(evl, dev_list);
+}
+
+void iiostat_prefix(struct perf_stat_config *config,
+		    struct evlist *evlist,
+		    char *prefix, struct timespec *ts)
+{
+	struct iio_device *device = evlist->selected->perf_device;
+
+	if (device) {
+		if (ts)
+			sprintf(prefix, "%6lu.%09lu%s%02x:%02x.%x%s",
+					ts->tv_sec, ts->tv_nsec,
+					config->csv_sep, device->dev_info.bdf.busno,
+					device->dev_info.bdf.devno, device->dev_info.bdf.funcno,
+					config->csv_sep);
+		else
+			sprintf(prefix, "%02x:%02x.%x%s",
+					device->dev_info.bdf.busno, device->dev_info.bdf.devno,
+					device->dev_info.bdf.funcno, config->csv_sep);
+	}
+}
+
+void iiostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
+			  struct perf_stat_output_ctx *out)
+{
+	double iiostat_value = 0;
+	u64 prev_count_val = 0;
+	const char *iiostat_metric = get_iiostat_metric(evsel->idx);
+	u8 device_die =
+		((struct iio_device *)evsel->perf_device)->dev_info.die;
+	struct perf_counts_values *count =
+		perf_counts(evsel->counts, device_die, 0);
+
+	if (evsel->prev_raw_counts && !out->force_header) {
+		struct perf_counts_values *prev_count =
+			perf_counts(evsel->prev_raw_counts, device_die, 0);
+		prev_count_val = prev_count->val;
+		prev_count->val = count->val;
+	}
+	iiostat_value = (count->val - prev_count_val) / ((double) count->run / count->ena);
+	out->print_metric(config, out->ctx, NULL, "%8.0f",
+			  iiostat_metric, iiostat_value / (256 * 1024));
+}
+
+int iiostat_print_device_list(struct evlist *evlist,
+			       struct perf_stat_config *config)
+{
+	struct evsel *evsel;
+	struct iio_device *device = NULL;
+
+	if (config->aggr_mode != AGGR_DEVICE) {
+		pr_err("unsupported event config\n");
+		return -1;
+	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel->perf_device) {
+			pr_err("unsupported event config\n");
+			return -1;
+		}
+		if ((iiostat_mode == IIOSTAT_SHOW || verbose) && device != evsel->perf_device) {
+			device = evsel->perf_device;
+			iiostat_device_show(config->output, device);
+		}
+	}
+	return (iiostat_mode == IIOSTAT_SHOW) ? -1 : 0;
+}
+
+void iiostat_delete_device_list(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	struct iio_device *device = NULL;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (device != evsel->perf_device) {
+			device = evsel->perf_device;
+			iio_device_delete(evsel->perf_device);
+		}
+	}
+}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 468fc49420ce..c7516a0182a0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -66,6 +66,7 @@
 #include "util/time-utils.h"
 #include "util/top.h"
 #include "asm/bug.h"
+#include "util/iiostat.h"
 
 #include <linux/time64.h>
 #include <linux/zalloc.h>
@@ -186,6 +187,7 @@ static struct perf_stat_config stat_config = {
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 	.big_num		= true,
+	.iiostat_run		= false,
 };
 
 static inline void diff_timespec(struct timespec *r, struct timespec *a,
@@ -723,6 +725,13 @@ static int parse_metric_groups(const struct option *opt,
 	return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
 }
 
+__weak int iiostat_parse(const struct option *opt __maybe_unused,
+						const char *str __maybe_unused,
+						int unset __maybe_unused)
+{
+	return 0;
+}
+
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
@@ -803,6 +812,8 @@ static struct option stat_options[] = {
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
 		     parse_metric_groups),
+	OPT_CALLBACK_OPTARG(0, "iiostat", &evsel_list, &stat_config, "PCIe bandwidth",
+	     "measure PCIe bandwidth per device", iiostat_parse),
 	OPT_END()
 };
 
@@ -908,6 +919,7 @@ static int perf_stat_init_aggr_mode(void)
 		break;
 	case AGGR_GLOBAL:
 	case AGGR_THREAD:
+	case AGGR_DEVICE:
 	case AGGR_UNSET:
 	default:
 		break;
@@ -1072,6 +1084,7 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	case AGGR_NONE:
 	case AGGR_GLOBAL:
 	case AGGR_THREAD:
+	case AGGR_DEVICE:
 	case AGGR_UNSET:
 	default:
 		break;
@@ -1129,6 +1142,12 @@ __weak void arch_topdown_group_warn(void)
 {
 }
 
+__weak int iiostat_print_device_list(struct evlist *evlist __maybe_unused,
+				      struct perf_stat_config *config __maybe_unused)
+{
+	return 0;
+}
+
 /*
  * Add default attributes, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -1358,6 +1377,10 @@ static int add_default_attributes(void)
 		free(str);
 	}
 
+	if (stat_config.iiostat_run &&
+		iiostat_print_device_list(evsel_list, &stat_config) < 0)
+		return -1;
+
 	if (!evsel_list->core.nr_entries) {
 		if (target__has_cpu(&target))
 			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
@@ -1680,6 +1703,10 @@ static void setup_system_wide(int forks)
 	}
 }
 
+__weak void iiostat_delete_device_list(struct evlist *evlist __maybe_unused)
+{
+}
+
 int cmd_stat(int argc, const char **argv)
 {
 	const char * const stat_usage[] = {
@@ -1844,7 +1871,7 @@ int cmd_stat(int argc, const char **argv)
 	 * --per-thread is aggregated per thread, we dont mix it with cpu mode
 	 */
 	if (((stat_config.aggr_mode != AGGR_GLOBAL &&
-	      stat_config.aggr_mode != AGGR_THREAD) || nr_cgroups) &&
+	      stat_config.aggr_mode != AGGR_THREAD && stat_config.aggr_mode != AGGR_DEVICE) || nr_cgroups) &&
 	    !target__has_cpu(&target)) {
 		fprintf(stderr, "both cgroup and no-aggregation "
 			"modes only available in system-wide mode\n");
@@ -2005,6 +2032,9 @@ int cmd_stat(int argc, const char **argv)
 	perf_stat__exit_aggr_mode();
 	perf_evlist__free_stats(evsel_list);
 out:
+	if (stat_config.iiostat_run)
+		iiostat_delete_device_list(evsel_list);
+
 	zfree(&stat_config.walltime_run);
 
 	if (smi_cost && smi_reset)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ddc5ee6f6592..4d1582db3c7b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -100,6 +100,7 @@ struct evsel {
 		perf_evsel__sb_cb_t	*cb;
 		void			*data;
 	} side_band;
+	void			*perf_device;
 };
 
 struct perf_missing_features {
diff --git a/tools/perf/util/iiostat.h b/tools/perf/util/iiostat.h
new file mode 100644
index 000000000000..4c886beec348
--- /dev/null
+++ b/tools/perf/util/iiostat.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * perf stat --iiostat
+ *
+ * Copyright (C) 2019, Intel Corporation
+ *
+ * Authors: Roman Sudarikov <roman.sudarikov@intel.com>
+ *	    Alexander Antonov <alexander.antonov@intel.com>
+ */
+
+#ifndef _IIOSTAT_H
+#define _IIOSTAT_H
+
+#include "util/stat.h"
+#include <subcmd/parse-options.h>
+#include "util/parse-events.h"
+#include "util/evlist.h"
+
+struct option;
+struct perf_stat_config;
+struct evlist;
+struct timespec;
+
+int  iiostat_parse(const struct option *opt, const char *str,
+		    int unset __maybe_unused);
+void iiostat_prefix(struct perf_stat_config *config, struct evlist *evlist,
+		     char *prefix, struct timespec *ts);
+void iiostat_print_metric(struct perf_stat_config *config __maybe_unused,
+			   struct evsel *evsel __maybe_unused,
+			   struct perf_stat_output_ctx *out __maybe_unused);
+int iiostat_print_device_list(struct evlist *evlist __maybe_unused,
+			       struct perf_stat_config *config __maybe_unused);
+void iiostat_delete_device_list(struct evlist *evlist);
+
+#endif /* _IIOSTAT_H */
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 93c03b39cd9c..65d08daff8d9 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1396,7 +1396,7 @@ static void python_process_stat(struct perf_stat_config *config,
 	struct perf_cpu_map *cpus = counter->core.cpus;
 	int cpu, thread;
 
-	if (config->aggr_mode == AGGR_GLOBAL) {
+	if (config->aggr_mode == AGGR_GLOBAL || config->aggr_mode == AGGR_DEVICE) {
 		process_stat(counter, -1, -1, tstamp,
 			     &counter->counts->aggr);
 		return;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ed3b0ac2f785..def4ef6bb155 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -16,6 +16,8 @@
 #include <linux/ctype.h>
 #include "cgroup.h"
 #include <api/fs/fs.h>
+#include "iiostat.h"
+#include "debug.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -123,6 +125,7 @@ static void aggr_printout(struct perf_stat_config *config,
 			config->csv_sep);
 		break;
 	case AGGR_GLOBAL:
+	case AGGR_DEVICE:
 	case AGGR_UNSET:
 	default:
 		break;
@@ -301,6 +304,11 @@ static void print_metric_header(struct perf_stat_config *config,
 	struct outstate *os = ctx;
 	char tbuf[1024];
 
+	if (os->evsel->perf_device && os->evsel->evlist->selected->perf_device
+	    && config->iiostat_run &&
+	    os->evsel->perf_device != os->evsel->evlist->selected->perf_device)
+		return;
+
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
@@ -322,7 +330,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	if (config->aggr_mode == AGGR_NONE)
 		return id;
 
-	if (config->aggr_mode == AGGR_GLOBAL)
+	if (config->aggr_mode == AGGR_GLOBAL || config->aggr_mode == AGGR_DEVICE)
 		return 0;
 
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
@@ -416,6 +424,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	if (config->csv_output && !config->metric_only) {
 		static int aggr_fields[] = {
 			[AGGR_GLOBAL] = 0,
+			[AGGR_DEVICE] = 0,
 			[AGGR_THREAD] = 1,
 			[AGGR_NONE] = 1,
 			[AGGR_SOCKET] = 2,
@@ -899,6 +908,7 @@ static int aggr_header_lens[] = {
 	[AGGR_NONE] = 6,
 	[AGGR_THREAD] = 24,
 	[AGGR_GLOBAL] = 0,
+	[AGGR_DEVICE] = 0,
 };
 
 static const char *aggr_header_csv[] = {
@@ -907,7 +917,8 @@ static const char *aggr_header_csv[] = {
 	[AGGR_SOCKET] 	= 	"socket,cpus",
 	[AGGR_NONE] 	= 	"cpu,",
 	[AGGR_THREAD] 	= 	"comm-pid,",
-	[AGGR_GLOBAL] 	=	""
+	[AGGR_GLOBAL]	=	"",
+	[AGGR_DEVICE]	=	"device,"
 };
 
 static void print_metric_headers(struct perf_stat_config *config,
@@ -931,6 +942,8 @@ static void print_metric_headers(struct perf_stat_config *config,
 			fputs("time,", config->output);
 		fputs(aggr_header_csv[config->aggr_mode], config->output);
 	}
+	if (config->iiostat_run && !config->interval && !config->csv_output)
+		fprintf(config->output, " device         ");
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
@@ -949,6 +962,13 @@ static void print_metric_headers(struct perf_stat_config *config,
 	fputc('\n', config->output);
 }
 
+__weak void iiostat_prefix(struct perf_stat_config *config __maybe_unused,
+			    struct evlist *evlist __maybe_unused,
+			    char *prefix __maybe_unused,
+			    struct timespec *ts __maybe_unused)
+{
+}
+
 static void print_interval(struct perf_stat_config *config,
 			   struct evlist *evlist,
 			   char *prefix, struct timespec *ts)
@@ -961,7 +981,8 @@ static void print_interval(struct perf_stat_config *config,
 	if (config->interval_clear)
 		puts(CONSOLE_CLEAR);
 
-	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
+	if (!config->iiostat_run)
+		sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
 
 	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
 		switch (config->aggr_mode) {
@@ -990,6 +1011,9 @@ static void print_interval(struct perf_stat_config *config,
 			if (!metric_only)
 				fprintf(output, "                  counts %*s events\n", unit_width, "unit");
 			break;
+		case AGGR_DEVICE:
+			fprintf(output, "#           time  device        ");
+			break;
 		case AGGR_GLOBAL:
 		default:
 			fprintf(output, "#           time");
@@ -1167,6 +1191,10 @@ perf_evlist__print_counters(struct evlist *evlist,
 	int interval = config->interval;
 	struct evsel *counter;
 	char buf[64], *prefix = NULL;
+	void *device = NULL;
+
+	if (config->iiostat_run)
+		evlist->selected = evlist__first(evlist);
 
 	if (interval)
 		print_interval(config, evlist, prefix = buf, ts);
@@ -1180,7 +1208,7 @@ perf_evlist__print_counters(struct evlist *evlist,
 			print_metric_headers(config, evlist, prefix, false);
 		if (num_print_iv++ == 25)
 			num_print_iv = 0;
-		if (config->aggr_mode == AGGR_GLOBAL && prefix)
+		if ((config->aggr_mode == AGGR_GLOBAL) && prefix)
 			fprintf(config->output, "%s", prefix);
 	}
 
@@ -1214,6 +1242,23 @@ perf_evlist__print_counters(struct evlist *evlist,
 			}
 		}
 		break;
+	case AGGR_DEVICE:
+		counter = evlist__first(evlist);
+		perf_evlist__set_selected(evlist, counter);
+		iiostat_prefix(config, evlist, prefix = buf, ts);
+		fprintf(config->output, "%s", prefix);
+		evlist__for_each_entry(evlist, counter) {
+			device = evlist->selected->perf_device;
+			if (device && device != counter->perf_device) {
+				perf_evlist__set_selected(evlist, counter);
+				iiostat_prefix(config, evlist, prefix, ts);
+				fprintf(config->output, "\n%s", prefix);
+			}
+			print_counter_aggr(config, counter, prefix);
+			if ((counter->idx + 1) == evlist->core.nr_entries)
+				fputc('\n', config->output);
+		}
+		break;
 	case AGGR_UNSET:
 	default:
 		break;
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2c41d47f6f83..8c46c172a457 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -9,6 +9,8 @@
 #include "expr.h"
 #include "metricgroup.h"
 #include <linux/zalloc.h>
+#include "iiostat.h"
+#include "counts.h"
 
 /*
  * AGGR_GLOBAL: Use CPU 0
@@ -814,6 +816,12 @@ static void generic_metric(struct perf_stat_config *config,
 		zfree(&pctx.ids[i].name);
 }
 
+__weak void iiostat_print_metric(struct perf_stat_config *config __maybe_unused,
+				  struct evsel *evsel __maybe_unused,
+				  struct perf_stat_output_ctx *out __maybe_unused)
+{
+}
+
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int cpu,
@@ -829,7 +837,9 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	struct metric_event *me;
 	int num = 1;
 
-	if (perf_evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
+	if (config->iiostat_run) {
+		iiostat_print_metric(config, evsel, out);
+	} else if (perf_evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
 		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
 
 		if (total) {
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index ebdd130557fb..672d33c1cafe 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -318,6 +318,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		}
 		break;
 	case AGGR_GLOBAL:
+	case AGGR_DEVICE:
 		aggr->val += count->val;
 		aggr->ena += count->ena;
 		aggr->run += count->run;
@@ -377,7 +378,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	if (ret)
 		return ret;
 
-	if (config->aggr_mode != AGGR_GLOBAL)
+	if (config->aggr_mode != AGGR_GLOBAL && config->aggr_mode != AGGR_DEVICE)
 		return 0;
 
 	if (!counter->snapshot)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index edbeb2f63e8d..be65afdaad90 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -46,6 +46,7 @@ enum aggr_mode {
 	AGGR_DIE,
 	AGGR_CORE,
 	AGGR_THREAD,
+	AGGR_DEVICE,
 	AGGR_UNSET,
 };
 
@@ -106,6 +107,7 @@ struct perf_stat_config {
 	bool			 big_num;
 	bool			 no_merge;
 	bool			 walltime_run_table;
+	bool			 iiostat_run;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.19.1

