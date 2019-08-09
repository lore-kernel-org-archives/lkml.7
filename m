Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81088C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A652086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XpDqpay4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfHIVkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:40:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51044 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfHIVkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:40:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79LeA8o044455;
        Fri, 9 Aug 2019 16:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565386810;
        bh=rvbC/eUk3CqrvPCJSGPBj/aE/j9tg/4DEycDb2m2lSk=;
        h=From:To:CC:Subject:Date;
        b=XpDqpay4RwkEmqqJBqV+TbKIqQk9HxYUeoa3BbcLwJ/rl6t9YkpxEgXPKGTmfrfs0
         YpGGNH3T66cZrmQ02BH+5GfjSw6sGXqw6Fx3hb6/HeqE053jj7DYK4im2lOvVsTdcR
         5V9j11Wx3aez+WJGAsa3rgr1k/gDmzLkbuABV/gc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79LeAcJ027906
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 16:40:10 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 16:40:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 16:40:10 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79LeAux040133;
        Fri, 9 Aug 2019 16:40:10 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x79Le9Z27245;
        Fri, 9 Aug 2019 16:40:09 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] rpmsg: add a description field
Date:   Fri, 9 Aug 2019 16:40:05 -0500
Message-ID: <20190809214005.32159-1-s-anna@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Ben-Cohen <ohad@wizery.com>

Add a new description field to the rpmsg bus infrastructure
that can be passed onto the rpmsg client drivers for additional
information. The current rpmsg bus client drivers need to have
a fixed id_table for proper matching, this new field can allow
flexibility for the client drivers (eg: like creating unique
cdevs).

The description field is published through an enhanced name
service announcement message structure. The name service
message processing logic is updated to maintain backward
compatibility with the previous message structure.

Based on an initial patch from Ohad Ben-Cohen.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
[s-anna@ti.com: forward port, add sysfs documentation, fixup qcom drivers]
Signed-off-by: Suman Anna <s-anna@ti.com>
[t-kristo@ti.com: reworked to support both rpmsg with/without the desc field]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 Documentation/ABI/testing/sysfs-bus-rpmsg | 29 +++++++++++++++
 drivers/rpmsg/qcom_glink_native.c         |  1 +
 drivers/rpmsg/qcom_smd.c                  |  1 +
 drivers/rpmsg/rpmsg_char.c                |  1 +
 drivers/rpmsg/rpmsg_core.c                |  6 ++++
 drivers/rpmsg/virtio_rpmsg_bus.c          | 44 +++++++++++++++++++----
 drivers/soc/qcom/wcnss_ctrl.c             |  1 +
 include/linux/rpmsg.h                     |  4 +++
 8 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rpmsg b/Documentation/ABI/testing/sysfs-bus-rpmsg
index 990fcc420935..7f1b09ecc64d 100644
--- a/Documentation/ABI/testing/sysfs-bus-rpmsg
+++ b/Documentation/ABI/testing/sysfs-bus-rpmsg
@@ -93,3 +93,32 @@ Description:
 		This sysfs entry allows the rpmsg driver for a rpmsg device
 		to be specified which will override standard OF, ID table
 		and name matching.
+
+What:		/sys/bus/rpmsg/devices/.../desc
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Bjorn Andersson <bjorn.andersson@linaro.org>
+Description:
+		Every rpmsg device is a communication channel with a remote
+		processor. Channels are identified by a textual name (see
+		/sys/bus/rpmsg/devices/.../name above) and have a local
+		("source") rpmsg address, and remote ("destination") rpmsg
+		address.
+
+		A channel is first created when an entity, whether local
+		or remote, starts listening on it for messages (and is thus
+		called an rpmsg server). When that happens, a "name service"
+		announcement is sent to the other processor, in order to let
+		it know about the creation of the channel (this way remote
+		clients know they can start sending messages).
+
+		The listening entity (or client) which communicates with a
+		remote processor is referred as rpmsg driver. The rpmsg device
+		and rpmsg driver are matched based on rpmsg device name (see
+		/sys/bus/rpmsg/devices/.../name above) and rpmsg driver ID table.
+
+		This sysfs entry contains an additional optional description of
+		the rpmsg device that can be optionally included as part of the
+		"name service" announcement. This description is then passed on
+		to the corresponding rpmsg drivers to further distinguish multiple
+		devices associated with the same rpmsg driver.
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index f46c787733e8..cfdabddc15ac 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1456,6 +1456,7 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 		strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
 		chinfo.src = RPMSG_ADDR_ANY;
 		chinfo.dst = RPMSG_ADDR_ANY;
