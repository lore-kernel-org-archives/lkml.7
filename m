Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFC8C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164DE218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383805;
	bh=IMFn1tzxwb26dMf9wGqGPU6excEbDGy+Ynd8rhWb8Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qoa6z0HPk6o9KjCFH9wZ55f2zEsS8uQoO67hNeqHUuhbwlRbFswGJip3M6bJTnijk
	 70JLEOpG5i7TxmbkILvjtYPUQJV1L/frPQI61p8f4X3jalqYcs4qMyksJYC1KUyp6B
	 a454R3e/z8Dy1cG7pub8FXGRlxbbnV3yq4NIqbRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfJFRnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729302AbfJFRnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:43:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BEC32080F;
        Sun,  6 Oct 2019 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383800;
        bh=IMFn1tzxwb26dMf9wGqGPU6excEbDGy+Ynd8rhWb8Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNiwsArk1W80PlJM51QT6jP88yn75LZwgY7x5xZjwRDPK1/0gHOw8DgXn298CVNwI
         B58CBLK33hlgBVUYG24GzCynrhMZjiTXGn1kWwlRt8nN1EoVmi7vqcIC+moajtL/rZ
         qNCVNzT7yas55hUX44dUFfPwVrusq8AfQSj+vz9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 101/166] power: supply: register HWMON devices with valid names
Date:   Sun,  6 Oct 2019 19:21:07 +0200
Message-Id: <20191006171222.049194629@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Romain Izard <romain.izard.pro@gmail.com>

[ Upstream commit f1b937cc86bedf94dbc3478c2c0dc79471081fff ]

With the introduction of the HWMON compatibility layer to the power
supply framework in Linux 5.3, all power supply devices' names can be
used directly to create HWMON devices with the same names.

But HWMON has rules on allowable names that are different from those
used in the power supply framework. The dash character is forbidden, as
it is used by the libsensors library in userspace as a separator,
whereas this character is used in the device names in more than half of
the existing power supply drivers. This last case is consistent with the
typical naming usage with MFD and Device Tree.

This leads to warnings in the kernel log, with the format:

power_supply gpio-charger: hwmon: \
	'gpio-charger' is not a valid name attribute, please fix

Add a protection to power_supply_add_hwmon_sysfs() that replaces any
dash in the device name with an underscore when registering with the
HWMON framework. Other forbidden characters (star, slash, space, tab,
newline) are not replaced, as they are not in common use.

Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_hwmon.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 51fe60440d125..75cf861ba492d 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -284,6 +284,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 	struct device *dev = &psy->dev;
 	struct device *hwmon;
 	int ret, i;
+	const char *name;
 
 	if (!devres_open_group(dev, power_supply_add_hwmon_sysfs,
 			       GFP_KERNEL))
@@ -334,7 +335,19 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		}
 	}
 
-	hwmon = devm_hwmon_device_register_with_info(dev, psy->desc->name,
+	name = psy->desc->name;
+	if (strchr(name, '-')) {
+		char *new_name;
+
+		new_name = devm_kstrdup(dev, name, GFP_KERNEL);
+		if (!new_name) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		strreplace(new_name, '-', '_');
+		name = new_name;
+	}
+	hwmon = devm_hwmon_device_register_with_info(dev, name,
 						psyhw,
 						&power_supply_hwmon_chip_info,
 						NULL);
-- 
2.20.1



