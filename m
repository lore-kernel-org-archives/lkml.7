Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87552C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B0220675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127359;
	bh=SjD6htXr7CFXazsCXr959/nxj1ZPNcG948lLniQ+4q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HQAIXb2L+OMkAVYVuH53yHQ3Xe3rwK/uuLJF1fMd4Pod8QPfbsKwpVqZn2kgI9EOw
	 5uA1sAJFOxHP2RcfhamuwpRVVQs7rGyn9Pyw/TBGZfsiV2EdOSYbTKU2xFNEZrh5Y5
	 xF9BO/KEjib9ubt5zhcRFA/6sow9GDHhcdhDXkDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392010AbfDXRf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391997AbfDXRfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:54 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F031D2054F;
        Wed, 24 Apr 2019 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127353;
        bh=SjD6htXr7CFXazsCXr959/nxj1ZPNcG948lLniQ+4q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZgcbExKT3StRhwGNXzsslFkDNZwfR1t5MnUjzxnlJILXzFY2Wpwsx5eg9eNwW6Rl
         gB87LnHAN3FKqWZNhjCMloYkApkRme28y4COP+KzvUy7a4VGDIRe5KV7IhMWPpfea1
         KxsAvPwyfRUto6gKV2PUPTsEnym/G8ol1B9Yr0LU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.0 058/115] iio: cros_ec: Fix the maths for gyro scale calculation
Date:   Wed, 24 Apr 2019 19:09:54 +0200
Message-Id: <20190424170928.584445787@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

commit 3d02d7082e5823598090530c3988a35f69689943 upstream.

Calculation did not use IIO_DEGREE_TO_RAD and implemented a variant to
avoid precision loss as we aim a nano value. The offset added to avoid
rounding error, though, doesn't give us a close result to the expected
value. E.g.

For 1000dps, the result should be:

    (1000 * pi ) / 180 >> 15 ~= 0.000532632218

But with current calculation we get

    $ cat scale
    0.000547890

Fix the calculation by just doing the maths involved for a nano value

   val * pi * 10e12 / (180 * 2^15)

so we get a closer result.

    $ cat scale
    0.000532632

Fixes: c14dca07a31d ("iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -103,9 +103,10 @@ static int cros_ec_sensors_read(struct i
 			 * Do not use IIO_DEGREE_TO_RAD to avoid precision
 			 * loss. Round to the nearest integer.
 			 */
-			*val = div_s64(val64 * 314159 + 9000000ULL, 1000);
-			*val2 = 18000 << (CROS_EC_SENSOR_BITS - 1);
-			ret = IIO_VAL_FRACTIONAL;
+			*val = 0;
+			*val2 = div_s64(val64 * 3141592653ULL,
+					180 << (CROS_EC_SENSOR_BITS - 1));
+			ret = IIO_VAL_INT_PLUS_NANO;
 			break;
 		case MOTIONSENSE_TYPE_MAG:
 			/*


