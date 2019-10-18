Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE1CCA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5072422459
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436464;
	bh=diCshV9a4pVZR6o458+ck/iOrPs3rlpxB36EUXWPJYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gygRE24w80Y+luy+LV9WZKXUss/iGVtY+7sFhmacV8Jh42cDlVLkQS7pnZCOUgyxe
	 pEvV4o70KaKREqsHk24NwyUENSdnH0Nftj5aed6NZ6E9tUFtmh0IB6W5IJOmFrHUqK
	 okO0CpGUUA1TILurmkbNGvyKIxPyu9zyNuM6cenM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfJRWHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733061AbfJRWHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:07:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD4F22466;
        Fri, 18 Oct 2019 22:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436457;
        bh=diCshV9a4pVZR6o458+ck/iOrPs3rlpxB36EUXWPJYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNxQuVSPj5jnMoqlcdAQf/qptA+MFFpzv5Vk4drkq4EjILSB9GVCtHX+9vX33oVsf
         oFym5QnIaQoDg/MgMUjcBnkwf/pgFNf5mvEhS6WydLxyhhezVL8fq/epbyxpcVFQw4
         gep4yqD2bjm4BmLdgWqBMnEpF/d8nPPnoMRCmrOc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andreas Klinger <ak@it-klinger.de>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 089/100] iio: adc: hx711: fix bug in sampling of data
Date:   Fri, 18 Oct 2019 18:05:14 -0400
Message-Id: <20191018220525.9042-89-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Klinger <ak@it-klinger.de>

[ Upstream commit 4043ecfb5fc4355a090111e14faf7945ff0fdbd5 ]

Fix bug in sampling function hx711_cycle() when interrupt occures while
PD_SCK is high. If PD_SCK is high for at least 60 us power down mode of
the sensor is entered which in turn leads to a wrong measurement.

Switch off interrupts during a PD_SCK high period and move query of DOUT
to the latest point of time which is at the end of PD_SCK low period.

This bug exists in the driver since it's initial addition. The more
interrupts on the system the higher is the probability that it happens.

Fixes: c3b2fdd0ea7e ("iio: adc: hx711: Add IIO driver for AVIA HX711")
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/hx711.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 36b59d8957fb8..6c5d81a89aec9 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -109,14 +109,14 @@ struct hx711_data {
 
 static int hx711_cycle(struct hx711_data *hx711_data)
 {
-	int val;
+	unsigned long flags;
 
 	/*
 	 * if preempted for more then 60us while PD_SCK is high:
 	 * hx711 is going in reset
 	 * ==> measuring is false
 	 */
-	preempt_disable();
+	local_irq_save(flags);
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
 
 	/*
@@ -126,7 +126,6 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 */
 	ndelay(hx711_data->data_ready_delay_ns);
 
-	val = gpiod_get_value(hx711_data->gpiod_dout);
 	/*
 	 * here we are not waiting for 0.2 us as suggested by the datasheet,
 	 * because the oscilloscope showed in a test scenario
@@ -134,7 +133,7 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 * and 0.56 us for PD_SCK low on TI Sitara with 800 MHz
 	 */
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
-	preempt_enable();
+	local_irq_restore(flags);
 
 	/*
 	 * make it a square wave for addressing cases with capacitance on
@@ -142,7 +141,8 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 */
 	ndelay(hx711_data->data_ready_delay_ns);
 
-	return val;
+	/* sample as late as possible */
+	return gpiod_get_value(hx711_data->gpiod_dout);
 }
 
 static int hx711_read(struct hx711_data *hx711_data)
-- 
2.20.1

