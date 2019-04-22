Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF33C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337D2204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963591;
	bh=odWBMkjyPNnuRw+4KE3xweDXxMT1ig2KF9W94YGphSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2AbwrpEqo79URevvwy9jIbnGZMapHOjJAz78LYVy+kgjlyKaP4uEyXdlknltiCghr
	 UTKn3Ezm4V+pl1Y/3QYaRhpozVJEG18HB89pZVGZzCvCnaVXc6nux/cr9ZHRrHpbxi
	 dyHZPRh2iga4iBhGmhFewP+9vOPwPfguH5W6Hghw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbfDVUG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbfDVTob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49529217D4;
        Mon, 22 Apr 2019 19:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962271;
        bh=odWBMkjyPNnuRw+4KE3xweDXxMT1ig2KF9W94YGphSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFhs0KMtCgAWzzdTTG/G5HR70YcFpaSUsUVpjJmiZ/8q0weuZVDACrn0TM5eMiD/S
         +kz3xNTtVeVSO6XJIThdWNsRd0s6ez6Im1egqfjo3VtCDMTlhL8BAERuf6oW6YOrzq
         E9LkRZG1w4GoIZ4o3Aj8b1iowG68DWl6QPrHsc+s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, linux-gpio@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 78/98] gpio: of: Check for "spi-cs-high" in child instead of parent node
Date:   Mon, 22 Apr 2019 15:41:45 -0400
Message-Id: <20190422194205.10404-78-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

[ Upstream commit 7ce40277bf848391705011ba37eac2e377cbd9e6 ]

"spi-cs-high" is going to be specified in child node of an SPI
controller's representing attached SPI device, so change the code to
look for it there, instead of checking parent node.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 9470563f2506..f1ae28289a67 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -142,16 +142,16 @@ static void of_gpio_flags_quirks(struct device_node *np,
 				 * conflict and the "spi-cs-high" flag will
 				 * take precedence.
 				 */
-				if (of_property_read_bool(np, "spi-cs-high")) {
+				if (of_property_read_bool(child, "spi-cs-high")) {
 					if (*flags & OF_GPIO_ACTIVE_LOW) {
 						pr_warn("%s GPIO handle specifies active low - ignored\n",
-							of_node_full_name(np));
+							of_node_full_name(child));
 						*flags &= ~OF_GPIO_ACTIVE_LOW;
 					}
 				} else {
 					if (!(*flags & OF_GPIO_ACTIVE_LOW))
 						pr_info("%s enforce active low on chipselect handle\n",
-							of_node_full_name(np));
+							of_node_full_name(child));
 					*flags |= OF_GPIO_ACTIVE_LOW;
 				}
 				break;
-- 
2.19.1

