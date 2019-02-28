Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93C42171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEkRlRv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbfB1LoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:44:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38861 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732633AbfB1Ln5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:43:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id a188so1640733wmf.3;
        Thu, 28 Feb 2019 03:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sOP657HwB9FWgEwUlmjEnbgHgZ2MqhBCsqdpVVGba8g=;
        b=LEkRlRv5jzK+9C3aci1Cb6HVlYNeIMv3/FYgrCi2dk6YnM93Ww0iOYXyKIdjCPZW9x
         a40hlT0d83+3ZyeSJfJ6WDbL2RXI+Gg9orVg6etNAOp50bDiCQJc8dGy/fDkwNZA+vSf
         DBUPFI8JEJplZPcRdmIOIFkQzO74Av8S2bigeyfVyuo2v7MUZ+4uIXtD5axZx8Hv99QJ
         X6qb3UPBzeI7SobQ+6YFq/jUSUwalmxHZt+235LNXdbZ9xkL4vZ7ut1PF8dH/6Vd3L1m
         9ZfbUqU8eb4odkoaey04oRhiM3KLQZu2cPzF8Iug91RM9P3wUYh60NTxrZsvio3ILsjh
         sdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sOP657HwB9FWgEwUlmjEnbgHgZ2MqhBCsqdpVVGba8g=;
        b=taOn4sI+jbMdmFQovqmegHbY37+FGjVsRlPG9BM94DTEeKXy1AG4BOEaKO1g70KTn9
         Cgs9xj7wU1zaDL89enZKNl3oxwp8Vup1K1WplxrbLY7j/ih4Ovh2HHDmWLrQG1OrJ91x
         gCk/Vakh+qO1OTjWBVJuxmIlR4FnjvFOW+nNife5HfhH+TpqMEyConBgP2dyHiFrz4cV
         RNxjH02lOgIdWm/7B5IWexjbN97ZVDYfbg637hY8F6/67/iXdm2ncNGIiejjctmHFH5M
         OlCASjB2XsGj/XY+S5FuxceE57Gk7MyAxYI9K3o2RJ1B2iNpJP6+YqcrfE5h8PR9NnOE
         Cjiw==
X-Gm-Message-State: AHQUAuanolRCrd8kEiOBLEPbnzHBoQFHsOHUnwqnrP0xL/YlAvdpaQxn
        bWNg0ZEvyjI8ONg18vOGjgI=
X-Google-Smtp-Source: APXvYqz+RIoBX8P7tuVXQvZGegdrycHHc7W0fbuv9JHMHYuxlIAanDXNVmV3ihUqzWNqJOpF8YFquw==
X-Received: by 2002:a1c:cf43:: with SMTP id f64mr2490079wmg.61.1551354234189;
        Thu, 28 Feb 2019 03:43:54 -0800 (PST)
Received: from uks1.vyatta.net ([137.221.143.78])
        by smtp.gmail.com with ESMTPSA id o12sm26022906wrx.53.2019.02.28.03.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 03:43:53 -0800 (PST)
From:   Robert Shearman <robertshearman@gmail.com>
To:     Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>
Cc:     linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Shearman <robert.shearman@att.com>
Subject: [PATCH v4 3/3] i2c: mux: pca954x: allow management of device idle state via sysfs
Date:   Thu, 28 Feb 2019 11:43:43 +0000
Message-Id: <20190228114343.36443-4-robertshearman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228114343.36443-1-robertshearman@gmail.com>
References: <20190228114343.36443-1-robertshearman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Shearman <robert.shearman@att.com>

The behaviour, by default, to not deselect after each transfer is
unsafe when there is a device with an address that conflicts with
another device on another mux on the same parent bus, and it
may not be convenient to use devicetree to set the deselect mux,
e.g. when running on x86_64 when ACPI is used to discover most of the
device hierarchy.

Therefore, provide the ability to set the idle state behaviour using a
new sysfs file, idle_state as a complement to the method of
instantiating the device via sysfs. The possible behaviours are
disconnect, i.e. to deselect all channels from the mux, as-is (the
default), i.e. leave the last channel selected, and set a
predetermined channel.

The current behaviour of leaving the channel as-is after each
transaction is preserved.

Signed-off-by: Robert Shearman <robert.shearman@att.com>
---
 .../ABI/testing/sysfs-bus-i2c-devices-pca954x | 20 +++++
 drivers/i2c/muxes/i2c-mux-pca954x.c           | 85 +++++++++++++++++--
 2 files changed, 97 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-pca954x

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-pca954x b/Documentation/ABI/testing/sysfs-bus-i2c-devices-pca954x
new file mode 100644
index 000000000000..0b0de8cd0d13
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-pca954x
@@ -0,0 +1,20 @@
+What:		/sys/bus/i2c/.../idle_state
+Date:		January 2019
+KernelVersion:	5.2
+Contact:	Robert Shearman <robert.shearman@att.com>
+Description:
+		Value that exists only for mux devices that can be
+		written to control the behaviour of the multiplexer on
+		idle. Possible values:
+		-2 - disconnect on idle, i.e. deselect the last used
+		     channel, which is useful when there is a device
+		     with an address that conflicts with another
+		     device on another mux on the same parent bus.
+		-1 - leave the mux as-is, which is the most optimal
+		     setting in terms of I2C operations and is the
+		     default mode.
+		0..<nchans> - set the mux to a predetermined channel,
+		     which is useful if there is one channel that is
+		     used almost always, and you want to reduce the
+		     latency for normal operations after rare
+		     transactions on other channels
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index e32fef560684..923aa3a5a3dc 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -49,6 +49,7 @@
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <dt-bindings/mux/mux.h>
 
 #define PCA954X_MAX_NCHANS 8
 
