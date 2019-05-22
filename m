Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B18C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449F82070D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="aFDd3I8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfEVRF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:05:27 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42604 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfEVRFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1558544723; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=V7HGf+8SOAYjYlQYSvXaU6vyPC5P7uEHXfZySQIJbos=;
        b=aFDd3I8r+imBy4uQvOyaAS+lVDgmMBbDEaisJrHJz+J0qKeVt/eBEvN/8B1dwjm3H6uk4R
        Ho71v9TBWFAUNJcB1DSyTDIsBnZq5VAaz/Vez/MMBD/AVsrNr7HxcjQYfklVJdnBKnX5TR
        gWZetg8bXpmpxFwf6F6OWC3bxpHvbu8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     od@zcrc.me, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] i2c: jz4780: Drop dependency on MACH_JZ4780
Date:   Wed, 22 May 2019 19:05:16 +0200
Message-Id: <20190522170516.15086-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_JZ4780 prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 26186439db6b..bfb1d05248dc 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -691,7 +691,7 @@ config I2C_IOP3XX
 
 config I2C_JZ4780
 	tristate "JZ4780 I2C controller interface support"
-	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	help
 	 If you say yes to this option, support will be included for the
 	 Ingenic JZ4780 I2C controller.
-- 
2.21.0.593.g511ec345e18

