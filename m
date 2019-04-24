Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30937C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3417206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bnXIRuWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbfDXQ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:57:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46712 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbfDXQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:57:12 -0400
Received: by mail-io1-f66.google.com with SMTP id p23so16418832iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3uSSI3VPvGi/6BY9R43l36Z4dacwuiCKP0Ld8kBlr44=;
        b=bnXIRuWRTnwCPHHhh2ttCAx++Rqo0b1IVaW/AbygR3fSMDmvw7lwKaFDt5fQa/iF6V
         zmbwzkNKV+g8Z7LcmuuvLVZvy5jwatrKZTF7q2duq2Mh2nv9crmk8/Qr1VJULepb/JdO
         BgfRAmYp+DclgUOwEGIe3koYhTJIcjxQcL3+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3uSSI3VPvGi/6BY9R43l36Z4dacwuiCKP0Ld8kBlr44=;
        b=WP0pJtQwwg6pfIfGeK75RW5z5eLF7Eo1IXPnL6uk+rL2a1Rc7cdRELEdO0RatwK0yj
         lnM5NDeq26HVohWOAfEKTH5wGxx21IfHZrfy9BBO/zJ9OMEaF5O2W1gkcwSmqhydqPDb
         c6OdO46nZjp2hIZgxjx8Ir9+/jXSmNKSHWl+sYlzBmso4hiCT6bFOWi3F+Njj5XNtrAq
         QkmourLOnoseXuV4i2emtl6pce5i35KzfOcxcRk+3hTG1kUUKngif8bfDm56i8w7xi78
         ZL4nnoiRx9BzY9EMDT5BubQ6w6xyAAiQaOdGCHAsDMx3aB/pR7Ii11E0f90L5iodLgl5
         fw9w==
X-Gm-Message-State: APjAAAVqWxMxLFfSja8Jlr2ad/WZIPIa61yKC1PxVvlsqifUUKskhtwX
        KXk1zqvxI4lmBLEMvdZWUV5WVA==
X-Google-Smtp-Source: APXvYqyadBr1IMFjQTX9rGDKQWx5Nq0vOnBgcQDq0K1n+HzSEENHc5KgWSursVWvZgxrPUrh/R253Q==
X-Received: by 2002:a6b:e30e:: with SMTP id u14mr9682312ioc.220.1556125030045;
        Wed, 24 Apr 2019 09:57:10 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id t67sm9371420ita.35.2019.04.24.09.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Apr 2019 09:57:09 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org,
        tbroch@chromium.org, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v8 1/2] platform/chrome: wilco_ec: Add property helper library
Date:   Wed, 24 Apr 2019 10:56:50 -0600
Message-Id: <20190424165651.236391-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Property is typically a data item that is stored to NVRAM
by the EC. Each of these data items has an index associated
with it, known as the Property ID (PID). Properties may have
variable lengths, up to a max of WILCO_EC_PROPERTY_MAX_SIZE
bytes. Properties can be simple integers, or they may be more
complex binary data.

This patch adds support for getting and setting properties.
This will be useful for setting the charge algorithm and charge
schedules, which all use properties.

Signed-off-by: Nick Crews <ncrews@chromium.org>
Acked-for-chrome-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
v7 changes:
-Remove bogus gerrit FROMLIST tag in commit title
v6 changes:
-Add EC_* prefix to enum property_ops so they are more unique.
-Split up the commit so properties are added in a first commit
v5 changes:
-Remove OP_SYNC, it has no immediate use case.
-Merge properties.h into wilco-ec.h
-Remove enum get_set_sync_op from the public interface,
 since without OP_SYNC they are irrelevant.
-Fix Kconfigs and Makefiles so they actually work
 with the v4 changes
-Tweak some formatting, spacing, and comments
-Fix validation of charge_type so illegal values
 can't be set. Before negative error codes were
 accidentally getting casted to positive numbers
-Remove more unneeded parentheses.
v4 changes:
-Use put_unaligned_le32() to store PID in request.
-Move implementation from
 drivers/platform/chrome/wilco_ec/charge_config.c to
 drivers/power/supply/wilco_charger.c
