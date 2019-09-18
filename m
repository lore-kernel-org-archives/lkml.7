Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99590C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C52421928
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="edyaNwt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbfIRSwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:52:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44195 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387624AbfIRSwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:52:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so350087pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Okiu/elfIgaQjLf/NcyUs2b0iC336LxObVGspA2lzqA=;
        b=edyaNwt+eE1B1lgdsf/YGnTJT7plTJ12j36UTrWUO/FNne2Cz4e3Jsmk0R1p+1RuKI
         wxis/VxbSyAsbRssjpJ8QEihlf90LcB+Eol37VpQzbP4CzHi7fjm0o4HFYGnT/NS3sth
         M5x4sS9d9PtxDr7DSNWf6FftE21sx5C2KZ3I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Okiu/elfIgaQjLf/NcyUs2b0iC336LxObVGspA2lzqA=;
        b=iOj+A9ZpfRSnJsVFLfRXbua7RHVPw2sQocH5PmxkcjiOwWulZvGfy91IyGOnP2XH2p
         1Bwnumw9hUtwuNztm+MUny/drZk6PFWzXK/euJkaYig2fp2LXfgdkQvuYzRO+YX9QKk+
         mCARIwQ73e36ooU1eKw/aS2bCaKoszQNcyNNc7wbCOguzzAV4bs6uY6BOLLlzuSTTYW6
         pHntN6MNBqueBAP3xhxae02MfnvR4SA1A5fRioLt7j+DegnsZE1T5DnJHVdtL/1ZC5F+
         yR/hsS8T3z93AwqMC8v5mMOjnps0SARFgnR/2FJiMsvryn0czPYccv1Gns9Bz1QUVuy9
         Jnkg==
X-Gm-Message-State: APjAAAWCIwXGpm22v6F7IEDASx3PH+tLoUd97JPJXzOfiD46P9W+mJB7
        weti7Syn8ReTVs2d+OfpR15d6A==
X-Google-Smtp-Source: APXvYqzEryEbvffH4fIUESAvKGyMWpAjiAWue/Z8tPbRhL3fkmz6diIJu/4RxieSqZDIvsTOUIGGJQ==
X-Received: by 2002:aa7:9835:: with SMTP id q21mr5970232pfl.122.1568832742624;
        Wed, 18 Sep 2019 11:52:22 -0700 (PDT)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o42sm3745010pjo.32.2019.09.18.11.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 11:52:22 -0700 (PDT)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH] devlink: add devlink notification for recovery
Date:   Thu, 19 Sep 2019 00:22:21 +0530
Message-Id: <1568832741-20850-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vikas Gupta <vikas.gupta@broadcom.com>

Add a devlink notification for reporter recovery

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 net/core/devlink.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index e48680e..42909fb 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -4730,6 +4730,28 @@ struct devlink_health_reporter *
 }
 EXPORT_SYMBOL_GPL(devlink_health_reporter_state_update);
 
+static void __devlink_recover_notify(struct devlink *devlink,
+				     enum devlink_command cmd)
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
+	err = devlink_nl_fill(msg, devlink, cmd, 0, 0, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return;
+	}
+
+	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
+				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+}
+
 static int
 devlink_health_reporter_recover(struct devlink_health_reporter *reporter,
 				void *priv_ctx)
@@ -4747,6 +4769,9 @@ struct devlink_health_reporter *
 	reporter->health_state = DEVLINK_HEALTH_REPORTER_STATE_HEALTHY;
 	reporter->last_recovery_ts = jiffies;
 
+	__devlink_recover_notify(reporter->devlink,
+				 DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
+
 	return 0;
 }
 
-- 
1.9.1

