Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCAAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E102205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126685;
	bh=WLn64TCrCVn/CGDSAYr7J5qAkULDqliUSBcZirV7cNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XKWhGHUI6AHxcAijXWSKTr2jm/ez9QqiPLYETs5nJFuAKPYSX4ShiMV7Hi5kf1beW
	 ClI0jBVbUMz1E2OcV4gq9mHY6jf93tIpAKNRzkFyvl5Gx4/abpAT4jZHfBz9PhG9+v
	 LDkSLLdZ2a2KoP0RjA6T36z/JXVMxdj1w2X74734=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbfDXRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389893AbfDXRYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:24:35 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B03205ED;
        Wed, 24 Apr 2019 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126675;
        bh=WLn64TCrCVn/CGDSAYr7J5qAkULDqliUSBcZirV7cNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hx4vzKu57vbjkRR63vmq87zP9mZ8S4u68oi4jvxdg7OfsXALy6o0AJ4oRKGng1LqX
         0aV8emhizl8p6YbBoM4XURkhcZepISNTLrgSlbxwK5y1xV6zaObL4cfPQizBs+n2gr
         7uzLv+sfyMGEBtcBdL0bTPBM3Cmo9Wjbgh985UuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Georg Ottinger <g.ottinger@abatec.at>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.9 21/44] iio: adc: at91: disable adc channel interrupt in timeout case
Date:   Wed, 24 Apr 2019 19:09:59 +0200
Message-Id: <20190424170855.555849600@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georg Ottinger <g.ottinger@abatec.at>

commit 09c6bdee51183a575bf7546890c8c137a75a2b44 upstream.

Having a brief look at at91_adc_read_raw() it is obvious that in the case
of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR registers is
omitted. If 2 different channels are queried we can end up with a
situation where two interrupts are enabled, but only one interrupt is
cleared in the interrupt handler. Resulting in a interrupt loop and a
system hang.

Signed-off-by: Georg Ottinger <g.ottinger@abatec.at>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/at91_adc.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -704,23 +704,29 @@ static int at91_adc_read_raw(struct iio_
 		ret = wait_event_interruptible_timeout(st->wq_data_avail,
 						       st->done,
 						       msecs_to_jiffies(1000));
-		if (ret == 0)
-			ret = -ETIMEDOUT;
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
-		}
-
-		*val = st->last_value;
 
+		/* Disable interrupts, regardless if adc conversion was
+		 * successful or not
+		 */
 		at91_adc_writel(st, AT91_ADC_CHDR,
 				AT91_ADC_CH(chan->channel));
 		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
 
-		st->last_value = 0;
-		st->done = false;
+		if (ret > 0) {
+			/* a valid conversion took place */
+			*val = st->last_value;
+			st->last_value = 0;
+			st->done = false;
+			ret = IIO_VAL_INT;
+		} else if (ret == 0) {
+			/* conversion timeout */
+			dev_err(&idev->dev, "ADC Channel %d timeout.\n",
+				chan->channel);
+			ret = -ETIMEDOUT;
+		}
+
 		mutex_unlock(&st->lock);
-		return IIO_VAL_INT;
+		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mv;


