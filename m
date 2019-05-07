Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EADC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BAE204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208141;
	bh=VRtGhhfvENSk8MY3OOpOVHVA92UpWAu95L5vA/T4aGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gXpaYhNUvr34RMZbtxDtNxa4/aIQ2GKG4Nc8d4pZNnNaH11yVqvU2fWWHo82aYIV4
	 TvT/mo7G1TZxyMZo37WQhSA/74WDg9ZFDH0kiJGH1cAz0VTq4iHf150c8b36yHGq8z
	 asIco6paApWBZ24J+cCTnwvsaMjRvrxDIcOE4ljE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfEGFkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbfEGFk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:40:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F12FB20675;
        Tue,  7 May 2019 05:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207628;
        bh=VRtGhhfvENSk8MY3OOpOVHVA92UpWAu95L5vA/T4aGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfCLMjBfimSrl+6hRlsICl8+sTs8uGacnlQdSRvhKdM+kULeMJPYCeSKk9B/mrneO
         58eD0ZUs6jH6A1HILb2cd0797yM9+lNvWmyQzGmdMusVQSMUtD2TcxREZWKy2WgWVB
         fwbeSCFremyK7eijYM+Y4RbYeOLLhoocs8CAcMA0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-leds@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 66/95] leds: pwm: silently error out on EPROBE_DEFER
Date:   Tue,  7 May 2019 01:37:55 -0400
Message-Id: <20190507053826.31622-66-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 9aec30371fb095a0c9415f3f0146ae269c3713d8 ]

When probing, if we fail to get the pwm due to probe deferal, we shouldn't
print an error message. Just be silent in this case.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/leds/leds-pwm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 8d456dc6c5bf..83f9bbe57e02 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -101,8 +101,9 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		led_data->pwm = devm_pwm_get(dev, led->name);
 	if (IS_ERR(led_data->pwm)) {
 		ret = PTR_ERR(led_data->pwm);
-		dev_err(dev, "unable to request PWM for %s: %d\n",
-			led->name, ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "unable to request PWM for %s: %d\n",
+				led->name, ret);
 		return ret;
 	}
 
-- 
2.20.1

