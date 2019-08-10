Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5973AC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B546217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+aheYMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfHJF3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:29:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45178 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:29:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so46835465pgp.12;
        Fri, 09 Aug 2019 22:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p+GfeX4Ueh4qeynfnY+nHD9xlpPk1TsHoPAB9+k1TQY=;
        b=k+aheYMTnj5mlzWzq1ilxhyRi5juqsvNPyrBOubgRPgTrctQUunUxavZ+AlHE8J1a6
         ZlQhaRmaaQWfA67IUltiIi96nWydnGnVsJZMJExGzLMaJwnJBrKFBqeK/ghEg5tBkfd2
         rhXRgo6+8lYV/CTa7YgKdI6GuNg8nzDD1fnxiniCsOV6k3RawXRpzph0dDBhFnEX2Wq2
         jG//G+mNdwhTLRq8ygt2iqFNae2jbFnD94ykXL9A67w3pada5OETSmXo1Cx2C4xi4n0i
         qtY7utQEumhIfl9v+xmmsVUdF4gbq0AQnLre/QVU7OqkpN9FWvBkVXhApGYw1uDx1MdN
         I8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p+GfeX4Ueh4qeynfnY+nHD9xlpPk1TsHoPAB9+k1TQY=;
        b=daqlNq3d2rYYYJF2azGGy3dEl5UwjpvbO5B1u/IKdo0+hVbZiBGYnoXRpJmDRUCE5Q
         mnsyBmXVj4MKL0pgcymPgO8Xd0vBOco0Dq1zAGFrIoLEQUEPtMikaKhz6rnUePXLe7Pe
         x77egoz4cWJmP0btOjvxSSSnd0bZEYWgxXeEXVER9UDItML//ZdjZCwMqwGRNRBSXh+8
         VnKVTXvWs3fvsh0kgK9puiyDNv8KnhCJHlqY3X4ZBv0IH/7l+OTo35pZarrq0ysEYdp9
         POAh2mfKvs9qxdniYok/zOUI/Wmfyx5+7E5AbYEsTGOzQIpCQmiimZDknjy8r8oR5gIi
         eh/Q==
X-Gm-Message-State: APjAAAUjMwJQihaPHNpj/MgwJLdtEUi96YVtEOwN1TzJ4wxymL6B5jRk
        yIx2InjF1kPs6yU0D2Ko/pQ=
X-Google-Smtp-Source: APXvYqxxpWtEqoQhAm3ka4Zp+gt5YbokpRaK82eECedhofkwnz5TtrsipKnUkmCv/rhm//nnApa9bA==
X-Received: by 2002:aa7:8d98:: with SMTP id i24mr25669455pfr.199.1565414970942;
        Fri, 09 Aug 2019 22:29:30 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id r6sm17958624pjb.22.2019.08.09.22.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:29:30 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 05/18] thermal: sun8i: rework for sun8i_ths_get_temp()
Date:   Sat, 10 Aug 2019 05:28:16 +0000
Message-Id: <20190810052829.6032-6-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For different socs, the way they get and calculate the
temperature is roughly the same. So get the difference
from device compatible.

Difference point:
  1) temperature calculation formula parameters
  2) ths data register start address

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index e9c2acbaac74..f338fa25b98e 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -22,9 +22,6 @@
 
 #define MAX_SENSOR_NUM	4
 
-#define SUN50I_H6_OFFSET	-2794
-#define SUN50I_H6_SCALE		-67
-
 #define FT_TEMP_MASK				GENMASK(11, 0)
 #define TEMP_CALIB_MASK				GENMASK(11, 0)
 #define TEMP_TO_REG				672
@@ -58,6 +55,10 @@ struct tsensor {
 
 struct ths_thermal_chip {
 	int		sensor_num;
+	int		offset;
+	int		scale;
+	int		ft_deviation;
+	int		temp_data_base;
 };
 
 struct ths_device {
@@ -73,7 +74,7 @@ struct ths_device {
 static int sun8i_ths_reg2temp(struct ths_device *tmdev,
 			      int reg)
 {
-	return (reg + SUN50I_H6_OFFSET) * SUN50I_H6_SCALE;
+	return (reg + tmdev->chip->offset) * tmdev->chip->scale;
 }
 
 static int sun8i_ths_get_temp(void *data, int *temp)
@@ -82,7 +83,7 @@ static int sun8i_ths_get_temp(void *data, int *temp)
 	struct ths_device *tmdev = s->tmdev;
 	int val;
 
-	regmap_read(tmdev->regmap, SUN50I_H6_THS_TEMP_DATA +
+	regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
 		    0x4 * s->id, &val);
 
 	/* ths have no data yet */
@@ -98,7 +99,7 @@ static int sun8i_ths_get_temp(void *data, int *temp)
 	 * temperature above is also used when the sensor is calibrated. If
 	 * do this, the correct calibration formula is hard to know.
 	 */
-	*temp += SUN50I_H6_FT_DEVIATION;
+	*temp += tmdev->chip->ft_deviation;
 
 	return 0;
 }
@@ -389,6 +390,10 @@ static int sun8i_ths_remove(struct platform_device *pdev)
 
 static const struct ths_thermal_chip sun50i_h6_ths = {
 	.sensor_num = 2,
+	.offset = -2794,
+	.scale = -67,
+	.ft_deviation = SUN50I_H6_FT_DEVIATION,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
 };
 
 static const struct of_device_id of_ths_match[] = {
-- 
2.17.1

