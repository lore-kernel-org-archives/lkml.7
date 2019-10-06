Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E90BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126B520862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383724;
	bh=oZ/CdR4pk54TSdx6nW2duEampafCF/90uNe4q3GZa9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dmY7sJdzamd/tgPHghf3YQbNyaAkX60vheGTQbRnbZyloo0SvMt+LyP5Rc0GXZzgn
	 zsW5MAw+yUTq9vQOcS+9E9wYycaSCcjsGbBszF3BQbzA2BNElB9vurUjtzMaz1ysLM
	 LQXnXftHZLRnMper41+tUo9xdn6lX28QHDXPMu1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfJFRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730882AbfJFRmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:42:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07FFC20700;
        Sun,  6 Oct 2019 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383719;
        bh=oZ/CdR4pk54TSdx6nW2duEampafCF/90uNe4q3GZa9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4cVwoFEe7dqN2L4qq1ne4ePPgRb99YYoW0xOOg/MIbu8ltHB/GYfdyGnbkMPQ9F7
         IY5ikJY8thQ+ZqsoYigAL7zPnADtMYUZHkdVDQhN9kyvI/6D44OpUaxyHgLhVvlsox
         Mujk4oyX9jXKI8r1072LRHUreW5xaJOUYlVZNJ1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 069/166] ARM: dts: dir685: Drop spi-cpol from the display
Date:   Sun,  6 Oct 2019 19:20:35 +0200
Message-Id: <20191006171219.185398266@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 2a7326caab479ca257c4b9bd67db42d1d49079bf ]

The D-Link DIR-685 had its clock polarity set as active
low using the special SPI "spi-cpol" property.

This is not correct: the datasheet clearly states:
"Fix SCL to GND level when not in use" which is
indicative that this line is active high.

After a recent fix making the GPIO-based SPI driver
force the clock line de-asserted at the beginning of
each SPI transaction this reared its ugly head: now
de-asserted was taken to mean the line should be
driven high, but it should be driven low.

Fix this up in the DTS file and the display works again.

Link: https://lore.kernel.org/r/20190915135444.11066-1-linus.walleij@linaro.org
Cc: Mark Brown <broonie@kernel.org>
Fixes: 2922d1cc1696 ("spi: gpio: Add SPI_MASTER_GPIO_SS flag")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index bfaa2de63a100..e2030ba16512f 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -72,7 +72,6 @@
 			reg = <0>;
 			/* 50 ns min period = 20 MHz */
 			spi-max-frequency = <20000000>;
-			spi-cpol; /* Clock active low */
 			vcc-supply = <&vdisp>;
 			iovcc-supply = <&vdisp>;
 			vci-supply = <&vdisp>;
-- 
2.20.1



