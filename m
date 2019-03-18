Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D044C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C762133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfCRTPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:15:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:54512 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfCRTPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:15:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 12:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="156107038"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2019 12:15:05 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 10/10] HID: intel-ish-hid: Add interface function for PCI device pointer
Date:   Mon, 18 Mar 2019 12:14:28 -0700
Message-Id: <20190318191428.6527-11-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
References: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of directly accessing PCI device poitner via struct ishtp_cl,
create interface function for same. This is required for DMA transfer.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 13 +++++++++++++
 include/linux/intel-ish-client-if.h   |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 66a485a41481..fb8ca12955b4 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -855,6 +855,19 @@ struct device *ishtp_device(struct ishtp_cl_device *device)
 }
 EXPORT_SYMBOL(ishtp_device);
 
+/**
+ * ishtp_get_pci_device() - Return PCI device dev pointer
+ * This interface is used to return PCI device pointer
+ * from ishtp_cl_device instance.
+ *
+ * Return: device *.
+ */
+struct device *ishtp_get_pci_device(struct ishtp_cl_device *device)
+{
+	return device->ishtp_dev->devc;
+}
+EXPORT_SYMBOL(ishtp_get_pci_device);
+
 /**
  * ishtp_trace_callback() - Return trace callback
  *
diff --git a/include/linux/intel-ish-client-if.h b/include/linux/intel-ish-client-if.h
index e98bfbb1e07e..16255c2ca2f4 100644
--- a/include/linux/intel-ish-client-if.h
+++ b/include/linux/intel-ish-client-if.h
@@ -77,6 +77,8 @@ int ishtp_register_event_cb(struct ishtp_cl_device *device,
 struct device *ishtp_device(struct ishtp_cl_device *cl_device);
 /* Trace interface for clients */
 void *ishtp_trace_callback(struct ishtp_cl_device *cl_device);
+/* Get device pointer of PCI device for DMA acces */
+struct device *ishtp_get_pci_device(struct ishtp_cl_device *cl_device);
 
 struct ishtp_cl *ishtp_cl_allocate(struct ishtp_cl_device *cl_device);
 void ishtp_cl_free(struct ishtp_cl *cl);
-- 
2.17.2

