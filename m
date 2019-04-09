Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2237DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C465820880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCuttH1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDIHdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:33:54 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:43902 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIHdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:33:51 -0400
Received: by mail-qt1-f201.google.com with SMTP id q21so14988977qtf.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 00:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4AcDR89kdR9GXaMkiMenrgge4Y6Rakg+71XrjSTE9Bg=;
        b=uCuttH1Uq1dpC4O99pSpnCSL9kl0Xhf/bv74RZeM7QXCIZ/5+oPS/BRdZ36FXmXgkJ
         o2B1/98s8VPS0IXhKCNuK57IGPR5X74TMF0DXH8Yw6+prLdB49Gror+pWYFDD/ZQzBUj
         KWHOlAuyENs1dmYZGH2xm+oMy0eDK3Dsr6UtC2kxmtUq1FmfP+KVNTVTKnxqwTrqvu56
         QQczAxaJ6UnBTNKSMI6Qcege9ggcYhRys7LaU3gaenIDOAqFZuDduKLHgJ1P4ocsMefs
         GnVG6euXsqmR3+r6KrDhK4iHtEiuuKIhKkAIbJ6Q9NAUG2f17kYt5Tq03LgXYcvAYmhc
         fsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4AcDR89kdR9GXaMkiMenrgge4Y6Rakg+71XrjSTE9Bg=;
        b=sJ2u4jYH6lIZV30XYXgLxq5alDOCI42KsffCmqIsADoDVZzFroWtSR+vWxPdSy/HcO
         JHHurd4XIWw/R5CjVR+VI2G3c0KBg75XtqPo9BmJCj1e5UAWpbxVa4yRx4OYPh/2EJwZ
         fmLTd55HZwOXYnPF36aGD4IoOrVaJUbEAAyqya4ZLzDsqJxZcYKrWl6bzQnLAeB2AFF8
         ke6NrH5xPHjO6ns0Jc3dhucTcQuwCOe0jE7NTTlyjqiHqF8eKHM+cnslFy5xlh98iF0d
         MEQJnmEHCPqJU5YgzkQ9AcyfBVYmbEZabEDjA5ygBeZRFUoifZ7xN3hTnRviO6SeVrnL
         Nong==
X-Gm-Message-State: APjAAAUDcYYW+vzOhMlTbWCzSM09GTUej2zvczK1B4UUdnCiPtD5Ny/L
        DNkTXkkEyiGtW5nhkJV+xBjG4cbHHNg=
X-Google-Smtp-Source: APXvYqy6/z9IuIpA+VHt+TNvsd/YWB79YPnrBdoeCIEcUKnDjGqwZtkGPkvOdEDIIIKO2roK0IhT7EMK7TM=
X-Received: by 2002:ac8:21f2:: with SMTP id 47mr4561312qtz.9.1554795229785;
 Tue, 09 Apr 2019 00:33:49 -0700 (PDT)
Date:   Tue,  9 Apr 2019 09:33:42 +0200
In-Reply-To: <c1b7d461-d0b1-e3a4-f8fd-7c757a5e38f6@xs4all.nl>
Message-Id: <20190409073342.74052-1-darekm@google.com>
Mime-Version: 1.0
References: <c1b7d461-d0b1-e3a4-f8fd-7c757a5e38f6@xs4all.nl>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC PATCH v2] media: cec: DRM connector to CEC dev mapping
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     linux-media@vger.kernel.org, hans.verkuil@cisco.com,
        hverkuil@xs4all.nl
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
(card number and connector id in case of DRM connectors) to cec_adapter.
That connector info is expected to be set either by a code creating
an adapter or trough a CEC notifier (which is extended for that purpose).

New ioctl, exposing connector info to userland, is added to /dev/cec.