@@ -84,7 +85,9 @@ struct pca954x {
 	const struct chip_desc *chip;
 
 	u8 last_chan;		/* last register value */
-	u8 deselect;
+	/* MUX_IDLE_AS_IS, MUX_IDLE_DISCONNECT or >= 0 for channel */
+	s8 idle_state;
+
 	struct i2c_client *client;
 
 	struct irq_domain *irq;
@@ -253,15 +256,71 @@ static int pca954x_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
 {
 	struct pca954x *data = i2c_mux_priv(muxc);
 	struct i2c_client *client = data->client;
+	s8 idle_state;
+
+	idle_state = READ_ONCE(data->idle_state);
+	if (idle_state >= 0)
+		/* Set the mux back to a predetermined channel */
+		return pca954x_select_chan(muxc, idle_state);
+
+	if (idle_state == MUX_IDLE_DISCONNECT) {
+		/* Deselect active channel */
+		data->last_chan = 0;
+		return pca954x_reg_write(muxc->parent, client,
+					 data->last_chan);
+	}
 
-	if (!(data->deselect & (1 << chan)))
-		return 0;
+	/* otherwise leave as-is */
 
-	/* Deselect active channel */
-	data->last_chan = 0;
-	return pca954x_reg_write(muxc->parent, client, data->last_chan);
+	return 0;
+}
+
+static ssize_t idle_state_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct pca954x *data = i2c_mux_priv(muxc);
+
+	return sprintf(buf, "%d\n", READ_ONCE(data->idle_state));
+}
+
+static ssize_t idle_state_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct pca954x *data = i2c_mux_priv(muxc);
+	int val;
+	int ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != MUX_IDLE_AS_IS && val != MUX_IDLE_DISCONNECT &&
+	    (val < 0 || val >= data->chip->nchans))
+		return -EINVAL;
+
+	i2c_lock_bus(muxc->parent, I2C_LOCK_SEGMENT);
+
+	WRITE_ONCE(data->idle_state, val);
+	/*
+	 * Set the mux into a state consistent with the new
+	 * idle_state.
+	 */
+	if (data->last_chan || val != MUX_IDLE_DISCONNECT)
+		ret = pca954x_deselect_mux(muxc, 0);
+
+	i2c_unlock_bus(muxc->parent, I2C_LOCK_SEGMENT);
+
+	return ret < 0 ? ret : count;
 }
 
+static DEVICE_ATTR_RW(idle_state);
+
 static irqreturn_t pca954x_irq_handler(int irq, void *dev_id)
 {
 	struct pca954x *data = dev_id;
@@ -328,8 +387,11 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 static void pca954x_cleanup(struct i2c_mux_core *muxc)
 {
 	struct pca954x *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
 	int c, irq;
 
+	device_remove_file(&client->dev, &dev_attr_idle_state);
+
 	if (data->irq) {
 		for (c = 0; c < data->chip->nchans; c++) {
 			irq = irq_find_mapping(data->irq, c);
@@ -410,9 +472,12 @@ static int pca954x_probe(struct i2c_client *client,
 	}
 
 	data->last_chan = 0;		   /* force the first selection */
+	data->idle_state = MUX_IDLE_AS_IS;
 
 	idle_disconnect_dt = np &&
 		of_property_read_bool(np, "i2c-mux-idle-disconnect");
+	if (idle_disconnect_dt)
+		data->idle_state = MUX_IDLE_DISCONNECT;
 
 	ret = pca954x_irq_setup(muxc);
 	if (ret)
@@ -420,8 +485,6 @@ static int pca954x_probe(struct i2c_client *client,
 
 	/* Now create an adapter for each channel */
 	for (num = 0; num < data->chip->nchans; num++) {
-		data->deselect |= idle_disconnect_dt << num;
-
 		ret = i2c_mux_add_adapter(muxc, 0, num, 0);
 		if (ret)
 			goto fail_cleanup;
@@ -436,6 +499,12 @@ static int pca954x_probe(struct i2c_client *client,
 			goto fail_cleanup;
 	}
 
+	/*
+	 * The attr probably isn't going to be needed in most cases,
+	 * so don't fail completely on error.
+	 */
+	device_create_file(dev, &dev_attr_idle_state);
+
 	dev_info(dev, "registered %d multiplexed busses for I2C %s %s\n",
 		 num, data->chip->muxtype == pca954x_ismux
 				? "mux" : "switch", client->name);
-- 
2.20.1

