Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55381C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2335C20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDXQ6bpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfDCHDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:03:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32773 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfDCHDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:03:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so1161895pgh.0;
        Wed, 03 Apr 2019 00:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ieKsljjbAwxH7pp36Hh7KqVH3DSOT/7yn21e/IKxtsE=;
        b=dDXQ6bpk+vYp8r5atlPowmb6yR6GJt2vk6U3g6ZnMXwcgOuwkojPTGBoQ3QhtLYrNw
         djNB0E3+2ZLEnB+j3GE1koUCfCP0SmWwQwoSmTXok4z5H6+gAlrhKdWpax7vxb+p7QyM
         xkBLzpBvET25UA3KmTW/x0Pxlr10GZ+UcmgYuUQHzPDjIj5F7PsORGI69EzzsX9C9L8w
         72Z5zBorvo9TaZ2Fovr1b2UE2d8+gI2Yo0oUjtzPpXF/Xy/DitYYeY/ywWGvkQRNPAmv
         oFO3yaJeOjYdaPn28jZKs7CzonYqd6UZde+nEbrAWkgPfl9eCr7bQi/oFHorZVv4GnsB
         O3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieKsljjbAwxH7pp36Hh7KqVH3DSOT/7yn21e/IKxtsE=;
        b=IBntC+rzqfrtj5ZNtJ7yd566EuiiigbZWwUo0fo3SqjJLhbflkdxWh5UvpiaGU7Ovi
         C38OLhsiGik4G/RLzn9RY9rmIRhnjOn+iG+ZJu1ultIlkNVirxjts1OBQXOWV7Zz0q2u
         8mO5m1cZnC4g0fiU5QXw40y9DVegT6V9QECOS5oexabkja41DfF9s3dgq0ZFXqP2mv+O
         I0OSscVlYNpugHD0xYAnvm7SzUVboY6csSpQlU5ug82YQEiU7OqcEgIk3hL7nxJErYmC
         /2zbWTjz4OubiZkWeFik79+Eoa+uBb2d5GpJ2nNDia76Eb7NP7OSy2JS4Db3NBcD9bNN
         uPXg==
X-Gm-Message-State: APjAAAUuXApGRVi5/LfKERYzPZQy/mVOvCBdMXm+XEGGjJzmqOdAgbeV
        1xMrhdAyftLMpI+UUzfRldwNsZNz
X-Google-Smtp-Source: APXvYqwQ5dbWC8206Z15fTqxar5kaagIiLLQeQLYNzCwSS1x+Vtx/KQAAGvn8xtR50A+kBzHVmGYlQ==
X-Received: by 2002:a63:c242:: with SMTP id l2mr71202531pgg.138.1554275026954;
        Wed, 03 Apr 2019 00:03:46 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e22sm20602750pfi.126.2019.04.03.00.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:03:46 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] iio: imx7d_adc: Replace pr_err with dev_err
Date:   Wed,  3 Apr 2019 00:03:21 -0700
Message-Id: <20190403070325.1077-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403070325.1077-1-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
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

