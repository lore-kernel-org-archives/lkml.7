Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D6EC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0DA21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YFWb/OnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbfISJRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:17:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36702 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388820AbfISJRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:17:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id x80so1816093lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5jEgfLonWDOY4gG+bQfNvM3LOy7AfPuT16vQNF0Rko=;
        b=YFWb/OnKgEGSzwhOTk8kfD9okuzk0BzEGCLfTis5hVAJfxOgbf0kFsfDJOY3GC35Mm
         io9DQ9d0PWtExT99gqG2Eh0R31/mvlKOtoNGmK2XUeuFrcUx/aNk4BePlU/97Ikm3n1T
         7muS0OZKkkqB+4A84Pxo3WwqACT6GLrGbMKDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5jEgfLonWDOY4gG+bQfNvM3LOy7AfPuT16vQNF0Rko=;
        b=trGjgdE5YnIZepzX0Dga5/30BVqLgPg9xmvkrpCcSNRMlkMYaCyoUWhipr4BArokcb
         NbQJZUj3NWWToWtv7MeAA+L90hVf43mQk6fIoz+m0zIHB7MOaSroYBPfNQNoGwFx24gK
         39BEuJJMV6gFgtMee7K1ADAMXx/83B1yeD/1/ykNPal8Ny08150gaOtZsdC+MG/ot6Ys
         FKLVH/2INR7U66MwQESnOAchTU17/YsckZufL450ULtKV613Li4THm3UmDMhdtyEc6SX
         Z875aGdVwGJbTl6wO14rRHHt4BpgED+mAPqaY81CiOFd+uGluKL+ErRfmCt02YslhCsz
         gVzA==
X-Gm-Message-State: APjAAAWqwKFcEpZ4sQgwepgsXY+pyckaenBy5xkErs6boL8WqltspOJC
        162xfgipwDSJixzkTjOEdVi98A==
X-Google-Smtp-Source: APXvYqyR+914Hiw1xUs+Gf6+FLCIiUoW+UOwUI4tZt260/8zlZZWIulKWowmqIvYgV6xS0TfcnyIkA==
X-Received: by 2002:a19:14f:: with SMTP id 76mr4339385lfb.92.1568884657005;
        Thu, 19 Sep 2019 02:17:37 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x3sm1016789ljm.103.2019.09.19.02.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 02:17:36 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     David Wu <david.wu@rock-chips.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: rockchip: simplify rockchip_pwm_get_state()
Date:   Thu, 19 Sep 2019 11:17:27 +0200
Message-Id: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way state->enabled is computed is rather convoluted and hard to
read - both branches of the if() actually do the exact same thing. So
remove the if(), and further simplify "<boolean condition> ? true :
false" to "<boolean condition>".

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
I stumbled on this while trying to understand how the pwm subsystem
works. This patch is a semantic no-op, but it's also possible that,
say, the first branch simply contains a "double negative" so either
the != should be == or the "false : true" should be "true : false".

 drivers/pwm/pwm-rockchip.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 51b96cb7dd25..54c6399e3f00 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -83,12 +83,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 	state->duty_cycle =  DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
 
 	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
-	if (pc->data->supports_polarity)
-		state->enabled = ((val & enable_conf) != enable_conf) ?
-				 false : true;
-	else
-		state->enabled = ((val & enable_conf) == enable_conf) ?
-				 true : false;
+	state->enabled = ((val & enable_conf) == enable_conf);
 
 	if (pc->data->supports_polarity) {
 		if (!(val & PWM_DUTY_POSITIVE))
-- 
2.20.1

