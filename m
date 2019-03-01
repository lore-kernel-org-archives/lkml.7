Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E10C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B5F218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfCAFiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:38:22 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42728 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731008AbfCAFiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:38:20 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Mar 2019 07:38:17 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x215brYb016903;
        Fri, 1 Mar 2019 07:38:14 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com
Cc:     parav@mellanox.com
Subject: [RFC net-next 6/8] devlink: Add support for devlink subdev lifecycle
Date:   Thu, 28 Feb 2019 23:37:50 -0600
Message-Id: <1551418672-12822-7-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551418672-12822-1-git-send-email-parav@mellanox.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for creating and deleting devlink subdevices.
For every subdev created on subdev bus, has corresponding devlink device.
This devlink device serves the control point for any internal device
configuration which is usually required before setting up the protocol
specific devices such as netdev, block or infiniband devices.

devlink subdev are created using iproute2 devlink tool command such as:
(a) create devlink subdev
$devlink dev add DEV
output: subdev/subdev0

(b) delete a devlink subdev
$devlink dev del DEV
$devlink dev del subdev/subdev0

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 include/net/devlink.h        |  6 ++-
 include/uapi/linux/devlink.h |  3 ++
 net/core/devlink.c           | 97 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9a067b1..3265508 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -36,6 +36,7 @@ struct devlink {
 	struct device *dev;
 	possible_net_t _net;
 	struct mutex lock;
+	struct devlink *parent;	/* optional if this is child devlink device */
 	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
@@ -524,6 +525,8 @@ struct devlink_ops {
 	int (*flash_update)(struct devlink *devlink, const char *file_name,
 			    const char *component,
 			    struct netlink_ext_ack *extack);
+	struct devlink* (*dev_add)(struct devlink *devlink);
+	void (*dev_del)(struct devlink *del_dev);
 };
 
 static inline void *devlink_priv(struct devlink *devlink)
@@ -545,7 +548,8 @@ static inline struct devlink *priv_to_devlink(void *priv)
 void devlink_init(struct devlink *devlink, const struct devlink_ops *ops);
 void devlink_cleanup(struct devlink *devlink);
 struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size);
-void __devlink_register(struct devlink *devlink, struct device *dev);
+int __devlink_register(struct devlink *devlink, struct device *dev,
+		       struct devlink *parent);
 int devlink_register(struct devlink *devlink, struct device *dev);
 void __devlink_unregister(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 53de880..233f5bc 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -105,6 +105,9 @@ enum devlink_command {
 
 	DEVLINK_CMD_FLASH_UPDATE,
 
+	DEVLINK_CMD_DEV_ADD,
+	DEVLINK_CMD_DEV_DEL,
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
diff --git a/net/core/devlink.c b/net/core/devlink.c
index cfbad2c..3b5c961 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -3759,6 +3759,57 @@ static int devlink_nl_cmd_region_read_dumpit(struct sk_buff *skb,
 	return err;
 }
 
+static int
+devlink_nl_cmd_dev_add_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *new_devlink;
+	struct sk_buff *msg;
+	int err;
+
+	if (!devlink->ops->dev_add || !devlink->ops->dev_del)
+		return -EOPNOTSUPP;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	new_devlink = devlink->ops->dev_add(devlink);
+	if (IS_ERR(new_devlink)) {
+		err = PTR_ERR(new_devlink);
+		goto dev_err;
+	}
+
+	err = devlink_nl_put_handle(msg, new_devlink);
+	if (err)
+		goto put_err;
+
+	return genlmsg_reply(msg, info);
+
+put_err:
+	devlink->ops->dev_del(new_devlink);
+dev_err:
+	nlmsg_free(msg);
+	return err;
+}
+
+static int
+devlink_nl_cmd_dev_del_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct devlink *devlink;
+	struct devlink *parent;
+
+	devlink = devlink_get_from_info(info);
+	if (!devlink)
+		return -ENODEV;
+	parent = devlink->parent;
+	if (!parent)
+		return -EOPNOTSUPP;
+
+	parent->ops->dev_del(devlink);
+	return 0;
+}
+
 struct devlink_info_req {
 	struct sk_buff *msg;
 };
@@ -5201,6 +5252,20 @@ static int devlink_nl_cmd_health_reporter_dump_get_doit(struct sk_buff *skb,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK,
 	},
+	{
+		.cmd = DEVLINK_CMD_DEV_ADD,
+		.doit = devlink_nl_cmd_dev_add_doit,
+		.policy = devlink_nl_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NEED_DEVLINK,
+	},
+	{
+		.cmd = DEVLINK_CMD_DEV_DEL,
+		.doit = devlink_nl_cmd_dev_del_doit,
+		.policy = devlink_nl_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = DEVLINK_NL_FLAG_NO_LOCK,
+	},
 };
 
 static struct genl_family devlink_nl_family __ro_after_init = {
@@ -5266,13 +5331,24 @@ struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size)
  *	Caller must hold devlink_mutex.
  *
  *	@devlink: devlink
+ *	@parent: pointer to parent devlink instance for which child devlink
+ *		 device is created. It must be set when child devlink
+ *		 device is created. It is optional otherwise.
  */
-void __devlink_register(struct devlink *devlink, struct device *dev)
+int __devlink_register(struct devlink *devlink, struct device *dev,
+		       struct devlink *parent)
 {
 	lockdep_assert_held(&devlink_mutex);
+
+	if (parent && (!parent->ops || !parent->ops->dev_add ||
+		       !parent->ops->dev_del))
+		return -EINVAL;
+
 	devlink->dev = dev;
+	devlink->parent = parent;
 	list_add_tail(&devlink->list, &devlink_list);
 	devlink_notify(devlink, DEVLINK_CMD_NEW);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(__devlink_register);
 
@@ -5283,13 +5359,27 @@ void __devlink_register(struct devlink *devlink, struct device *dev)
  */
 int devlink_register(struct devlink *devlink, struct device *dev)
 {
+	int ret;
+
 	mutex_lock(&devlink_mutex);
-	__devlink_register(devlink, dev);
+	ret = __devlink_register(devlink, dev, NULL);
 	mutex_unlock(&devlink_mutex);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(devlink_register);
 
+static void devlink_child_devices_delete(struct devlink *devlink)
+{
+	struct devlink *cur, *tmp;
+
+	list_for_each_entry_safe(cur, tmp, &devlink_list, list) {
+		struct devlink *parent = cur->parent;
+
+		if (devlink == parent)
+			parent->ops->dev_del(cur);
+	}
+}
+
 /**
  *	__devlink_unregister - Unregister devlink instance
  *	Caller must hold the devlink_mutex while invoking this API.
@@ -5299,6 +5389,7 @@ int devlink_register(struct devlink *devlink, struct device *dev)
 void __devlink_unregister(struct devlink *devlink)
 {
 	lockdep_assert_held(&devlink_mutex);
+	devlink_child_devices_delete(devlink);
 	devlink_notify(devlink, DEVLINK_CMD_DEL);
 	list_del(&devlink->list);
 }
-- 
1.8.3.1

