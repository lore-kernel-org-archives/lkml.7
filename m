Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2349C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F49F208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfE2Ho2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:44:28 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:27133 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726842AbfE2HoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:44:22 -0400
X-UUID: cf43890cc10640748f2aef7fa618f03d-20190529
X-UUID: cf43890cc10640748f2aef7fa618f03d-20190529
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1353994933; Wed, 29 May 2019 15:44:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 29 May 2019 15:44:15 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 15:44:14 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
Subject: [PATCH v6 06/10] device connection: Add fwnode_connection_find_match()
Date:   Wed, 29 May 2019 15:43:44 +0800
Message-ID: <1559115828-19146-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

The fwnode_connection_find_match() function is exactly the
same as device_connection_find_match(), except it takes
struct fwnode_handle as parameter instead of struct device.
That allows locating device connections before the device
entries have been created.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v6:
  new patch
---
 drivers/base/devcon.c  | 33 +++++++++++++++++++++++++--------
 include/linux/device.h | 10 +++++++---
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 04db9ae235e4..8311b70bbca2 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -12,9 +12,6 @@
 static DEFINE_MUTEX(devcon_lock);
 static LIST_HEAD(devcon_list);
 
-typedef void *(*devcon_match_fn_t)(struct device_connection *con, int ep,
-				   void *data);
-
 static void *
 fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 			  void *data, devcon_match_fn_t match)
@@ -38,6 +35,28 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+/**
+ * fwnode_connection_find_match - Find connection from a device node
+ * @fwnode: Device node with the connection
+ * @con_id: Identifier for the connection
+ * @data: Data for the match function
+ * @match: Function to check and convert the connection description
+ *
+ * Find a connection with unique identifier @con_id between @fwnode and another
+ * device node. @match will be used to convert the connection description to
+ * data the caller is expecting to be returned.
+ */
+void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match)
+{
+	if (!fwnode || !match)
+		return NULL;
+
+	return fwnode_graph_devcon_match(fwnode, con_id, data, match);
+}
+EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
+
 /**
  * device_connection_find_match - Find physical connection to a device
  * @dev: Device with the connection
@@ -61,11 +80,9 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 	if (!match)
 		return NULL;
 
-	if (fwnode) {
-		ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
-		if (ret)
-			return ret;
-	}
+	ret = fwnode_connection_find_match(fwnode, con_id, data, match);
+	if (ret)
+		return ret;
 
 	mutex_lock(&devcon_lock);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index e85264fb6616..9445f068602f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -772,10 +772,14 @@ struct device_connection {
 	struct list_head	list;
 };
 
+typedef void *(*devcon_match_fn_t)(struct device_connection *con, int ep,
+				   void *data);
+
+void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match);
 void *device_connection_find_match(struct device *dev, const char *con_id,
-				void *data,
-				void *(*match)(struct device_connection *con,
-					       int ep, void *data));
+				   void *data, devcon_match_fn_t match);
 
 struct device *device_connection_find(struct device *dev, const char *con_id);
 
-- 
2.21.0

