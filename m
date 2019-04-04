Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F30C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78309206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Or85JGjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfDDHaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:30:22 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50128 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:30:22 -0400
Received: by mail-pg1-f202.google.com with SMTP id x2so1010772pge.16
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qKDjR/q9/Z56sk8+oMUSl5YqHuKVSbgtEW1aW6KZ3Xk=;
        b=Or85JGjYVDRT4KjhKh+5yXzT6hXJELzpeM9Nk46zG0Txi3M/F8vt1KZucUt3e8eDx+
         8YNIh6FnS8HdtlXvho7R+TbwI1JNsPowBFN1WB3MZ5yopHmOaZDEXI7N30KwVg0JFDvR
         i9guT5Nc8rWisPE3K84wZ+7SF0tK9XXQlcoSBucaLXesRw2sAfa72oUl1PcCew0HpOoS
         311S8gdMXg/gEbI9jgMStYeOEEuckMil4WkntyegWRYeYaqMgrXiIqG1rvCZHPCLt8Xy
         qRpJNV/q6tESz6b+utrMTHt/qW4Lv349t7mjnTRgSn2lqi0SNBXqwiQkkX+0Cg+vOXvo
         B3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qKDjR/q9/Z56sk8+oMUSl5YqHuKVSbgtEW1aW6KZ3Xk=;
        b=DhTiQErwz2kS1Lm3nGYCIs5DzCKGJe4MRwIFTd4MKVUVvqI46M+6/XKt58Xh79BtgR
         nbYSFA0UdoJdOeVgEuJzKYIGcgWiZvX8Z9ecXMwl0vFvAbD+QBPvq41ubRvfJuc61++w
         /5R5CphJkB/6qSbOb/AkROWO0iQvsxA9kYDM4KAKHKXMsmhaZbO1MFwz/DviahTznOsy
         8+l7aLM4cg6i4K7SWx0iJmUM1YKeIT5pNOfPL2eSdTd0QEPOeL978Li0bUJ9GjOG6CU9
         zZAy0p1Aw2nG4xbiTLaiOKyfTV6Qt+itpwUVdIbcWN3WYL1RnKkIZzrxueLIl/YaSqar
         rOIQ==
X-Gm-Message-State: APjAAAVP4IDm5YRftn5Zh/lKoaRpErdvQSZnm20HKfuDi6gKbir4nz+k
        g96kwhsRSikOdY/BhDok+Vp5wyK4M50=
X-Google-Smtp-Source: APXvYqwk1FJcnRduYnx8FyGKHSBg3XIzWcW5XjI2z8cjAEpY17JHhWUvmGlky+ltOk8HgWvrr3DHI2R5KFA=
X-Received: by 2002:a63:ef18:: with SMTP id u24mr99359pgh.24.1554363020730;
 Thu, 04 Apr 2019 00:30:20 -0700 (PDT)
Date:   Thu,  4 Apr 2019 09:30:05 +0200
Message-Id: <20190404073005.35474-1-darekm@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC PATCH] media: cec: DRM connector to CEC dev mapping
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     linux-media@vger.kernel.org, hans.verkuil@cisco.com
Cc:     linux-kernel@vger.kernel.org,
        Dariusz Marcinkiewicz <darekm@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch proposes to introduce explicit mapping between DRM connectors
and /dev/cecX adapters.

This is achieved here by adding a new structure with connector info
(DRM card number and connector id) to cec_adapter. That connector info
is expected to be set either by a code creating an adapter or trough
a CEC notifier (which is extended for that purpose).

A new ioctl, exposing connector info to userland, is added to /dev/cec.
New CEC event type is also added. That event is to notify an application
that the info about mapping between an adapter and a DRM connector was
just set.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
---

Notes:
    Sending the patch in its current form the get feedback if that is
    considered a right approach or if some other way of learning
    the mapping in userland is preferred.

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 +-
 drivers/gpu/drm/drm_dp_cec.c                  | 20 ++++----
 drivers/gpu/drm/i915/intel_dp.c               |  4 +-
 drivers/gpu/drm/i915/intel_hdmi.c             |  7 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  3 +-
 drivers/media/cec/cec-adap.c                  | 21 ++++++++-
 drivers/media/cec/cec-api.c                   | 17 +++++++
 drivers/media/cec/cec-core.c                  | 12 ++++-
 drivers/media/cec/cec-notifier.c              | 47 ++++++++++++++++---
 include/drm/drm_dp_helper.h                   | 14 +++---
 include/media/cec-notifier.h                  | 31 ++++++++++--
 include/media/cec.h                           | 13 ++++-
 include/uapi/linux/cec.h                      | 18 +++++++
 13 files changed, 172 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index c4ea3a91f17aa..41678df654cdc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -379,7 +379,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 
 	drm_dp_aux_register(&aconnector->dm_dp_aux.aux);
 	drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
