Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83862C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF9420729
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfKPLga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:36:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:37564 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfKPLga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:36:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2019 03:36:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,312,1569308400"; 
   d="scan'208";a="236375360"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by fmsmga002.fm.intel.com with ESMTP; 16 Nov 2019 03:36:27 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: bus: add more client attributes to sysfs
Date:   Sat, 16 Nov 2019 16:21:36 +0200
Message-Id: <20191116142136.17535-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Export more client attributes via sysfs that are usually obtained
upon connection. In some cases, for example a monitoring application
may wish to know the attributes without actually performing the connection.
Added attributes:
max number of connections, fixed address, max message length.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-mei | 21 +++++++++++++++
 drivers/misc/mei/bus.c                  | 33 +++++++++++++++++++++++
 drivers/misc/mei/client.h               | 36 +++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-mei b/Documentation/ABI/testing/sysfs-bus-mei
index 3f8701e8fa24..3d37e2796d5a 100644
--- a/Documentation/ABI/testing/sysfs-bus-mei
+++ b/Documentation/ABI/testing/sysfs-bus-mei
@@ -26,3 +26,24 @@ KernelVersion:	4.3
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
 Description:	Stores mei client protocol version
 		Format: %d
+
+What:		/sys/bus/mei/devices/.../max_conn
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	Stores mei client maximum number of connections
+		Format: %d
+
+What:		/sys/bus/mei/devices/.../fixed
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	Stores mei client fixed address, if any
+		Format: %d
+
+What:		/sys/bus/mei/devices/.../max_len
+Date:		Nov 2019
+KernelVersion:	5.5
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	Stores mei client maximum message length
+		Format: %d
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 53bb394ccba6..a0a495c95e3c 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -791,11 +791,44 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 }
 static DEVICE_ATTR_RO(modalias);
 
+static ssize_t max_conn_show(struct device *dev, struct device_attribute *a,
+			     char *buf)
+{
+	struct mei_cl_device *cldev = to_mei_cl_device(dev);
+	u8 maxconn = mei_me_cl_max_conn(cldev->me_cl);
+
+	return scnprintf(buf, PAGE_SIZE, "%d", maxconn);
+}
+static DEVICE_ATTR_RO(max_conn);
+
+static ssize_t fixed_show(struct device *dev, struct device_attribute *a,
+			  char *buf)
+{
+	struct mei_cl_device *cldev = to_mei_cl_device(dev);
+	u8 fixed = mei_me_cl_fixed(cldev->me_cl);
+
+	return scnprintf(buf, PAGE_SIZE, "%d", fixed);
+}
+static DEVICE_ATTR_RO(fixed);
+
+static ssize_t max_len_show(struct device *dev, struct device_attribute *a,
+			    char *buf)
+{
+	struct mei_cl_device *cldev = to_mei_cl_device(dev);
+	u32 maxlen = mei_me_cl_max_len(cldev->me_cl);
+
+	return scnprintf(buf, PAGE_SIZE, "%u", maxlen);
+}
+static DEVICE_ATTR_RO(max_len);
+
 static struct attribute *mei_cldev_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_version.attr,
 	&dev_attr_modalias.attr,
+	&dev_attr_max_conn.attr,
+	&dev_attr_fixed.attr,
+	&dev_attr_max_len.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mei_cldev);
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index c1f9e810cf81..2f8954def591 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -69,6 +69,42 @@ static inline u8 mei_me_cl_ver(const struct mei_me_client *me_cl)
 	return me_cl->props.protocol_version;
 }
 
+/**
+ * mei_me_cl_max_conn - return me client max number of connections
+ *
+ * @me_cl: me client
+ *
+ * Return: me client max number of connections
+ */
+static inline u8 mei_me_cl_max_conn(const struct mei_me_client *me_cl)
+{
+	return me_cl->props.max_number_of_connections;
+}
+
+/**
+ * mei_me_cl_fixed - return me client fixed address, if any
+ *
+ * @me_cl: me client
+ *
+ * Return: me client fixed address
+ */
+static inline u8 mei_me_cl_fixed(const struct mei_me_client *me_cl)
+{
+	return me_cl->props.fixed_address;
+}
+
+/**
+ * mei_me_cl_max_len - return me client max msg length
+ *
+ * @me_cl: me client
+ *
+ * Return: me client max msg length
+ */
+static inline u32 mei_me_cl_max_len(const struct mei_me_client *me_cl)
+{
+	return me_cl->props.max_msg_length;
+}
+
 /*
  * MEI IO Functions
  */
-- 
2.21.0

