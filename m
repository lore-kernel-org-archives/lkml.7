Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3EDC388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445D420815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="CWao2nyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfI3FZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 01:25:05 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:41010 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbfI3FZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 01:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569821102; x=1601357102;
  h=from:to:cc:subject:date:message-id;
  bh=qzFcBPOoP/Rv8ykLaC0eQHksn1NzctMIHEFRc4wakkk=;
  b=CWao2nyPTvsENa+EY3446tBct7V/cAdfCGbQFLQOb4mi13rPTS83jKb2
   lMfnKPLE/eAb93E5LboX0hBtWIjtt1Kb75FynmQPaowPkhoS7+ADbIhVq
   9Xi5J2IGNg8LxdQyYBKKs4mNmQcfuPioK8O1m6+UvbmX1ywz7pYFqWfKR
   akG/YSbr/01ZED2pj1ue1APcRbgpG6UOZj1CgwRHnV/YItVZGWrpJLWBi
   2nTvL3W9CAsi3UFr25GROWYfIdPMzJ2Ll4anvdOAH77NhZqom8Eu991x8
   9oTyS2GiREs5T5vAv2dFYGvfCJW4Dw4LBo4DlFwul+sWm+GbneCAlXiKY
   A==;
IronPort-SDR: 7/pyjGBMZfMNCmQWiomrl+KqVWY0YA/RD/eokFDMVoSahkTgjUNqkHLqVoXcrT361N0caS38Qh
 A3Rz0lV8HNntTVuRrNMv87rOcLhH40krLJbjBV1E/wrW7pfR4cnxVoVJ0YOqdZqRXzedjeobTD
 gbjDSxVEqshFnZGEnDReO56XmKQOGGgtzoPJydR8vNn0OFohjs4FSB8gZyBKXaKPqK8GXDA7ZF
 77/lgfmsTMusK/ngwdAvj+oySweUFuRcAYi+53E34KNQJ8OWrb8U9zClrQewmpKoSrUvxwSkvG
 YTw=
IronPort-PHdr: =?us-ascii?q?9a23=3A+G38DBFTrt+EKl36RwU9UZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ78rs2wAkXT6L1XgUPTWs2DsrQY0rGQ7/mrCDZIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+5oAnMucUbhZVuIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWMNRVy1aAoOnbosPCeUBNvtGoYfkulAOoxq+CheoBOzy1zREgnH70bE/3+?=
 =?us-ascii?q?knDArI3hEvH8gWvXrUstv7KakcX+OywqTT0TnPc+lb1Svn5YTUbhwsp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDwHKjlSRqIzlIjOV0fkGvm+b7uthVeKgkW8npx1trjWh3cosl5?=
 =?us-ascii?q?XGhpgPxl/a6Cp53Z84KNulQ0B4ed6pCIVcuz2eOodsQc4vQ3tktDgnxrAJo5?=
 =?us-ascii?q?K3YjQGxIg/yxLCavGKd5KE7gztWeuROzt0mnNodKi9ihu990Wr1/fyWdOu0F?=
 =?us-ascii?q?lQqypIitzMtncQ2BPN8sWHUf59/lu52TaIygDT9vlIIUAqmqrfLJ4s2rswmY?=
 =?us-ascii?q?ASsUTHByP2gEH2gLKPekUq5OSk9/jrbq/ppp+bMI90hQX+Pbo0lsOjBuQ4Nx?=
 =?us-ascii?q?ACX2md+euiyL3u5VP1TKlOg/EskaTUsIrWKdoGqqO2GQNZzJov5wqnAzejyt?=
 =?us-ascii?q?sYnH0HLFxfeBKAiojkI1HPIfH4DfilglSgjCtnyv7dM738HprNNGLPn6n8cr?=
 =?us-ascii?q?Zg80Jc0hY8zchD55JIDbEMOPbzWk73tNzFAR41Kg+0zPj9CNV7yIweXXmCAr?=
 =?us-ascii?q?GWMKzMq1+E/OEvLPeWZI8Tpjn9L+Ip5/n0jX82yhczZ66siKoWenClGbwyMl?=
 =?us-ascii?q?eZaHu02owpDGwQ+AcyUbq52xW5TTdPaiPqDOoH7TYhBdfjUt/O?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FjCQBJkJFdgMjWVdFmgh6DXkwQjR6?=
 =?us-ascii?q?FclABAQEGiyaBCYV6iDGBewEIAQEBDAEBLQIBAYRAgz0jNgcOAgMJAQEFAQE?=
 =?us-ascii?q?BAQEFBAEBAhABAQkNCQgnhUKCOimDNQsWFVKBFQEFATUiOYJHAYF2FAWfA4E?=
 =?us-ascii?q?DPIwlM4hcAQkNgUgJAQiBIoc1hFmBEIEHhGGHY4JEBIEvAQEBiz4BgjGHK5Z?=
 =?us-ascii?q?JAQYCghAUgXiTByeCN4ICiT05iwYBLYoonGsCCgcGDyOBNgWCBU0lgWwKgUR?=
 =?us-ascii?q?QEBSBWheOQiEzgQiQBgE?=
