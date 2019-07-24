Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB81C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2327B22AEC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997963;
	bh=hLJwoxGCEhIXliv/Juh+dWJj8SLc20uVUGBu7kODr2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Fx3HU8URXHXuhvcpOFcmKfTdasABcFBcdQ9ooNPhp/iQsF+CDeDqvhN0nPMJNuh5
	 5GWqajE+Qx+hp4LCsV6Fjw5izXMzhixD+kl7ZsFHZVQ3mi4LZI/RrmNKXO8WyDkDh7
	 0s4wB13ql2xbpSTFI2hkFGpnNzulTDupowS67eZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391761AbfGXTwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391751AbfGXTwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:52:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4FF217D4;
        Wed, 24 Jul 2019 19:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997959;
        bh=hLJwoxGCEhIXliv/Juh+dWJj8SLc20uVUGBu7kODr2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9yVrAndBuJ4NiABLN7/6bgm4A9QPBULKgymERvK/oVxJi9Z+RcXb8fX83Vu8N3bz
         NF1HtBr9XE25Hl7+4gV2ujPNsa915y/X3o8exzvmEhRs9OqChVsztVE5d702rNrCOX
         QSE7EYuBrBvfOBqK/NPS8jbFCPWjTvIpMy8uwbUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 200/371] gpiolib: Fix references to gpiod_[gs]et_*value_cansleep() variants
Date:   Wed, 24 Jul 2019 21:19:12 +0200
Message-Id: <20190724191739.772267703@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3285170f28a850638794cdfe712eb6d93e51e706 ]

Commit 372e722ea4dd4ca1 ("gpiolib: use descriptors internally") renamed
the functions to use a "gpiod" prefix, and commit 79a9becda8940deb
("gpiolib: export descriptor-based GPIO interface") introduced the "raw"
variants, but both changes forgot to update the comments.

Readd a similar reference to gpiod_set_value(), which was accidentally
removed by commit 1e77fc82110ac36f ("gpio: Add missing open drain/source
handling to gpiod_set_value_cansleep()").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20190701142738.25219-1-geert+renesas@glider.be
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fd1344056e1d..b8a5c1e3b99d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3012,7 +3012,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 int gpiod_get_raw_value(const struct gpio_desc *desc)
 {
 	VALIDATE_DESC(desc);
-	/* Should be using gpio_get_value_cansleep() */
+	/* Should be using gpiod_get_raw_value_cansleep() */
 	WARN_ON(desc->gdev->chip->can_sleep);
 	return gpiod_get_raw_value_commit(desc);
 }
@@ -3033,7 +3033,7 @@ int gpiod_get_value(const struct gpio_desc *desc)
 	int value;
 
 	VALIDATE_DESC(desc);
-	/* Should be using gpio_get_value_cansleep() */
+	/* Should be using gpiod_get_value_cansleep() */
 	WARN_ON(desc->gdev->chip->can_sleep);
 
 	value = gpiod_get_raw_value_commit(desc);
@@ -3304,7 +3304,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 void gpiod_set_raw_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
-	/* Should be using gpiod_set_value_cansleep() */
+	/* Should be using gpiod_set_raw_value_cansleep() */
 	WARN_ON(desc->gdev->chip->can_sleep);
 	gpiod_set_raw_value_commit(desc, value);
 }
@@ -3345,6 +3345,7 @@ static void gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
 void gpiod_set_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
+	/* Should be using gpiod_set_value_cansleep() */
 	WARN_ON(desc->gdev->chip->can_sleep);
 	gpiod_set_value_nocheck(desc, value);
 }
-- 
2.20.1



