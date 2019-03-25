Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38688C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F8E20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfCYNQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:16:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:14700 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbfCYNQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:16:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 06:16:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="158179280"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2019 06:16:45 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm: Add fwnode member to the struct drm_connector
Date:   Mon, 25 Mar 2019 16:16:40 +0300
Message-Id: <20190325131641.71076-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325131641.71076-1-heikki.krogerus@linux.intel.com>
References: <20190325131641.71076-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system firmware supplies nodes that represent the connectors,
they need to be associated with the connector entries.

ACPI tables at least always supply a device node for every connector
on integrated video hardware - this is explained in ACPI
specification's ch. "Appendix B Video Extension". Many drivers appear
to already deal with those connector firmware nodes "indirectly"
in order to support custom Operation Regions, _DSM (device specific
method) and access other resources the nodes supply for the
connectors.

This commit will only add the fwnode member. It's first up to the
drivers to assign and take advantage of it. For convenience, the nodes
are assigned to the device entries that are used for exposing the
connectors to the user space via sysfs. That makes it possible to see
the link between the connector and its node also from user space. In
case of ACPI, the connector's sysfs directory will have a symlink
named "firmware_node" pointing to the node object directory in sysfs
if a node is associated with the connector.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/gpu/drm/drm_sysfs.c | 49 +++++++++++++++++++++++++------------
 include/drm/drm_connector.h |  2 ++
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index ecb7b33002bb..7667939ef1c0 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -264,26 +264,50 @@ static const struct attribute_group *connector_dev_groups[] = {
 	NULL
 };
 
+static void drm_sysfs_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 int drm_sysfs_connector_add(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
+	struct device *kdev;
+	int ret;
 
 	if (connector->kdev)
 		return 0;
 
-	connector->kdev =
-		device_create_with_groups(drm_class, dev->primary->kdev, 0,
-					  connector, connector_dev_groups,
-					  "card%d-%s", dev->primary->index,
-					  connector->name);
-	DRM_DEBUG("adding \"%s\" to sysfs\n",
-		  connector->name);
+	kdev = kzalloc(sizeof(*kdev), GFP_KERNEL);
+	if (!kdev)
+		return -ENOMEM;
 
-	if (IS_ERR(connector->kdev)) {
-		DRM_ERROR("failed to register connector device: %ld\n", PTR_ERR(connector->kdev));
-		return PTR_ERR(connector->kdev);
+	device_initialize(kdev);
+	kdev->class = drm_class;
+	kdev->parent = dev->primary->kdev;
+	kdev->fwnode = connector->fwnode;
+	kdev->groups = connector_dev_groups;
+	kdev->release = drm_sysfs_release;
+	dev_set_drvdata(kdev, connector);
+
+	ret = dev_set_name(kdev, "card%d-%s", dev->primary->index,
+			   connector->name);
+	if (ret) {
+		kfree(kdev);
+		return ret;
+	}
+
+	DRM_DEBUG("adding \"%s\" to sysfs\n", connector->name);
+
+	ret = device_add(kdev);
+	if (ret) {
+		DRM_ERROR("failed to register connector device: %d\n", ret);
+		put_device(kdev);
+		return ret;
 	}
 
+	connector->kdev = kdev;
+
 	/* Let userspace know we have a new connector */
 	drm_sysfs_hotplug_event(dev);
 
@@ -330,11 +354,6 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_sysfs_hotplug_event);
 
-static void drm_sysfs_release(struct device *dev)
-{
-	kfree(dev);
-}
-
 struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
 {
 	const char *minor_str;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c8061992d6cb..b8977c4eab14 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -886,6 +886,8 @@ struct drm_connector {
 	struct device *kdev;
 	/** @attr: sysfs attributes */
 	struct device_attribute *attr;
+	/** @fwnode: associated device node supplied by platform firmware */
+	struct fwnode_handle *fwnode;
 
 	/**
 	 * @head:
-- 
2.20.1