X-IPAS-Result: =?us-ascii?q?A2FjCQBJkJFdgMjWVdFmgh6DXkwQjR6FclABAQEGiyaBC?=
 =?us-ascii?q?YV6iDGBewEIAQEBDAEBLQIBAYRAgz0jNgcOAgMJAQEFAQEBAQEFBAEBAhABA?=
 =?us-ascii?q?QkNCQgnhUKCOimDNQsWFVKBFQEFATUiOYJHAYF2FAWfA4EDPIwlM4hcAQkNg?=
 =?us-ascii?q?UgJAQiBIoc1hFmBEIEHhGGHY4JEBIEvAQEBiz4BgjGHK5ZJAQYCghAUgXiTB?=
 =?us-ascii?q?yeCN4ICiT05iwYBLYoonGsCCgcGDyOBNgWCBU0lgWwKgURQEBSBWheOQiEzg?=
 =?us-ascii?q?QiQBgE?=
X-IronPort-AV: E=Sophos;i="5.64,565,1559545200"; 
   d="scan'208";a="79493040"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2019 22:25:02 -0700
Received: by mail-pl1-f200.google.com with SMTP id y2so4574661plk.19
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 22:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fPKABXGUyoM/LSYBewEpMZXiulfn1+x5kwR93rT2pjY=;
        b=REfSLgh4ar6kcfkMOZXM4CBXNTL8SleALjOiYGiu4WFONPD8vYt5XjtqtVUJK99rg/
         Fu3T5ZWOwXCtkZfWuzbgSgfFBUNpKE/TfE+ONMQ2HJS0yYYYX1bhcZso+YujwQiofpsH
         BarC1+81pfD4tWlTPpR8UkRdM2DaqgO23i7h78tLmuZejQQRa2DqgDqa738GOOJfum9I
         Jug9OU+Lc4TaHpHThNL3YXIUAXFqKAOtQpreaKjYLNLcY5nLlcG2Y7zePeYLKaiZF+4+
         8FRnKldGms74aeb2X4+NgnRc/NZOm+bO1T7x3pdR68h10ieMSDtGnGFTcZGI7oDnIxim
         PrWA==
X-Gm-Message-State: APjAAAWsG5AQUubbDrXzf6Jn/RmBJ5yr2/FeUIOZWcNYiPrgWVs3xBOF
        QR0FzWxVOGGYXb4qOygpSSnceTdnf8LujXXVfHI+UiGGa2ULy5qcVaUqoKEpLCie6ZVO+A8RaRa
        +dyCieYzUq6ObFVf2twWOHNbBmw==
X-Received: by 2002:a63:5652:: with SMTP id g18mr21799334pgm.393.1569821101510;
        Sun, 29 Sep 2019 22:25:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyPeVROo1TnM+H1kGzA7cRPqfO3NXggBNlKrrjPDdQwOcK4O2BhRFl7aOQNC2xwRWyuzG9QsA==
X-Received: by 2002:a63:5652:: with SMTP id g18mr21799307pgm.393.1569821101057;
        Sun, 29 Sep 2019 22:25:01 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id a11sm11186636pfg.94.2019.09.29.22.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 22:25:00 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: Variables could be uninitalized if regmap_read() fails
