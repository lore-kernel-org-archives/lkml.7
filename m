Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83276C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0B02186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbfCAFiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:38:24 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42726 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731671AbfCAFiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:38:20 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Mar 2019 07:38:13 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x215brYa016903;
        Fri, 1 Mar 2019 07:38:11 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com
Cc:     parav@mellanox.com
Subject: [RFC net-next 5/8] devlink: Add variant of devlink_register/unregister
Date:   Thu, 28 Feb 2019 23:37:49 -0600
Message-Id: <1551418672-12822-6-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551418672-12822-1-git-send-email-parav@mellanox.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add variants of devlink_register and devlink_unregister which doesn't
explicitly acquire/release devlink_mutex lock, but requires that caller
hold the devlink_mutex lock.

This is required to create child devlink devices while working on
parent devlink device.

Change-Id: I74417158144b28ff51ecfb2d1105c83ebefdf985
Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 include/net/devlink.h | 15 ++++++++++++++-
 net/core/devlink.c    | 36 +++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index ae5e0e6..9a067b1 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -545,7 +545,9 @@ static inline struct devlink *priv_to_devlink(void *priv)
 void devlink_init(struct devlink *devlink, const struct devlink_ops *ops);
 void devlink_cleanup(struct devlink *devlink);
 struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size);
+void __devlink_register(struct devlink *devlink, struct device *dev);
 int devlink_register(struct devlink *devlink, struct device *dev);
+void __devlink_unregister(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
 int devlink_port_register(struct devlink *devlink,
@@ -713,6 +715,7 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 
 static inline void devlink_init(struct devlink *devlink,
 				const struct devlink_ops *ops)
+{
 }
 
 static inline void devlink_cleanup(struct devlink *devlink)
@@ -725,11 +728,21 @@ static inline struct devlink *devlink_alloc(const struct devlink_ops *ops,
 	return kzalloc(sizeof(struct devlink) + priv_size, GFP_KERNEL);
 }
 
-static inline int devlink_register(struct devlink *devlink, struct device *dev)
+static inline void __devlink_register(struct devlink *devlink,
+				      struct device *dev)
+{
+}
+
+static inline int devlink_register(struct devlink *devlink,
+				   struct device *dev)
 {
 	return 0;
 }
 
+static inline void __devlink_unregister(struct devlink *devlink)
+{
+}
+
 static inline void devlink_unregister(struct devlink *devlink)
 {
 }
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 25492c6..cfbad2c 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -5262,22 +5262,49 @@ struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size)
 EXPORT_SYMBOL_GPL(devlink_alloc);
 
 /**
- *	devlink_register - Register devlink instance
+ *	__devlink_register - Register devlink instance
+ *	Caller must hold devlink_mutex.
  *
  *	@devlink: devlink
  */
-int devlink_register(struct devlink *devlink, struct device *dev)
+void __devlink_register(struct devlink *devlink, struct device *dev)
 {
-	mutex_lock(&devlink_mutex);
+	lockdep_assert_held(&devlink_mutex);
 	devlink->dev = dev;
 	list_add_tail(&devlink->list, &devlink_list);
 	devlink_notify(devlink, DEVLINK_CMD_NEW);
+}
+EXPORT_SYMBOL_GPL(__devlink_register);
+
+/**
+ *	devlink_register - Register devlink instance
+ *
+ *	@devlink: devlink
+ */
+int devlink_register(struct devlink *devlink, struct device *dev)
+{
+	mutex_lock(&devlink_mutex);
+	__devlink_register(devlink, dev);
 	mutex_unlock(&devlink_mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(devlink_register);
 
 /**
+ *	__devlink_unregister - Unregister devlink instance
+ *	Caller must hold the devlink_mutex while invoking this API.
+ *
+ *	@devlink: devlink
+ */
+void __devlink_unregister(struct devlink *devlink)
+{
+	lockdep_assert_held(&devlink_mutex);
+	devlink_notify(devlink, DEVLINK_CMD_DEL);
+	list_del(&devlink->list);
+}
+EXPORT_SYMBOL_GPL(__devlink_unregister);
+
+/**
  *	devlink_unregister - Unregister devlink instance
  *
  *	@devlink: devlink
@@ -5285,8 +5312,7 @@ int devlink_register(struct devlink *devlink, struct device *dev)
 void devlink_unregister(struct devlink *devlink)
 {
 	mutex_lock(&devlink_mutex);
-	devlink_notify(devlink, DEVLINK_CMD_DEL);
-	list_del(&devlink->list);
+	__devlink_unregister(devlink);
 	mutex_unlock(&devlink_mutex);
 }
 EXPORT_SYMBOL_GPL(devlink_unregister);
-- 
1.8.3.1

