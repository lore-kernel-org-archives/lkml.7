Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443C9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127C220B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733202AbfJJIbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:31:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:47296 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbfJJIbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:31:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 01:31:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208,223";a="207144165"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 10 Oct 2019 01:31:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Oct 2019 11:31:10 +0300
Date:   Thu, 10 Oct 2019 11:31:10 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/2] extcon: axp288: Move to swnodes
Message-ID: <20191010083110.GA4981@kuha.fi.intel.com>
References: <20191008122600.22340-1-heikki.krogerus@linux.intel.com>
 <8120fbf2-08d3-6ee2-21bf-458a4e12b29c@redhat.com>
 <20191008140159.GC12909@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20191008140159.GC12909@kuha.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 05:02:04PM +0300, Heikki Krogerus wrote:
> On Tue, Oct 08, 2019 at 03:59:23PM +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 08-10-2019 14:25, Heikki Krogerus wrote:
> > > Hi Hans,
> > > 
> > > Fixed the compiler warning in this version. No other changes.
> > > 
> > > The original cover letter:
> > > 
> > > That AXP288 extcon driver is the last that uses build-in connection
> > > description. I'm replacing it with a code that finds the role mux
> > > software node instead.
> > > 
> > > I'm proposing also here a little helper
> > > usb_role_switch_find_by_fwnode() that uses
> > > class_find_device_by_fwnode() to find the role switches.
> > 
> > Both patches look good to me and I can confirm that things still
> > work as they should on a CHT device with an AXP288 PMIC, so for both:
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Regards,
> > 
> > Hans
> > 
> > p.s.
> > 
> > I guess this means we can remove the build-in connection (
> > device_connection_add / remove) stuff now?
> 
> Yes. I'll prepare separate patches for that.

Actually, maybe it would make sense to just remove it in this series.
I'm attaching a patch that remove struct device_connection completely.
Can you check if it makes sense to you?

thanks,

-- 
heikki

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-device-connection-Remove-struct-device_connection.patch"

From 9444a9498dd22fd88208d19ab3454689b953eb7b Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Wed, 9 Oct 2019 16:49:24 +0300
Subject: [PATCH] device connection: Remove struct device_connection

Now that we have software fwnodes to cover cases where a
firmware node does not describe the connections, there is no
need for dedicated device connection descriptors.

This removes struct device_connection completely. From now
on the processing is always done with the fwnode handle.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../driver-api/device_connection.rst          |  37 +-----
 drivers/base/devcon.c                         | 116 ++++--------------
 drivers/usb/roles/class.c                     |  12 +-
 drivers/usb/typec/class.c                     |  12 +-
 drivers/usb/typec/mux.c                       |  40 ++----
 include/linux/device.h                        |  49 +-------
 6 files changed, 48 insertions(+), 218 deletions(-)

diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
index ba364224c349..f1dfb426c0e8 100644
--- a/Documentation/driver-api/device_connection.rst
+++ b/Documentation/driver-api/device_connection.rst
@@ -5,39 +5,14 @@ Device connections
 Introduction
 ------------
 
-Devices often have connections to other devices that are outside of the direct
-child/parent relationship. A serial or network communication controller, which
-could be a PCI device, may need to be able to get a reference to its PHY
-component, which could be attached for example to the I2C bus. Some device
-drivers need to be able to control the clocks or the GPIOs for their devices,
-and so on.
-
-Device connections are generic descriptions of any type of connection between
-two separate devices.
-
-Device connections alone do not create a dependency between the two devices.
-They are only descriptions which are not tied to either of the devices directly.
-A dependency between the two devices exists only if one of the two endpoint
-devices requests a reference to the other. The descriptions themselves can be
-defined in firmware (not yet supported) or they can be built-in.
-
-Usage
------
-
-Device connections should exist before device ``->probe`` callback is called for
-either endpoint device in the description. If the connections are defined in
-firmware, this is not a problem. It should be considered if the connection
-descriptions are "built-in", and need to be added separately.
-
-The connection description consists of the names of the two devices with the
-connection, i.e. the endpoints, and unique identifier for the connection which
-is needed if there are multiple connections between the two devices.
-
-After a description exists, the devices in it can request reference to the other
-endpoint device, or they can request the description itself.
+Device connection API allows drivers to acquire references to devices that are,
+according to their firmware nodes, connected to the devices those drivers are
+controlling. The API is in practice a wrapper that for now utilizes
+``fwnode_graph*()`` family of functions and
+:c:func:`fwnode_property_get_reference_arg` function.
 
 API
 ---
 
 .. kernel-doc:: drivers/base/devcon.c
