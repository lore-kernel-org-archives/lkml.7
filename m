Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4D2CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1D620B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfKDQLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:11:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:36385 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfKDQLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:11:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 08:11:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="195496809"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2019 08:10:59 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        richard.gong@intel.com
Subject: [PATCHv3] firmware: Fix incompatible function behavior for RSU driver
Date:   Mon,  4 Nov 2019 10:24:36 -0600
Message-Id: <1572884676-1385-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

The older versions of remote system update (RSU) firmware don't support
retry and notify features then the kernel module dies when it queries
the RSU retry counter or performs notify operation.

Update the Intel service layer and RSU drivers to be compatible with
all versions of RSU firmware.

Reported-by: Radu Barcau <radu.bacrau@intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: update commit messages
v3: fix 2 build warnings reported by test robot
---
 drivers/firmware/stratix10-rsu.c                   | 42 ++++++++++------------
 drivers/firmware/stratix10-svc.c                   | 18 +++++++++-
 .../linux/firmware/intel/stratix10-svc-client.h    |  8 +++++
 3 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index bb008c0..f853333 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -20,7 +20,6 @@
 #define RSU_VERSION_MASK		GENMASK_ULL(63, 32)
 #define RSU_ERROR_LOCATION_MASK		GENMASK_ULL(31, 0)
 #define RSU_ERROR_DETAIL_MASK		GENMASK_ULL(63, 32)
-#define RSU_FW_VERSION_MASK		GENMASK_ULL(15, 0)
 
 #define RSU_TIMEOUT	(msecs_to_jiffies(SVC_RSU_REQUEST_TIMEOUT_MS))
 
@@ -109,9 +108,12 @@ static void rsu_command_callback(struct stratix10_svc_client *client,
 {
 	struct stratix10_rsu_priv *priv = client->priv;
 
-	if (data->status != BIT(SVC_STATUS_RSU_OK))
-		dev_err(client->dev, "RSU returned status is %i\n",
-			data->status);
+	if (data->status == BIT(SVC_STATUS_RSU_NO_SUPPORT))
+		dev_warn(client->dev, "Secure FW doesn't support notify\n");
+	else if (data->status == BIT(SVC_STATUS_RSU_ERROR))
+		dev_err(client->dev, "Failure, returned status is %lu\n",
+			BIT(data->status));
+
 	complete(&priv->completion);
 }
 
@@ -133,9 +135,11 @@ static void rsu_retry_callback(struct stratix10_svc_client *client,
 
 	if (data->status == BIT(SVC_STATUS_RSU_OK))
 		priv->retry_counter = *counter;
+	else if (data->status == BIT(SVC_STATUS_RSU_NO_SUPPORT))
+		dev_warn(client->dev, "Secure FW doesn't support retry\n");
 	else
-		dev_err(client->dev, "Failed to get retry counter %i\n",
-			data->status);
+		dev_err(client->dev, "Failed to get retry counter %lu\n",
+			BIT(data->status));
 
 	complete(&priv->completion);
 }
@@ -333,15 +337,10 @@ static ssize_t notify_store(struct device *dev,
 		return ret;
 	}
 
-	/* only 19.3 or late version FW supports retry counter feature */
-	if (FIELD_GET(RSU_FW_VERSION_MASK, priv->status.version)) {
-		ret = rsu_send_msg(priv, COMMAND_RSU_RETRY,
-				   0, rsu_retry_callback);
-		if (ret) {
-			dev_err(dev,
-				"Error, getting RSU retry %i\n", ret);
-			return ret;
-		}
+	ret = rsu_send_msg(priv, COMMAND_RSU_RETRY, 0, rsu_retry_callback);
+	if (ret) {
+		dev_err(dev, "Error, getting RSU retry %i\n", ret);
+		return ret;
 	}
 
 	return count;
@@ -413,15 +412,10 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 		stratix10_svc_free_channel(priv->chan);
 	}
 
-	/* only 19.3 or late version FW supports retry counter feature */
-	if (FIELD_GET(RSU_FW_VERSION_MASK, priv->status.version)) {
-		ret = rsu_send_msg(priv, COMMAND_RSU_RETRY, 0,
-				   rsu_retry_callback);
-		if (ret) {
-			dev_err(dev,
-				"Error, getting RSU retry %i\n", ret);
-			stratix10_svc_free_channel(priv->chan);
-		}
+	ret = rsu_send_msg(priv, COMMAND_RSU_RETRY, 0, rsu_retry_callback);
+	if (ret) {
+		dev_err(dev, "Error, getting RSU retry %i\n", ret);
+		stratix10_svc_free_channel(priv->chan);
 	}
 
 	return ret;
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index b4853211..c6c3140 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -493,8 +493,24 @@ static int svc_normal_to_secure_thread(void *data)
 			pdata->chan->scl->receive_cb(pdata->chan->scl, cbdata);
 			break;
 		default:
-			pr_warn("it shouldn't happen\n");
+			pr_warn("Secure firmware doesn't support...\n");
+
+			/*
+			 * be compatible with older version firmware which
+			 * doesn't support RSU notify or retry
+			 */
+			if ((pdata->command == COMMAND_RSU_RETRY) ||
+				(pdata->command == COMMAND_RSU_NOTIFY)) {
+				cbdata->status =
+					BIT(SVC_STATUS_RSU_NO_SUPPORT);
+				cbdata->kaddr1 = NULL;
+				cbdata->kaddr2 = NULL;
+				cbdata->kaddr3 = NULL;
+				pdata->chan->scl->receive_cb(
+					pdata->chan->scl, cbdata);
+			}
 			break;
+
 		}
 	};
 
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index b6c4302..59bc6e2 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -41,6 +41,12 @@
  *
  * SVC_STATUS_RSU_OK:
  * Secure firmware accepts the request of remote status update (RSU).
+ *
+ * SVC_STATUS_RSU_ERROR:
+ * Error encountered during remote system update.
+ *
+ * SVC_STATUS_RSU_NO_SUPPORT:
+ * Secure firmware doesn't support RSU retry or notify feature.
  */
 #define SVC_STATUS_RECONFIG_REQUEST_OK		0
 #define SVC_STATUS_RECONFIG_BUFFER_SUBMITTED	1
@@ -50,6 +56,8 @@
 #define SVC_STATUS_RECONFIG_ERROR		5
 #define SVC_STATUS_RSU_OK			6
 #define SVC_STATUS_RSU_ERROR			7
+#define SVC_STATUS_RSU_NO_SUPPORT		8
+
 /**
  * Flag bit for COMMAND_RECONFIG
  *
-- 
2.7.4

