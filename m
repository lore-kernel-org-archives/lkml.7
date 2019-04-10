Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB854C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CBB2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X5KjQihM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfDJEPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:15:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34348 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfDJEPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:15:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3A4EjGL127769;
        Tue, 9 Apr 2019 23:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554869685;
        bh=nVjBp3JGzdDjDs/bKo73hN0etoc5xZ1brHyNvGfIIrc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=X5KjQihMEjvosX+ydo2cgJuAzP4XETvyf6S4/0T/GT29z5ZO5aEzva1ekF2Ux6rwd
         BTIS9aT1x4c2Eo65rW+8tfZTsG+ognkCzu/7dcHJn6iEvi35cxG6EjCf2QY1jt0jXh
         Ertjjf3j5zNsYiIA+GrVT3KW4zyrUZoa98AUdlXo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3A4Ej5G048589
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 23:14:45 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 23:14:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 23:14:44 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3A4EKZQ029255;
        Tue, 9 Apr 2019 23:14:41 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v6 05/12] firmware: ti_sci: Add helper apis to manage resources
Date:   Wed, 10 Apr 2019 09:43:51 +0530
Message-ID: <20190410041358.16809-6-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410041358.16809-1-lokeshvutla@ti.com>
References: <20190410041358.16809-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each resource with in the device can be uniquely identified as defined
by TISCI. Since this is generic across the devices, resource allocation
also can be made generic instead of each client driver handling the
resource. So add helper apis to manage the resource.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v5:
- New patch. Abstracted out resource managemented into firmware driver after
 discussing with Nishanth and Marc.

 drivers/firmware/ti_sci.c              | 130 +++++++++++++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  54 ++++++++++
 2 files changed, 184 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 88e461498def..e4b01cfc5883 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2277,6 +2277,136 @@ const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_ti_sci_get_by_phandle);
 
