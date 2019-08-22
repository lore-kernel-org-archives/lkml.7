Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C44FC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF192377B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbfHVISI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:18:08 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46537 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726262AbfHVISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:18:08 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from ayal@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 22 Aug 2019 11:18:02 +0300
Received: from dev-l-vrt-210.mtl.labs.mlnx (dev-l-vrt-210.mtl.labs.mlnx [10.134.210.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7M8I2gV009936;
        Thu, 22 Aug 2019 11:18:02 +0300
Received: from dev-l-vrt-210.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-210.mtl.labs.mlnx (8.15.2/8.15.2/Debian-8ubuntu1) with ESMTP id x7M8I2W6022032;
        Thu, 22 Aug 2019 11:18:02 +0300
Received: (from ayal@localhost)
        by dev-l-vrt-210.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id x7M8I1Rv022031;
        Thu, 22 Aug 2019 11:18:01 +0300
From:   Aya Levin <ayal@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aya Levin <ayal@mellanox.com>
Subject: [net] devlink: Add method for time-stamp on reporter's dump
Date:   Thu, 22 Aug 2019 11:17:51 +0300
Message-Id: <1566461871-21992-1-git-send-email-ayal@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting the dump's time-stamp, use ktime_get_real in addition to
jiffies. This simplifies the user space implementation and bypasses
some inconsistent behavior with translating jiffies to current time.

Fixes: c8e1da0bf923 ("devlink: Add health report functionality")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
---
 include/uapi/linux/devlink.h | 2 ++
 net/core/devlink.c           | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index ffc993256527..4dd4e4e7b19b 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -348,6 +348,8 @@ enum devlink_attr {
 	DEVLINK_ATTR_PORT_PCI_PF_NUMBER,	/* u16 */
 	DEVLINK_ATTR_PORT_PCI_VF_NUMBER,	/* u16 */
 
+	DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TSPEC,
+
 	/* add new attributes above here, update the policy in devlink.c */
 
 	__DEVLINK_ATTR_MAX,
diff --git a/net/core/devlink.c b/net/core/devlink.c
index d3dbb904bf3b..b26875c4329b 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -4577,6 +4577,7 @@ struct devlink_health_reporter {
 	bool auto_recover;
 	u8 health_state;
 	u64 dump_ts;
+	struct timespec dump_real_ts;
 	u64 error_count;
 	u64 recovery_count;
 	u64 last_recovery_ts;
@@ -4749,6 +4750,7 @@ static int devlink_health_do_dump(struct devlink_health_reporter *reporter,
 		goto dump_err;
 
 	reporter->dump_ts = jiffies;
+	reporter->dump_real_ts = ktime_to_timespec(ktime_get_real());
 
 	return 0;
 
@@ -4911,6 +4913,10 @@ devlink_nl_health_reporter_fill(struct sk_buff *msg,
 			      jiffies_to_msecs(reporter->dump_ts),
 			      DEVLINK_ATTR_PAD))
 		goto reporter_nest_cancel;
+	if (reporter->dump_fmsg &&
+	    nla_put(msg, DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TSPEC,
+		    sizeof(reporter->dump_real_ts), &reporter->dump_real_ts))
+		goto reporter_nest_cancel;
 
 	nla_nest_end(msg, reporter_attr);
 	genlmsg_end(msg, hdr);
-- 
2.14.1

