Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD27CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FD1214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811119;
	bh=HbsuwdOIgem/E0Mlci7TCiK8L+RXj1IGzfey9vqEvCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eWE+pSJOPfPT3BQeGDXvlp3LOkn9ShUNp0oUqVonE6A9ZHa2nM/TtYUjuAbiJEHtE
	 bU2fIKKc3JZOIkY6yBQjEyiysFLAmutDX10qWNGN3/2HXbk7Nxytrygqktfoor3vvz
	 /fD2kthSD5/p4fTCX0qLVQXzV6HQc8tBcnZUH2uA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfEBPb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbfEBPby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:31:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6600A20C01;
        Thu,  2 May 2019 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811113;
        bh=HbsuwdOIgem/E0Mlci7TCiK8L+RXj1IGzfey9vqEvCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItgcUYSBqnY+6Xvgh2QsxxieaUgwaDFaEa1fR+hNc002Nzl0ZKtxSePmXj8m/RnRY
         S3Gg7tySvqECIvfi0uQyTdesxXxUOUnjVKEmS3wQMKBW7V/AvzWwD7pirFXt4yEpnU
         e7zylUW0MaNSUyHyNqjVip4HyrsWtRLLi79TvvqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, linux-gpio@vger.kernel.org,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 080/101] gpio: of: Check propname before applying "cs-gpios" quirks
Date:   Thu,  2 May 2019 17:21:22 +0200
Message-Id: <20190502143345.235274686@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e5545c94e43b8f6599ffc01df8d1aedf18ee912a ]

SPI GPIO device has more than just "cs-gpio" property in its node and
would request those GPIOs as a part of its initialization. To avoid
applying CS-specific quirk to all of them add a check to make sure
that propname is "cs-gpios".

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index a1dd2f1c0d02..9470563f2506 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -119,7 +119,8 @@ static void of_gpio_flags_quirks(struct device_node *np,
 	 * to determine if the flags should have inverted semantics.
 	 */
 	if (IS_ENABLED(CONFIG_SPI_MASTER) &&
-	    of_property_read_bool(np, "cs-gpios")) {
+	    of_property_read_bool(np, "cs-gpios") &&
+	    !strcmp(propname, "cs-gpios")) {
 		struct device_node *child;
 		u32 cs;
 		int ret;
-- 
2.19.1