-   :functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
+   :functions: device_connection_find_match fwnode_connection_find_match device_connection_find
diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 14e2178e09f8..f7698362f267 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -9,24 +9,20 @@
 #include <linux/device.h>
 #include <linux/property.h>
 
-static DEFINE_MUTEX(devcon_lock);
-static LIST_HEAD(devcon_list);
-
 static void *
 fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 			  void *data, devcon_match_fn_t match)
 {
-	struct device_connection con = { .id = con_id };
 	struct fwnode_handle *ep;
 	void *ret;
 
 	fwnode_graph_for_each_endpoint(fwnode, ep) {
-		con.fwnode = fwnode_graph_get_remote_port_parent(ep);
-		if (!fwnode_device_is_available(con.fwnode))
+		fwnode = fwnode_graph_get_remote_port_parent(ep);
+		if (!fwnode_device_is_available(fwnode))
 			continue;
 
-		ret = match(&con, -1, data);
-		fwnode_handle_put(con.fwnode);
+		ret = match(fwnode, con_id, data);
+		fwnode_handle_put(fwnode);
 		if (ret) {
 			fwnode_handle_put(ep);
 			return ret;
@@ -39,17 +35,16 @@ static void *
 fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 		    void *data, devcon_match_fn_t match)
 {
-	struct device_connection con = { };
 	void *ret;
 	int i;
 
 	for (i = 0; ; i++) {
-		con.fwnode = fwnode_find_reference(fwnode, con_id, i);
-		if (IS_ERR(con.fwnode))
+		fwnode = fwnode_find_reference(fwnode, con_id, i);
+		if (IS_ERR(fwnode))
 			break;
 
-		ret = match(&con, -1, data);
-		fwnode_handle_put(con.fwnode);
+		ret = match(fwnode, NULL, data);
+		fwnode_handle_put(fwnode);
 		if (ret)
 			return ret;
 	}
@@ -99,37 +94,8 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
 void *device_connection_find_match(struct device *dev, const char *con_id,
 				   void *data, devcon_match_fn_t match)
 {
-	struct fwnode_handle *fwnode = dev_fwnode(dev);
-	const char *devname = dev_name(dev);
-	struct device_connection *con;
-	void *ret = NULL;
-	int ep;
-
-	if (!match)
-		return NULL;
-
-	ret = fwnode_connection_find_match(fwnode, con_id, data, match);
-	if (ret)
-		return ret;
-
-	mutex_lock(&devcon_lock);
-
-	list_for_each_entry(con, &devcon_list, list) {
-		ep = match_string(con->endpoint, 2, devname);
-		if (ep < 0)
-			continue;
-
-		if (con_id && strcmp(con->id, con_id))
-			continue;
-
-		ret = match(con, !ep, data);
-		if (ret)
-			break;
-	}
-
-	mutex_unlock(&devcon_lock);
-
-	return ret;
+	return fwnode_connection_find_match(dev_fwnode(dev), con_id,
+					    data, match);
 }
 EXPORT_SYMBOL_GPL(device_connection_find_match);
 
@@ -152,41 +118,25 @@ static struct bus_type *generic_match_buses[] = {
 	NULL,
 };
 
-static void *device_connection_fwnode_match(struct device_connection *con)
+/* This tries to find the device from the most common bus types by name. */
+static void *generic_match(struct fwnode_handle *fwnode, const char *id,
+			   void *data)
 {
 	struct bus_type *bus;
 	struct device *dev;
+	void *ret = NULL;
 
 	for (bus = generic_match_buses[0]; bus; bus++) {
-		dev = bus_find_device_by_fwnode(bus, con->fwnode);
-		if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)))
-			return dev;
+		dev = bus_find_device_by_fwnode(bus, fwnode);
+		if (dev) {
+			if (!strncmp(dev_name(dev), id, strlen(id)))
+				return dev;
+			ret = ERR_PTR(-EPROBE_DEFER);
+		}
 
 		put_device(dev);
 	}
-	return NULL;
-}
-
-/* This tries to find the device from the most common bus types by name. */
-static void *generic_match(struct device_connection *con, int ep, void *data)
-{
-	struct bus_type *bus;
-	struct device *dev;
-
-	if (con->fwnode)
-		return device_connection_fwnode_match(con);
-
-	for (bus = generic_match_buses[0]; bus; bus++) {
-		dev = bus_find_device_by_name(bus, NULL, con->endpoint[ep]);
-		if (dev)
-			return dev;
-	}
-
-	/*
-	 * We only get called if a connection was found, tell the caller to
-	 * wait for the other device to show up.
-	 */
-	return ERR_PTR(-EPROBE_DEFER);
+	return ret;
 }
 
 /**
@@ -205,27 +155,3 @@ struct device *device_connection_find(struct device *dev, const char *con_id)
 	return device_connection_find_match(dev, con_id, NULL, generic_match);
 }
 EXPORT_SYMBOL_GPL(device_connection_find);
-
-/**
- * device_connection_add - Register a connection description
- * @con: The connection description to be registered
- */
-void device_connection_add(struct device_connection *con)
-{
-	mutex_lock(&devcon_lock);
-	list_add_tail(&con->list, &devcon_list);
-	mutex_unlock(&devcon_lock);
-}
-EXPORT_SYMBOL_GPL(device_connection_add);
-
-/**
- * device_connections_remove - Unregister connection description
- * @con: The connection description to be unregistered
- */
-void device_connection_remove(struct device_connection *con)
-{
-	mutex_lock(&devcon_lock);
-	list_del(&con->list);
-	mutex_unlock(&devcon_lock);
-}
-EXPORT_SYMBOL_GPL(device_connection_remove);
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 8273126ffdf4..67e48c733e92 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -85,19 +85,15 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
 
