Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0635C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7F12070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6UrKbwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbfCZGrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:47:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41941 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731424AbfCZGcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id y5so1154943plk.8;
        Mon, 25 Mar 2019 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n05gdPWRHIhq08sP8yadS4QZFNVpNhYfEvGLwxji304=;
        b=T6UrKbwQwBjelzKo7rb3pkZWlWmw9c0XJEcNC7/gN94XejFKO22wdHyNubGb+aIgtr
         IshD101Q2bOBPFbw2jssCPHg3SjFsz3WfARvs26Sf9swrlRk8qkkG8sKGnzTrQ5ROYBw
         q8eDHiFRrRxreX4CAERqu776eqfU6m1fqbjuwfpQgSSAUdVdzZbu7YveL1VY9Q4qx5Er
         78H09UUGLWkHW6QWHK1N1ASqolmtR9DoICBQpHg4ohx4TQrA3CtlqufR5dUnHkx6viyB
         gmhKPZ9wqGXYkbxRvhgCXu2m35BxkNWN8gcSlO6hdBJ74yVRIb9DPan7YfWtm/N396xq
         Qo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n05gdPWRHIhq08sP8yadS4QZFNVpNhYfEvGLwxji304=;
        b=SZQmBbBu1OPZdmvW3QWNI15szxcGne4xDs2R76PWbYvDk3lQsy3TpM5YL7Y6jj0gat
         PyGKEqktgrpnpWDn885Rcmav8JO+eaYgRFvsDoCkKSz7ovlETSyp4jyK4HLab9FaMwd7
         7iyoeL20b3w2h+6UNqmcukZzI30VZDOv3GryQN0ZszP3ZXmBgqnISEnqokhIOwaRMhYZ
         jZvFby5n57bwedEtQXHFnAOLpZDQ6/me4AwvcLK8CHJbEtY0TZQvWCdS6KYQOcBp7Tl4
         UiNmRyNJ5y9fxarZB52zW4OmQVQGmTPgvwopbW5ZZZwbErd0emJ5RnVaHuLY3N7RnmrX
         380w==
X-Gm-Message-State: APjAAAXh2yjwRmHfRiawUUgVjb82Ei/W6HpeFliYGM7yK0vHeSf2v2dS
        3ROS2zF03B1fsjYr7uQhmAkcYH2T
X-Google-Smtp-Source: APXvYqzoApkmLuhFJGAEmF8XZNHnm2birP7PbdXmPzJShszmEEZKW0fzcjzJEGmeFIp7S8AN0HS89A==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3mr11979261plb.153.1553581943385;
        Mon, 25 Mar 2019 23:32:23 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id m10sm20096573pgq.42.2019.03.25.23.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 23:32:22 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] gpio: of: Check for "spi-cs-high" in child instead of parent node
Date:   Mon, 25 Mar 2019 23:32:09 -0700
Message-Id: <20190326063209.6421-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326063209.6421-1-andrew.smirnov@gmail.com>
References: <20190326063209.6421-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"spi-cs-high" is going to be specified in child node of an SPI
controller's representing attached SPI device, so change the code to
look for it there, instead of checking parent node.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpio/gpiolib-of.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ee7f08386a72..0220dd6d64ed 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -143,16 +143,16 @@ static void of_gpio_flags_quirks(struct device_node *np,
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
2.20.1

