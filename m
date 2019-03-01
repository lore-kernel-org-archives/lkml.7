Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94758C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFB12186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbfCAFiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:38:17 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42708 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731008AbfCAFiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:38:14 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Mar 2019 07:38:10 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x215brYZ016903;
        Fri, 1 Mar 2019 07:38:08 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com
Cc:     parav@mellanox.com
Subject: [RFC net-next 4/8] devlink: Introduce and use devlink_init/cleanup() in alloc/free
Date:   Thu, 28 Feb 2019 23:37:48 -0600
Message-Id: <1551418672-12822-5-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551418672-12822-1-git-send-email-parav@mellanox.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is usecase to allocate devlink instance along with other structure
instance.
This is case when struct devlink and struct device are desired to be
part of single structure instance whose life cycle is driven by the life
cycle of the core device.
To support it, have more grandular init/cleanup APIs and reuse them in
existing alloc/free APIs.

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 include/net/devlink.h | 10 ++++++++++
 net/core/devlink.c    | 50 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index a2da49d..ae5e0e6 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -542,6 +542,8 @@ static inline struct devlink *priv_to_devlink(void *priv)
 
 #if IS_ENABLED(CONFIG_NET_DEVLINK)
 
+void devlink_init(struct devlink *devlink, const struct devlink_ops *ops);
+void devlink_cleanup(struct devlink *devlink);
 struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size);
 int devlink_register(struct devlink *devlink, struct device *dev);
 void devlink_unregister(struct devlink *devlink);
@@ -709,6 +711,14 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 
 #else
 
+static inline void devlink_init(struct devlink *devlink,
+				const struct devlink_ops *ops)
+}
+
+static inline void devlink_cleanup(struct devlink *devlink)
+{
+}
+
 static inline struct devlink *devlink_alloc(const struct devlink_ops *ops,
 					    size_t priv_size)
 {
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 04d9855..25492c6 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -5218,21 +5218,16 @@ static int devlink_nl_cmd_health_reporter_dump_get_doit(struct sk_buff *skb,
 };
 
 /**
- *	devlink_alloc - Allocate new devlink instance resources
+ *	devlink_init - Initialize devlink instance
  *
- *	@ops: ops
- *	@priv_size: size of user private data
+ *	@devlink: devlink pointer, which is not allocated using devlink_alloc().
  *
- *	Allocate new devlink instance resources, including devlink index
- *	and name.
+ *	When user wants to allocate devlink object along with other objects
+ *	in driver such as refcounted using struct device, it is useful to
+ *	just init the devlink instance without allocating.
  */
-struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size)
+void devlink_init(struct devlink *devlink, const struct devlink_ops *ops)
 {
-	struct devlink *devlink;
-
-	devlink = kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
-	if (!devlink)
-		return NULL;
 	devlink->ops = ops;
 	devlink_net_set(devlink, &init_net);
 	INIT_LIST_HEAD(&devlink->port_list);
@@ -5243,6 +5238,25 @@ struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size)
 	INIT_LIST_HEAD(&devlink->region_list);
 	INIT_LIST_HEAD(&devlink->reporter_list);
 	mutex_init(&devlink->lock);
+}
+EXPORT_SYMBOL_GPL(devlink_init);
+
+/**
+ *	devlink_alloc - Allocate new devlink instance resources
+ *
+ *	@ops: ops
+ *	@priv_size: size of user private data
+ *
+ *	Allocate new devlink instance resources, including devlink index
+ *	and name.
+ */
+struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size)
+{
+	struct devlink *devlink;
+
+	devlink = kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
+	if (devlink)
+		devlink_init(devlink, ops);
 	return devlink;
 }
 EXPORT_SYMBOL_GPL(devlink_alloc);
@@ -5278,11 +5292,11 @@ void devlink_unregister(struct devlink *devlink)
 EXPORT_SYMBOL_GPL(devlink_unregister);
 
 /**
- *	devlink_free - Free devlink instance resources
+ *	devlink_cleanup - Cleanup devlink instance resources
  *
  *	@devlink: devlink
  */
-void devlink_free(struct devlink *devlink)
+void devlink_cleanup(struct devlink *devlink)
 {
 	WARN_ON(!list_empty(&devlink->reporter_list));
 	WARN_ON(!list_empty(&devlink->region_list));
@@ -5291,7 +5305,17 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
 	WARN_ON(!list_empty(&devlink->port_list));
+}
+EXPORT_SYMBOL_GPL(devlink_cleanup);
 
+/**
+ *	devlink_free - Free devlink instance resources
+ *
+ *	@devlink: devlink
+ */
+void devlink_free(struct devlink *devlink)
+{
+	devlink_cleanup(devlink);
 	kfree(devlink);
 }
 EXPORT_SYMBOL_GPL(devlink_free);
-- 
1.8.3.1

