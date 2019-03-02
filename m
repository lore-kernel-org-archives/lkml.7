Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64755C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2464F20838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="IXR83I4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfCBXgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:36:14 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:34704 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfCBXgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 18:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551569769; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JxzTaPJ+1m042fGj0D2uCEKzGbpGlEuVoq++EpXOWzk=;
        b=IXR83I4BfcfKIkTCEaODuNaHgr5YmhV4OSWX1oCfboL4JedY+DxJLXzsnBA8Vb2mt/0R/k
        u4BibBdmOYruNm86s89v1nHs3lgs5JJABoX1lAgBY733H8sNUCMqrVXBk2xalZv7npETBk
        ShfVw3bPBgIQM1WVIDJwgrrwTUl5yyM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v10 16/27] pwm: jz4740: Drop dependency on MACH_INGENIC, use COMPILE_TEST
Date:   Sat,  2 Mar 2019 20:34:02 -0300
Message-Id: <20190302233413.14813-17-paul@crapouillou.net>
In-Reply-To: <20190302233413.14813-1-paul@crapouillou.net>
References: <20190302233413.14813-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_INGENIC prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

On other architectures, this driver can still be built, thanks to
COMPILE_TEST. This is used by automated tools to find bugs, for
instance.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
         v5: New patch
    
         v6: No change
    
         v7: No change
    
         v8: No change
    
         v9: No change
    
         v10: No change

 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4e201e970509..0c9b07cb77ff 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -203,7 +203,7 @@ config PWM_IMX
 
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
-	depends on MACH_INGENIC
+	depends on MIPS || COMPILE_TEST
 	depends on COMMON_CLK
 	select INGENIC_TIMER
 	help
-- 
2.11.0

