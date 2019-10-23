Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F5FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F15E2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wM7lI1Fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbfJWRrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:47:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38668 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730513AbfJWRrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1571852843; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2YxJuEgeum48XOf8+NOF4s4gfxtGM+tvTtwbCujb0E=;
        b=wM7lI1FgaKyh76bG9Ww+hKrY1LJdZa77wh81VQWYjUAV5hBPf57jMfsS1miWOxYk6XeMm9
        XWhcRuwEHjLZiW987ljqJdrP7JX95TPMiRDQ7yhoS09VQdUs2AdnJ9XWpmzn292P5wr+nw
        O4d0hx9FAQnxdel5rdG/8W/u22Ays/w=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/3] watchdog: jz4740: Drop dependency on MACH_JZ47xx
Date:   Wed, 23 Oct 2019 19:47:14 +0200
Message-Id: <20191023174714.14362-3-paul@crapouillou.net>
In-Reply-To: <20191023174714.14362-1-paul@crapouillou.net>
References: <20191023174714.14362-1-paul@crapouillou.net>
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
Acked-by: Guenter Roeck <linux@roeck-us.net>
---

Notes:
    v2: Rebase on top of 5.4-rc4

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dbef995856bf..fd4844f0a8f3 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1641,7 +1641,7 @@ config INDYDOG
 
 config JZ4740_WDT
 	tristate "Ingenic jz4740 SoC hardware watchdog"
-	depends on MACH_JZ4740 || MACH_JZ4780
+	depends on MIPS
 	depends on COMMON_CLK
 	select WATCHDOG_CORE
 	select MFD_SYSCON
-- 
2.23.0

