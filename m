Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F60FC06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD1A208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzzYNO6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfGADYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 23:24:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43801 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfGADYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 23:24:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so13138956qto.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 20:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TBkGIpZDTRWUqhge/wC7uC1qGZRr0i17gzx2p4IYZwY=;
        b=JzzYNO6MunIO3mqHv0ndJxirDJcdQSSuFy9YMsqQ/p0d88m+Jx3kE6huuOS0bPQqCK
         Tc0oTqzZ8bf/By2K9MFrBZ4119RgZRvIPe7Ynk9jq/wNgYeV3SqqM14z+BjeqbEnqOCL
         DiAHD3aLJVxmRdzSVdvMFPJKaPWRtgQyaNELNte+fDfGr+V0+i2PgnNHqde7GMykF0J5
         QFrp3oh/qCy30tElf9dXyswsUbOyZyP4AIRtLx89hgBtsfbOjLubvZhTdRw+LZICHJpY
         B+pWWQol1kQbuVNsgEE1S72iMIqqeT4U8pIy7nZiXRcN7q8UOLg9E8HtfzyboaFuIzSP
         vCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TBkGIpZDTRWUqhge/wC7uC1qGZRr0i17gzx2p4IYZwY=;
        b=DTRUgHCliHylq6AjDN79D2nw7tX5Gz5dK40cD8FRdo0G40tX17VcXBKW8DlFoismJt
         I/N/nSb5QKGAJ0D5iUkHCtcawZISnZQ6Qal9hdlHZGd94hOixlJwqR4u/FGgM+T/H3zv
         7VW5wQUMMGE56dlodHVC7Az3aLShBZKdcHBZq1GAxbqYzdyKkQNtrjGcHtIFLUmWMVHk
         YpGSYo7DM5d5eCguyvdD6KSilCq0ABQ3eD6HksF76MpX3J0MNLtOocxcVCtYM5BbleQO
         bSnPCvQ8n1+4ISktcjF6c7Q/L/wCRvGIpjyTVnRSavrlSQXg1+hxMdSMDqEsrNh6rK0W
         32Jg==
X-Gm-Message-State: APjAAAVw7pOTyjD2FRg8VTJPlfaqqQB+EfUyUPP4bC6ObClXYnlTRzLt
        TfGG/4cop/TYvBUTMeiv6Wo=
X-Google-Smtp-Source: APXvYqzTygIW3Zvf1UugDAWJd6BU2aigSwWo22zGT0E2LGG8WIzpV5rgihga//zrTeHm6VlkC7OdVw==
X-Received: by 2002:ad4:5283:: with SMTP id v3mr19343701qvr.207.1561951480157;
        Sun, 30 Jun 2019 20:24:40 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.22])
        by smtp.gmail.com with ESMTPSA id g53sm5172840qtk.65.2019.06.30.20.24.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 20:24:39 -0700 (PDT)
Date:   Mon, 1 Jul 2019 00:24:35 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/vkms: Introduce configfs for enabling/disabling
 connectors
Message-ID: <b7a3fbf4ddab54965bf2dc3c0aab843e2f66dd10.1561950553.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1561950553.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561950553.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces an implementation of vkms subsystems through
configfs; we want to be able to reconfigure vkms instance without having
to reload the module. This commit adds the primary support for configfs
by allowing vkms to expose the ability to enable/disable its connectors.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/Makefile        |   3 +-
 drivers/gpu/drm/vkms/vkms_configfs.c | 229 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.c      |   6 +
 drivers/gpu/drm/vkms/vkms_drv.h      |  12 ++
 4 files changed, 249 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c

diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index 333d3cead0e3..f90c016cd9fe 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -6,6 +6,7 @@ vkms-y := \
 	vkms_crtc.o \
 	vkms_gem.o \
 	vkms_composer.o \
