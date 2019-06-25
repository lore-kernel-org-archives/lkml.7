Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF58C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4168214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbfFYKYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:24:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56384 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfFYKYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:24:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 69E98288E1F
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     kernel@collabora.com, m.szyprowski@samsung.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 1/2] drm: Include ddc adapter pointer in struct drm_connector
Date:   Tue, 25 Jun 2019 12:24:40 +0200
Message-Id: <ef88f682401ae863a91e6c885d83a2756ae20b85.1561458051.git.andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1561458051.git.andrzej.p@collabora.com>
References: <20190625101655.n246vbwtupb4eoyz@shell.armlinux.org.uk>
 <cover.1561458051.git.andrzej.p@collabora.com>
In-Reply-To: <cover.1561458051.git.andrzej.p@collabora.com>
References: <cover.1561458051.git.andrzej.p@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic code which creates symbolic links in sysfs, pointing to ddc
interface used by a particular video output. For example:

ls -l /sys/class/drm/card0-HDMI-A-1/ddc
lrwxrwxrwx 1 root root 0 Jun 24 10:42 /sys/class/drm/card0-HDMI-A-1/ddc \
	-> ../../../../soc/13880000.i2c/i2c-2

This makes it easy for user to associate a display with its ddc adapter
and use e.g. ddcutil to control the chosen monitor.

This patch adds an i2c_adapter pointer to struct drm_connector. Particular
drivers can then use it instead of using their own private instance. If a
connector contains a ddc, then create a symbolic link in sysfs.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/gpu/drm/drm_sysfs.c |  7 +++++++
 include/drm/drm_connector.h | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index ad10810bc972..26d359b39785 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -294,6 +294,9 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 	/* Let userspace know we have a new connector */
 	drm_sysfs_hotplug_event(dev);
 
+	if (connector->ddc)
+		return sysfs_create_link(&connector->kdev->kobj,
+				 &connector->ddc->dev.kobj, "ddc");
 	return 0;
 }
 
@@ -301,6 +304,10 @@ void drm_sysfs_connector_remove(struct drm_connector *connector)
 {
 	if (!connector->kdev)
 		return;
+
+	if (connector->ddc)
+		sysfs_remove_link(&connector->kdev->kobj, "ddc");
+
 	DRM_DEBUG("removing \"%s\" from sysfs\n",
 		  connector->name);
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index ca745d9feaf5..1ad3d1d54ba7 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -23,6 +23,7 @@
 #ifndef __DRM_CONNECTOR_H__
 #define __DRM_CONNECTOR_H__
 
+#include <linux/i2c.h>
 #include <linux/list.h>
 #include <linux/llist.h>
 #include <linux/ctype.h>
@@ -1308,6 +1309,16 @@ struct drm_connector {
 	 * [0]: progressive, [1]: interlaced
 	 */
 	int audio_latency[2];
+
+	/**
+	 * @ddc: associated ddc adapter.
+	 * A connector usually has its associated ddc adapter. If a driver uses
+	 * this field, then an appropriate symbolic link is created in connector
+	 * sysfs directory to make it easy for the user to tell which i2c
+	 * adapter is for a particular display.
+	 */
+	struct i2c_adapter *ddc;
+
 	/**
 	 * @null_edid_counter: track sinks that give us all zeros for the EDID.
 	 * Needed to workaround some HW bugs where we get all 0s
-- 
2.17.1