-static void *usb_role_switch_match(struct device_connection *con, int ep,
+static void *usb_role_switch_match(struct fwnode_handle *fwnode, const char *id,
 				   void *data)
 {
 	struct device *dev;
 
-	if (con->fwnode) {
-		if (con->id && !fwnode_property_present(con->fwnode, con->id))
-			return NULL;
+	if (id && !fwnode_property_present(fwnode, id))
+		return NULL;
 
-		dev = class_find_device_by_fwnode(role_class, con->fwnode);
-	} else {
-		dev = class_find_device_by_name(role_class, con->endpoint[ep]);
-	}
+	dev = class_find_device_by_fwnode(role_class, fwnode);
 
 	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 94a3eda62add..cccd60652618 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -205,20 +205,14 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	put_device(&adev->dev);
 }
 
-static void *typec_port_match(struct device_connection *con, int ep, void *data)
+static void *typec_port_match(struct fwnode_handle *fwnode, const char *id,
+			      void *data)
 {
-	struct device *dev;
-
 	/*
 	 * FIXME: Check does the fwnode supports the requested SVID. If it does
 	 * we need to return ERR_PTR(-PROBE_DEFER) when there is no device.
 	 */
-	if (con->fwnode)
-		return class_find_device_by_fwnode(typec_class, con->fwnode);
-
-	dev = class_find_device_by_name(typec_class, con->endpoint[ep]);
-
-	return dev ? dev : ERR_PTR(-EPROBE_DEFER);
+	return class_find_device_by_fwnode(typec_class, fwnode);
 }
 
 struct typec_altmode *
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 57907f26f681..957c405e4545 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -17,11 +17,6 @@
 
 #include "bus.h"
 
-static int name_match(struct device *dev, const void *name)
-{
-	return !strcmp((const char *)name, dev_name(dev));
-}
-
 static bool dev_name_ends_with(struct device *dev, const char *suffix)
 {
 	const char *name = dev_name(dev);
@@ -39,21 +34,16 @@ static int switch_fwnode_match(struct device *dev, const void *fwnode)
 	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-switch");
 }
 
-static void *typec_switch_match(struct device_connection *con, int ep,
+static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
 				void *data)
 {
 	struct device *dev;
 
-	if (con->fwnode) {
-		if (con->id && !fwnode_property_present(con->fwnode, con->id))
-			return NULL;
+	if (id && !fwnode_property_present(fwnode, id))
+		return NULL;
 
-		dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
-					switch_fwnode_match);
-	} else {
-		dev = class_find_device(&typec_mux_class, NULL,
-					con->endpoint[ep], name_match);
-	}
+	dev = class_find_device(&typec_mux_class, NULL, fwnode,
+				switch_fwnode_match);
 
 	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
@@ -182,7 +172,8 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
 	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-mux");
 }
 