-				      aconnector->base.name, dm->adev->dev);
+				      &aconnector->base);
 	aconnector->mst_mgr.cbs = &dm_mst_cbs;
 	drm_dp_mst_topology_mgr_init(
 		&aconnector->mst_mgr,
diff --git a/drivers/gpu/drm/drm_dp_cec.c b/drivers/gpu/drm/drm_dp_cec.c
index b15cee85b702b..cb09bb2197a85 100644
--- a/drivers/gpu/drm/drm_dp_cec.c
+++ b/drivers/gpu/drm/drm_dp_cec.c
@@ -8,7 +8,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_dp_helper.h>
+#include <drm/drmP.h>
 #include <media/cec.h>
 
 /*
@@ -295,6 +297,7 @@ static void drm_dp_cec_unregister_work(struct work_struct *work)
  */
 void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 {
+	struct drm_connector *connector = aux->cec.connector;
 	u32 cec_caps = CEC_CAP_DEFAULTS | CEC_CAP_NEEDS_HPD;
 	unsigned int num_las = 1;
 	u8 cap;
@@ -344,16 +347,19 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 
 	/* Create a new adapter */
 	aux->cec.adap = cec_allocate_adapter(&drm_dp_cec_adap_ops,
-					     aux, aux->cec.name, cec_caps,
+					     aux, connector->name, cec_caps,
 					     num_las);
 	if (IS_ERR(aux->cec.adap)) {
 		aux->cec.adap = NULL;
 		goto unlock;
 	}
-	if (cec_register_adapter(aux->cec.adap, aux->cec.parent)) {
+	if (cec_register_adapter(aux->cec.adap, connector->dev->dev)) {
 		cec_delete_adapter(aux->cec.adap);
 		aux->cec.adap = NULL;
 	} else {
+		cec_s_connector_info(aux->cec.adap,
+				     connector->dev->primary->index,
+				     connector->base.id);
 		/*
 		 * Update the phys addr for the new CEC adapter. When called
 		 * from drm_dp_cec_register_connector() edid == NULL, so in
@@ -406,22 +412,20 @@ EXPORT_SYMBOL(drm_dp_cec_unset_edid);
 /**
  * drm_dp_cec_register_connector() - register a new connector
  * @aux: DisplayPort AUX channel
- * @name: name of the CEC device
- * @parent: parent device
+ * @connector: drm connector
  *
  * A new connector was registered with associated CEC adapter name and
  * CEC adapter parent device. After registering the name and parent
  * drm_dp_cec_set_edid() is called to check if the connector supports
  * CEC and to register a CEC adapter if that is the case.
  */
-void drm_dp_cec_register_connector(struct drm_dp_aux *aux, const char *name,
-				   struct device *parent)
+void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
+				   struct drm_connector *connector)
 {
 	WARN_ON(aux->cec.adap);
 	if (WARN_ON(!aux->transfer))
 		return;
-	aux->cec.name = name;
-	aux->cec.parent = parent;
+	aux->cec.connector = connector;
 	INIT_DELAYED_WORK(&aux->cec.unregister_work,
 			  drm_dp_cec_unregister_work);
 }
diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index cf709835fb9a9..b30eb9598965b 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -5557,8 +5557,7 @@ intel_dp_connector_register(struct drm_connector *connector)
 	intel_dp->aux.dev = connector->kdev;
 	ret = drm_dp_aux_register(&intel_dp->aux);
 	if (!ret)
-		drm_dp_cec_register_connector(&intel_dp->aux,
-					      connector->name, dev->dev);
+		drm_dp_cec_register_connector(&intel_dp->aux, connector);
 	return ret;
 }
 
@@ -7107,3 +7106,4 @@ void intel_dp_mst_resume(struct drm_i915_private *dev_priv)
 		}
 	}
 }
