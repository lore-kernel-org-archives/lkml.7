Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6E7C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6284F23404
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620161;
	bh=o/h0K/QgLQLBTCQBwpwh39O6WHVqKMUR9tz1VOI8b2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BqFfJ2tI7s1SxAAES23pyAnLN0ZJrqr87kL/X/lOxd1EUUW4p/mDafsCmsxnCBsj4
	 g91/oqM0aT5V/do92EitKVNS050XfzP/9hangE4DMiuR+Ru8CoSs0t7QCEF+M9Npdx
	 9jiDHurZ43LW5e/yK9uZ3243YtjrOuN6OdY1LSjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbfIDSCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732363AbfIDSCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:02:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10AFB2339D;
        Wed,  4 Sep 2019 18:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620158;
        bh=o/h0K/QgLQLBTCQBwpwh39O6WHVqKMUR9tz1VOI8b2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Imw4u4/MAuCycV2xsxA8nZ3wlHryFVO/k3hNvLG1y6xgAgZbj/Mi8EdZSDwhvKK47
         KOkSjtI0mc8djK21hG8hKJvNc/Hy055uqQzSoSdyoS0EOPjkeudU4DI+ERrC1DB/oQ
         O9NpwIr/JKFYuv27RwYoo6xbaP33Ap408gOQplXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/57] watchdog: bcm2835_wdt: Fix module autoload
Date:   Wed,  4 Sep 2019 19:53:40 +0200
Message-Id: <20190904175303.162724718@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175301.777414715@linuxfoundation.org>
References: <20190904175301.777414715@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 215e06f0d18d5d653d6ea269e4dfc684854d48bf ]

The commit 5e6acc3e678e ("bcm2835-pm: Move bcm2835-watchdog's DT probe
to an MFD.") broke module autoloading on Raspberry Pi. So add a
module alias this fix this.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/bcm2835_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index b339e0e67b4c1..adb699145a071 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -252,6 +252,7 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+MODULE_ALIAS("platform:bcm2835-wdt");
 MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
 MODULE_DESCRIPTION("Driver for Broadcom BCM2835 watchdog timer");
 MODULE_LICENSE("GPL");
-- 
2.20.1



