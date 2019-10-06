Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F3EC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 04:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B35F2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 04:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mT58WraE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfJFEnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 00:43:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42184 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfJFEnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 00:43:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so6363228pff.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 21:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O9DS1pnBfgmugCUm9X9KTPp9NfZzZz5SWHJyycSHOa8=;
        b=mT58WraESphLJi1YCTvdXwLK4HZ+G+XXhBacRETPW8JOgN3S7kFkm9n/heVUasoAKS
         eYfuhgYINyTf8aK5G/fzyOnntkIaQNCWhViL/nyY1TKoBBQP8fVYwZoBW4O/BRlN/gER
         Tnkjj6AXJqlueRhFuH9ludKHb9Q+OoB6KL6wLJ3QJsA+7zF7o9/zQVCyVuW1QMiCQG4Y
         s7XRdSCmObHhK8LXOEfPN30nHUEZm2hXBHaMu0P8wBL3cmGP9issZ9u7n71Ivy+kR6mz
         mOReCVGTSzKoP1GFpGGqnDpvdQpbUPg1L0U3eiFeGmg3FtjPT+WXRwBwP5xEUt1YXEAy
         hekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O9DS1pnBfgmugCUm9X9KTPp9NfZzZz5SWHJyycSHOa8=;
        b=TV5GTCaDWT0v8qBV1gMbcfUw7AsclpoGCbc+JZp4PWl6toREEOSUimd0nOK7torBWe
         vVW6cZhHYnPdEY9QFdLf+BYa7a4RSpyB89KkwerSJjWmhbTwgIydBy7eiKxy1HWg3r0O
         pRomZrMkZjOeLQZVjmBgnhPEXVFYd2zy3AaMST8M2mUPQSMGRjiFPi3Bf7zmuRBHb7AE
         xkxBwNg7HnmGMYL/2vpe+HXYSC0Rh2yWwg6y26QjY1B9KPAkG4AbGtcr48n+s+Bq/lyl
         pmH59zg8aoram77U02a+2Algm+lfITnZXMWUbOUdS8lFmBod8vx8jKdEi21pfdv41N6v
         zpKQ==
X-Gm-Message-State: APjAAAXl60h3G4eheAdzSiKhwlKiyDrtSO20xNPysu3oVL0SiCthtx1D
        HAshGGdAey7sOcGb/Q5xDaL1PQ==
X-Google-Smtp-Source: APXvYqyLpc5tvMaDdt2mWljW9j21Zq9//Fs8mt7wJ5+bP4PVVJoqyMexxAA46O4wXBov/mCGCwr+jg==
X-Received: by 2002:aa7:96b8:: with SMTP id g24mr26938028pfk.163.1570337011730;
        Sat, 05 Oct 2019 21:43:31 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s5sm8157384pjn.24.2019.10.05.21.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 21:43:31 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: Fix kerneldoc for apply operation
Date:   Sat,  5 Oct 2019 21:43:26 -0700
Message-Id: <20191006044326.12043-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the @state passed to apply() is now const the comment in the
kerneldoc about drivers being expected to adjust the parameters is no
longer valid. Update it to reflect the API change.

Fixes: 71523d1812ac ("pwm: Ensure pwm_apply_state() doesn't modify the state argument")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 include/linux/pwm.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b2c9c460947d..8bc86f645d0d 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -243,10 +243,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  * @request: optional hook for requesting a PWM
  * @free: optional hook for freeing a PWM
  * @capture: capture and report PWM signal
- * @apply: atomically apply a new PWM config. The state argument
- *	   should be adjusted with the real hardware config (if the
- *	   approximate the period or duty_cycle value, state should
- *	   reflect it)
+ * @apply: atomically apply a new PWM config.
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
-- 
2.18.0

