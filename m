Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80C5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BC320674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574422029;
	bh=Klx/vYedqDT/UALTFgFJbMomfAZhczkTY09h71IdXCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hplhqpRZ2Sgofs6xgMwKTeCku1B+86SiRe+I4Uo3kPA5tj2Syf+fjk8DG2Tb5qlLA
	 SNrHBhA8A7yMdwVO0XcAwXAp8wLUnjGC7Blq+9oB3lB5jB5qd0xihLz9DfK5NUf3xf
	 bp3nAFKgp6MEzi1mYYnm6YJbyiHOIk0Xy5xFAtLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfKVL1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfKVKdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:33:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C872072D;
        Fri, 22 Nov 2019 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418796;
        bh=Klx/vYedqDT/UALTFgFJbMomfAZhczkTY09h71IdXCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uEUtB12QEaAAtIzrA7YWSRfP6kgsQ5R6CW7phIR3jX5Ilj3joCkn7GqM+4+HJUsuH
         +9RKpEqrFA3qbCkHkERo/V7WrULFTerKsMCadklNUfW5mnIcDy6jv3hq5cq7TdBO4i
         hd4LYl+Xoce9k66XSgiX1sKYoH2wRWIM01vDhzr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 054/159] power: supply: max8998-charger: Fix platform data retrieval
Date:   Fri, 22 Nov 2019 11:27:25 +0100
Message-Id: <20191122100746.610472481@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/power/max8998_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/max8998_charger.c b/drivers/power/max8998_charger.c
index b64cf0f141425..66438029bdd0c 100644
--- a/drivers/power/max8998_charger.c
+++ b/drivers/power/max8998_charger.c
@@ -85,7 +85,7 @@ static const struct power_supply_desc max8998_battery_desc = {
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