Changes since v1:
 - removed the unnecessary event,
 - extended cec_connctor_info to allow for various types of connectors.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 +-
 drivers/gpu/drm/drm_dp_cec.c                  | 24 +++++++++-----
 drivers/gpu/drm/i915/intel_dp.c               |  5 ++-
 drivers/gpu/drm/i915/intel_hdmi.c             | 11 ++++++-
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  3 +-
 drivers/media/cec/cec-adap.c                  |  7 +++++
 drivers/media/cec/cec-api.c                   | 11 +++++++
 drivers/media/cec/cec-core.c                  |  3 ++
 drivers/media/cec/cec-notifier.c              | 19 +++++++++++-
 include/drm/drm_dp_helper.h                   | 14 ++++-----
 include/media/cec-notifier.h                  | 31 +++++++++++++++++--
 include/media/cec.h                           | 11 ++++++-
 include/uapi/linux/cec.h                      | 24 ++++++++++++++
 13 files changed, 139 insertions(+), 26 deletions(-)

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
index b15cee85b702b..c92aca0ff6320 100644
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
@@ -344,16 +347,23 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 
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
+		struct cec_connector_info info;
+
+		info.type = CEC_CONNECTOR_TYPE_DRM;
+		info.drm.card_no = connector->dev->primary->index;
+		info.drm.connector_id = connector->base.id;
+		cec_s_connector_info(aux->cec.adap, connector);
+
 		/*
 		 * Update the phys addr for the new CEC adapter. When called
 		 * from drm_dp_cec_register_connector() edid == NULL, so in
@@ -406,22 +416,20 @@ EXPORT_SYMBOL(drm_dp_cec_unset_edid);
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
index cf709835fb9a9..1d451999c4cc1 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -5542,7 +5542,6 @@ static int
 intel_dp_connector_register(struct drm_connector *connector)
 {
 	struct intel_dp *intel_dp = intel_attached_dp(connector);
-	struct drm_device *dev = connector->dev;
 	int ret;
 
 	ret = intel_connector_register(connector);
@@ -5557,8 +5556,7 @@ intel_dp_connector_register(struct drm_connector *connector)
 	intel_dp->aux.dev = connector->kdev;
 	ret = drm_dp_aux_register(&intel_dp->aux);
 	if (!ret)
-		drm_dp_cec_register_connector(&intel_dp->aux,
-					      connector->name, dev->dev);
+		drm_dp_cec_register_connector(&intel_dp->aux, connector);
 	return ret;
 }
 
@@ -7107,3 +7105,4 @@ void intel_dp_mst_resume(struct drm_i915_private *dev_priv)
 		}
 	}
 }
+
diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
index f125a62eba8cf..228f58f568ef1 100644
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -2448,8 +2448,17 @@ void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
 
 	intel_hdmi->cec_notifier = cec_notifier_get_conn(dev->dev,
 							 port_identifier(port));
-	if (!intel_hdmi->cec_notifier)
+	if (intel_hdmi->cec_notifier) {
+		struct cec_connector_info info;
+
+		info.type = CEC_CONNECTOR_TYPE_DRM;
+		info.drm.card_no = connector->dev->primary->index;
+		info.drm.connector_id = connector->base.id;
+		cec_notifier_set_connector_info(intel_hdmi->cec_notifier,
+						&info);
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
index f1261cc2b6fa5..88f42c5e8512f 100644
--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -1566,6 +1566,13 @@ void cec_s_phys_addr_from_edid(struct cec_adapter *adap,
 }
 EXPORT_SYMBOL_GPL(cec_s_phys_addr_from_edid);
 
+void cec_s_connector_info(struct cec_adapter *adap,
+			  struct cec_connector_info *info)
+{
+	memcpy(&adap->connector, info, sizeof(*info));
+}
+EXPORT_SYMBOL_GPL(cec_s_connector_info);
+
 /*
  * Called from either the ioctl or a driver to set the logical addresses.
  *
diff --git a/drivers/media/cec/cec-api.c b/drivers/media/cec/cec-api.c
index 156a0d76ab2a1..0394a77d5bb5c 100644
--- a/drivers/media/cec/cec-api.c
+++ b/drivers/media/cec/cec-api.c
@@ -187,6 +187,14 @@ static long cec_adap_s_log_addrs(struct cec_adapter *adap, struct cec_fh *fh,
 	return 0;
 }
 
+static long cec_adap_g_connector_info(struct cec_adapter *adap,
+				      struct cec_connector_info __user *parg)
+{
+	if (copy_to_user(parg, &adap->connector, sizeof(adap->connector)))
+		return -EFAULT;
+	return 0;
+}
+
 static long cec_transmit(struct cec_adapter *adap, struct cec_fh *fh,
 			 bool block, struct cec_msg __user *parg)
 {
@@ -514,6 +522,9 @@ static long cec_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case CEC_ADAP_S_LOG_ADDRS:
 		return cec_adap_s_log_addrs(adap, fh, block, parg);
 
+	case CEC_ADAP_G_CONNECTOR_INFO:
+		return cec_adap_g_connector_info(adap, parg);
+
 	case CEC_TRANSMIT:
 		return cec_transmit(adap, fh, block, parg);
 
diff --git a/drivers/media/cec/cec-core.c b/drivers/media/cec/cec-core.c
index cc875dabd7658..7b0e28263195a 100644
--- a/drivers/media/cec/cec-core.c
+++ b/drivers/media/cec/cec-core.c
@@ -195,6 +195,9 @@ void cec_register_cec_notifier(struct cec_adapter *adap,
 
 	adap->notifier = notifier;
 	cec_notifier_register(adap->notifier, adap, cec_cec_notify);
+
+	cec_s_connector_info(adap,
+			     cec_notifier_get_connector_info(notifier));
 }
 EXPORT_SYMBOL_GPL(cec_register_cec_notifier);
 #endif
diff --git a/drivers/media/cec/cec-notifier.c b/drivers/media/cec/cec-notifier.c
index dd2078b27a419..a3c172ee0999b 100644
--- a/drivers/media/cec/cec-notifier.c
+++ b/drivers/media/cec/cec-notifier.c
@@ -26,6 +26,7 @@ struct cec_notifier {
 	void (*callback)(struct cec_adapter *adap, u16 pa);
 
 	u16 phys_addr;
+	struct cec_connector_info connector_info;
 };
 
 static LIST_HEAD(cec_notifiers);
@@ -51,6 +52,7 @@ struct cec_notifier *cec_notifier_get_conn(struct device *dev, const char *conn)
 	if (conn)
 		n->conn = kstrdup(conn, GFP_KERNEL);
 	n->phys_addr = CEC_PHYS_ADDR_INVALID;
+	n->connector_info.type = CEC_CONNECTOR_TYPE_NO_CONNECTOR;
 	mutex_init(&n->lock);
 	kref_init(&n->kref);
 	list_add_tail(&n->head, &cec_notifiers);
@@ -106,9 +108,24 @@ void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
 }
 EXPORT_SYMBOL_GPL(cec_notifier_set_phys_addr_from_edid);
 
+void cec_notifier_set_connector_info(struct cec_notifier *n,
+				     struct cec_connector_info *c)
+{
+	memcpy(&n->connector_info, c, sizeof(*c));
+}
+EXPORT_SYMBOL_GPL(cec_notifier_set_connector_info);
+
+struct cec_connector_info *cec_notifier_get_connector_info(
+	struct cec_notifier *n)
+{
+	return &n->connector_info;
+}
+EXPORT_SYMBOL_GPL(cec_notifier_get_connector_info);
+
 void cec_notifier_register(struct cec_notifier *n,
 			   struct cec_adapter *adap,
-			   void (*callback)(struct cec_adapter *adap, u16 pa))
+			   void (*callback)(struct cec_adapter *adap,
+					    u16 pa))
 {
 	kref_get(&n->kref);
 	mutex_lock(&n->lock);
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
index 814eeef35a5cf..f6a7572920f3f 100644
--- a/include/media/cec-notifier.h
+++ b/include/media/cec-notifier.h
@@ -63,6 +63,21 @@ void cec_notifier_set_phys_addr(struct cec_notifier *n, u16 pa);
 void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
 					  const struct edid *edid);
 
+/**
+ * cec_notifier_get_connector_info - get connector info associatied with
+ * a notifier
+ * @n: the CEC notifier
+ */
+struct cec_connector_info *cec_notifier_get_connector_info(
+				struct cec_notifier *n);
+
+/**
+ * cec_notifier_set_connector_info - associates connector info with a notifier
+ * @n: the CEC notifier
+ * @c: the connector info
+ */
+void cec_notifier_set_connector_info(struct cec_notifier *n,
+				     struct cec_connector_info *c);
 /**
  * cec_notifier_register - register a callback with the notifier
  * @n: the CEC notifier
@@ -108,9 +123,21 @@ static inline void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
 {
 }
 
+const struct cec_connector_info*
+	cec_notifier_get_connector_info(struct cec_notifier *n)
+{
+	return (struct cec_connector_info *)0xdeadfeed;
+}
+
+static inline void cec_notifier_set_connector_info(
+			struct cec_notifier *n,
+			struct cec_connector_info *c)
+{
+}
+
 static inline void cec_notifier_register(struct cec_notifier *n,
-			 struct cec_adapter *adap,
-			 void (*callback)(struct cec_adapter *adap, u16 pa))
+			struct cec_adapter *adap,
+			void (*callback)(struct cec_adapter *adap, u16 pa))
 {
 }
 
diff --git a/include/media/cec.h b/include/media/cec.h
index 707411ef8ba28..b19b6efb4a23a 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
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
+void cec_s_connector_info(struct cec_adapter *adap,
+			  struct cec_connector_info *connector);
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
index 3094af68b6e76..618ef95ce79a1 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -411,6 +411,27 @@ struct cec_event_lost_msgs {
 	__u32 lost_msgs;
 };
 
+/**
+ * struct cec_event_connector - tells if and which connector is associated
+ * with the CEC adapter.
+ * @card_no: drm card number, -1 if no connector
+ * @connector_id: drm connector id.
+ */
+struct cec_drm_connector_info {
+	int card_no;
+	__u32 connector_id;
+};
+
+#define CEC_CONNECTOR_TYPE_NO_CONNECTOR	0
+#define CEC_CONNECTOR_TYPE_DRM		1
+struct cec_connector_info {
+	int type;
+	union {
+		struct cec_drm_connector_info drm;
+		__u32 raw[16];
+	};
+};
+
 /**
  * struct cec_event - CEC event structure
  * @ts: the timestamp of when the event was sent.
@@ -475,6 +496,9 @@ struct cec_event {
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

