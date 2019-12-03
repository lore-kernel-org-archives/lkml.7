Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4ECC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1CD20865
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412923;
	bh=Cob9II1USz9OZYAyMh+qKhCiH3vFEAJWdyas8rtimoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t4S1WSvU7JyOQuGDdXSpxuhkZA6TWXM6hqzhNMqODHROAIyfiPoNbCisub0H92NPi
	 zFX/XOwSuV+o9FR1wRAlwzzqYC+a1nRIpD5eRPvqy3joAgJTmbF7UQikew053uMURc
	 EFakaOwij5QxFvgdVRW5V4nxX8PxMqJfplHIjT9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfLCWmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbfLCWl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:41:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0708320862;
        Tue,  3 Dec 2019 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412917;
        bh=Cob9II1USz9OZYAyMh+qKhCiH3vFEAJWdyas8rtimoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaPixY+tSnPWY2O5MWBYz3AFaIyH07TK240diQS6zUsoMo1iCHrO7oGrKJlLmvv3n
         GmFcT9zOr3KE4I04ueSpN36evM42YVr8rqf5gEGvgBmseoBQyGpq1gt54Uk1tLDN8E
         f1z+eFdh9F19RNpjXWy6Shg8K5GHhHmou1zgX5Pc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xingyu Chen <xingyu.chen@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 066/135] watchdog: meson: Fix the wrong value of left time
Date:   Tue,  3 Dec 2019 23:35:06 +0100
Message-Id: <20191203213025.240489620@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

[ Upstream commit 2c77734642d52448aca673e889b39f981110828b ]

The left time value is wrong when we get it by sysfs. The left time value
should be equal to preset timeout value minus elapsed time value. According
to the Meson-GXB/GXL datasheets which can be found at [0], the timeout value
is saved to BIT[0-15] of the WATCHDOG_TCNT, and elapsed time value is saved
to BIT[16-31] of the WATCHDOG_TCNT.

[0]: http://linux-meson.com

Fixes: 683fa50f0e18 ("watchdog: Add Meson GXBB Watchdog Driver")
Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/meson_gxbb_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index d17c1a6ed7234..5a9ca10fbcfa0 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -89,8 +89,8 @@ static unsigned int meson_gxbb_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 
 	reg = readl(data->reg_base + GXBB_WDT_TCNT_REG);
 
-	return ((reg >> GXBB_WDT_TCNT_CNT_SHIFT) -
-		(reg & GXBB_WDT_TCNT_SETUP_MASK)) / 1000;
+	return ((reg & GXBB_WDT_TCNT_SETUP_MASK) -
+		(reg >> GXBB_WDT_TCNT_CNT_SHIFT)) / 1000;
 }
 
 static const struct watchdog_ops meson_gxbb_wdt_ops = {
-- 
2.20.1



