Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1D9C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A2421D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611979;
	bh=KB354o3/r9P+JtBFvnw5fnhLSpxOdIW6UqA4GyhnQBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NDlf/hbNOGtvSMZvCvPlAnYkoWdIhwzzxLNMG+HMNM0chE4Xet7klUAsfhtJ/hyF7
	 5o3UiWoTmRQAk3dVZU/VPl4jDlhYqkRiqOhYLYr2N8wm48da3d5WYb00n/QJhJES95
	 u7s1zS9hbVIaag12ERQaX7YmBujWU5KvytO//r9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfKMC0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfKMBvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:51:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B0EB222D3;
        Wed, 13 Nov 2019 01:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609876;
        bh=KB354o3/r9P+JtBFvnw5fnhLSpxOdIW6UqA4GyhnQBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkQGPc13qIRJMzCiSlyDpJC6+hFeoDBeVccZMAzTx9L7rrSu0t2Nm72FDYELAByxj
         kDMpMZRLEgENv1VXilwNsB0q+yVrstubyZN0jH5SzhGAdFWH0P4tMLPfq+m79p9eNb
         6FtO4sIcuUJ8+wbTluVCOUgID8OhIIghuErtmWsY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 039/209] watchdog: renesas_wdt: stop when unregistering
Date:   Tue, 12 Nov 2019 20:47:35 -0500
Message-Id: <20191113015025.9685-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 14de99b44b34dbb9d0f64845b1cbb675e047767e ]

We want to go into a sane state when unregistering. Currently, it
happens that the watchdog stops when unbinding because of RuntimePM
stopping the core clock. When rebinding, the core clock gets reactivated
and the watchdog fires even though it hasn't been opened by userspace
yet. Strange scenario, yes, but sane state is much preferred anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/renesas_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index d01efd342dc0c..62d9d3edcdf25 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -239,6 +239,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&priv->wdev, priv);
 	watchdog_set_nowayout(&priv->wdev, nowayout);
 	watchdog_set_restart_priority(&priv->wdev, 0);
+	watchdog_stop_on_unregister(&priv->wdev);
 
 	/* This overrides the default timeout only if DT configuration was found */
 	ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
-- 
2.20.1

