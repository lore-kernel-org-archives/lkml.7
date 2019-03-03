Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1E4C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E1F206DD
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCCQrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:47:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:31318 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfCCQrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:47:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 08:47:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,436,1544515200"; 
   d="scan'208";a="128667524"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2019 08:47:13 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 7/9] HID: intel-ish-hid: Add interface functions for struct ishtp_cl
Date:   Sun,  3 Mar 2019 08:46:52 -0800
Message-Id: <20190303164654.29400-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
References: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of directly accessing members of struct ishtp_cl, create interface
functions to access them.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/client.c | 42 ++++++++++++++++++++++++
 include/linux/intel-ish-client-if.h      |  7 ++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index 657b46dcefa6..b7ac5e3b1e82 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -1063,3 +1063,45 @@ void recv_ishtp_cl_msg_dma(struct ishtp_device *dev, void *msg,
 eoi:
 	return;
 }
+
+void *ishtp_get_client_data(struct ishtp_cl *cl)
+{
+	return cl->client_data;
+}
+EXPORT_SYMBOL(ishtp_get_client_data);
+
+void ishtp_set_client_data(struct ishtp_cl *cl, void *data)
+{
+	cl->client_data = data;
+}
+EXPORT_SYMBOL(ishtp_set_client_data);
+
+struct ishtp_device *ishtp_get_ishtp_device(struct ishtp_cl *cl)
+{
+	return cl->dev;
+}
+EXPORT_SYMBOL(ishtp_get_ishtp_device);
+
+void ishtp_set_tx_ring_size(struct ishtp_cl *cl, int size)
+{
+	cl->tx_ring_size = size;
+}
+EXPORT_SYMBOL(ishtp_set_tx_ring_size);
+
+void ishtp_set_rx_ring_size(struct ishtp_cl *cl, int size)
+{
+	cl->rx_ring_size = size;
+}
+EXPORT_SYMBOL(ishtp_set_rx_ring_size);
+
+void ishtp_set_connection_state(struct ishtp_cl *cl, int state)
+{
+	cl->state = state;
+}
+EXPORT_SYMBOL(ishtp_set_connection_state);
+
+void ishtp_cl_set_fw_client_id(struct ishtp_cl *cl, int fw_client_id)
+{
+	cl->fw_client_id = fw_client_id;
+}
+EXPORT_SYMBOL(ishtp_cl_set_fw_client_id);
diff --git a/include/linux/intel-ish-client-if.h b/include/linux/intel-ish-client-if.h
index 7ce172f656f8..526e3048e09f 100644
--- a/include/linux/intel-ish-client-if.h
+++ b/include/linux/intel-ish-client-if.h
@@ -87,5 +87,12 @@ int ishtp_cl_flush_queues(struct ishtp_cl *cl);
 int ishtp_cl_io_rb_recycle(struct ishtp_cl_rb *rb);
 bool ishtp_cl_tx_empty(struct ishtp_cl *cl);
 struct ishtp_cl_rb *ishtp_cl_rx_get_rb(struct ishtp_cl *cl);
+void *ishtp_get_client_data(struct ishtp_cl *cl);
+void ishtp_set_client_data(struct ishtp_cl *cl, void *data);
+struct ishtp_device *ishtp_get_ishtp_device(struct ishtp_cl *cl);
+void ishtp_set_tx_ring_size(struct ishtp_cl *cl, int size);
+void ishtp_set_rx_ring_size(struct ishtp_cl *cl, int size);
+void ishtp_set_connection_state(struct ishtp_cl *cl, int state);
+void ishtp_cl_set_fw_client_id(struct ishtp_cl *cl, int fw_client_id);
 
 #endif /* _INTEL_ISH_CLIENT_IF_H_ */
-- 
2.17.2