-static void *typec_mux_match(struct device_connection *con, int ep, void *data)
+static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
+			     void *data)
 {
 	const struct typec_altmode_desc *desc = data;
 	struct device *dev;
@@ -191,31 +182,24 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 	u16 *val;
 	int i;
 
-	if (!con->fwnode) {
-		dev = class_find_device(&typec_mux_class, NULL,
-					con->endpoint[ep], name_match);
-
-		return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
-	}
-
 	/*
 	 * Check has the identifier already been "consumed". If it
 	 * has, no need to do any extra connection identification.
 	 */
-	match = !con->id;
+	match = !id;
 	if (match)
 		goto find_mux;
 
 	/* Accessory Mode muxes */
 	if (!desc) {
-		match = fwnode_property_present(con->fwnode, "accessory");
+		match = fwnode_property_present(fwnode, "accessory");
 		if (match)
 			goto find_mux;
 		return NULL;
 	}
 
 	/* Alternate Mode muxes */
-	nval = fwnode_property_count_u16(con->fwnode, "svid");
+	nval = fwnode_property_count_u16(fwnode, "svid");
 	if (nval <= 0)
 		return NULL;
 
@@ -223,7 +207,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 	if (!val)
 		return ERR_PTR(-ENOMEM);
 
-	nval = fwnode_property_read_u16_array(con->fwnode, "svid", val, nval);
+	nval = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
 	if (nval < 0) {
 		kfree(val);
 		return ERR_PTR(nval);
@@ -240,7 +224,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 	return NULL;
 
 find_mux:
-	dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
+	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				mux_fwnode_match);
 
 	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
diff --git a/include/linux/device.h b/include/linux/device.h
index 9f2f2e169f95..26fcae1dae32 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1013,26 +1013,8 @@ struct device_dma_parameters {
 	unsigned long segment_boundary_mask;
 };
 
-/**
- * struct device_connection - Device Connection Descriptor
- * @fwnode: The device node of the connected device
- * @endpoint: The names of the two devices connected together
- * @id: Unique identifier for the connection
- * @list: List head, private, for internal use only
- *
- * NOTE: @fwnode is not used together with @endpoint. @fwnode is used when
- * platform firmware defines the connection. When the connection is registered
- * with device_connection_add() @endpoint is used instead.
- */
-struct device_connection {
-	struct fwnode_handle	*fwnode;
-	const char		*endpoint[2];
-	const char		*id;
-	struct list_head	list;
-};
-
-typedef void *(*devcon_match_fn_t)(struct device_connection *con, int ep,
-				   void *data);
+typedef void *(*devcon_match_fn_t)(struct fwnode_handle *fwnode,
+				   const char *id, void *data);
 
 void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
@@ -1042,33 +1024,6 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 
 struct device *device_connection_find(struct device *dev, const char *con_id);
 
-void device_connection_add(struct device_connection *con);
-void device_connection_remove(struct device_connection *con);
-
-/**
- * device_connections_add - Add multiple device connections at once
- * @cons: Zero terminated array of device connection descriptors
- */
-static inline void device_connections_add(struct device_connection *cons)
-{
-	struct device_connection *c;
-
-	for (c = cons; c->endpoint[0]; c++)
-		device_connection_add(c);
-}
-
-/**
- * device_connections_remove - Remove multiple device connections at once
- * @cons: Zero terminated array of device connection descriptors
- */
-static inline void device_connections_remove(struct device_connection *cons)
-{
-	struct device_connection *c;
-
-	for (c = cons; c->endpoint[0]; c++)
-		device_connection_remove(c);
-}
-
 /**
  * enum device_link_state - Device link states.
  * @DL_STATE_NONE: The presence of the drivers is not being tracked.
-- 
2.23.0


--PEIAKu/WMn1b1Hv9--
