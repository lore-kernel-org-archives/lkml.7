Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EF6FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F22521D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213373;
	bh=TW1UJ3v+CH/LPjjD9VAJXk8Gc7Yo8euonvZXeuV1Gl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vaQwFnAUI1HOUP7I2KmlqhtsINFWtzsMN6ke/6fRz/4dtMBouziCWxornYMJz1788
	 Yn/LOz0kSfqKxQCiRFkwUWPpPSw5lT1U6BStFfubjABnmM2+0QZHCDBX7i8IEJJhMs
	 fkLaMMBwmk1RvnXyHmWzz1gTGB3QcAnGWgoRQxl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390207AbfKHLmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390170AbfKHLmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5250D21D7E;
        Fri,  8 Nov 2019 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213368;
        bh=TW1UJ3v+CH/LPjjD9VAJXk8Gc7Yo8euonvZXeuV1Gl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xj6eyM/w40tzSYhNctukg7BtEfWOZA69sbV8xhec1KPmx4A8ICqxOFjT+Ca0fnpsm
         0LZCzlfb2eMjYUdsZZDMqla6erebX+l4ooze7+bCDea2unhq1sCt5FuSKjtpAJHf2t
         gvyy12w9b4bjBp9Rbt+jrWmSi0wBUjFmMfvtGKno=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 195/205] power: supply: max8998-charger: Fix platform data retrieval
Date:   Fri,  8 Nov 2019 06:37:42 -0500
Message-Id: <20191108113752.12502-195-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

[ Upstream commit cb90a2c6f77fe9b43d1e3f759bb2f13fe7fa1811 ]

Since the max8998 MFD driver supports instantiation by DT, platform data
retrieval is handled in MFD probe and cell drivers should get use
the pdata field of max8998_dev struct to obtain them.

Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/max8998_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index cad7d1a8feec7..aa65e6c36c55e 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -86,7 +86,7 @@ static const struct power_supply_desc max8998_battery_desc = {
 static int max8998_battery_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *iodev = dev_get_drvdata(pdev->dev.parent);
-	struct max8998_platform_data *pdata = dev_get_platdata(iodev->dev);
+	struct max8998_platform_data *pdata = iodev->pdata;
 	struct power_supply_config psy_cfg = {};
 	struct max8998_battery_data *max8998;
 	struct i2c_client *i2c;
-- 
2.20.1

