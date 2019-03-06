Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11452C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA0620663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T+iycT7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCFVrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:47:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34029 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCFVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:47:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id i130so9471518pgd.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 13:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3gPoXW02AvG9JrxPvdSOZ6JYsQwzJXYB/uKkYNgh4p8=;
        b=T+iycT7Sm1aTSLEvOHcqcPkwrjrMjwj9eo1i79fgVWERXptp4F6Q2BKpEgqaEPmfsT
         iBK2Bv2+U0pPFCHJVjoGjtgb8Te78LKmiz8QB+Jes/QjBvgyEMGwIXsR8iArJVoQ4yHY
         jgdY6Xv/7tM6jsVeKiM5VsvXe7x5sLtXfx4wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3gPoXW02AvG9JrxPvdSOZ6JYsQwzJXYB/uKkYNgh4p8=;
        b=sdj32gPlZ1aiSuPLSaPScKa5oOXTYk/8w8jJmbXXHWzoYDV9BZ4s6lOQdHSKIRiWoW
         xQVp98afzP+faixtz7EK7lgeOw6Fy8qkRYi5DoEVSIYdulpfZv8X4QFqfeW9GLx9jmtF
         teLiT5og5auLhYrY8GLe1mRUN3mzb2HDHZfT9pvAQlndTqwOXFcTYeGM1HPWvh3V/Cs3
         DCSNZ+aYHucLHW2RuO6nHYVfsjjTw8hZeLVWLVWLrRCULxeGlboV3HH6qc0IsBNK+Fwf
         yyDwoCvqBHmGzfSp5Ap/a2qqg7VF5yar3axa0iCIVFGORIbO4kPnUi/DO0LODBI2aklv
         zD6A==
X-Gm-Message-State: APjAAAWoCKdKgS5fl6QPqr6swtOAnwgeJUM9Ki5j18Zl4vjV5LfdVagB
        VAMavak2QtHQNK6YY1WeM65FLXOyy2uuJw==
X-Google-Smtp-Source: APXvYqxQzbzCQvBm9GZ5N9WfBrY3K9WaTU9hWEfLnsBTpdBgV5yS1hB0X0JzmrSiK23G49QLNd7XVQ==
X-Received: by 2002:a17:902:aa06:: with SMTP id be6mr9279294plb.57.1551908854596;
        Wed, 06 Mar 2019 13:47:34 -0800 (PST)
Received: from randolph.mtv.corp.google.com ([2620:15c:202:201:c881:1161:9556:f56])
        by smtp.gmail.com with ESMTPSA id y22sm3761915pfn.136.2019.03.06.13.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 13:47:33 -0800 (PST)
From:   David Valleau <valleau@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     briannorris@chromium.org, David Valleau <valleau@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH] tools: usb: usbip: adding support for older kernel versions
Date:   Wed,  6 Mar 2019 13:47:30 -0800
Message-Id: <20190306214730.6545-1-valleau@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current usbip tool relies on the behavior of the vhci-hcd driver in
order to work correctly. In instances where a newer version of the tool
is used with an older version of the kernel, there are incompatibilities
that can sometimes result in failure.

This patch adds some fallback capabilities so that the tool will work
with the vhci-hcd driver from kernel version 3.18 onward.

Signed-off-by: David Valleau <valleau@chromium.org>
---

 tools/usb/usbip/libsrc/vhci_driver.c | 246 ++++++++++++++++++++++++---
 tools/usb/usbip/libsrc/vhci_driver.h |   7 +
 2 files changed, 228 insertions(+), 25 deletions(-)

diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
index ed8c9d360c0f..4e02cf6832a6 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -37,7 +37,136 @@ imported_device_init(struct usbip_imported_device *idev, char *busid)
 	return NULL;
 }
 
