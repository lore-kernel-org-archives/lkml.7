Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3542EC04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05713216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558006804;
	bh=cy3FzNZeoOM5t8yaVU43pD1Gxq1s42srfdmURpRgDDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j6e2/OG7Pzwo1YR6hueqKToAB5s6hOuyY24VXJ5YAeE+JjlUwPXsK75zjP03w9CyN
	 4ClLx1+xxK/gxom1sAUq06CLp9tyFRrlImuobMW90LFYlX3ZeQtjsrQDPGSdTMyt9P
	 Om+IKPQRazctbm8CYrdwdzrcmxL+HH/PvFoI/uPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfEPLkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbfEPLj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:39:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91C832089E;
        Thu, 16 May 2019 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006799;
        bh=cy3FzNZeoOM5t8yaVU43pD1Gxq1s42srfdmURpRgDDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRC45nVN+3O3umO+p2e+ZNyl7p3fMfRSAb1pwAqdaZoPf1/8c+VjqcZ/peVjmVyfp
         CsenwauI1zWIsAanjnSXsci9XIV7xCFPgqaTtITOwvlImDE174vWjvSg9Bvzg1XiMH
         0wgoNP8V/fods0rC3vnJELp0xoNIamKygSpHkZoA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 21/34] power: supply: sysfs: prevent endless uevent loop with CONFIG_POWER_SUPPLY_DEBUG
Date:   Thu, 16 May 2019 07:39:18 -0400
Message-Id: <20190516113932.8348-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516113932.8348-1-sashal@kernel.org>
References: <20190516113932.8348-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

[ Upstream commit 349ced9984ff540ce74ca8a0b2e9b03dc434b9dd ]

Fix a similar endless event loop as was done in commit
8dcf32175b4e ("i2c: prevent endless uevent loop with
CONFIG_I2C_DEBUG_CORE"):

  The culprit is the dev_dbg printk in the i2c uevent handler. If
  this is activated (for instance by CONFIG_I2C_DEBUG_CORE) it results
  in an endless loop with systemd-journald.

  This happens if user-space scans the system log and reads the uevent
  file to get information about a newly created device, which seems
  fair use to me. Unfortunately reading the "uevent" file uses the
  same function that runs for creating the uevent for a new device,
  generating the next syslog entry

Both CONFIG_I2C_DEBUG_CORE and CONFIG_POWER_SUPPLY_DEBUG were reported
in https://bugs.freedesktop.org/show_bug.cgi?id=76886 but only former
seems to have been fixed. Drop debug prints as it was done in I2C
subsystem to resolve the issue.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_sysfs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dce24f5961609..5358a80d854f9 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -383,15 +383,11 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 	char *prop_buf;
 	char *attrname;
 
-	dev_dbg(dev, "uevent\n");
-
 	if (!psy || !psy->desc) {
 		dev_dbg(dev, "No power supply yet\n");
 		return ret;
 	}
 
-	dev_dbg(dev, "POWER_SUPPLY_NAME=%s\n", psy->desc->name);
-
 	ret = add_uevent_var(env, "POWER_SUPPLY_NAME=%s", psy->desc->name);
 	if (ret)
 		return ret;
@@ -427,8 +423,6 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 			goto out;
 		}
 
-		dev_dbg(dev, "prop %s=%s\n", attrname, prop_buf);
-
 		ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s", attrname, prop_buf);
 		kfree(attrname);
 		if (ret)
-- 
2.20.1

