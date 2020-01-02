Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEFAC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C637F20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004954;
	bh=kI714KhdZOV86NSLDIwxv61nxxSXvDcFcQ6Rb3avn6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c/4KtcpHLtJWZunB0Tcjymb2TWjXzEWpVoMRk/VwdVNyjZkQBgFHREkcqe/vBRP9d
	 69eZl0W4IA88ONAAOnaks3kRZYLczd9fyhZ/iisNTsbDtjt/8PrdK+pTz+JbcL9IDZ
	 zcIwMtRCm6l32YnqMwF1UUCzEf8+cJVr+jSrWWbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgABWme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:42:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbgABWfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:35:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B2F20863;
        Thu,  2 Jan 2020 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004549;
        bh=kI714KhdZOV86NSLDIwxv61nxxSXvDcFcQ6Rb3avn6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TYJQDMN6kdbaj/jtF1pxTD6qGZz8EozPR/BEV0m/8jgp2QnLzenrv/HHIFijHpHqQ
         KlIUARVHtujL2Nfm76zYlo9F00GYMCxJikuk9NXcSX/XIVhTBQ41bWtCN2yhKZSMnM
         yspolCxPHxVXP+K0Gh8HtPKUnjTpxzjTHUkFC4eA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 028/137] iio: adc: max1027: Reset the device at probe time
Date:   Thu,  2 Jan 2020 23:06:41 +0100
Message-Id: <20200102220550.401050486@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit db033831b4f5589f9fcbadb837614a7c4eac0308 ]

All the registers are configured by the driver, let's reset the chip
at probe time, avoiding any conflict with a possible earlier
configuration.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/max1027.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 41d495c6035e..7d5e4114e7a8 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -470,6 +470,14 @@ static int max1027_probe(struct spi_device *spi)
 		goto fail_dev_register;
 	}
 
+	/* Internal reset */
+	st->reg = MAX1027_RST_REG;
+	ret = spi_write(st->spi, &st->reg, 1);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to reset the ADC\n");
+		return ret;
+	}
+
 	/* Disable averaging */
 	st->reg = MAX1027_AVG_REG;
 	ret = spi_write(st->spi, &st->reg, 1);
-- 
2.20.1



