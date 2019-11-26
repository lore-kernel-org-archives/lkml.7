Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782CCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD672071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfKZQgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:36:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:53760 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfKZQgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:36:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 08:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="359212460"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2019 08:36:40 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH 2/6] perf tools: Helper functions to enumerate and probe PCI devices
Date:   Tue, 26 Nov 2019 19:36:26 +0300
Message-Id: <20191126163630.17300-3-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
References: <20191126163630.17300-1-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

This makes aggregation of performance data per I/O device
available in the perf user tools.

Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
---
 tools/perf/util/Build |  1 +
 tools/perf/util/pci.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pci.h | 23 +++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 tools/perf/util/pci.c
 create mode 100644 tools/perf/util/pci.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8dcfca1a882f..02b699f8a10a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -23,6 +23,7 @@ perf-y += memswap.o
 perf-y += parse-events.o
 perf-y += perf_regs.o
 perf-y += path.o
+perf-y += pci.o
 perf-y += print_binary.o
 perf-y += rlimit.o
 perf-y += argv_split.o
diff --git a/tools/perf/util/pci.c b/tools/perf/util/pci.c
new file mode 100644
index 000000000000..ba1a48e9d0cc
--- /dev/null
+++ b/tools/perf/util/pci.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helper functions to access PCI CFG space.
+ *
+ * Copyright (C) 2019, Intel Corporation
+ *
+ * Authors: Roman Sudarikov <roman.sudarikov@intel.com>
+ *	    Alexander Antonov <alexander.antonov@intel.com>
+ */
+#include "pci.h"
+#include <api/fs/fs.h>
+#include <linux/kernel.h>
+#include <string.h>
+#include <unistd.h>
+
+#define PCI_DEVICE_PATH_TEMPLATE "bus/pci/devices/0000:%02x:%02x.0"
+#define PCI_DEVICE_FILE_TEMPLATE PCI_DEVICE_PATH_TEMPLATE"/%s"
+
+static bool directory_exists(const char * const path)
+{
+	return (access(path, F_OK) == 0);
+}
+
+bool pci_device_probe(struct bdf bdf)
+{
+	char path[PATH_MAX];
+
+	scnprintf(path, PATH_MAX, "%s/"PCI_DEVICE_PATH_TEMPLATE,
+		  sysfs__mountpoint(), bdf.busno, bdf.devno);
+	return directory_exists(path);
+}
+
+bool is_pci_device_root_port(struct bdf bdf, u8 *secondary, u8 *subordinate)
+{
+	char path[PATH_MAX];
+	int secondary_interim;
+	int subordinate_interim;
+
+	scnprintf(path, PATH_MAX, PCI_DEVICE_FILE_TEMPLATE,
+		  bdf.busno, bdf.devno, "secondary_bus_number");
+	if (!sysfs__read_int(path, &secondary_interim)) {
+		scnprintf(path, PATH_MAX, PCI_DEVICE_FILE_TEMPLATE,
+			  bdf.busno, bdf.devno, "subordinate_bus_number");
+		if (!sysfs__read_int(path, &subordinate_interim)) {
+			if (secondary)
+				*secondary = (u8)secondary_interim;
+			if (subordinate)
+				*subordinate = (u8)subordinate_interim;
+			return true;
+		}
+	}
+	return false;
+}
diff --git a/tools/perf/util/pci.h b/tools/perf/util/pci.h
new file mode 100644
index 000000000000..e963b12e10e7
--- /dev/null
+++ b/tools/perf/util/pci.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ *
+ * Copyright (C) 2019, Intel Corporation
+ *
+ * Authors: Roman Sudarikov <roman.sudarikov@intel.com>
+ *	    Alexander Antonov <alexander.antonov@intel.com>
+ */
+#ifndef _PCI_H
+#define _PCI_H
+
+#include <linux/types.h>
+
+struct bdf {
+	u8 busno;
+	u8 devno;
+	u8 funcno;
+};
+
+bool pci_device_probe(struct bdf bdf);
+bool is_pci_device_root_port(struct bdf bdf, u8 *secondary, u8 *subordinate);
+
+#endif /* _PCI_H */
-- 
2.19.1

