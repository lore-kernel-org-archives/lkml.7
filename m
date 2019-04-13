Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD095C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA3020869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlz5gKwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfDMKel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:34:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36530 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfDMKdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so13887888wml.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMLyru0cyPr/VpDb34zq0Nxx/FQp28s73ZIdoYf+fi0=;
        b=zlz5gKwXEsDl6pN5xym6O5aY5HbGefR+vvd2xxY2hZKgU55joBEyXzBEW9gwXNCGRz
         PRQsWa7asM9EgwUueUWIaHXHUhOxUMyaQ+r0X2D1PZ9gjt1ZybNtTgx2AWoWLxT1KQk4
         Lpqh6SqWbKOLb7jUK1gsH+cX0IUhW47oSEnDrwkJ9pkyT2i0voglRU0mkpYCymVKVvyM
         uqO3/J3sEGUKyeESWpEopV7+K/3/JZEn2BmQMHB2/r+7PMIXBDznnI6psjyU//TgXAuD
         VrDdd2svzQPgmj6dd5cW1icbqlqOa7GKtW2zD6gthstwjhf1Nlcg5SAE56941A3p61IB
         3Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMLyru0cyPr/VpDb34zq0Nxx/FQp28s73ZIdoYf+fi0=;
        b=iiYR8OuTUocap4r6ghDfrbpEr1BJxAVhHhIDH7hd278ZmsuM6lS0SOErGckvX/oywi
         nNr0TZr6fqtZeZJNV+8qjPcK/IqylGz13Ae8I2dsWDmll5mL2dC9CFn6epS+P5x7FBgW
         SJWhYR6nZroBaltLhG3RyBGImtQyh3zIzNQj2icU5wydjfE8HkywY1xyNvqBCIGDftXX
         6JU4fleRjJqOaWsg8p1UE/YOvw2EiwK3gWD4DmoxQnSFW4PMP1qOEkh2/NgC1iimc2ao
         sJKN+Ct1xwOVkSNPA6wGI/N7m18rRor4WuTMXkSrbrY5wghG7CvW80HHwv8um/MGmGRU
         2tZQ==
X-Gm-Message-State: APjAAAWPzAvqi88+fdGaAaR4HBV3Fum/psqvgRwUTSjHTa8A3wZWocWj
        hawxXxMazg1WHQ93un/SbmjkjA==
X-Google-Smtp-Source: APXvYqzbSfQh6xkSEVxrKs8uq7HICNMLAufHhQgNsJkCR+uClkWrg1W4zRakKp55+0ly+784I8F2Qg==
X-Received: by 2002:a05:600c:2055:: with SMTP id p21mr13719536wmg.118.1555151588608;
        Sat, 13 Apr 2019 03:33:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 02/20] nvmem: imx-ocotp: add support for imx8mq
Date:   Sat, 13 Apr 2019 11:32:47 +0100
Message-Id: <20190413103305.9576-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The i.MX8MQ uses the same OCOTP block as the i.MX7D, but with
fourfold increase in fuse banks.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 08a9b1ef8ae4..e0b22b6c045b 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -444,6 +444,12 @@ static const struct ocotp_params imx7ulp_params = {
 	.bank_address_words = 0,
 };
 
+static const struct ocotp_params imx8mq_params = {
+	.nregs = 256,
+	.bank_address_words = 4,
+	.set_timing = imx_ocotp_set_imx7_timing,
+};
+
 static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-ocotp",  .data = &imx6q_params },
 	{ .compatible = "fsl,imx6sl-ocotp", .data = &imx6sl_params },
@@ -453,6 +459,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-ocotp",  .data = &imx7d_params },
 	{ .compatible = "fsl,imx6sll-ocotp", .data = &imx6sll_params },
 	{ .compatible = "fsl,imx7ulp-ocotp", .data = &imx7ulp_params },
+	{ .compatible = "fsl,imx8mq-ocotp", .data = &imx8mq_params },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
2.21.0

