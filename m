Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3927AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FB9218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="nc1bnd/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCUWP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:15:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42377 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfCUWP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:15:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id b74so89364qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzWqXzu0MES7QWDiYCfpkzfd1rAbmIZUJfKN+nnjS/Y=;
        b=nc1bnd/bYIpsne+BA2hNY/EpznTwIrVkkrE8XgzwsKYLkXb/Sr/cNeKH9XO7JXrJCe
         pj6NNuUwYjWNhwgIfAtl1NydbcNsNVpxGFPMnrDYk8Dj3RQHElxJFcgHDz8bWvyQ2oku
         ozryoukt2aGmXsmLpf/GhwFhf+yZlGQMUcvvASm0ulWTJTSlcJH6f8pv9DnHgRwQVZKF
         O0kpstz/Vy0oCtL5rqr8cQBBRjVguG5/3Z1JcPMk4YH3B3UPGutQ0KGlHwIbwicGWey+
         tOBsNnDaHNoITnRzI38dEcds+3l9U6cSxye2Dx93+/RI2I1TALUl32ir9B3iYA8v3cTL
         TXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzWqXzu0MES7QWDiYCfpkzfd1rAbmIZUJfKN+nnjS/Y=;
        b=FnuX5ZrERh2tzyUWHcuo3dTyOwLtJZxdrQa1s6SGEJlVTgevnQwRmZKTIcrscxj+fk
         OBViJ4TG5i+I0Jwr3Q+djjM6X21kY8SDaNsMQUSk2xj/gQRqzZaTKFelw+TnymwTZi19
         mTTGRZr/HM1+1D3x96XoGP6dpuik5qVqyaaoVF6iVZ6qp9CY0ZxxmzarUqp2MarLQBRH
         69KbEnIJH6IC/X7aSkqR4WYWxTnaR4kKb4kJ/XwPZyWnEQqm1G/yb5w60QjXFW+AXUwW
         7O67c9HfPEENuNRpZuxmnhdT21BsgQKnsaZ2GWzNGYhVePstPBSzK+VWyW/c+fIw4SAD
         JfoQ==
X-Gm-Message-State: APjAAAXNSuYo93aoENrEzcVeuaSt9wf4LmJj6yqYSIW9UWcLryGQovgg
        ay9rBMUF38+beUeDM2iubQlWUg==
X-Google-Smtp-Source: APXvYqwfVganjXK59RsLZeRjA3BMwI6AWyUnr7KzPMR6P4SuDy557nWicnZ3M27l3TFPGFWvZHEGjQ==
X-Received: by 2002:a37:c15:: with SMTP id 21mr4852630qkm.50.1553206555276;
        Thu, 21 Mar 2019 15:15:55 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id w37sm3895968qtw.27.2019.03.21.15.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:15:54 -0700 (PDT)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc:     Bob Duke <bduke@criticallink.com>,
        Mike Williamson <michael.williamson@criticallink.com>,
        Greg Gluszek <greg.gluszek@criticallink.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Misael Lopez Cruz <misael.lopez@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] ASoC: tlv320aic26: Allow tlv320aic26 to be selected in menuconfig
Date:   Thu, 21 Mar 2019 18:15:43 -0400
Message-Id: <20190321221549.13765-2-jcormier@criticallink.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without a description you can't select the device in menuconfig
Set depends to SPI_MASTER to match conditional in SND_SOC_ALL_CODECS

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 419114edfd57..cd697a015819 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1087,8 +1087,8 @@ config SND_SOC_TLV320AIC23_SPI
 	select SND_SOC_TLV320AIC23
 
 config SND_SOC_TLV320AIC26
-	tristate
-	depends on SPI
+	tristate "Texas Instruments TLV320AIC26 audio CODEC - SPI"
+	depends on SPI_MASTER
 
 config SND_SOC_TLV320AIC31XX
 	tristate "Texas Instruments TLV320AIC31xx CODECs"
-- 
2.21.0

