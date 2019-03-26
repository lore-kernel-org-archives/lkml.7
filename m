Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85913C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561B320823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582115;
	bh=pytmc5e5A/N1LDPGJnbccu+mopuE/ovOD+0eBNYCz0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y86SzW3cCzZoiWmZXNqzdEoBNPNutXgNa7TbDRu6YYPsMlZekuJwMe/ou0ORKOXQd
	 ZKnW6wt72xRlfxnurb8bm51yErHetJAmZqTwoSx3colIAXd091soejTWrl2dzs5x5/
	 CLPdtKixgb/FwHyka5E0yp+rF53TT1IHX7TuYv0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbfCZGfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731603AbfCZGfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:35:09 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CEF420879;
        Tue, 26 Mar 2019 06:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582108;
        bh=pytmc5e5A/N1LDPGJnbccu+mopuE/ovOD+0eBNYCz0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqCoMzi+5C5ih3z9OW3ZJeXJSdxY4jzVgithkRBvWhvV+Y2Gdc/O8slx3D3P2V+t3
         SSxrqibjxPOuoorxX5AQzgwLMOnA893JtCpxk1KxPo1Zju3c0iTttd/l9pntENWXMh
         i8T5z4uvQCUXuVgpZjPSqP2EqM+1Etw54NQpCzqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 39/41] pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.
Date:   Tue, 26 Mar 2019 15:30:16 +0900
Message-Id: <20190326042652.013337030@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

commit 5fb5caee92ba35a4a3baa61d45a78eb057e2c031 upstream.

Before this patch the enable signal was set before the PWM signal and
vice-versa on power off. This sequence is wrong, at least, it is on
the different panels datasheets that I checked, so I inverted the sequence
to follow the specs.

For reference the following panels have the mentioned sequence:
  - N133HSE-EA1 (Innolux)
  - N116BGE (Innolux)
  - N156BGE-L21 (Innolux)
  - B101EAN0 (Auo)
  - B101AW03 (Auo)
  - LTN101NT05 (Samsung)
  - CLAA101WA01A (Chunghwa)

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/backlight/pwm_bl.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -54,10 +54,11 @@ static void pwm_backlight_power_on(struc
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
 
+	pwm_enable(pb->pwm);
+
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 1);
 
-	pwm_enable(pb->pwm);
 	pb->enabled = true;
 }
 
@@ -66,12 +67,12 @@ static void pwm_backlight_power_off(stru
 	if (!pb->enabled)
 		return;
 
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
-
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 0);
 
+	pwm_config(pb->pwm, 0, pb->period);
+	pwm_disable(pb->pwm);
+
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
 }


