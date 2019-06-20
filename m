Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C734C48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B31A2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561056219;
	bh=qssMf724l63GhfHaaNI1XFYyjk/ni2GigTWG47mPq+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kjmd7aX3djd5m73W2VoGDWawgHhinJwEQXb+QubLQ9gscLqRmVHYS/ijHbJK6onAO
	 8/7N0gZV8rldNSq0vtIaXNI0Ljzb5uP85nJ8EHTt1TNEeF3mb3ZObM1W6olw7oeIIN
	 LMWtczZfD06EV2cbNR2GCSSg7DviVDRz25x25TH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfFTSnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfFTSnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:43:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D664720656;
        Thu, 20 Jun 2019 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561056216;
        bh=qssMf724l63GhfHaaNI1XFYyjk/ni2GigTWG47mPq+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHJUJEpwQpJgwjwTXV86R/ejECgnna4zyIVw+/u2pkpi+auEYU1B5ZtOyYh7NGTVs
         1FAaosz+V23bG4urwC89rZHwUQsIWYEjV0OrQ0tBNk7o4I59XcGyzvLp26ZQHyNH50
         QCyUvS9YRDBEFu7EbFPVa9ItFy5BKcXPxQ9rCFyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 027/117] watchdog: fix compile time error of pretimeout governors
Date:   Thu, 20 Jun 2019 19:56:01 +0200
Message-Id: <20190620174353.612777514@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
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
index 15c01830799a..d65c220d8175 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1850,6 +1850,7 @@ comment "Watchdog Pretimeout Governors"
 
 config WATCHDOG_PRETIMEOUT_GOV
 	bool "Enable watchdog pretimeout governors"
+	depends on WATCHDOG_CORE
 	help
 	  The option allows to select watchdog pretimeout governors.
 
-- 
2.20.1