-	vkms_writeback.o
+	vkms_writeback.o \
+	vkms_configfs.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
new file mode 100644
index 000000000000..5d1a30517cca
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "vkms_drv.h"
+
+static struct config_group *connector_group;
+static struct vkms_device *vkms_device;
+
+static char *available_connectors[] = {
+	"Virtual",
+	"Writeback",
+};
+
+struct connectors_fs {
+	struct config_item item;
+	bool enable;
+};
+
+static int enable_connector(const char *name)
+{
+	int ret = 0;
+
+	if (!strcmp(name, "Writeback"))
+		ret = enable_writeback_connector(vkms_device);
+	else if (!strcmp(name, "Virtual"))
+		ret = enable_virtual_connector(vkms_device);
+
+	if (ret)
+		return ret;
+
+	drm_mode_config_reset(&vkms_device->drm);
+	return 0;
+}
+
+static void disable_connector(const char *name)
+{
+	if (!strcmp(name, "Writeback"))
+		disable_writeback_connector(vkms_device);
+	else if (!strcmp(name, "Virtual"))
+		disable_virtual_connector(vkms_device);
+}
+
+static inline struct connectors_fs *to_conn_item(struct config_item *item)
+{
+	return item ? container_of(item, struct connectors_fs, item) : NULL;
+}
+
+static ssize_t conn_fs_enable_show(struct config_item *item, char *page)
+{
+	struct connectors_fs *conn_item = to_conn_item(item);
+
+	return sprintf(page, "%d\n", conn_item->enable);
+}
+
+static ssize_t conn_fs_enable_store(struct config_item *item,
+				    const char *page, size_t count)
+{
+	struct connectors_fs *conn_item = to_conn_item(item);
+	char *p = (char *)page;
+	unsigned int enable;
+	int ret;
+
+	ret = kstrtouint(p, 10, &enable);
+	if (ret)
+		return -EINVAL;
+
+	if (enable > 1)
+		return -EINVAL;
+
+	if (enable == conn_item->enable)
+		return count;
+
+	if (enable) {
+		ret = enable_connector(item->ci_name);
+		if (ret)
+			return ret;
+	} else {
+		disable_connector(item->ci_name);
+	}
+
+	conn_item->enable = enable ? true : false;
+	return count;
+}
+
+CONFIGFS_ATTR(conn_fs_, enable);
+
+static struct configfs_attribute *connectors_fs_attrs[] = {
+	&conn_fs_attr_enable,
+	NULL,
+};
+
+static void connectors_fs_release(struct config_item *item)
+{
+	kfree(to_conn_item(item));
+}
+
+static struct configfs_item_operations connectors_fs_ops = {
+	.release = connectors_fs_release,
+};
+
+static const struct config_item_type connectors_fs_type = {
+	.ct_item_ops	= &connectors_fs_ops,
+	.ct_attrs	= connectors_fs_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_item *make_connector_item(struct config_group *group,
+					       const char *name)
+{
+	struct connectors_fs *conn_item;
+	int i, ret, total_conn = ARRAY_SIZE(available_connectors);
+
+	for (i = 0; i < total_conn; i++)
+		if (!strcmp(name, available_connectors[i]))
+			break;
+
+	if (i == total_conn)
+		return ERR_PTR(-EINVAL);
+
+	ret = enable_connector(name);
+	if (ret)
+		return ERR_PTR(ret);
+
+	conn_item = kzalloc(sizeof(*conn_item), GFP_KERNEL);
+	if (!conn_item)
+		return ERR_PTR(-ENOMEM);
+
+	config_item_init_type_name(&conn_item->item, name,
+				   &connectors_fs_type);
+
+	conn_item->enable = true;
+
+	return &conn_item->item;
+}
+
+static void drop_connector_item(struct config_group *group,
+				struct config_item *item)
+{
+	char *name = item->ci_name;
+
+	disable_connector(name);
+
+	config_item_put(item);
+}
+
+static struct configfs_group_operations connector_group_ops = {
+	.make_item	= make_connector_item,
+	.drop_item	= drop_connector_item,
+};
+
+static const struct config_item_type connector_type = {
+	.ct_group_ops	= &connector_group_ops,
+	.ct_owner	= THIS_MODULE,
+};
+
+static const struct config_item_type vkms_subsystem_type = {
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct configfs_subsystem vkms_subsystem = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "vkms",
+			.ci_type = &vkms_subsystem_type,
+		},
+	},
+	.su_mutex = __MUTEX_INITIALIZER(vkms_subsystem.su_mutex),
+};
+
+static void init_default_conn_configfs(struct config_group *root)
+{
+	struct vkms_config_state *config_state = &vkms_device->config_state;
+	int i, ret;
+
+	connector_group = configfs_register_default_group(root, "connectors",
+							  &connector_type);
+	if (IS_ERR(connector_group)) {
+		ret = PTR_ERR(connector_group);
+		pr_err("Error %d while registering functions group\n", ret);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(available_connectors); i++) {
+		struct config_group *group = config_state->connectors[i];
+
+		if (!strcmp(available_connectors[i], "Writeback") &&
+		    !enable_writeback)
+			continue;
+
+		group = configfs_register_default_group(connector_group,
+							available_connectors[i],
+							&connectors_fs_type);
+		if (IS_ERR(connector_group)) {
+			ret = PTR_ERR(config_state->connectors[i]);
+			DRM_ERROR("Error %d while trying to register %s\n",
+				  ret, available_connectors[i]);
+			continue;
+		}
+
+		to_conn_item(&group->cg_item)->enable = true;
+	}
+}
+
+int vkms_configfs_init(struct vkms_device *vkmsdev)
+{
+	struct config_group *root = &vkms_subsystem.su_group;
+	int ret;
+
+	vkms_device = vkmsdev;
+
+	config_group_init(root);
+	ret = configfs_register_subsystem(&vkms_subsystem);
+	if (ret) {
+		pr_err("Error %d while registering subsystem %s\n", ret,
+		       root->cg_item.ci_namebuf);
+		goto err;
+	}
+
+	init_default_conn_configfs(root);
+
+	return 0;
+
+err:
+	return ret;
+}
+
+void vkms_configfs_exit(void)
+{
+	configfs_unregister_subsystem(&vkms_subsystem);
+}
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 152d7de24a76..a930a5a52ce4 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -166,6 +166,10 @@ static int __init vkms_init(void)
 	if (ret)
 		goto out_fini;
 
