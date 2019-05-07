Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD771C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEFD20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfEGOg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:36:29 -0400
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:34234 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbfEGOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:36:26 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout017.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hO1Cf-000DwF-Qc; Tue, 07 May 2019 16:36:21 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hO1Cf-0008oW-Jv; Tue, 07 May 2019 16:36:21 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        David Laight <David.Laight@ACULAB.COM>, dev@pschenker.ch,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] iio: stmpe-adc: Enable all stmpe-adc interrupts just once
Date:   Tue,  7 May 2019 16:36:13 +0200
Message-Id: <20190507143615.28477-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507143615.28477-1-dev@pschenker.ch>
References: <20190507143615.28477-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This commit will enable the interrupts of all channels handled by this
driver only once in the probe function.

This will improve performance because one byte less has to be written over
i2c on each read out of the adc. On the fastest ADC mode this will improve
read out speed by 15%.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/iio/adc/stmpe-adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index b3872eb37293..82b43e4522b6 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -74,9 +74,6 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
 		return -EINVAL;
 	}
 
-	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
-			STMPE_ADC_CH(info->channel));
-
 	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
 			STMPE_ADC_CH(info->channel));
 
@@ -336,6 +333,9 @@ static int stmpe_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
+			~(norequest_mask & 0xFF));
+
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-- 
2.21.0

