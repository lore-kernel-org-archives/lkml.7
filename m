Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD043C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E1E2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfKZQgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:36:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:53760 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfKZQgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:36:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 08:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="359212477"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2019 08:36:44 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH 3/6] perf stat: Helper functions for list of IIO devices
Date:   Tue, 26 Nov 2019 19:36:27 +0300
Message-Id: <20191126163630.17300-4-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191126163630.17300-3-roman.sudarikov@linux.intel.com>
References: <20191126163630.17300-1-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-3-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

Helper functions to iterate through and manipulate with list
of struct iio_device objects. The following patch will use it.

Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
---
 tools/perf/arch/x86/util/iiostat.c | 178 +++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 tools/perf/arch/x86/util/iiostat.c

diff --git a/tools/perf/arch/x86/util/iiostat.c b/tools/perf/arch/x86/util/iiostat.c
new file mode 100644
index 000000000000..b93b9b9da418
--- /dev/null
+++ b/tools/perf/arch/x86/util/iiostat.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * perf stat --iiostat
+ *
+ * Copyright (C) 2019, Intel Corporation
+ *
+ * Authors: Roman Sudarikov <roman.sudarikov@intel.com>
+ *	    Alexander Antonov <alexander.antonov@intel.com>
+ */
+#include "path.h"
+#include "pci.h"
+#include <api/fs/fs.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include "util/debug.h"
+#include "util/iiostat.h"
+#include "util/counts.h"
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <regex.h>
+
+struct dev_info {
+	struct bdf bdf;
+	u8 ch_mask;
+	u8 socket;
+	u8 pmu_idx;
+	u8 root_port_nr;
+};
+
+struct iio_device {
+	struct list_head node;
+	struct dev_info	dev_info;
+	int idx;
+};
+
+struct iio_devs_list {
+	struct list_head devices;
+	int nr_entries;
+};
+
+/**
+ * __iio_devs_for_each_device - iterate thru all the iio devices
+ * @list: list_head instance to iterate
+ * @device: struct iio_device iterator
+ */
+#define __iio_devs_for_each_device(list, device) \
+		list_for_each_entry(device, list, node)
+
+/**
+ * iio_devs_list_for_each_device - iterate thru all the iio devices
+ * @list: iio_devs_list instance to iterate
+ * @device: struct iio_device iterator
+ */
+#define iio_devs_list_for_each_device(list, device) \
+	__iio_devs_for_each_device(&(list->devices), device)
+
+/**
+ * __iio_devs_for_each_device_safe - safely iterate thru all the iio devices
+ * @devices: list_head instance to iterate
+ * @tmp: struct iio_device temp iterator
+ * @device: struct iio_device iterator
+ */
+#define __iio_devs_for_each_device_safe(devices, tmp, device) \
+		list_for_each_entry_safe(device, tmp, devices, node)
+
+/**
+ * iio_devs_list_for_each_device_safe - safely iterate thru all the iio devices
+ * @list: iio_devs_list instance to iterate
+ * @tmp: struct iio_device temp iterator
+ * @device: struct iio_device iterator
+ */
+#define iio_devs_list_for_each_device_safe(list, tmp, device) \
+		__iio_devs_for_each_device_safe(&(list->devices), tmp, device)
+
+#define iio_device_delete_from_list(device) \
+		list_del(&(device->node))
+
+static struct iio_device *iio_device_new(struct dev_info *info)
+{
+	struct iio_device *p =
+		(struct iio_device *)calloc(1, sizeof(struct iio_device));
+
+	if (p) {
+		INIT_LIST_HEAD(&(p->node));
+		p->dev_info = *info;
+		p->idx = -1;
+	}
+	return p;
+}
+
+static void iio_device_delete(struct iio_device *device)
+{
+	if (device) {
+		list_del_init(&(device->node));
+		free(device);
+	}
+}
+
+static void iiostat_device_show(FILE *output,
+			const struct iio_device * const device)
+{
+	if (output && device)
+		fprintf(output, "S%d-RootPort%d-uncore_iio_%d<%02x:%02x.%x>\n",
+			device->dev_info.socket,
+			device->dev_info.root_port_nr, device->dev_info.pmu_idx,
+			device->dev_info.bdf.busno, device->dev_info.bdf.devno,
+			device->dev_info.bdf.funcno);
+}
+
+static struct iio_devs_list *iio_devs_list_new(void)
+{
+	struct iio_devs_list *devs_list =
+		(struct iio_devs_list *)calloc(1, sizeof(struct iio_devs_list));
+
+	if (devs_list)
+		INIT_LIST_HEAD(&(devs_list->devices));
+	return devs_list;
+}
+
+static void iio_devs_list_free(struct iio_devs_list *list)
+{
+	struct iio_device *tmp_device;
+	struct iio_device *device;
+
+	if (list) {
+		iio_devs_list_for_each_device_safe(list, tmp_device, device)
+			iio_device_delete(device);
+		list_del_init(&(list->devices));
+		free(list);
+	}
+}
+
+static bool is_same_iio_device(struct bdf lhd, struct bdf rhd)
+{
+	return (lhd.busno == rhd.busno) && (lhd.devno == rhd.devno) &&
+		(lhd.funcno == rhd.funcno);
+}
+
+static void iio_devs_list_add_device(struct iio_devs_list *list,
+				      struct iio_device * const device)
+{
+	struct iio_device *it;
+
+	if (list && device) {
+		iio_devs_list_for_each_device(list, it)
+			if (is_same_iio_device(it->dev_info.bdf, device->dev_info.bdf))
+				return;
+		device->idx = list->nr_entries++;
+		list_add_tail(&(device->node), &(list->devices));
+	}
+}
+
+static void iio_devs_list_join_list(struct iio_devs_list *dest,
+				     struct iio_devs_list *src)
+{
+	int idx = 0;
+	struct iio_device *it;
+
+	if (dest && src) {
+		if (dest->nr_entries) {
+			it = list_last_entry(&(dest->devices),
+					     struct iio_device, node);
+			idx = it->idx + 1;
+		}
+		iio_devs_list_for_each_device(src, it)
+			it->idx = idx++;
+		list_splice_tail(&(src->devices), &(dest->devices));
+		dest->nr_entries += src->nr_entries;
+	}
+}
-- 
2.19.1