+	ret = vkms_configfs_init(vkms_device);
+	if (ret)
+		DRM_ERROR("Could not initialize configfs");
+
 	ret = drm_dev_register(&vkms_device->drm, 0);
 	if (ret)
 		goto out_fini;
@@ -194,6 +198,8 @@ static void __exit vkms_exit(void)
 	drm_dev_put(&vkms_device->drm);
 
 	kfree(vkms_device);
+
+	vkms_configfs_exit();
 }
 
 module_init(vkms_init);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index a1ca5c658355..c811bc192606 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -9,6 +9,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_writeback.h>
 #include <linux/hrtimer.h>
+#include <linux/configfs.h>
 
 #define XRES_MIN    20
 #define YRES_MIN    20
@@ -83,10 +84,17 @@ struct vkms_output {
 	spinlock_t composer_lock;
 };
 
+#define MAX_CONN_CONFIGFS 10
+
+struct vkms_config_state {
+	struct config_group *connectors[MAX_CONN_CONFIGFS];
+};
+
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
 	struct vkms_output output;
+	struct vkms_config_state config_state;
 };
 
 struct vkms_gem_object {
@@ -160,4 +168,8 @@ void disable_virtual_connector(struct vkms_device *vkmsdev);
 int enable_writeback_connector(struct vkms_device *vkmsdev);
 void disable_writeback_connector(struct vkms_device *connector);
 
+/* Configfs */
+int vkms_configfs_init(struct vkms_device *vkmsdev);
+void vkms_configfs_exit(void);
+
 #endif /* _VKMS_DRV_H_ */
-- 
2.21.0