-static int parse_status(const char *value)
+static void assign_idev(struct usbip_imported_device *idev, uint8_t port,
+			uint32_t status, uint32_t devid)
+{
+	idev->port	= port;
+	idev->status	= status;
+	idev->devid	= devid;
+	idev->busnum	= (devid >> 16);
+	idev->devnum	= (devid & 0x0000ffff);
+}
+
+static int init_idev(struct usbip_imported_device *idev, const char *lbusid)
+{
+	if (idev->status != VDEV_ST_NULL &&
+	    idev->status != VDEV_ST_NOTASSIGNED) {
+		idev = imported_device_init(idev, lbusid);
+		if (!idev) {
+			dbg("imported_device_init failed");
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static int parse_status_3_18(const char *value)
+{
+	int ret = 0;
+	char *c;
+
+	/* skip a header line */
+	c = strchr(value, '\n');
+	if (!c)
+		return -1;
+	c++;
+
+	while (*c != '\0') {
+		int port, status, speed, devid;
+		unsigned long socket;
+		char lbusid[SYSFS_BUS_ID_SIZE];
+		struct usbip_imported_device *idev;
+
+		ret = sscanf(c, "%d %d %d %x %lx %31s\n",
+				&port, &status, &speed,
+				&devid, &socket, lbusid);
+
+		if (ret < 5) {
+			dbg("sscanf failed: %d", ret);
+			return -1;
+		}
+
+		dbg("port %d status %d speed %d devid %x",
+				port, status, speed, devid);
+		dbg("socket %lx lbusid %s", socket, lbusid);
+
+		/* if a device is connected, look at it */
+		idev = &vhci_driver->idev[port];
+		memset(idev, 0, sizeof(*idev));
+
+		/* assume that the hub is high-speed */
+		idev->hub = HUB_SPEED_HIGH;
+		assign_idev(idev, port, status, devid);
+
+		if (init_idev(idev, lbusid))
+			return -1;
+
+		/* go to the next line */
+		c = strchr(c, '\n');
+		if (!c)
+			break;
+		c++;
+	}
+
+	dbg("exit");
+
+	return 0;
+}
+
+static int parse_status_4_4(const char *value)
+{
+	int ret = 0;
+	char *c;
+
+	/* skip a header line */
+	c = strchr(value, '\n');
+	if (!c)
+		return -1;
+	c++;
+
+	while (*c != '\0') {
+		int port, status, speed, devid;
+		int sockfd;
+		char lbusid[SYSFS_BUS_ID_SIZE];
+		struct usbip_imported_device *idev;
+
+		ret = sscanf(c, "%d %d %d %x %u %31s\n",
+				&port, &status, &speed,
+				&devid, &sockfd, lbusid);
+
+		if (ret < 5) {
+			dbg("sscanf failed: %d", ret);
+			return -1;
+		}
+
+		dbg("port %d status %d speed %d devid %x",
+				port, status, speed, devid);
+		dbg("sockfd %u lbusid %s", sockfd, lbusid);
+
+		/* if a device is connected, look at it */
+		idev = &vhci_driver->idev[port];
+		memset(idev, 0, sizeof(*idev));
+
+		/* assume that the hub is high-speed */
+		idev->hub = HUB_SPEED_HIGH;
+		assign_idev(idev, port, status, devid);
+
+		if (init_idev(idev, lbusid))
+			return -1;
+
+		/* go to the next line */
+		c = strchr(c, '\n');
+		if (!c)
+			break;
+		c++;
+	}
+
+	dbg("exit");
+
+	return 0;
+}
+
+static int parse_status_4_14(const char *value)
 {
 	int ret = 0;
 	char *c;
@@ -61,7 +190,7 @@ static int parse_status(const char *value)
 
 		if (ret < 5) {
 			dbg("sscanf failed: %d", ret);
-			BUG();
+			return -1;
 		}
 
 		dbg("hub %s port %d status %d speed %d devid %x",
@@ -77,22 +206,10 @@ static int parse_status(const char *value)
 		else /* strncmp("ss", hub, 2) == 0 */
 			idev->hub = HUB_SPEED_SUPER;
 
-		idev->port	= port;
-		idev->status	= status;
-
-		idev->devid	= devid;
+		assign_idev(idev, port, status, devid);
 
-		idev->busnum	= (devid >> 16);
-		idev->devnum	= (devid & 0x0000ffff);
-
-		if (idev->status != VDEV_ST_NULL
-		    && idev->status != VDEV_ST_NOTASSIGNED) {
-			idev = imported_device_init(idev, lbusid);
-			if (!idev) {
-				dbg("imported_device_init failed");
-				return -1;
-			}
-		}
+		if (init_idev(idev, lbusid))
+			return -1;
 
 		/* go to the next line */
 		c = strchr(c, '\n');
@@ -106,6 +223,41 @@ static int parse_status(const char *value)
 	return 0;
 }
 
+/*
+ * Parses the sysfs status contained within value to populate the idev fields
+ * within vhci_driver.
+ *
+ * Uses the format of the header line to determine which parsing function to
+ * call.
+ */
+static int parse_status(const char *value)
+{
+	char *c;
+	char header[STATUS_HEADER_MAX] = { 0 };
+	size_t size;
+	int status = -1;
+
+	c = strchr(value, '\n');
+	if (!c)
+		return -1;
+
+	size = c - value;
+	if (size > STATUS_HEADER_MAX)
+		return -1;
+	strncpy(header, value, size);
+
+	if (strncmp(header, V3_18_STATUS_HEADER, size) == 0)
+		return parse_status_3_18(value);
+	if (strncmp(header, V4_4_STATUS_HEADER, size) == 0)
+		return parse_status_4_4(value);
+	if (strncmp(header, V4_14_STATUS_HEADER, size) == 0)
+		return parse_status_4_14(value);
+
+	dbg("unknown header format in status");
+
+	return -1;
+}
+
 #define MAX_STATUS_NAME 16
 
 static int refresh_imported_device_list(void)
@@ -135,14 +287,43 @@ static int refresh_imported_device_list(void)
 	return 0;
 }
 
+static int fallback_get_nports(struct udev_device *hc_device)
+{
+	char *c;
+	int nports = 0;
+	const char *attr_status;
+
+	attr_status = udev_device_get_sysattr_value(hc_device, "status");
+	if (!attr_status) {
+		err("udev_device_get_sysattr_value failed");
+		return -1;
+	}
+
+	/* skip a header line */
+	c = strchr(attr_status, '\n');
+	if (!c)
+		return 0;
+	c++;
+
+	while (*c != '\0') {
+		nports++;
+		/* go to the next line */
+		c = strchr(c, '\n');
+		if (!c)
+			return nports;
+		c++;
+	}
+
+	return nports;
+}
+
 static int get_nports(struct udev_device *hc_device)
 {
 	const char *attr_nports;
 
 	attr_nports = udev_device_get_sysattr_value(hc_device, "nports");
 	if (!attr_nports) {
-		err("udev_device_get_sysattr_value nports failed");
-		return -1;
+		return fallback_get_nports(hc_device);
 	}
 
 	return (int)strtoul(attr_nports, NULL, 10);
@@ -150,7 +331,8 @@ static int get_nports(struct udev_device *hc_device)
 
 static int vhci_hcd_filter(const struct dirent *dirent)
 {
-	return strcmp(dirent->d_name, "vhci_hcd") >= 0;
+	return strncmp(dirent->d_name, USBIP_VHCI_DRV_NAME,
+		       strlen(USBIP_VHCI_DRV_NAME)) == 0;
 }
 
 static int get_ncontrollers(void)
@@ -240,6 +422,24 @@ static int read_record(int rhport, char *host, unsigned long host_len,
 
 /* ---------------------------------------------------------------------- */
 
+/*
+ * Attempt to open the vhci udev device. If the first lookup fails fall back to
+ * looking up the old name in order to support older kernel versions.
+ */
+static struct udev_device *open_hc_device()
+{
+	struct udev_device *device;
+
+	device = udev_device_new_from_subsystem_sysname(
+		udev_context, USBIP_VHCI_BUS_TYPE, USBIP_VHCI_DEVICE_NAME);
+	if (!device) {
+		device = udev_device_new_from_subsystem_sysname(
+			udev_context, USBIP_VHCI_BUS_TYPE,
+			USBIP_VHCI_DEVICE_NAME_OLD);
+	}
+	return device;
+}
+
 int usbip_vhci_driver_open(void)
 {
 	int nports;
@@ -252,10 +452,7 @@ int usbip_vhci_driver_open(void)
 	}
 
 	/* will be freed in usbip_driver_close() */
-	hc_device =
-		udev_device_new_from_subsystem_sysname(udev_context,
-						       USBIP_VHCI_BUS_TYPE,
-						       USBIP_VHCI_DEVICE_NAME);
+	hc_device = open_hc_device();
 	if (!hc_device) {
 		err("udev_device_new_from_subsystem_sysname failed");
 		goto err;
@@ -335,7 +532,6 @@ int usbip_vhci_refresh_device_list(void)
 int usbip_vhci_get_free_port(uint32_t speed)
 {
 	for (int i = 0; i < vhci_driver->nports; i++) {
-
 		switch (speed) {
 		case	USB_SPEED_SUPER:
 			if (vhci_driver->idev[i].hub != HUB_SPEED_SUPER)
diff --git a/tools/usb/usbip/libsrc/vhci_driver.h b/tools/usb/usbip/libsrc/vhci_driver.h
index 6c9aca216705..a18f4d243c7a 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.h
+++ b/tools/usb/usbip/libsrc/vhci_driver.h
@@ -13,6 +13,13 @@
 
 #define USBIP_VHCI_BUS_TYPE "platform"
 #define USBIP_VHCI_DEVICE_NAME "vhci_hcd.0"
+#define USBIP_VHCI_DEVICE_NAME_OLD "vhci_hcd"
+
+#define V3_18_STATUS_HEADER "prt sta spd bus dev socket           local_busid"
+#define V4_4_STATUS_HEADER "prt sta spd dev      sockfd local_busid"
+#define V4_14_STATUS_HEADER "hub port sta spd dev      sockfd local_busid"
+
+#define STATUS_HEADER_MAX 64
 
 enum hub_speed {
 	HUB_SPEED_HIGH = 0,
-- 
2.21.0.352.gf09ad66450-goog

