Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F31C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F7920637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014222;
	bh=IqSHiwzJG93tt7Lx1FKTOFNoh5baUghQmp+8/Sn/Vh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=maTie+wNbs29ooX8vq/2JIRk5OavOuvl6Lrib4QMmdKNS0Z+TzQAoCNXCQvpcnX0v
	 aFrsH7ZUYZiErOoZwa5vVtGCFb7pGW97qjrYOLw+pGFrvMK5JV1oaAIGnuB51kBu5c
	 8BSlXwfUSE7Fxkk7ysUUrRJrdrx/ZPzBGh0XKWGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfLJVnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbfLJVdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:33:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9070E206D5;
        Tue, 10 Dec 2019 21:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013615;
        bh=IqSHiwzJG93tt7Lx1FKTOFNoh5baUghQmp+8/Sn/Vh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imwiaKGujk+jbHmBNNlNwDcJbEAHlOj/RONVdDq3YCXYawYG61KNBJ/afShsZOnnn
         F3+sBAZjWS9cEWkjrk1YNAEea3ER4PXG9jDYQ7ZndEvaLi5xWBVFJ++ouSVmxsuX1b
         zjWRgW1A991vKl0o6jeAb/+PBT6Na0K6QJMAmKuc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 060/177] iio: adc: max1027: Reset the device at probe time
Date:   Tue, 10 Dec 2019 16:30:24 -0500
Message-Id: <20191210213221.11921-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 311c1a89c329e..0939eb0384f1c 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -460,6 +460,14 @@ static int max1027_probe(struct spi_device *spi)
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

