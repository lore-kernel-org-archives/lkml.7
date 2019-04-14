Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6109BC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C56820896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3xf/BBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDNSfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:35:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34516 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDNSfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:35:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so7479488plt.1;
        Sun, 14 Apr 2019 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ieKsljjbAwxH7pp36Hh7KqVH3DSOT/7yn21e/IKxtsE=;
        b=E3xf/BBnGIbHHwyqyojUntx5F8z2dktDzkYX/LtkLLwx9shSXV+FbEvZreUc4oJwMW
         s5zXF+b/67DFMnX4orEToAbbebQ0bBX4gJfDVr/I8sdzoqRzFmfQ2HAznLR25MgMZpAv
         uFif2ebj2EyEi5KCclVTjXHHIQohkljoST3C8AQc4We6s93ophmnTRtKEfVz+lT//ZCP
         VNRk57DutsEjuIITT5ij/XtZi3fmfqboEQfpG2rayJEd+JQ0l4o8M3f8Rbjifky7TLl/
         ub1RfRzqOAuUlf58yNuWMixFXX4yv4I36YCvHvVBa0wUqRklVP/S2YEgF3q3dB7g0HhS
         A8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieKsljjbAwxH7pp36Hh7KqVH3DSOT/7yn21e/IKxtsE=;
        b=leHu5klnOpAVEyxHctMnSPsqcj/jnog70xAADUP6dM0l/dqnYOkelSiWX2Zs9EY8u3
         AylWuGfJ6J2GqZ0TYf5R1xeH6UAugw0706opGe8vTvpaaaBbYhRo3Zs8ogS4UqoR6buH
         i5WIxp+/estmC9TZQljdn1xdXkFcI3kzq9lLxCAehr2ITZ06Cv8x+GMH94R3sPq6pdOJ
         jufCzKjYj16ouMB3yYeTnoTlfRvyhs7xIbjwhWqTolPb4MuFLUfO295hv1LcD8WfnaPL
         J6J04Dm8LA9r839tecLNyMEIC7NbUptRguPgBtviFlIqPuEe3cg4ly7S2zH9nDtYISnI
         LKgw==
X-Gm-Message-State: APjAAAXZCAZHdi6+kBe/z1tTrECjP5Nk9/ectWN6wK1mGBa50OC0bUmj
        G1n2V9MniIfBu7W4cGD/+L1I/vdH
X-Google-Smtp-Source: APXvYqwIRGLo6hiQ6ZY3L/HirwTe7DFoZi5scgQj60Qer5xua29iWLs7zyXMPwwGjht1DXUPC+d+kA==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr68349502plq.97.1555266913442;
        Sun, 14 Apr 2019 11:35:13 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p7sm83791758pfp.70.2019.04.14.11.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:35:12 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] iio: imx7d_adc: Replace pr_err with dev_err
Date:   Sun, 14 Apr 2019 11:35:00 -0700
Message-Id: <20190414183504.23286-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414183504.23286-1-andrew.smirnov@gmail.com>
References: <20190414183504.23286-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace combination of pr_err()/dev_name() with an equivalent call for
dev_err().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/adc/imx7d_adc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 3bbd657409d5..72cfe9834bcb 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -388,8 +388,9 @@ static irqreturn_t imx7d_adc_isr(int irq, void *dev_id)
 	 * timeout flags.
 	 */
 	if (status & IMX7D_REG_ADC_INT_STATUS_CHANNEL_CONV_TIME_OUT) {
-		pr_err("%s: ADC got conversion time out interrupt: 0x%08x\n",
-			dev_name(info->dev), status);
+		dev_err(info->dev,
+			"ADC got conversion time out interrupt: 0x%08x\n",
+			status);
 		status &= ~IMX7D_REG_ADC_INT_STATUS_CHANNEL_CONV_TIME_OUT;
 		writel(status, info->regs + IMX7D_REG_ADC_INT_STATUS);
 	}
-- 
2.20.1

