Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A89DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A2721743
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB2uNyqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfHNGJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39082 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfHNGJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id x4so11572727ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=go+1BvHiZ551s7lZZtvzU+7HaWl7o/QBHe+MvPdzMnE=;
        b=DB2uNyqKpzDzXvdgtr4TdYqx4FJ1xEsqNOfYwtyOdiyN8bmElVFNz5Y0QHN1tZwHJL
         ZXY6ddKq6RNyTtLEScnryGITuQ2rSc7wS22yci9vy2R9CSaQkY8MKwQFjpeteP/M/Omw
         tFid6mUmH+6ES71/fxOTcUTKhdvsMaMffcuT3R5VQabk+OkUA2QSwkWXOOuWJv5KDTW0
         6116/1ms5skkFH9i9nYOIHmFg9rbrfrl9fNN29VHkWjywexztmApeKsSGr0jpCHcZTk2
         dDqGTu0sAKnTbkJI25Cx1tuShn5R9x6mjRiPrbgg/FTD4nmEJRMr+CHxt3UqAKqmfSXN
         yzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=go+1BvHiZ551s7lZZtvzU+7HaWl7o/QBHe+MvPdzMnE=;
        b=CbBo3+iY4527N4MPSLSWvdd9X1Hmch3uayAAE4heomW9Lf9xHjz+tdGQj1MTMt2VEL
         AYM6UBBFDDMYE4bOdnK8Q4lWORqn+cuSLXurmaTXk+n6wGqlfbKhaClRFZLMRX9QMcF6
         c/GuUt5K+e0P1lAQA5slK2HLZ7cwEgkwT4dCyJsVLp7YgY0aPwXqQutfdLq5Ws4ZMEAG
         yZPaPcV60cRFUAW8SnZ1TtkvVV7NKIzkiu+rc/s0PdZlqPIsZsnZ0ITx+xbjNyRmMDUc
         8qa2UQOJGC73vL0HoHr/h4i0djqIaUedKJMgqw6NiF5h6+xSEOxjFbJ7zdfIJ8Iqq2Xz
         nksQ==
X-Gm-Message-State: APjAAAU9oRgdND15/mJzOsfLtSREEIOwxqB+N5A4aCc3K0ZdwDUTniFD
        mjacPzaTflq37kLTvrQF8zA=
X-Google-Smtp-Source: APXvYqxke6on79/JFb/mW5nqF0uOU5tx+pV8+KsdaUpiYfd+xIeG5MpxPdARsgAB0SJSFsZtf1z0sw==
X-Received: by 2002:a2e:9b84:: with SMTP id z4mr24044973lji.75.1565762952729;
        Tue, 13 Aug 2019 23:09:12 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:11 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v5 09/15] clk: sunxi-ng: h6: Allow I2S to change parent rate
Date:   Wed, 14 Aug 2019 08:08:48 +0200
Message-Id: <20190814060854.26345-10-codekipper@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814060854.26345-1-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

I2S doesn't work if parent rate couldn't be change. Difference between
wanted and actual rate is too big.

Fix this by adding CLK_SET_RATE_PARENT flag to I2S clocks.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index aebef4af9861..d89353a3cdec 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -505,7 +505,7 @@ static struct ccu_div i2s3_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS("i2s3",
 						      audio_parents,
 						      &ccu_div_ops,
-						      0),
+						      CLK_SET_RATE_PARENT),
 	},
 };
 
@@ -518,7 +518,7 @@ static struct ccu_div i2s0_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS("i2s0",
 						      audio_parents,
 						      &ccu_div_ops,
-						      0),
+						      CLK_SET_RATE_PARENT),
 	},
 };
 
@@ -531,7 +531,7 @@ static struct ccu_div i2s1_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS("i2s1",
 						      audio_parents,
 						      &ccu_div_ops,
-						      0),
+						      CLK_SET_RATE_PARENT),
 	},
 };
 
@@ -544,7 +544,7 @@ static struct ccu_div i2s2_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS("i2s2",
 						      audio_parents,
 						      &ccu_div_ops,
-						      0),
+						      CLK_SET_RATE_PARENT),
 	},
 };
 
-- 
2.22.0

