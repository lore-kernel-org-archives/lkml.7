Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ABFECE58B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5585B2190F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TjVT0D6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfJBJP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:15:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35619 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJBJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:15:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so6138244wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPzLmAFxVlvoWlrn/cPfzD8ybuBQrABYqNe+NltmaKc=;
        b=TjVT0D6D0IDve5evcKRh6oxGsg70BRR503/nwR27ckewQi1eA7EoYNYe69MKOT/mrw
         IwsSwedW0AarjTBKsAb5oEBFz6Wuj7bBy4CaR+nE1y5oYJEF1aFYT3TCv3aURhSHLVev
         VbcjX+F0OBK8G78rKEhs59ebi0KtuuuszxbZcFfphI7Im+mEOzBs3nJbkzBbrlxsQLts
         fBoaZluHMUnbkFpavdfrqISEOvILhKJDwiEW8A9536Afgrhj7uQoUmOolVhaqh0yo17z
         LlXhY43TWJNBti5XJbAIX3Z0FYOWaRJh6zEPPYftj10rasuNDz7noeB1U6dzImMEq/vx
         MjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPzLmAFxVlvoWlrn/cPfzD8ybuBQrABYqNe+NltmaKc=;
        b=OC4LyvgokKsMOEbIwoIMnFwiqRsKGnj1izNZACP3CJdXDwE4ElNOdC/1q5625BR0pY
         v14oLvPk8JSRJtoGYQKN99HEj+tRbRH0Yney4Yfqpeqyy4dBRmwZGKW44oov2J1GuPq2
         4LrLzA/ChhyyPDaiO43/8nTDmhTThUKsGMChdfn5rBpgG0TtutlASyPkBcZE6jAWaVOZ
         376yMyQhw7qBOsgKCH8QLeObayIGOa2c3HcqGgfZSQ19g0Ad1c8RWoB18co/7W7lTop7
         VgpvR7a522p+jsW5W3eaDpttuCYPlqjoB9FheNQW86TsmqHvydunlVGKHEeBDLSPGYKI
         w9Xg==
X-Gm-Message-State: APjAAAVb3SLUW2fLjghWz+qf9pY/wWP5K/mS4I78PEswB/ynF7hxjLCY
        No6wWA/bv7/ISae8z0avePyY0Q==
X-Google-Smtp-Source: APXvYqyAeNIzYfZDnXVDS34M/KFIdc9BCM3rsZxBblu5PD/ay+OI5yEHpjToOgd8l9an0xWnyWUp6Q==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr2060315wml.169.1570007734515;
        Wed, 02 Oct 2019 02:15:34 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r13sm32913737wrn.0.2019.10.02.02.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:15:33 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] dt-bindings: clock: meson: add sm1 resets to the axg-audio controller
Date:   Wed,  2 Oct 2019 11:15:24 +0200
Message-Id: <20191002091529.17112-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002091529.17112-1-jbrunet@baylibre.com>
References: <20191002091529.17112-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset id of the sm1 audio clock controller

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../reset/amlogic,meson-g12a-audio-reset.h        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
index 14b78dabed0e..f805129ca7af 100644
--- a/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
@@ -35,4 +35,19 @@
 #define AUD_RESET_TOHDMITX	24
 #define AUD_RESET_CLKTREE	25
 
+/* SM1 added resets */
+#define AUD_RESET_RESAMPLE_B	26
+#define AUD_RESET_TOVAD		27
+#define AUD_RESET_LOCKER	28
+#define AUD_RESET_SPDIFIN_LB	29
+#define AUD_RESET_FRATV		30
+#define AUD_RESET_FRHDMIRX	31
+#define AUD_RESET_FRDDR_D	32
+#define AUD_RESET_TODDR_D	33
+#define AUD_RESET_LOOPBACK_B	34
+#define AUD_RESET_EARCTX	35
+#define AUD_RESET_EARCRX	36
+#define AUD_RESET_FRDDR_E	37
+#define AUD_RESET_TODDR_E	38
+
 #endif
-- 
2.21.0

