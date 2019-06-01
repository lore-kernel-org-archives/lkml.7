Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2C9C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0110D27312
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395321;
	bh=6bKgTT5gnfcJKsWHUTECbQrducSnrKEOJSsgdtKBWCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FvuBrtgd6ZWzmw81XxsEAg3I/xa1JB/ZhLIKlo338kVSehEof46VPRdRPwilXgEvq
	 WEOAVmK1sO48cOVW4aT4QXu61a7QxRXDGsEIn4pk128YTnIZ37D1S2hL0/HpD5PuOH
	 Wy4w4Uns6jYEfmEZ22JzDYRtneF5N+JIG7OEXpVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfFANWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbfFANVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:21:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639EA27321;
        Sat,  1 Jun 2019 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395315;
        bh=6bKgTT5gnfcJKsWHUTECbQrducSnrKEOJSsgdtKBWCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUYtWzyKANdolWeVH8DiQzaQq1noggktyWYDBbnDO1F2pQQzKiKMO7YPh5keZIlLL
         3/NN9b1x/A1IhPHCrK8N8oTRlWETRv78zccOKGlrCxaLhi4i/bsdyhyXPwtLbDtWrd
         P0SUVdfKw9kXNrVlDllwN1mMAUl4oxMZ0R3vPk1w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Georg Hofmann <georg@hofmannsweb.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 069/173] watchdog: imx2_wdt: Fix set_timeout for big timeout values
Date:   Sat,  1 Jun 2019 09:17:41 -0400
Message-Id: <20190601131934.25053-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131934.25053-1-sashal@kernel.org>
References: <20190601131934.25053-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georg Hofmann <georg@hofmannsweb.com>

[ Upstream commit b07e228eee69601addba98b47b1a3850569e5013 ]

The documentated behavior is: if max_hw_heartbeat_ms is implemented, the
minimum of the set_timeout argument and max_hw_heartbeat_ms should be used.
This patch implements this behavior.
Previously only the first 7bits were used and the input argument was
returned.

Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/imx2_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 2b52514eaa86a..7e7bdcbbc741b 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -178,8 +178,10 @@ static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
 static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 				unsigned int new_timeout)
 {
-	__imx2_wdt_set_timeout(wdog, new_timeout);
+	unsigned int actual;
 
+	actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
+	__imx2_wdt_set_timeout(wdog, actual);
 	wdog->timeout = new_timeout;
 	return 0;
 }
-- 
2.20.1

