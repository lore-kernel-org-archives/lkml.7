Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88960C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E93B21907
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962526;
	bh=HPnogGGDgKAi/i75JMxxknHOrXn3DxmGD/sBlUEbxu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p0ZS5wmH30j8UTCn8JmRCR2z6qv6xoj5+iCDw5L4ZzIM/TGkreirw3JOOysXjImi3
	 XAieNNK9TrWfYo/WH0I3O4ejzdGTXSa6hUlJfLfSZ3IpD5qJbaPRrruyofzLwY1DSp
	 T1K4VUV8yIVTfW6YEZGUFe5pnkFaza3iMfv7QMCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfDVTsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbfDVTsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C428721907;
        Mon, 22 Apr 2019 19:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962520;
        bh=HPnogGGDgKAi/i75JMxxknHOrXn3DxmGD/sBlUEbxu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFxLVQTXV3/BQEgM9jveeyX/3PZWUq5PApidTxYbJHbwBz5d6nshMmRSTXivjGiX2
         GD++8z1Jcd5QCmA3Jg22xRGUlkYOzbwSeBRitxSMUbvIPM0EXWrxnXeegNXu3yGY6s
         Uk4D4J+k8uLzcFk2F2o0dt3PjfYopmgqqHF0Rj+g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 39/43] gpio: of: Fix of_gpiochip_add() error path
Date:   Mon, 22 Apr 2019 15:47:23 -0400
Message-Id: <20190422194727.12495-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit f7299d441a4da8a5088e651ea55023525a793a13 ]

If the call to of_gpiochip_scan_gpios() in of_gpiochip_add() fails, no
error handling is performed.  This lead to the need of callers to call
of_gpiochip_remove() on failure, which causes "BAD of_node_put() on ..."
if the failure happened before the call to of_node_get().

Fix this by adding proper error handling.

Note that calling gpiochip_remove_pin_ranges() multiple times causes no
harm: subsequent calls are a no-op.

Fixes: dfbd379ba9b7431e ("gpio: of: Return error if gpio hog configuration failed")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ee8c046cab62..d6ed4e891b34 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -499,7 +499,13 @@ int of_gpiochip_add(struct gpio_chip *chip)
 
 	of_node_get(chip->of_node);
 
-	return of_gpiochip_scan_gpios(chip);
+	status = of_gpiochip_scan_gpios(chip);
+	if (status) {
+		of_node_put(chip->of_node);
+		gpiochip_remove_pin_ranges(chip);
+	}
+
+	return status;
 }
 
 void of_gpiochip_remove(struct gpio_chip *chip)
-- 
2.19.1