-Move drivers/platform/chrome/wilco_ec/properties.h to
 include/linux/platform_data/wilco-ec-properties.h
-Remove parentheses in switch statement in psp_val_to_charge_mode()
-Check for any negatvie return code from psp_val_to_charge_mode()
 instead of just -EINVAL so its less brittle
-Tweak comments in wilco-ec-properties.h
v3 changes:
-Add this changelog
-Fix commit message tags
v2 changes:
-Update Documentation to say KernelVersion 5.2
-Update Documentation to explain Trickle mode better.
-rename things from using *PCC* to *CHARGE*
-Split up conversions between POWER_SUPPLY_PROP_CHARGE_TYPE values
and Wilco EC codes
-Use devm_ flavor of power_supply_register(), which simplifies things
-Add extra error checking on property messages received from the EC
-Fix bug in memcpy() calls in properties.c
-Refactor fill_property_id()
-Add valid input checks to charge_type
-Properly convert charge_type when get()ting

 drivers/platform/chrome/wilco_ec/Makefile     |   2 +-
 drivers/platform/chrome/wilco_ec/properties.c | 132 ++++++++++++++++++
 include/linux/platform_data/wilco-ec.h        |  71 ++++++++++
 3 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.c

diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 063e7fb4ea17..29b734137786 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-wilco_ec-objs				:= core.o mailbox.o
+wilco_ec-objs				:= core.o mailbox.o properties.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
 wilco_ec_debugfs-objs			:= debugfs.o
 obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
diff --git a/drivers/platform/chrome/wilco_ec/properties.c b/drivers/platform/chrome/wilco_ec/properties.c
new file mode 100644
index 000000000000..e69682c95ea2
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/properties.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/string.h>
+#include <linux/unaligned/le_memmove.h>
+
+/* Operation code; what the EC should do with the property */
+enum ec_property_op {
+	EC_OP_GET = 0,
+	EC_OP_SET = 1,
+};
+
+struct ec_property_request {
+	u8 op; /* One of enum ec_property_op */
+	u8 property_id[4]; /* The 32 bit PID is stored Little Endian */
+	u8 length;
+	u8 data[WILCO_EC_PROPERTY_MAX_SIZE];
+} __packed;
+
+struct ec_property_response {
+	u8 reserved[2];
+	u8 op; /* One of enum ec_property_op */
+	u8 property_id[4]; /* The 32 bit PID is stored Little Endian */
+	u8 length;
+	u8 data[WILCO_EC_PROPERTY_MAX_SIZE];
+} __packed;
+
+static int send_property_msg(struct wilco_ec_device *ec,
+			     struct ec_property_request *rq,
+			     struct ec_property_response *rs)
+{
+	struct wilco_ec_message ec_msg;
+	int ret;
+
+	memset(&ec_msg, 0, sizeof(ec_msg));
+	ec_msg.type = WILCO_EC_MSG_PROPERTY;
+	ec_msg.request_data = rq;
+	ec_msg.request_size = sizeof(*rq);
+	ec_msg.response_data = rs;
+	ec_msg.response_size = sizeof(*rs);
+
+	ret = wilco_ec_mailbox(ec, &ec_msg);
+	if (ret < 0)
+		return ret;
+	if (rs->op != rq->op)
+		return -EBADMSG;
+	if (memcmp(rq->property_id, rs->property_id, sizeof(rs->property_id)))
+		return -EBADMSG;
+
+	return 0;
+}
+
+int wilco_ec_get_property(struct wilco_ec_device *ec,
+			  struct wilco_ec_property_msg *prop_msg)
+{
+	struct ec_property_request rq;
+	struct ec_property_response rs;
+	int ret;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.op = EC_OP_GET;
+	put_unaligned_le32(prop_msg->property_id, rq.property_id);
+
+	ret = send_property_msg(ec, &rq, &rs);
+	if (ret < 0)
+		return ret;
+
+	prop_msg->length = rs.length;
+	memcpy(prop_msg->data, rs.data, rs.length);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wilco_ec_get_property);
+
+int wilco_ec_set_property(struct wilco_ec_device *ec,
+			  struct wilco_ec_property_msg *prop_msg)
+{
+	struct ec_property_request rq;
+	struct ec_property_response rs;
+	int ret;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.op = EC_OP_SET;
+	put_unaligned_le32(prop_msg->property_id, rq.property_id);
+	rq.length = prop_msg->length;
+	memcpy(rq.data, prop_msg->data, prop_msg->length);
+
+	ret = send_property_msg(ec, &rq, &rs);
+	if (ret < 0)
+		return ret;
+	if (rs.length != prop_msg->length)
+		return -EBADMSG;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wilco_ec_set_property);
+
+int wilco_ec_get_byte_property(struct wilco_ec_device *ec, u32 property_id,
+			       u8 *val)
+{
+	struct wilco_ec_property_msg msg;
+	int ret;
+
+	msg.property_id = property_id;
+
+	ret = wilco_ec_get_property(ec, &msg);
+	if (ret < 0)
+		return ret;
+	if (msg.length != 1)
+		return -EBADMSG;
+
+	*val = msg.data[0];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wilco_ec_get_byte_property);
+
+int wilco_ec_set_byte_property(struct wilco_ec_device *ec, u32 property_id,
+			       u8 val)
+{
+	struct wilco_ec_property_msg msg;
+
+	msg.property_id = property_id;
+	msg.data[0] = val;
+	msg.length = 1;
+
+	return wilco_ec_set_property(ec, &msg);
+}
+EXPORT_SYMBOL_GPL(wilco_ec_set_byte_property);
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 1ff224793c99..50a21bd5fd44 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -123,4 +123,75 @@ struct wilco_ec_message {
  */
 int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg);
 
