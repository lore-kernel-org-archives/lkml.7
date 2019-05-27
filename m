Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF5C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D3421707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="pBZkokzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfE0Crz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 22:47:55 -0400
Received: from gateway20.websitewelcome.com ([192.185.54.2]:37480 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbfE0Crx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 22:47:53 -0400
X-Greylist: delayed 1471 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 May 2019 22:47:52 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id F0ADC400C5945
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 20:23:07 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id V5IGhcT3SdnCeV5IGhHjR1; Sun, 26 May 2019 21:23:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I4VLnKJzdba2/tICr5vHEXDmUjBljIV86QHf5FlXteA=; b=pBZkokznjDxJn5J0nEp/+icHZt
        YZukC0iqe8exicoGyoaaPdEHgzTPBSFsvRBwQ89W562CdIfWzRdc7i//G/aHpxbjSyDNfngXNx92V
        pfKxPUwOuA0QrX8G9IBsO9vUXnw0Yx/E38IDVfhR39v0BWtKG7+FDfLGfBRz8kRPY7fVZ+PxCSdsL
        e/f4tRW4IjuOOOaXY8YLrzuuOS7nJew6b+4S6Js6+n1X0gtq8zz9oIRBVUYCZCWoUHPGCG2wA3V/J
        7QtxE1xobhSWBtwmx838KEf0O+VtjqKv2A09qHUhqiG9QU9k/W7YzG+OONtVXCIXDdgh4MKh3km7R
        XrqP/Utg==;
Received: from [177.34.20.96] (port=57660 helo=castello.castello.in)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hV5IF-003JNX-JQ; Sun, 26 May 2019 23:23:20 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v3 5/5] power: supply: max17040: Send uevent in SOC and status change
Date:   Sun, 26 May 2019 23:22:58 -0300
Message-Id: <20190527022258.32748-6-matheus@castello.eng.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527022258.32748-1-matheus@castello.eng.br>
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 177.34.20.96
X-Source-L: No
X-Exim-ID: 1hV5IF-003JNX-JQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello.in) [177.34.20.96]:57660
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 68
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify core through power_supply_changed() in case of changes in state
of charge and power supply status. This is useful for user-space to
efficiently update current battery level.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 61e6fcfea8a1..34278845cfe5 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -176,6 +176,9 @@ static void max17040_get_online(struct i2c_client *client)
 static void max17040_get_status(struct i2c_client *client)
 {
 	struct max17040_chip *chip = i2c_get_clientdata(client);
+	int last_status;
+
+	last_status = chip->status;

 	if (!chip->pdata || !chip->pdata->charger_online
 			|| !chip->pdata->charger_enable) {
@@ -194,6 +197,9 @@ static void max17040_get_status(struct i2c_client *client)

 	if (chip->soc > MAX17040_BATTERY_FULL)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
+
+	if (last_status != chip->status)
+		power_supply_changed(chip->battery);
 }

 static void max17040_get_of_data(struct max17040_chip *chip)
@@ -217,10 +223,18 @@ static void max17040_check_changes(struct i2c_client *client)
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
+	int last_soc;

 	chip = container_of(work, struct max17040_chip, work.work);
+
+	/* store SOC for check change */
+	last_soc = chip->soc;
 	max17040_check_changes(chip->client);

+	/* check changes and send uevent */
+	if (chip->soc >= 0 && last_soc != chip->soc)
+		power_supply_changed(chip->battery);
+
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 }
--
2.20.1

