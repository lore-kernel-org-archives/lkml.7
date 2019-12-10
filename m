Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDF0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BFE20836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013165;
	bh=8sQZi92LYMSGs3wG0gKqFzU+WlXbbH0AzH5Aku7580E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2l+S3hVHFAiezWtuedK68bopiUttvA3ZkZqlBCa7N+GjqTjmiqjBfrcK68LNVwVgY
	 +S6rp8XokZ4sETpT5wvl3+oAHDe1JQ/QKzRcKX2EW9/9eXxEc1liDfDccyA8d2X0H1
	 nUizMWlBLNRC5js5a0/rg37SPZkoP/ueOsI+z9Bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfLJVZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:25:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729499AbfLJVZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:25:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA0420836;
        Tue, 10 Dec 2019 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013129;
        bh=8sQZi92LYMSGs3wG0gKqFzU+WlXbbH0AzH5Aku7580E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBTrp2qJ7Q9h5G2sM3sjdYSIVBYYsSD1GyljiSeVIzj76U27a+oKeaFOVAvjjcFop
         eKyM7neXRGzdbofm74dKuOrP5XWahPw5aaN+s2eqGPwPNpky/1Hbo0gudnjnSSrB+7
         9ahgxWuRUyfUUNUogcVTuwLhosRJPSVxPJv8FraU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 014/292] iio: tcs3414: fix iio_triggered_buffer_{pre,post}enable positions
Date:   Tue, 10 Dec 2019 16:20:33 -0500
Message-Id: <20191210212511.11392-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210212511.11392-1-sashal@kernel.org>
References: <20191210212511.11392-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit 0fe2f2b789190661df24bb8bf62294145729a1fe ]

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

For the predisable hook, the disable code should occur before detaching
the poll func, and for the postenable hook, the poll func should be
attached before the enable code.

The driver was slightly reworked. The preenable hook was moved to the
postenable, to add some symmetry to the postenable/predisable part.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/tcs3414.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 7c0291c5fe76e..b542e5619ead8 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -240,32 +240,42 @@ static const struct iio_info tcs3414_info = {
 	.attrs = &tcs3414_attribute_group,
 };
 
-static int tcs3414_buffer_preenable(struct iio_dev *indio_dev)
+static int tcs3414_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct tcs3414_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
 
 	data->control |= TCS3414_CONTROL_ADC_EN;
-	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
+	ret = i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
+	if (ret)
+		iio_triggered_buffer_predisable(indio_dev);
+
+	return ret;
 }
 
 static int tcs3414_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct tcs3414_data *data = iio_priv(indio_dev);
-	int ret;
-
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		return ret;
+	int ret, ret2;
 
 	data->control &= ~TCS3414_CONTROL_ADC_EN;
-	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
+	ret = i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
+
+	ret2 = iio_triggered_buffer_predisable(indio_dev);
+	if (!ret)
+		ret = ret2;
+
+	return ret;
 }
 
 static const struct iio_buffer_setup_ops tcs3414_buffer_setup_ops = {
-	.preenable = tcs3414_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
+	.postenable = tcs3414_buffer_postenable,
 	.predisable = tcs3414_buffer_predisable,
 };
 
-- 
2.20.1