+/*
+ * A Property is typically a data item that is stored to NVRAM
+ * by the EC. Each of these data items has an index associated
+ * with it, known as the Property ID (PID). Properties may have
+ * variable lengths, up to a max of WILCO_EC_PROPERTY_MAX_SIZE
+ * bytes. Properties can be simple integers, or they may be more
+ * complex binary data.
+ */
+
+#define WILCO_EC_PROPERTY_MAX_SIZE	4
+
+/**
+ * struct ec_property_set_msg - Message to get or set a property.
+ * @property_id: Which property to get or set.
+ * @length: Number of bytes of |data| that are used.
+ * @data: Actual property data.
+ */
+struct wilco_ec_property_msg {
+	u32 property_id;
+	int length;
+	u8 data[WILCO_EC_PROPERTY_MAX_SIZE];
+};
+
+/**
+ * wilco_ec_get_property() - Retrieve a property from the EC.
+ * @ec: Embedded Controller device.
+ * @prop_msg: Message for request and response.
+ *
+ * The property_id field of |prop_msg| should be filled before calling this
+ * function. The result will be stored in the data and length fields.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int wilco_ec_get_property(struct wilco_ec_device *ec,
+			  struct wilco_ec_property_msg *prop_msg);
+
+/**
+ * wilco_ec_set_property() - Store a property on the EC.
+ * @ec: Embedded Controller device.
+ * @prop_msg: Message for request and response.
+ *
+ * The property_id, length, and data fields of |prop_msg| should be
+ * filled before calling this function.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int wilco_ec_set_property(struct wilco_ec_device *ec,
+			  struct wilco_ec_property_msg *prop_msg);
+
+/**
+ * wilco_ec_get_byte_property() - Retrieve a byte-size property from the EC.
+ * @ec: Embedded Controller device.
+ * @property_id: Which property to retrieve.
+ * @val: The result value, will be filled by this function.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int wilco_ec_get_byte_property(struct wilco_ec_device *ec, u32 property_id,
+			       u8 *val);
+
+/**
+ * wilco_ec_get_byte_property() - Store a byte-size property on the EC.
+ * @ec: Embedded Controller device.
+ * @property_id: Which property to store.
+ * @val: Value to store.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int wilco_ec_set_byte_property(struct wilco_ec_device *ec, u32 property_id,
+			       u8 val);
+
 #endif /* WILCO_EC_H */
-- 
2.20.1

