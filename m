Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292B6C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B2F208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="I38aNrJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfFGQYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:24:49 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:59204 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbfFGQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559924684; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lak2Oa+O+D9V7TF30FwRdWh/po3l5OvcaoatH7Ifn8=;
        b=I38aNrJPX1TkIuQZ9QyOzBH1Vw9ivww19D6jvLNXrJ9u039o97KMd0BTNgIGXGYOjuaoVb
        zzmjx9qfMFCt22+Nug6TvxSXgvxdkqVrOhkXjN5qSeRQ26FrXyysoJmjNZOplblzL0l0Hf
        n6aequMzBHz+LFe6JvtWQ9v5onEB50c=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     od@zcrc.me, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/4] watchdog: jz4740: Drop dependency on MACH_JZ47xx
Date:   Fri,  7 Jun 2019 18:24:28 +0200
Message-Id: <20190607162429.17915-4-paul@crapouillou.net>
In-Reply-To: <20190607162429.17915-1-paul@crapouillou.net>
References: <20190607162429.17915-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_JZ47xx prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Notes:
    v2: Rebased on v5.2-rc3

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ffe754539f5a..20dd9efc9416 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1634,7 +1634,7 @@ config INDYDOG
 
 config JZ4740_WDT
 	tristate "Ingenic jz4740 SoC hardware watchdog"
-	depends on MACH_JZ4740 || MACH_JZ4780
+	depends on MIPS
 	select WATCHDOG_CORE
 	help
 	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
-- 
2.21.0.593.g511ec345e18

