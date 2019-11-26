Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B00C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7905207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfKZQhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:37:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:39751 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfKZQhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:37:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 08:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="359212559"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2019 08:36:58 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH 6/6] perf stat: Add PCI device name to --iiostat output
Date:   Tue, 26 Nov 2019 19:36:30 +0300
Message-Id: <20191126163630.17300-7-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191126163630.17300-6-roman.sudarikov@linux.intel.com>
References: <20191126163630.17300-1-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-3-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-4-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-5-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-6-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

Example:
   $ perf stat --iiostat=show

Sample output w/o libpci:

    S0-RootPort0-uncore_iio_0<00:00.0>
    S1-RootPort2-uncore_iio_2<af:00.0>

Sample output with libpci:

    S0-RootPort0-uncore_iio_0<00:00.0 Sky Lake-E DMI3 Registers>
    S1-RootPort2-uncore_iio_2<af:00.0 Omni-Path HFI Silicon 100 Series [discrete]>

Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
---
 tools/perf/arch/x86/util/iiostat.c | 15 ++++++++--
 tools/perf/util/pci.c              | 46 ++++++++++++++++++++++++++++++
 tools/perf/util/pci.h              |  4 +++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/iiostat.c b/tools/perf/arch/x86/util/iiostat.c
index 058a01d3a93f..7aad994e4936 100644
--- a/tools/perf/arch/x86/util/iiostat.c
+++ b/tools/perf/arch/x86/util/iiostat.c
@@ -113,6 +113,7 @@ struct dev_info {
 	u8 die;
 	u8 pmu_idx;
 	u8 root_port_nr;
+	char *name;
 };
 
 struct iio_device {
@@ -210,7 +211,12 @@ static struct iio_device *iio_device_new(struct dev_info *info)
 	if (p) {
 		INIT_LIST_HEAD(&(p->node));
 		p->dev_info = *info;
+		p->dev_info.name = strdup(pci_device_name(info->bdf));
 		p->idx = -1;
+		if (!p->dev_info.name) {
+			free(p);
+			p = NULL;
+		}
 	}
 	return p;
 }
@@ -219,6 +225,7 @@ static void iio_device_delete(struct iio_device *device)
 {
 	if (device) {
 		list_del_init(&(device->node));
+		free(device->dev_info.name);
 		free(device);
 	}
 }
@@ -227,11 +234,11 @@ static void iiostat_device_show(FILE *output,
 			const struct iio_device * const device)
 {
 	if (output && device)
-		fprintf(output, "S%d-RootPort%d-uncore_iio_%d<%02x:%02x.%x>\n",
+		fprintf(output, "S%d-RootPort%d-uncore_iio_%d<%02x:%02x.%x %s>\n",
 			device->dev_info.die,
 			device->dev_info.root_port_nr, device->dev_info.pmu_idx,
 			device->dev_info.bdf.busno, device->dev_info.bdf.devno,
-			device->dev_info.bdf.funcno);
+			device->dev_info.bdf.funcno, device->dev_info.name);
 }
 
 static struct iio_devs_list *iio_devs_list_new(void)
@@ -426,9 +433,12 @@ static int iio_devs_scan(struct iio_devs_list **list)
 	if (!rp_nr)
 		return -ENOMEM;
 
+	pci_library_init();
+
 	interim = iio_devs_list_new();
 	if (!interim) {
 		free(rp_nr);
+		pci_library_cleanup();
 		return -ENOMEM;
 	}
 
@@ -457,6 +467,7 @@ static int iio_devs_scan(struct iio_devs_list **list)
 		iio_devs_list_free(interim);
 
 	free(rp_nr);
+	pci_library_cleanup();
 
 	return ret;
 }
diff --git a/tools/perf/util/pci.c b/tools/perf/util/pci.c
index ba1a48e9d0cc..6ce05e6ba037 100644
--- a/tools/perf/util/pci.c
+++ b/tools/perf/util/pci.c
@@ -8,6 +8,9 @@
  *	    Alexander Antonov <alexander.antonov@intel.com>
  */
 #include "pci.h"
+#ifdef HAVE_LIBPCI_SUPPORT
+#include <pci/pci.h>
+#endif
 #include <api/fs/fs.h>
 #include <linux/kernel.h>
 #include <string.h>
@@ -16,6 +19,49 @@
 #define PCI_DEVICE_PATH_TEMPLATE "bus/pci/devices/0000:%02x:%02x.0"
 #define PCI_DEVICE_FILE_TEMPLATE PCI_DEVICE_PATH_TEMPLATE"/%s"
 
+#ifdef HAVE_LIBPCI_SUPPORT
+static struct pci_access *pacc;
+#endif
+
+void pci_library_init(void)
+{
+#ifdef HAVE_LIBPCI_SUPPORT
+	pacc = pci_alloc();
+	if (pacc) {
+		pci_init(pacc);
+		pci_scan_bus(pacc);
+	}
+#endif
+}
+
+void pci_library_cleanup(void)
+{
+#ifdef HAVE_LIBPCI_SUPPORT
+	pci_cleanup(pacc);
+#endif
+}
+
+char *pci_device_name(struct bdf bdf __maybe_unused)
+{
+#ifdef HAVE_LIBPCI_SUPPORT
+	struct pci_dev *device;
+	char namebuf[PATH_MAX];
+
+	if (pacc) {
+		device = pci_get_dev(pacc, 0, bdf.busno, bdf.devno, bdf.funcno);
+		if (device) {
+			pci_fill_info(device, PCI_FILL_IDENT);
+			return pci_lookup_name(pacc, namebuf, sizeof(namebuf),
+					       PCI_LOOKUP_DEVICE, device->vendor_id,
+					       device->device_id);
+		}
+	}
+	return (char *)"";
+#else
+	return (char *)"";
+#endif
+}
+
 static bool directory_exists(const char * const path)
 {
 	return (access(path, F_OK) == 0);
diff --git a/tools/perf/util/pci.h b/tools/perf/util/pci.h
index e963b12e10e7..8d8551360419 100644
--- a/tools/perf/util/pci.h
+++ b/tools/perf/util/pci.h
@@ -17,6 +17,10 @@ struct bdf {
 	u8 funcno;
 };
 
+void pci_library_init(void);
+void pci_library_cleanup(void);
+
+char *pci_device_name(struct bdf bdf);
 bool pci_device_probe(struct bdf bdf);
 bool is_pci_device_root_port(struct bdf bdf, u8 *secondary, u8 *subordinate);
 
-- 
2.19.1