+
diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
index f125a62eba8cf..5ad088c7a0c03 100644
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -2448,8 +2448,13 @@ void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
 
 	intel_hdmi->cec_notifier = cec_notifier_get_conn(dev->dev,
 							 port_identifier(port));
-	if (!intel_hdmi->cec_notifier)
+	if (intel_hdmi->cec_notifier) {
+		cec_notifier_set_connector_info(intel_hdmi->cec_notifier,
+						connector->dev->primary->index,
+						connector->base.id);
+	} else {
 		DRM_DEBUG_KMS("CEC notifier get failed\n");
+	}
 }
 
 void intel_hdmi_init(struct drm_i915_private *dev_priv,
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 4116ee62adafe..4438824ca88b0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1413,8 +1413,7 @@ nouveau_connector_create(struct drm_device *dev,
 	switch (type) {
 	case DRM_MODE_CONNECTOR_DisplayPort:
 	case DRM_MODE_CONNECTOR_eDP:
-		drm_dp_cec_register_connector(&nv_connector->aux,
-					      connector->name, dev->dev);
+		drm_dp_cec_register_connector(&nv_connector->aux, connector);
 		break;
 	}
 
diff --git a/drivers/media/cec/cec-adap.c b/drivers/media/cec/cec-adap.c
index f1261cc2b6fa5..dceddab9bcaee 100644
--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -87,7 +87,7 @@ void cec_queue_event_fh(struct cec_fh *fh,
 			const struct cec_event *new_ev, u64 ts)
 {
 	static const u16 max_events[CEC_NUM_EVENTS] = {
-		1, 1, 800, 800, 8, 8, 8, 8
+		1, 1, 800, 800, 8, 8, 8, 8, 1
 	};
 	struct cec_event_entry *entry;
 	unsigned int ev_idx = new_ev->event - 1;
@@ -1566,6 +1566,25 @@ void cec_s_phys_addr_from_edid(struct cec_adapter *adap,
 }
 EXPORT_SYMBOL_GPL(cec_s_phys_addr_from_edid);
 
+void cec_s_connector_info(struct cec_adapter *adap, int card_no,
+			  u32 connector_id)
+{
+	struct cec_event ev = {
+		.event = CEC_EVENT_CONNECTOR_SET,
+		.flags = 0,
+		.connector.card_no = card_no,
+		.connector.connector_id = connector_id,
+	};
+
+	mutex_lock(&adap->lock);
+	adap->connector.card_no = card_no;
+	adap->connector.connector_id = connector_id;
+	mutex_unlock(&adap->lock);
+
+	cec_queue_event(adap, &ev);
+}
+EXPORT_SYMBOL_GPL(cec_s_connector_info);
+
 /*
  * Called from either the ioctl or a driver to set the logical addresses.
  *
diff --git a/drivers/media/cec/cec-api.c b/drivers/media/cec/cec-api.c
index 156a0d76ab2a1..f523d5433849f 100644
--- a/drivers/media/cec/cec-api.c
+++ b/drivers/media/cec/cec-api.c
@@ -187,6 +187,20 @@ static long cec_adap_s_log_addrs(struct cec_adapter *adap, struct cec_fh *fh,
 	return 0;
 }
 
+static long cec_adap_g_connector_info(struct cec_adapter *adap,
+				      struct cec_log_addrs __user *parg)
+{
+	struct cec_connector_info connector_info;
+
+	mutex_lock(&adap->lock);
+	connector_info = adap->connector;
+	mutex_unlock(&adap->lock);
+
+	if (copy_to_user(parg, &connector_info, sizeof(connector_info)))
+		return -EFAULT;
+	return 0;
+}
+
 static long cec_transmit(struct cec_adapter *adap, struct cec_fh *fh,
 			 bool block, struct cec_msg __user *parg)
 {
@@ -514,6 +528,9 @@ static long cec_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case CEC_ADAP_S_LOG_ADDRS:
 		return cec_adap_s_log_addrs(adap, fh, block, parg);
 
+	case CEC_ADAP_G_CONNECTOR_INFO:
+		return cec_adap_g_connector_info(adap, parg);
+
 	case CEC_TRANSMIT:
 		return cec_transmit(adap, fh, block, parg);
 
diff --git a/drivers/media/cec/cec-core.c b/drivers/media/cec/cec-core.c
index cc875dabd7658..d80f14d58b1be 100644
--- a/drivers/media/cec/cec-core.c
+++ b/drivers/media/cec/cec-core.c
@@ -182,11 +182,17 @@ static void cec_devnode_unregister(struct cec_adapter *adap)
 }
 
 #ifdef CONFIG_CEC_NOTIFIER
-static void cec_cec_notify(struct cec_adapter *adap, u16 pa)
+static void cec_cec_phys_addr_notify(struct cec_adapter *adap, u16 pa)
 {
 	cec_s_phys_addr(adap, pa, false);
 }
 
+static void cec_cec_connector_notify(struct cec_adapter *adap, int card_no,
+				     u32 connector_id)
+{
+	cec_s_connector_info(adap, card_no, connector_id);
+}
+
 void cec_register_cec_notifier(struct cec_adapter *adap,
 			       struct cec_notifier *notifier)
 {
@@ -194,7 +200,9 @@ void cec_register_cec_notifier(struct cec_adapter *adap,
 		return;
 
 	adap->notifier = notifier;
-	cec_notifier_register(adap->notifier, adap, cec_cec_notify);
+	cec_notifier_register(adap->notifier, adap,
+			      cec_cec_phys_addr_notify,
+			      cec_cec_connector_notify);
 }
 EXPORT_SYMBOL_GPL(cec_register_cec_notifier);
 #endif
diff --git a/drivers/media/cec/cec-notifier.c b/drivers/media/cec/cec-notifier.c
index dd2078b27a419..86b0412a95d14 100644
--- a/drivers/media/cec/cec-notifier.c
+++ b/drivers/media/cec/cec-notifier.c
@@ -23,9 +23,13 @@ struct cec_notifier {
 	struct device *dev;
 	const char *conn;
 	struct cec_adapter *cec_adap;
-	void (*callback)(struct cec_adapter *adap, u16 pa);
+	void (*phys_addr_callback)(struct cec_adapter *adap, u16 pa);
+	void (*connector_callback)(struct cec_adapter *adap,
+				   int card_no,
+				   u32 connector_id);
 
 	u16 phys_addr;
+	struct cec_connector_info connector_info;
 };
 
 static LIST_HEAD(cec_notifiers);
@@ -51,6 +55,7 @@ struct cec_notifier *cec_notifier_get_conn(struct device *dev, const char *conn)
 	if (conn)
 		n->conn = kstrdup(conn, GFP_KERNEL);
 	n->phys_addr = CEC_PHYS_ADDR_INVALID;
+	n->connector_info.card_no = CEC_CONNECTOR_INVALID_CARD_NO;
 	mutex_init(&n->lock);
 	kref_init(&n->kref);
 	list_add_tail(&n->head, &cec_notifiers);
@@ -85,8 +90,8 @@ void cec_notifier_set_phys_addr(struct cec_notifier *n, u16 pa)
 
 	mutex_lock(&n->lock);
 	n->phys_addr = pa;
-	if (n->callback)
-		n->callback(n->cec_adap, n->phys_addr);
+	if (n->phys_addr_callback)
+		n->phys_addr_callback(n->cec_adap, n->phys_addr);
 	mutex_unlock(&n->lock);
 }
 EXPORT_SYMBOL_GPL(cec_notifier_set_phys_addr);
@@ -106,15 +111,42 @@ void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
 }
 EXPORT_SYMBOL_GPL(cec_notifier_set_phys_addr_from_edid);
 
+void cec_notifier_set_connector_info(struct cec_notifier *n, int card_no,
+				     u32 connector_id)
+{
+	if (n == NULL)
+		return;
+
+	mutex_lock(&n->lock);
+	n->connector_info.card_no = card_no;
+	n->connector_info.connector_id = connector_id;
+	if (n->connector_callback)
+		n->connector_callback(n->cec_adap, card_no, connector_id);
+	mutex_unlock(&n->lock);
+}
+EXPORT_SYMBOL_GPL(cec_notifier_set_connector_info);
+
 void cec_notifier_register(struct cec_notifier *n,
 			   struct cec_adapter *adap,
-			   void (*callback)(struct cec_adapter *adap, u16 pa))
+			   void (*phys_addr_callback)(struct cec_adapter *adap,
+						      u16 pa),
+			   void (*connector_callback)(struct cec_adapter *adap,
+						      int card_no,
+						      u32 connector_id))
 {
 	kref_get(&n->kref);
 	mutex_lock(&n->lock);
 	n->cec_adap = adap;
-	n->callback = callback;
-	n->callback(adap, n->phys_addr);
+
+	n->phys_addr_callback = phys_addr_callback;
+	n->phys_addr_callback(adap, n->phys_addr);
+
+	n->connector_callback = connector_callback;
+	if (n->connector_callback) {
+		n->connector_callback(adap, n->connector_info.card_no,
+				      n->connector_info.connector_id);
+	}
+
 	mutex_unlock(&n->lock);
 }
 EXPORT_SYMBOL_GPL(cec_notifier_register);
@@ -122,7 +154,8 @@ EXPORT_SYMBOL_GPL(cec_notifier_register);
 void cec_notifier_unregister(struct cec_notifier *n)
 {
 	mutex_lock(&n->lock);
-	n->callback = NULL;
+	n->phys_addr_callback = NULL;
+	n->connector_callback = NULL;
 	mutex_unlock(&n->lock);
 	cec_notifier_put(n);
 }
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 97ce790a5b5aa..ded0ff01f2ac7 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1208,6 +1208,7 @@ struct drm_dp_aux_msg {
 
 struct cec_adapter;
 struct edid;
+struct drm_connector;
 
 /**
  * struct drm_dp_aux_cec - DisplayPort CEC-Tunneling-over-AUX
@@ -1220,8 +1221,7 @@ struct edid;
 struct drm_dp_aux_cec {
 	struct mutex lock;
 	struct cec_adapter *adap;
-	const char *name;
-	struct device *parent;
+	struct drm_connector *connector;
 	struct delayed_work unregister_work;
 };
 
@@ -1418,8 +1418,8 @@ drm_dp_has_quirk(const struct drm_dp_desc *desc, enum drm_dp_quirk quirk)
 
 #ifdef CONFIG_DRM_DP_CEC
 void drm_dp_cec_irq(struct drm_dp_aux *aux);
-void drm_dp_cec_register_connector(struct drm_dp_aux *aux, const char *name,
-				   struct device *parent);
+void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
+				   struct drm_connector *connector);
 void drm_dp_cec_unregister_connector(struct drm_dp_aux *aux);
 void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid);
 void drm_dp_cec_unset_edid(struct drm_dp_aux *aux);
@@ -1428,9 +1428,9 @@ static inline void drm_dp_cec_irq(struct drm_dp_aux *aux)
 {
 }
 
-static inline void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
-						 const char *name,
-						 struct device *parent)
+static inline
+void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
+				   struct drm_connector *connector)
 {
 }
 
diff --git a/include/media/cec-notifier.h b/include/media/cec-notifier.h
index 814eeef35a5cf..0b77bef601158 100644
--- a/include/media/cec-notifier.h
+++ b/include/media/cec-notifier.h
@@ -63,15 +63,28 @@ void cec_notifier_set_phys_addr(struct cec_notifier *n, u16 pa);
 void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
 					  const struct edid *edid);
 
+/**
+ * cec_notifier_set_connector_info - associates connector info with a notifier
+ * @n: the CEC notifier
+ * @card_no: the drm card number
+ * @connector_id: drm connector id
+ */
+void cec_notifier_set_connector_info(struct cec_notifier *n, int card_no,
+				     u32 connector_id);
 /**
  * cec_notifier_register - register a callback with the notifier
  * @n: the CEC notifier
  * @adap: the CEC adapter, passed as argument to the callback function
- * @callback: the callback function
+ * @phys_addr_callback : callback invoked when new phys address is set
+ * @connector_callback : callback invoked when connector is set
  */
 void cec_notifier_register(struct cec_notifier *n,
 			   struct cec_adapter *adap,
-			   void (*callback)(struct cec_adapter *adap, u16 pa));
+			   void (*phys_addr_callback)(struct cec_adapter *adap,
+						      u16 pa),
+			   void (*connector_callback)(struct cec_adapter *adap,
+						      int card_no,
+						      u32 connector_id));
 
 /**
  * cec_notifier_unregister - unregister the callback from the notifier.
@@ -108,9 +121,19 @@ static inline void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
 {
 }
 
+static inline void cec_notifier_set_connector_info(struct cec_notifier *n,
+						   int card_no,
+						   u32 connector_id)
+{
+}
+
 static inline void cec_notifier_register(struct cec_notifier *n,
-			 struct cec_adapter *adap,
-			 void (*callback)(struct cec_adapter *adap, u16 pa))
+			   struct cec_adapter *adap,
+			   void (*phys_addr_callback)(struct cec_adapter *adap,
+						      u16 pa),
+			   void (*connector_callback)(struct cec_adapter *adap,
+						      int card_no,
+						      u32 connector_id))
 {
 }
 
diff --git a/include/media/cec.h b/include/media/cec.h
index 707411ef8ba28..940c8826a1632 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -78,7 +78,7 @@ struct cec_event_entry {
 };
 
 #define CEC_NUM_CORE_EVENTS 2
-#define CEC_NUM_EVENTS CEC_EVENT_PIN_5V_HIGH
+#define CEC_NUM_EVENTS CEC_EVENT_CONNECTOR_SET
 
 struct cec_fh {
 	struct list_head	list;
@@ -200,6 +200,8 @@ struct cec_adapter {
 	u32 sequence;
 
 	char input_phys[32];
+
+	struct cec_connector_info connector;
 };
 
 static inline void *cec_get_drvdata(const struct cec_adapter *adap)
@@ -247,9 +249,11 @@ void cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr,
 		     bool block);
 void cec_s_phys_addr_from_edid(struct cec_adapter *adap,
 			       const struct edid *edid);
+void cec_s_connector_info(struct cec_adapter *adap, int card_no,
+			  u32 connector_id);
+
 int cec_transmit_msg(struct cec_adapter *adap, struct cec_msg *msg,
 		     bool block);
-
 /* Called by the adapter */
 void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
 			  u8 arb_lost_cnt, u8 nack_cnt, u8 low_drive_cnt,
@@ -357,6 +361,11 @@ static inline void cec_s_phys_addr_from_edid(struct cec_adapter *adap,
 {
 }
 
+void cec_s_connector_info(struct cec_adapter *adap, int card_no,
+			  u32 connector_id)
+{
+}
+
 static inline u16 cec_get_edid_phys_addr(const u8 *edid, unsigned int size,
 					 unsigned int *offset)
 {
diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
index 3094af68b6e76..cb9817ab2012e 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -389,6 +389,7 @@ struct cec_log_addrs {
 #define CEC_EVENT_PIN_HPD_HIGH		6
 #define CEC_EVENT_PIN_5V_LOW		7
 #define CEC_EVENT_PIN_5V_HIGH		8
+#define CEC_EVENT_CONNECTOR_SET		9
 
 #define CEC_EVENT_FL_INITIAL_STATE	(1 << 0)
 #define CEC_EVENT_FL_DROPPED_EVENTS	(1 << 1)
@@ -411,6 +412,19 @@ struct cec_event_lost_msgs {
 	__u32 lost_msgs;
 };
 
+/**
+ * struct cec_event_connector - tells if and which drm connector is associated
+ * with the CEC adapter.
+ * @card_no: drm card number, -1 if no connector
+ * @connector_id: drm connector id.
+ */
+
+#define CEC_CONNECTOR_INVALID_CARD_NO	-1
+struct cec_connector_info {
+	int card_no;
+	__u32 connector_id;
+};
+
 /**
  * struct cec_event - CEC event structure
  * @ts: the timestamp of when the event was sent.
@@ -427,6 +441,7 @@ struct cec_event {
 	union {
 		struct cec_event_state_change state_change;
 		struct cec_event_lost_msgs lost_msgs;
+		struct cec_connector_info connector;
 		__u32 raw[16];
 	};
 };
@@ -475,6 +490,9 @@ struct cec_event {
 #define CEC_G_MODE		_IOR('a',  8, __u32)
 #define CEC_S_MODE		_IOW('a',  9, __u32)
 
+/* Gets the connector info */
+#define CEC_ADAP_G_CONNECTOR_INFO _IOR('a',  10, struct cec_connector_info)
+
 /*
  * The remainder of this header defines all CEC messages and operands.
  * The format matters since it the cec-ctl utility parses it to generate
-- 
2.18.1

