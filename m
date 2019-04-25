Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7BEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054BD214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbfDYK5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:57:46 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46426 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730529AbfDYK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:57:46 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 25 Apr 2019 13:57:43 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x3PAvhbY006894;
        Thu, 25 Apr 2019 13:57:43 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id x3PAvgDt005433;
        Thu, 25 Apr 2019 13:57:42 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id x3PAvaFk005428;
        Thu, 25 Apr 2019 13:57:36 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next] devlink: Execute devlink health recover as a work
Date:   Thu, 25 Apr 2019 13:57:03 +0300
Message-Id: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different reporters have different rules in the driver and are being
created/destroyed during different stages of driver load/unload/running.
So during execution of a reporter recover the flow can go through
another reporter's destroy and create. Such flow leads to deadlock
trying to lock a mutex already held if the flow was triggered by devlink
recover command.
To avoid such deadlock, we execute the recover flow from a workqueue.
Once the recover work is done successfully the reporter health state and
recover counter are being updated.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 include/net/devlink.h |  1 +
 net/core/devlink.c    | 70 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 4f5e416..820b327 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -32,6 +32,7 @@ struct devlink {
 	struct list_head region_list;
 	u32 snapshot_id;
 	struct list_head reporter_list;
+	struct workqueue_struct *reporters_wq;
 	struct devlink_dpipe_headers *dpipe_headers;
 	const struct devlink_ops *ops;
 	struct device *dev;
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 7b91605..8ee380e 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -4422,6 +4422,7 @@ struct devlink_health_reporter {
 	u64 error_count;
 	u64 recovery_count;
 	u64 last_recovery_ts;
+	struct work_struct recover_work;
 };
 
 void *
@@ -4443,6 +4444,40 @@ struct devlink_health_reporter {
 	return NULL;
 }
 
+static int
+devlink_health_reporter_recover(struct devlink_health_reporter *reporter,
+				void *priv_ctx)
+{
+	int err;
+
+	if (!reporter->ops->recover)
+		return -EOPNOTSUPP;
+
+	err = reporter->ops->recover(reporter, priv_ctx);
+	if (err)
+		return err;
+
+	reporter->recovery_count++;
+	reporter->health_state = DEVLINK_HEALTH_REPORTER_STATE_HEALTHY;
+	reporter->last_recovery_ts = jiffies;
+
+	trace_devlink_health_reporter_state_update(reporter->devlink,
+						   reporter->ops->name,
+						   reporter->health_state);
+	return 0;
+}
+
+static void
+devlink_health_reporter_recover_work(struct work_struct *work)
+{
+	struct devlink_health_reporter *reporter;
+
+	reporter = container_of(work, struct devlink_health_reporter,
+				recover_work);
+
+	devlink_health_reporter_recover(reporter, NULL);
+}
+
 /**
  *	devlink_health_reporter_create - create devlink health reporter
  *
@@ -4483,6 +4518,8 @@ struct devlink_health_reporter *
 	reporter->devlink = devlink;
 	reporter->graceful_period = graceful_period;
 	reporter->auto_recover = auto_recover;
+	INIT_WORK(&reporter->recover_work,
+		  devlink_health_reporter_recover_work);
 	mutex_init(&reporter->dump_lock);
 	list_add_tail(&reporter->list, &devlink->reporter_list);
 unlock:
@@ -4505,6 +4542,7 @@ struct devlink_health_reporter *
 	mutex_unlock(&reporter->devlink->lock);
 	if (reporter->dump_fmsg)
 		devlink_fmsg_free(reporter->dump_fmsg);
+	cancel_work_sync(&reporter->recover_work);
 	kfree(reporter);
 }
 EXPORT_SYMBOL_GPL(devlink_health_reporter_destroy);
@@ -4526,26 +4564,6 @@ struct devlink_health_reporter *
 }
 EXPORT_SYMBOL_GPL(devlink_health_reporter_state_update);
 
-static int
-devlink_health_reporter_recover(struct devlink_health_reporter *reporter,
-				void *priv_ctx)
-{
-	int err;
-
-	if (!reporter->ops->recover)
-		return -EOPNOTSUPP;
-
-	err = reporter->ops->recover(reporter, priv_ctx);
-	if (err)
-		return err;
-
-	reporter->recovery_count++;
-	reporter->health_state = DEVLINK_HEALTH_REPORTER_STATE_HEALTHY;
-	reporter->last_recovery_ts = jiffies;
-
-	return 0;
-}
-
 static void
 devlink_health_dump_clear(struct devlink_health_reporter *reporter)
 {
@@ -4813,7 +4831,11 @@ static int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
 	if (!reporter)
 		return -EINVAL;
 
-	return devlink_health_reporter_recover(reporter, NULL);
+	if (!reporter->ops->recover)
+		return -EOPNOTSUPP;
+
+	queue_work(devlink->reporters_wq, &reporter->recover_work);
+	return 0;
 }
 
 static int devlink_nl_cmd_health_reporter_diagnose_doit(struct sk_buff *skb,
@@ -5234,6 +5256,11 @@ struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size)
 	INIT_LIST_HEAD(&devlink->param_list);
 	INIT_LIST_HEAD(&devlink->region_list);
 	INIT_LIST_HEAD(&devlink->reporter_list);
+	devlink->reporters_wq = create_singlethread_workqueue("devlink_reporters");
+	if (!devlink->reporters_wq) {
+		kfree(devlink);
+		return NULL;
+	}
 	mutex_init(&devlink->lock);
 	return devlink;
 }
@@ -5278,6 +5305,7 @@ void devlink_unregister(struct devlink *devlink)
 void devlink_free(struct devlink *devlink)
 {
 	mutex_destroy(&devlink->lock);
+	destroy_workqueue(devlink->reporters_wq);
 	WARN_ON(!list_empty(&devlink->reporter_list));
 	WARN_ON(!list_empty(&devlink->region_list));
 	WARN_ON(!list_empty(&devlink->param_list));
-- 
1.8.3.1

