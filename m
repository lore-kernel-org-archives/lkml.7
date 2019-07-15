Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8C9C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B9A21530
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199300;
	bh=DLo5pmgS/AdP/rgSpXt55DfVY/NaptcLWB2SMMvhlQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hgirbDvNBLyuC511XUUTwfw0Wjh+anrjwl0+CsPfverbF683VX8hiRUwQVi/jfj8C
	 dCaZ7g65TH2p5o/q9HnrSG1tRHs0isK48swoKNG0ReVdY/UJXMiJJM13hI3Ei9Jzhp
	 1z7FCGXPf/liIMyqTZQvSu3O7lDGqw7wTbDHpuRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbfGOOBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387477AbfGOOBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:01:31 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA4D1212F5;
        Mon, 15 Jul 2019 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199291;
        bh=DLo5pmgS/AdP/rgSpXt55DfVY/NaptcLWB2SMMvhlQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4eFGqzrzgg34L/G4Lrjl1JaIXX0AXLc0PzBjjy4RoEZopNGLvMO+txqfBSoE3lAL
         d4PbWzBbC9l00eERGBNxXRczfnZGjWb8lSPkHMa+ZbU9vse2ylSLJcyTqe1x20R+xP
         0wiXZ3rqwEsxsRmC7wefCaOx+VMzhYlCUiIE4Nck=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 228/249] gpiolib: Fix references to gpiod_[gs]et_*value_cansleep() variants
Date:   Mon, 15 Jul 2019 09:46:33 -0400
Message-Id: <20190715134655.4076-228-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

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
index be1d1d2f8aaa..bb3104d2eb0c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3025,7 +3025,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 int gpiod_get_raw_value(const struct gpio_desc *desc)
 {
 	VALIDATE_DESC(desc);
-	/* Should be using gpio_get_value_cansleep() */
+	/* Should be using gpiod_get_raw_value_cansleep() */
 	WARN_ON(desc->gdev->chip->can_sleep);
 	return gpiod_get_raw_value_commit(desc);
 }
@@ -3046,7 +3046,7 @@ int gpiod_get_value(const struct gpio_desc *desc)
 	int value;
 
 	VALIDATE_DESC(desc);
-	/* Should be using gpio_get_value_cansleep() */
+	/* Should be using gpiod_get_value_cansleep() */
 	WARN_ON(desc->gdev->chip->can_sleep);
 
 	value = gpiod_get_raw_value_commit(desc);
@@ -3317,7 +3317,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 void gpiod_set_raw_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
-	/* Should be using gpiod_set_value_cansleep() */
+	/* Should be using gpiod_set_raw_value_cansleep() */
 	WARN_ON(desc->gdev->chip->can_sleep);
 	gpiod_set_raw_value_commit(desc, value);
 }
@@ -3358,6 +3358,7 @@ static void gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
 void gpiod_set_value(struct gpio_desc *desc, int value)
 {
 	VALIDATE_DESC_VOID(desc);
+	/* Should be using gpiod_set_value_cansleep() */
 	WARN_ON(desc->gdev->chip->can_sleep);
 	gpiod_set_value_nocheck(desc, value);
 }
-- 
2.20.1

