Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B621CCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F63A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfJ3Pm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:42:28 -0400
Received: from foss.arm.com ([217.140.110.172]:36696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfJ3Pm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:42:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0255E4F5;
        Wed, 30 Oct 2019 08:42:26 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 351803F6C4;
        Wed, 30 Oct 2019 08:42:25 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] driver: base: cpu: export device_online/offline
Date:   Wed, 30 Oct 2019 15:38:32 +0000
Message-Id: <20191030153837.18107-8-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030153837.18107-1-qais.yousef@arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And the {lock,unlock}_device_hotplug so that they can be used from
modules.

This is in preparation to replace cpu_up/down with
device_online/offline; which kernel/torture.c will require to be
exported to be built as a module.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: linux-kernel@vger.kernel.org
---
 drivers/base/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2db62d98e395..3431cd0c9eac 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -882,11 +882,13 @@ void lock_device_hotplug(void)
 {
 	mutex_lock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(lock_device_hotplug);
 
 void unlock_device_hotplug(void)
 {
 	mutex_unlock(&device_hotplug_lock);
 }
+EXPORT_SYMBOL_GPL(unlock_device_hotplug);
 
 int lock_device_hotplug_sysfs(void)
 {
@@ -2678,6 +2680,7 @@ int device_offline(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(device_offline);
 
 /**
  * device_online - Put the device back online after successful device_offline().
@@ -2709,6 +2712,7 @@ int device_online(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(device_online);
 
 struct root_device {
 	struct device dev;
-- 
2.17.1

