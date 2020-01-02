Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B387DC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CD820866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005967;
	bh=YD5Qd+d9+AvbAi/KPYotBzxb9IG9TQDX7dJEYehuDCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NuaGIq9tAwz3/EREb7VefQLSzqmegVmeKvTZCv7KxsQXgLECp6XvWghO1hrQWvGy/
	 pNpoB3qoYZ3N/Q9fwOSAgThjk8f4UvMW4Ko/dCFAWtt/vjhfu/3a6qIlDy13qUX325
	 +eavpOOXHAtC7uHUTjiCdSVOlawhO6WcClw5trTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgABWOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:14:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbgABWOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:14:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8491221D7D;
        Thu,  2 Jan 2020 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003254;
        bh=YD5Qd+d9+AvbAi/KPYotBzxb9IG9TQDX7dJEYehuDCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T429RGus5MCafrAUlLRxkyAXQLgpFDhPn0qpKYy4v9lFY/p+g/tBwAmYz5nBWiHTz
         q2TSoXBZxFgU0jk99wgeiXwxay54t8XbwG0rfMvyffy1SgRBEkzW8i5nTRQ7OVLGxY
         VpYnr9Zaxbz5TRL5bxvsEW9aGweErfwwGirpZg+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 083/191] watchdog: imx7ulp: Fix reboot hang
Date:   Thu,  2 Jan 2020 23:06:05 +0100
Message-Id: <20200102215838.833496463@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 6083ab7b2f3f25022e2e8f4c42f14a8521f47873 ]

The following hang is observed when a 'reboot' command is issued:

# reboot
# Stopping network: OK
Stopping klogd: OK
Stopping syslogd: OK
umount: devtmpfs busy - remounted read-only
[    8.612079] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
[   10.694753] reboot: Restarting system
[   11.699008] Reboot failed -- System halted

Fix this problem by adding a .restart ops member.

Fixes: 41b630f41bf7 ("watchdog: Add i.MX7ULP watchdog support")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20191029174037.25381-1-festevam@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/imx7ulp_wdt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 5ce51026989a..ba5d535a6db2 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -106,12 +106,28 @@ static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
 	return 0;
 }
 
+static int imx7ulp_wdt_restart(struct watchdog_device *wdog,
+			       unsigned long action, void *data)
+{
+	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
+
+	imx7ulp_wdt_enable(wdt->base, true);
+	imx7ulp_wdt_set_timeout(&wdt->wdd, 1);
+
+	/* wait for wdog to fire */
+	while (true)
+		;
+
+	return NOTIFY_DONE;
+}
+
 static const struct watchdog_ops imx7ulp_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = imx7ulp_wdt_start,
 	.stop  = imx7ulp_wdt_stop,
 	.ping  = imx7ulp_wdt_ping,
 	.set_timeout = imx7ulp_wdt_set_timeout,
+	.restart = imx7ulp_wdt_restart,
 };
 
 static const struct watchdog_info imx7ulp_wdt_info = {
-- 
2.20.1