+		chinfo.desc[0] = '\0';
 
 		rpmsg_unregister_device(glink->dev, &chinfo);
 	}
diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 4abbeea782fa..7cd6b9c47065 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1307,6 +1307,7 @@ static void qcom_channel_state_worker(struct work_struct *work)
 		strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
 		chinfo.src = RPMSG_ADDR_ANY;
 		chinfo.dst = RPMSG_ADDR_ANY;
+		chinfo.desc[0] = '\0';
 		rpmsg_unregister_device(&edge->dev, &chinfo);
 		channel->registered = false;
 		spin_lock_irqsave(&edge->channels_lock, flags);
diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index eea5ebbb5119..4bd91445a2fd 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -442,6 +442,7 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
 	chinfo.name[RPMSG_NAME_SIZE-1] = '\0';
 	chinfo.src = eptinfo.src;
 	chinfo.dst = eptinfo.dst;
+	chinfo.desc[0] = '\0';
 
 	return rpmsg_eptdev_create(ctrldev, chinfo);
 };
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index ea88fd4e2a6e..334a50425b5c 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -302,6 +302,10 @@ static int rpmsg_device_match(struct device *dev, void *data)
 	if (strncmp(chinfo->name, rpdev->id.name, RPMSG_NAME_SIZE))
 		return 0;
 
+	if (chinfo->desc && chinfo->desc != rpdev->desc &&
+	    strncmp(chinfo->desc, rpdev->desc, RPMSG_NAME_SIZE))
+		return 0;
+
 	/* found a match ! */
 	return 1;
 }
@@ -365,6 +369,7 @@ static DEVICE_ATTR_RW(field)
 
 /* for more info, see Documentation/ABI/testing/sysfs-bus-rpmsg */
 rpmsg_show_attr(name, id.name, "%s\n");
+rpmsg_show_attr(desc, desc, "%s\n");
 rpmsg_show_attr(src, src, "0x%x\n");
 rpmsg_show_attr(dst, dst, "0x%x\n");
 rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
@@ -386,6 +391,7 @@ static DEVICE_ATTR_RO(modalias);
 
 static struct attribute *rpmsg_dev_attrs[] = {
 	&dev_attr_name.attr,
+	&dev_attr_desc.attr,
 	&dev_attr_modalias.attr,
 	&dev_attr_dst.attr,
 	&dev_attr_src.attr,
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 376ebbf880d6..49901582ff0e 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -110,6 +110,23 @@ struct rpmsg_ns_msg {
 	u32 flags;
 } __packed;
 
+/**
+ * struct rpmsg_ns_msg_ext - dynamic name service announcement message v2
+ * @name: name of remote service that is published
+ * @desc: description of remote service
+ * @addr: address of remote service that is published
+ * @flags: indicates whether service is created or destroyed
+ *
+ * Interchangeable nameservice message with rpmsg_ns_msg. This one has
+ * the addition of the desc field for extra flexibility.
+ */
+struct rpmsg_ns_msg_ext {
+	char name[RPMSG_NAME_SIZE];
+	char desc[RPMSG_NAME_SIZE];
+	u32 addr;
+	u32 flags;
+} __packed;
+
 /**
  * enum rpmsg_ns_flags - dynamic name service announcement flags
  *
@@ -402,8 +419,9 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 	if (tmp) {
 		/* decrement the matched device's refcount back */
 		put_device(tmp);
-		dev_err(dev, "channel %s:%x:%x already exist\n",
-				chinfo->name, chinfo->src, chinfo->dst);
+		dev_err(dev, "channel %s:%s:%x:%x already exist\n",
+			chinfo->name, chinfo->desc,
+			chinfo->src, chinfo->dst);
 		return NULL;
 	}
 
