Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A4C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0501622525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RhVR6tn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgABPvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:51:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37814 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgABPvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:51:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so17958564plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MhQG0/5JezNv1KtQT1rgY66YIDnDZ+v70hNo6D0LoXg=;
        b=RhVR6tn88iqM9CAUBuIXpC8u7enUg5KhZQzj0GVrdn/23ih1Mi5aXE//i/LbuUb6JS
         XJv5C66APOE7/VFJ7f6chnXcg3hU+P9y05EGl3LG8UGI2uYd1JJTo18ArBgTNMTqNXv7
         pn/7QuBC8goVmWplj8gh1M37fOG+1fdQY+iVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MhQG0/5JezNv1KtQT1rgY66YIDnDZ+v70hNo6D0LoXg=;
        b=IEB/6/Ou7SZyZzm26vhPGX66itMwBp7kc7STmZHZvvBqg1s9UuiB8UfZR/LRVta9PJ
         9IbcJ2zHDqwLeXt9MVOfqLUIjQiNtKKzil921KX94FVqy7omP5KmCEa6OtDfZ14Bq1Tc
         NQOikAIox/gYe8w5Vik2vgk4Y5ojNykIMBZ7lYpkj1Bsz05RRwZML4HYr3d0sWbbG8VR
         6hy6s+Mifpy0E9ieMpk+/H7sA3zF9ehpiZFNVJCmG8m1I9Gv/ilKozHKD6X445Pr/M+B
         ENE+3B8L/ERX4e7BGiljOYYkSah6t2WyLwSiwYbD7M2OMxDOq9C1EkgiFMQi7BChMv27
         BpkQ==
X-Gm-Message-State: APjAAAVE4xpSxENGfa8/qnmVLDkMmsiVJ7HFhmft4pBUzG9TSi3VPLoH
        cIqOZ6pPlYhmxMPa8ooslgkBNw==
X-Google-Smtp-Source: APXvYqxmTFehZbAfKFT1nOlnLy/69betFFYIHUPY6KrYNNfHnEW3rMAgBVj9YfpNL5BAF1lBPsgaMw==
X-Received: by 2002:a17:90b:3004:: with SMTP id hg4mr20589047pjb.52.1577980273180;
        Thu, 02 Jan 2020 07:51:13 -0800 (PST)
Received: from Ninja.ibn.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2sm11499420pjv.18.2020.01.02.07.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 07:51:12 -0800 (PST)
From:   Vikas Gupta <vikas.gupta@broadcom.com>
To:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vasundhara-v.volam@broadcom.com, vikram.prakash@broadcom.com,
        Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH v1 2/3] devlink: add devink notification when reporter update health state
Date:   Thu,  2 Jan 2020 21:18:10 +0530
Message-Id: <1577980091-25118-3-git-send-email-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577980091-25118-1-git-send-email-vikas.gupta@broadcom.com>
References: <1577980091-25118-1-git-send-email-vikas.gupta@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a devlink notification when reporter update the health
state.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 net/core/devlink.c | 59 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index e686ae6..d30aa47 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -4844,23 +4844,6 @@ devlink_health_reporter_destroy(struct devlink_health_reporter *reporter)
 EXPORT_SYMBOL_GPL(devlink_health_reporter_destroy);
 
 void
-devlink_health_reporter_state_update(struct devlink_health_reporter *reporter,
-				     enum devlink_health_reporter_state state)
-{
-	if (WARN_ON(state != DEVLINK_HEALTH_REPORTER_STATE_HEALTHY &&
-		    state != DEVLINK_HEALTH_REPORTER_STATE_ERROR))
-		return;
-
-	if (reporter->health_state == state)
-		return;
-
-	reporter->health_state = state;
-	trace_devlink_health_reporter_state_update(reporter->devlink,
-						   reporter->ops->name, state);
-}
-EXPORT_SYMBOL_GPL(devlink_health_reporter_state_update);
-
-void
 devlink_health_reporter_recovery_done(struct devlink_health_reporter *reporter)
 {
 	reporter->recovery_count++;
@@ -5097,6 +5080,48 @@ devlink_nl_health_reporter_fill(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
+static void devlink_recover_notify(struct devlink_health_reporter *reporter,
+				   enum devlink_command cmd)
+{
+	struct sk_buff *msg;
+	int err;
+
+	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	err = devlink_nl_health_reporter_fill(msg, reporter->devlink,
+					      reporter, cmd, 0, 0, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_multicast_netns(&devlink_nl_family,
+				devlink_net(reporter->devlink),
+				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+}
+
+void
+devlink_health_reporter_state_update(struct devlink_health_reporter *reporter,
+				     enum devlink_health_reporter_state state)
+{
+	if (WARN_ON(state != DEVLINK_HEALTH_REPORTER_STATE_HEALTHY &&
+		    state != DEVLINK_HEALTH_REPORTER_STATE_ERROR))
+		return;
+
+	if (reporter->health_state == state)
+		return;
+
+	reporter->health_state = state;
+	trace_devlink_health_reporter_state_update(reporter->devlink,
+						   reporter->ops->name, state);
+	devlink_recover_notify(reporter, DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
+}
+EXPORT_SYMBOL_GPL(devlink_health_reporter_state_update);
+
 static int devlink_nl_cmd_health_reporter_get_doit(struct sk_buff *skb,
 						   struct genl_info *info)
 {
-- 
2.7.4

