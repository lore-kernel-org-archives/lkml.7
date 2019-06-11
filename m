Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8270AC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660F32063F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405067AbfFKJ5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:57:30 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49675 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404553AbfFKJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:57:24 -0400
X-Originating-IP: 90.88.159.246
Received: from dell-desktop.home (aaubervilliers-681-1-40-246.w90-88.abo.wanadoo.fr [90.88.159.246])
        (Authenticated sender: mylene.josserand@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5FE454001A;
        Tue, 11 Jun 2019 09:57:21 +0000 (UTC)
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To:     peda@axentia.se, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com
Subject: [PATCH v1 1/3] iio: afe: rescale: Move scale conversion to new function
Date:   Tue, 11 Jun 2019 11:56:57 +0200
Message-Id: <20190611095659.29845-2-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190611095659.29845-1-mylene.josserand@bootlin.com>
References: <20190611095659.29845-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare the support of processed value, create a function
to convert the scale according to the voltage-divider node
used in the device-tree.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 drivers/iio/afe/iio-rescale.c | 54 +++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e9ceee66d1e7..3e689d6eb501 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -33,12 +33,41 @@ struct rescale {
 	s32 denominator;
 };
 
+static int rescale_convert_scale(struct rescale *rescale, int *val, int *val2)
+{
+	unsigned long long tmp;
+	int ret;
+
+	ret = iio_read_channel_scale(rescale->source, val, val2);
+	switch (ret) {
+	case IIO_VAL_FRACTIONAL:
+		*val *= rescale->numerator;
+		*val2 *= rescale->denominator;
+		return ret;
+	case IIO_VAL_INT:
+		*val *= rescale->numerator;
+		if (rescale->denominator == 1)
+			return ret;
+		*val2 = rescale->denominator;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp = *val * 1000000000LL;
+		do_div(tmp, rescale->denominator);
+		tmp *= rescale->numerator;
+		do_div(tmp, 1000000000LL);
+		*val = tmp;
+
+		return ret;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int rescale_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	unsigned long long tmp;
 	int ret;
 
 	switch (mask) {
@@ -46,28 +75,7 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 		return iio_read_channel_raw(rescale->source, val);
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = iio_read_channel_scale(rescale->source, val, val2);
-		switch (ret) {
-		case IIO_VAL_FRACTIONAL:
-			*val *= rescale->numerator;
-			*val2 *= rescale->denominator;
-			return ret;
-		case IIO_VAL_INT:
-			*val *= rescale->numerator;
-			if (rescale->denominator == 1)
-				return ret;
-			*val2 = rescale->denominator;
-			return IIO_VAL_FRACTIONAL;
-		case IIO_VAL_FRACTIONAL_LOG2:
-			tmp = *val * 1000000000LL;
-			do_div(tmp, rescale->denominator);
-			tmp *= rescale->numerator;
-			do_div(tmp, 1000000000LL);
-			*val = tmp;
-			return ret;
-		default:
-			return -EOPNOTSUPP;
-		}
+		return rescale_convert_scale(rescale, val, val2);
 	default:
 		return -EINVAL;
 	}
-- 
2.11.0

