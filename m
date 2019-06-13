Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CFAC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505E7208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441266;
	bh=8G5MfffYqj/Seca9o+vYrMrouSvXWPcShxmiaV2MsiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M1gOwQiCgeZBNQrY2n9FXUyzus207wSPxFtJA4mWK35qlLjx5E0HHOkZAieQSKcJM
	 p7pXt2N7TYZQcdOv8p5WNafJQqn5zZJosZsL9KU54mZaKFHnXzq7DOmQVLjL2xgUSl
	 yLfB/yPhisdO9ITDSl9WYO6H0GZnJgbLw5ZQVPOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389981AbfFMPyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731568AbfFMIxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:53:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E313120866;
        Thu, 13 Jun 2019 08:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560416005;
        bh=8G5MfffYqj/Seca9o+vYrMrouSvXWPcShxmiaV2MsiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgZGeDXP9qIl5m34+CvnyMmXMU7m/8BBLCZtTwhz85iyocw6Qslu/eD5POzCPRT87
         KNYYWZDRvvbHkM2POp+1noBLGOlRQJHjhni8RVritEFu2ELVbqjW7xSv/rq3R243Pk
         YhYa6WotkXupyJEcfS6XXBKX+ez965aIKYPd9Hno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 054/118] watchdog: fix compile time error of pretimeout governors
Date:   Thu, 13 Jun 2019 10:33:12 +0200
Message-Id: <20190613075646.855692675@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a223770bfa7b6647f3a70983257bd89f9cafce46 ]

CONFIG_WATCHDOG_PRETIMEOUT_GOV build symbol adds watchdog_pretimeout.o
object to watchdog.o, the latter is compiled only if CONFIG_WATCHDOG_CORE
is selected, so it rightfully makes sense to add it as a dependency.

The change fixes the next compilation errors, if CONFIG_WATCHDOG_CORE=n
and CONFIG_WATCHDOG_PRETIMEOUT_GOV=y are selected:

  drivers/watchdog/pretimeout_noop.o: In function `watchdog_gov_noop_register':
  drivers/watchdog/pretimeout_noop.c:35: undefined reference to `watchdog_register_governor'
  drivers/watchdog/pretimeout_noop.o: In function `watchdog_gov_noop_unregister':
  drivers/watchdog/pretimeout_noop.c:40: undefined reference to `watchdog_unregister_governor'

  drivers/watchdog/pretimeout_panic.o: In function `watchdog_gov_panic_register':
  drivers/watchdog/pretimeout_panic.c:35: undefined reference to `watchdog_register_governor'
  drivers/watchdog/pretimeout_panic.o: In function `watchdog_gov_panic_unregister':
  drivers/watchdog/pretimeout_panic.c:40: undefined reference to `watchdog_unregister_governor'

Reported-by: Kuo, Hsuan-Chi <hckuo2@illinois.edu>
Fixes: ff84136cb6a4 ("watchdog: add watchdog pretimeout governor framework")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8c9ea3cd9c60..b7914eb6a04b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1967,6 +1967,7 @@ comment "Watchdog Pretimeout Governors"
 
 config WATCHDOG_PRETIMEOUT_GOV
 	bool "Enable watchdog pretimeout governors"
+	depends on WATCHDOG_CORE
 	help
 	  The option allows to select watchdog pretimeout governors.
 
-- 
2.20.1



