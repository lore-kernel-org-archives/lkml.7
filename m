Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69946C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3984520652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369526;
	bh=PNiYqTZrhZu605lG950RmJceNbiRLA2RtOXRI7WxMnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nf1KZEBq0JWzIUbgTvno1nsymIto5i1ADwkP5Lmk5oAtLw7X25wUFHAN5PR0x2LLE
	 eSRFhLkFAtDhSNt5X0foxjf0TYCcihcP35JVTl8o3XrxGxDcWlDUiXUQs4dgXz0OZY
	 EQRDn4oG6OghWbu+ELPaoOraV4Es8b4i7o4wEltE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbfDDJSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388413AbfDDJSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:18:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF90320652;
        Thu,  4 Apr 2019 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369521;
        bh=PNiYqTZrhZu605lG950RmJceNbiRLA2RtOXRI7WxMnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1oBJyDtxDOtbgZFMp/B0ZuxJH3OHcclouzYGnGa4dSH8HN3FtxSV/sQc2FwTEd4w
         ADLw9aHArpJ8DKvDlahKTfOEO56v59ABF2ZHaE+l6HWIMwoXX8MoiT5R+a2jpaOJnZ
         Y4guFtK26KreVrloNest3gcmgUwX9b8p5wXlYWo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Fertic <jeremyfertic@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 237/246] staging: iio: adt7316: fix dac_bits assignment
Date:   Thu,  4 Apr 2019 10:48:57 +0200
Message-Id: <20190404084627.589988870@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e9de475723de5bf207a5b7b88bdca863393e42c8 ]

The value of dac_bits is used in adt7316_show_DAC() and adt7316_store_DAC(),
and it should be either 8, 10, or 12 bits depending on the device in use. The
driver currently only assigns a value to dac_bits in
adt7316_store_da_high_resolution(). The purpose of the dac high resolution
option is not to change dac resolution for normal operation. Instead, it
is specific to an optional feature where one or two of the four dacs can
be set to output voltage proportional to temperature. If the user chooses
to set dac a and/or dac b to output voltage proportional to temperature,
the da_high_resolution attribute can optionally be enabled to use 10 bit
resolution rather than the default 8 bits. This is only available on the
10 and 12 bit dac devices. If the user attempts to read or write dacs a
or b under these settings, the driver's current behaviour is to return an
error. Dacs c and d continue to operate normally under these conditions.
With the above in mind, remove the dac_bits assignments from this function
since the value of dac_bits as used in the driver is not dependent on this
dac high resolution option.

Since the dac_bits assignments discussed above are currently the only ones
in this driver, the default value of dac_bits is 0. This results in incorrect
calculations when the dacs are read or written in adt7316_show_DAC() and
adt7316_store_DAC(). To correct this, assign a value to dac_bits in
adt7316_probe() to ensure correct operation as soon as the device is
registered and available to userspace.

Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/addac/adt7316.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index dc93e85808e0..7839d869d25d 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -651,17 +651,10 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 	u8 config3;
 	int ret;
 
-	chip->dac_bits = 8;
-
-	if (buf[0] == '1') {
+	if (buf[0] == '1')
 		config3 = chip->config3 | ADT7316_DA_HIGH_RESOLUTION;
-		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
-			chip->dac_bits = 12;
-		else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
-			chip->dac_bits = 10;
-	} else {
+	else
 		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
-	}
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
 	if (ret)
@@ -2123,6 +2116,13 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	else
 		return -ENODEV;
 
+	if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
+		chip->dac_bits = 12;
+	else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
+		chip->dac_bits = 10;
+	else
+		chip->dac_bits = 8;
+
 	chip->ldac_pin = devm_gpiod_get_optional(dev, "adi,ldac", GPIOD_OUT_LOW);
 	if (IS_ERR(chip->ldac_pin)) {
 		ret = PTR_ERR(chip->ldac_pin);
-- 
2.19.1