Date:   Sun, 29 Sep 2019 22:25:39 -0700
Message-Id: <20190930052540.19168-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions in this file are trying to use regmap_read() to
initialize the specific variable, however, if regmap_read() fails,
the variable could be uninitialized but used directly, which is
potentially unsafe. The return value of regmap_read() should be
checked and handled.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/adc/bcm_iproc_adc.c | 45 ++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 646ebdc0a8b4..6df19ceb5ff2 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -137,6 +137,7 @@ static irqreturn_t iproc_adc_interrupt_thread(int irq, void *data)
 	u32 channel_intr_status;
 	u32 intr_status;
 	u32 intr_mask;
+	int ret;
 	struct iio_dev *indio_dev = data;
 	struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
 
@@ -145,8 +146,19 @@ static irqreturn_t iproc_adc_interrupt_thread(int irq, void *data)
 	 * Make sure this interrupt is intended for us.
 	 * Handle only ADC channel specific interrupts.
 	 */
-	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_STATUS, &intr_status);
-	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &intr_mask);
+	ret = regmap_read(adc_priv->regmap,
+					IPROC_INTERRUPT_STATUS, &intr_status);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_STATUS.\n");
+		return ret;
+	}
+
+	ret = regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &intr_mask);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_MASK.\n");
+		return ret;
+	}
+
 	intr_status = intr_status & intr_mask;
 	channel_intr_status = (intr_status & IPROC_ADC_INTR_MASK) >>
 				IPROC_ADC_INTR;
@@ -162,6 +174,7 @@ static irqreturn_t iproc_adc_interrupt_handler(int irq, void *data)
 	struct iproc_adc_priv *adc_priv;
 	struct iio_dev *indio_dev = data;
 	unsigned int valid_entries;
+	int ret;
 	u32 intr_status;
 	u32 intr_channels;
 	u32 channel_status;
@@ -169,23 +182,37 @@ static irqreturn_t iproc_adc_interrupt_handler(int irq, void *data)
 
 	adc_priv = iio_priv(indio_dev);
 
-	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_STATUS, &intr_status);
+	ret = regmap_read(adc_priv->regmap,
+					IPROC_INTERRUPT_STATUS, &intr_status);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_STATUS.\n");
+		return ret;
+	}
+
 	dev_dbg(&indio_dev->dev, "iproc_adc_interrupt_handler(),INTRPT_STS:%x\n",
 			intr_status);
 
 	intr_channels = (intr_status & IPROC_ADC_INTR_MASK) >> IPROC_ADC_INTR;
 	if (intr_channels) {
-		regmap_read(adc_priv->regmap,
+		ret = regmap_read(adc_priv->regmap,
 			    IPROC_ADC_CHANNEL_INTERRUPT_STATUS +
 			    IPROC_ADC_CHANNEL_OFFSET * adc_priv->chan_id,
 			    &ch_intr_status);
+		if (ret) {
+			dev_err(&indio_dev->dev, "Fail to read the register.\n");
+			return ret;
+		}
 
 		if (ch_intr_status & IPROC_ADC_CHANNEL_WTRMRK_INTR_MASK) {
-			regmap_read(adc_priv->regmap,
+			ret = regmap_read(adc_priv->regmap,
 					IPROC_ADC_CHANNEL_STATUS +
 					IPROC_ADC_CHANNEL_OFFSET *
 					adc_priv->chan_id,
 					&channel_status);
+			if (ret) {
+				dev_err(&indio_dev->dev, "Fail to read the register.\n");
+				return ret;
+			}
 
 			valid_entries = ((channel_status &
 				IPROC_ADC_CHANNEL_VALID_ENTERIES_MASK) >>
@@ -230,6 +257,7 @@ static int iproc_adc_do_read(struct iio_dev *indio_dev,
 	u32 mask;
 	u32 val_check;
 	int failed_cnt = 0;
+	int ret;
 	struct iproc_adc_priv *adc_priv = iio_priv(indio_dev);
 
 	mutex_lock(&adc_priv->mutex);
@@ -284,7 +312,12 @@ static int iproc_adc_do_read(struct iio_dev *indio_dev,
 	 * Testing has shown that this may loop a few time, but we have never
 	 * hit the full count.
 	 */
-	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &val_check);
+	ret = regmap_read(adc_priv->regmap, IPROC_INTERRUPT_MASK, &val_check);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Fail to read IPROC_INTERRUPT_MASK.\n");
+		return ret;
+	}
+
 	while (val_check != val) {
 		failed_cnt++;
 
-- 
2.17.1