+/**
+ * ti_sci_get_free_resource() - Get a free resource from TISCI resource.
+ * @res:	Pointer to the TISCI resource
+ *
+ * Return: resource num if all went ok else TI_SCI_RESOURCE_NULL.
+ */
+u16 ti_sci_get_free_resource(struct ti_sci_resource *res)
+{
+	unsigned long flags;
+	u16 set, free_bit;
+
+	raw_spin_lock_irqsave(&res->lock, flags);
+	for (set = 0; set < res->sets; set++) {
+		free_bit = find_first_zero_bit(res->desc[set].res_map,
+					       res->desc[set].num);
+		if (free_bit != res->desc[set].num) {
+			set_bit(free_bit, res->desc[set].res_map);
+			raw_spin_unlock_irqrestore(&res->lock, flags);
+			return res->desc[set].start + free_bit;
+		}
+	}
+	raw_spin_unlock_irqrestore(&res->lock, flags);
+
+	return TI_SCI_RESOURCE_NULL;
+}
+EXPORT_SYMBOL_GPL(ti_sci_get_free_resource);
+
+/**
+ * ti_sci_release_resource() - Release a resource from TISCI resource.
+ * @res:	Pointer to the TISCI resource
+ * @id:		Resource id to be released.
+ */
+void ti_sci_release_resource(struct ti_sci_resource *res, u16 id)
+{
+	unsigned long flags;
+	u16 set;
+
+	raw_spin_lock_irqsave(&res->lock, flags);
+	for (set = 0; set < res->sets; set++) {
+		if (res->desc[set].start <= id &&
+		    (res->desc[set].num + res->desc[set].start) > id)
+			clear_bit(id - res->desc[set].start,
+				  res->desc[set].res_map);
+	}
+	raw_spin_unlock_irqrestore(&res->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ti_sci_release_resource);
+
+/**
+ * ti_sci_get_num_resources() - Get the number of resources in TISCI resource
+ * @res:	Pointer to the TISCI resource
+ *
+ * Return: Total number of available resources.
+ */
+u32 ti_sci_get_num_resources(struct ti_sci_resource *res)
+{
+	u32 set, count = 0;
+
+	for (set = 0; set < res->sets; set++)
+		count += res->desc[set].num;
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(ti_sci_get_num_resources);
+
+/**
+ * devm_ti_sci_get_of_resource() - Get a TISCI resource assigned to a device
+ * @handle:	TISCI handle
+ * @dev:	Device pointer to which the resource is assigned
+ * @dev_id:	TISCI device id to which the resource is assigned
+ * @of_prop:	property name by which the resource are represented
+ *
+ * Return: Pointer to ti_sci_resource if all went well else appropriate
+ *	   error pointer.
+ */
+struct ti_sci_resource *
+devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
+			    struct device *dev, u32 dev_id, char *of_prop)
+{
+	struct ti_sci_resource *res;
+	u32 resource_subtype;
+	int i, ret;
+
+	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return ERR_PTR(-ENOMEM);
+
+	res->sets = of_property_count_elems_of_size(dev_of_node(dev), of_prop,
+						    sizeof(u32));
+	if (res->sets < 0) {
+		dev_err(dev, "%s resource type ids not available\n", of_prop);
+		return ERR_PTR(res->sets);
+	}
+
+	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
+				 GFP_KERNEL);
+	if (!res->desc)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < res->sets; i++) {
+		ret = of_property_read_u32_index(dev_of_node(dev), of_prop, i,
+						 &resource_subtype);
+		if (ret)
+			return ERR_PTR(-EINVAL);
+
+		ret = handle->ops.rm_core_ops.get_range(handle, dev_id,
+							resource_subtype,
+							&res->desc[i].start,
+							&res->desc[i].num);
+		if (ret) {
+			dev_err(dev, "dev = %d subtype %d not allocated for this host\n",
+				dev_id, resource_subtype);
+			return ERR_PTR(ret);
+		}
+
+		dev_dbg(dev, "dev = %d, subtype = %d, start = %d, num = %d\n",
+			dev_id, resource_subtype, res->desc[i].start,
+			res->desc[i].num);
+
+		res->desc[i].res_map =
+			devm_kzalloc(dev, BITS_TO_LONGS(res->desc[i].num) *
+				     sizeof(*res->desc[i].res_map), GFP_KERNEL);
+		if (!res->desc[i].res_map)
+			return ERR_PTR(-ENOMEM);
+	}
+	raw_spin_lock_init(&res->lock);
+
+	return res;
+}
+
 static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 				void *cmd)
 {
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index a0216c947acd..277d98fab505 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -268,6 +268,33 @@ struct ti_sci_handle {
 	struct ti_sci_ops ops;
 };
 
+#define TI_SCI_RESOURCE_NULL	0xffff
+
+/**
+ * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
+ * @start:	Start index of the resource.
+ * @num:	Number of resources.
+ * @res_map:	Bitmap to manage the allocation of these resources.
+ */
+struct ti_sci_resource_desc {
+	u16 start;
+	u16 num;
+	unsigned long *res_map;
+};
+
+/**
+ * struct ti_sci_resource - Structure representing a resource assigned
+ *			    to a device.
+ * @sets:	Number of sets available from this resource type
+ * @lock:	Lock to guard the res map in each set.
+ * @desc:	Array of resource descriptors.
+ */
+struct ti_sci_resource {
+	u16 sets;
+	raw_spinlock_t lock;
+	struct ti_sci_resource_desc *desc;
+};
+
 #if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
 const struct ti_sci_handle *ti_sci_get_handle(struct device *dev);
 int ti_sci_put_handle(const struct ti_sci_handle *handle);
@@ -276,6 +303,12 @@ const struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
 						  const char *property);
 const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
 						       const char *property);
+u16 ti_sci_get_free_resource(struct ti_sci_resource *res);
+void ti_sci_release_resource(struct ti_sci_resource *res, u16 id);
+u32 ti_sci_get_num_resources(struct ti_sci_resource *res);
+struct ti_sci_resource *
+devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
+			    struct device *dev, u32 dev_id, char *of_prop);
 
 #else	/* CONFIG_TI_SCI_PROTOCOL */
 
@@ -308,6 +341,27 @@ const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline u16 ti_sci_get_free_resource(struct ti_sci_resource *res)
+{
+	return TI_SCI_RESOURCE_NULL;
+}
+
+static inline void ti_sci_release_resource(struct ti_sci_resource *res, u16 id)
+{
+}
+
+static inline u32 ti_sci_get_num_resources(struct ti_sci_resource *res)
+{
+	return 0;
+}
+
+static inline struct ti_sci_resource *
+devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
+			    struct device *dev, u32 dev_id, char *of_prop)
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif	/* CONFIG_TI_SCI_PROTOCOL */
 
 #endif	/* __TISCI_PROTOCOL_H */
-- 
2.21.0