@@ -419,6 +437,7 @@ static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
 	rpdev->src = chinfo->src;
 	rpdev->dst = chinfo->dst;
 	rpdev->ops = &virtio_rpmsg_ops;
+	strncpy(rpdev->desc, chinfo->desc, RPMSG_NAME_SIZE);
 
 	/*
 	 * rpmsg server channels has predefined local address (for now),
@@ -816,18 +835,29 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 		       void *priv, u32 src)
 {
 	struct rpmsg_ns_msg *msg = data;
+	struct rpmsg_ns_msg_ext *msg_ext = data;
 	struct rpmsg_device *newch;
 	struct rpmsg_channel_info chinfo;
 	struct virtproc_info *vrp = priv;
 	struct device *dev = &vrp->vdev->dev;
 	int ret;
+	u32 addr;
+	u32 flags;
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
 	dynamic_hex_dump("NS announcement: ", DUMP_PREFIX_NONE, 16, 1,
 			 data, len, true);
 #endif
 
-	if (len != sizeof(*msg)) {
+	if (len == sizeof(*msg)) {
+		addr = msg->addr;
+		flags = msg->flags;
+		chinfo.desc[0] = '\0';
+	} else if (len == sizeof(*msg_ext)) {
+		addr = msg_ext->addr;
+		flags = msg_ext->flags;
+		strncpy(chinfo.desc, msg_ext->desc, sizeof(chinfo.desc));
+	} else if (len != sizeof(*msg)) {
 		dev_err(dev, "malformed ns msg (%d)\n", len);
 		return -EINVAL;
 	}
@@ -847,14 +877,14 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
 
 	dev_info(dev, "%sing channel %s addr 0x%x\n",
-		 msg->flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
-		 msg->name, msg->addr);
+		 flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
+		 msg->name, addr);
 
 	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
 	chinfo.src = RPMSG_ADDR_ANY;
-	chinfo.dst = msg->addr;
+	chinfo.dst = addr;
 
-	if (msg->flags & RPMSG_NS_DESTROY) {
+	if (flags & RPMSG_NS_DESTROY) {
 		ret = rpmsg_unregister_device(&vrp->vdev->dev, &chinfo);
 		if (ret)
 			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index e5c68051fb17..ad9f28dc13f1 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -276,6 +276,7 @@ struct rpmsg_endpoint *qcom_wcnss_open_channel(void *wcnss, const char *name, rp
 	strscpy(chinfo.name, name, sizeof(chinfo.name));
 	chinfo.src = RPMSG_ADDR_ANY;
 	chinfo.dst = RPMSG_ADDR_ANY;
+	chinfo.desc[0] = '\0';
 
 	return rpmsg_create_ept(_wcnss->channel->rpdev, cb, priv, chinfo);
 }
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 9fe156d1c018..436faf04ba1c 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -28,11 +28,13 @@ struct rpmsg_endpoint_ops;
 /**
  * struct rpmsg_channel_info - channel info representation
  * @name: name of service
+ * @desc: description of service
  * @src: local address
  * @dst: destination address
  */
 struct rpmsg_channel_info {
 	char name[RPMSG_NAME_SIZE];
+	char desc[RPMSG_NAME_SIZE];
 	u32 src;
 	u32 dst;
 };
@@ -42,6 +44,7 @@ struct rpmsg_channel_info {
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
  * @driver_override: driver name to force a match
+ * @desc: description of remote service
  * @src: local address
  * @dst: destination address
  * @ept: the rpmsg endpoint of this channel
@@ -51,6 +54,7 @@ struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
 	char *driver_override;
+	char desc[RPMSG_NAME_SIZE];
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
-- 
2.22.0

