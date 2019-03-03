Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE70C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B0A20842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCCQrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:47:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:31316 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfCCQrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:47:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 08:47:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,436,1544515200"; 
   d="scan'208";a="128667519"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2019 08:47:12 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/9] HID: intel-ish-hid: Simplify ishtp_cl_link()
Date:   Sun,  3 Mar 2019 08:46:48 -0800
Message-Id: <20190303164654.29400-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
References: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers will only use ISHTP_HOST_CLIENT_ID_ANY, so get rid of
option to pass this additional id.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c |  2 +-
 drivers/hid/intel-ish-hid/ishtp/client.c     | 14 ++++----------
 drivers/hid/intel-ish-hid/ishtp/client.h     |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index ffed7c91bebf..287d71338b91 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -637,7 +637,7 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 	dev_dbg(cl_data_to_dev(client_data), "%s\n", __func__);
 	hid_ishtp_trace(client_data,  "%s reset flag: %d\n", __func__, reset);
 
-	rv = ishtp_cl_link(hid_ishtp_cl, ISHTP_HOST_CLIENT_ID_ANY);
+	rv = ishtp_cl_link(hid_ishtp_cl);
 	if (rv) {
 		dev_err(cl_data_to_dev(client_data),
 			"ishtp_cl_link failed\n");
diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index 760e48a368a8..657b46dcefa6 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -168,9 +168,6 @@ EXPORT_SYMBOL(ishtp_cl_free);
 /**
  * ishtp_cl_link() - Reserve a host id and link the client instance
  * @cl: client device instance
- * @id: host client id to use. It can be ISHTP_HOST_CLIENT_ID_ANY if any
- *	id from the available can be used
- *
  *
  * This allocates a single bit in the hostmap. This function will make sure
  * that not many client sessions are opened at the same time. Once allocated
@@ -179,11 +176,11 @@ EXPORT_SYMBOL(ishtp_cl_free);
  *
  * Return: 0 or error code on failure
  */
-int ishtp_cl_link(struct ishtp_cl *cl, int id)
+int ishtp_cl_link(struct ishtp_cl *cl)
 {
 	struct ishtp_device *dev;
-	unsigned long	flags, flags_cl;
-	int	ret = 0;
+	unsigned long flags, flags_cl;
+	int id, ret = 0;
 
 	if (WARN_ON(!cl || !cl->dev))
 		return -EINVAL;
@@ -197,10 +194,7 @@ int ishtp_cl_link(struct ishtp_cl *cl, int id)
 		goto unlock_dev;
 	}
 
-	/* If Id is not assigned get one*/
-	if (id == ISHTP_HOST_CLIENT_ID_ANY)
-		id = find_first_zero_bit(dev->host_clients_map,
-			ISHTP_CLIENTS_MAX);
+	id = find_first_zero_bit(dev->host_clients_map, ISHTP_CLIENTS_MAX);
 
 	if (id >= ISHTP_CLIENTS_MAX) {
 		spin_unlock_irqrestore(&dev->device_lock, flags);
diff --git a/drivers/hid/intel-ish-hid/ishtp/client.h b/drivers/hid/intel-ish-hid/ishtp/client.h
index 992625891a6c..afa8b1f521d0 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.h
+++ b/drivers/hid/intel-ish-hid/ishtp/client.h
@@ -172,7 +172,7 @@ static inline bool ishtp_cl_cmp_id(const struct ishtp_cl *cl1,
 /* exported functions from ISHTP under client management scope */
 struct ishtp_cl *ishtp_cl_allocate(struct ishtp_cl_device *cl_device);
 void ishtp_cl_free(struct ishtp_cl *cl);
-int ishtp_cl_link(struct ishtp_cl *cl, int id);
+int ishtp_cl_link(struct ishtp_cl *cl);
 void ishtp_cl_unlink(struct ishtp_cl *cl);
 int ishtp_cl_disconnect(struct ishtp_cl *cl);
 int ishtp_cl_connect(struct ishtp_cl *cl);
-- 
2.17.2

