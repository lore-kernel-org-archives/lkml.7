Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D466ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6E721D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263005;
	bh=56kjPX0eX66U31d8LMlDx4804SYS0FnyBIXSPh8M7ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nwlxzvdsxHu6D8JadsxkdjdlBhm4szo0+FlmhRhQLXnQnhjC/tbzh1BF9txhDKH9N
	 Fp6qaUn2lw5McxnjPMlPLBggfdwRwz4s4FskSVt5bBYzQUnFGIPuCWNBAEwKIBdm2l
	 ULllF0DNzrr6MU1vK3wed1fYMG+5PQWh1ZjuynpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395423AbfJPV4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387438AbfJPV4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:56:24 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E753E21D7A;
        Wed, 16 Oct 2019 21:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262984;
        bh=56kjPX0eX66U31d8LMlDx4804SYS0FnyBIXSPh8M7ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aa6tpYAUm6lCI/d2Dbdk0UtP2HeGy0V873CID6khdhLjjBzAG17S0lSgcm5aRQUSN
         aDQdRW/Hjc44IDwgnky4/Dj/oxiSFP5nkC8tKnMM1ov43X8eKto/RZ44inzPW86FU5
         T2Apce6uN35nJ0JMcYT/PvG3ZSZGGV8+5Fsff4cI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 53/65] iio: hx711: add delay until DOUT is ready
Date:   Wed, 16 Oct 2019 14:51:07 -0700
Message-Id: <20191016214837.120994171@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214756.457746573@linuxfoundation.org>
References: <20191016214756.457746573@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Klinger <ak@it-klinger.de>

[ Upstream commit 461631face58054c72b1f1453f2d66d71b1974e7 ]

On a system with parasitic capacitance it turned out that DOUT is not ready
after 100 ns after PD_SCK has raised. A measurement showed almost 1000 ns
until DOUT has reached its correct value.

With this patch its now possible to wait until data is ready.

The wait time should not be higher than the maximum PD_SCK high time which
is corresponding to the datasheet 50000 ns.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/hx711.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 27005d84ed73d..8eb3f1bbe332b 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -89,6 +89,14 @@ struct hx711_data {
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
 	struct mutex		lock;
+	/*
+	 * delay after a rising edge on SCK until the data is ready DOUT
+	 * this is dependent on the hx711 where the datasheet tells a
+	 * maximum value of 100 ns
+	 * but also on potential parasitic capacities on the wiring
+	 */
+	u32			data_ready_delay_ns;
+	u32			clock_frequency;
 };
 
 static int hx711_cycle(struct hx711_data *hx711_data)
@@ -102,6 +110,14 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 */
 	preempt_disable();
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
+
+	/*
+	 * wait until DOUT is ready
+	 * it turned out that parasitic capacities are extending the time
+	 * until DOUT has reached it's value
+	 */
+	ndelay(hx711_data->data_ready_delay_ns);
+
 	val = gpiod_get_value(hx711_data->gpiod_dout);
 	/*
 	 * here we are not waiting for 0.2 us as suggested by the datasheet,
@@ -112,6 +128,12 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
 	preempt_enable();
 
+	/*
+	 * make it a square wave for addressing cases with capacitance on
+	 * PC_SCK
+	 */
+	ndelay(hx711_data->data_ready_delay_ns);
+
 	return val;
 }
 
@@ -401,6 +423,7 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 static int hx711_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -474,6 +497,22 @@ static int hx711_probe(struct platform_device *pdev)
 	hx711_data->gain_set = 128;
 	hx711_data->gain_chan_a = 128;
 
+	hx711_data->clock_frequency = 400000;
+	ret = of_property_read_u32(np, "clock-frequency",
+					&hx711_data->clock_frequency);
+
+	/*
+	 * datasheet says the high level of PD_SCK has a maximum duration
+	 * of 50 microseconds
+	 */
+	if (hx711_data->clock_frequency < 20000) {
+		dev_warn(dev, "clock-frequency too low - assuming 400 kHz\n");
+		hx711_data->clock_frequency = 400000;
+	}
+
+	hx711_data->data_ready_delay_ns =
+				1000000000 / hx711_data->clock_frequency;
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = "hx711";
-- 
2.20.1



