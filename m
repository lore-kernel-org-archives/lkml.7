Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E9EFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC3320872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263502;
	bh=6Tth2jOeWpDQ2aUcTiGK2l5Bgddx8M/sL5/m/fEewoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WI3fVXyqMGBBWupL1B8eDguEAYsLXkq1io0U4Hm5K6FKkDiHEfWfrrDKM+KtZY80N
	 rfKMHol7bKfaJhssEHxzJr8Qre6KH8rYMjQeJp7N8pB5Frtu0+/NweUU5BKOKa912E
	 vBK4bGFzCDNpSGX1+++gwRYDzE4FfWG5oVoy6zF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406900AbfJPWFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438325AbfJPV64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:56 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C15E20872;
        Wed, 16 Oct 2019 21:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263135;
        bh=6Tth2jOeWpDQ2aUcTiGK2l5Bgddx8M/sL5/m/fEewoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbQj6P92cG49D9P0zGqqvrMxbi7xH6PlbWeV8VcrseNx8xcYTmLN75cHuV7xAnCe/
         IuAbhu8Ushz/PF66R3RCeWxDfxZcJDm8ZoZjtIIsaB5Sbg2dmqbcfvEmP5yzPdf1yU
         IImNoxLP0vsoX5/hQk0cBzofMcsGNXduMW/VWVvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.3 059/112] iio: accel: adxl372: Fix/remove limitation for FIFO samples
Date:   Wed, 16 Oct 2019 14:50:51 -0700
Message-Id: <20191016214900.232869545@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

commit d202ce4787e446556c6b9d01f84734c3f8174ba3 upstream.

Currently, the driver sets the FIFO_SAMPLES register with the number of
sample sets (maximum of 170 for 3 axis data, 256 for 2-axis and 512 for
single axis). However, the FIFO_SAMPLES register should store the number
of samples, regardless of how the FIFO format is configured.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Fixes: f4f55ce38e5f ("iio:adxl372: Add FIFO and interrupts support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/adxl372.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -474,12 +474,17 @@ static int adxl372_configure_fifo(struct
 	if (ret < 0)
 		return ret;
 
-	fifo_samples = st->watermark & 0xFF;
+	/*
+	 * watermark stores the number of sets; we need to write the FIFO
+	 * registers with the number of samples
+	 */
+	fifo_samples = (st->watermark * st->fifo_set_size);
 	fifo_ctl = ADXL372_FIFO_CTL_FORMAT_MODE(st->fifo_format) |
 		   ADXL372_FIFO_CTL_MODE_MODE(st->fifo_mode) |
-		   ADXL372_FIFO_CTL_SAMPLES_MODE(st->watermark);
+		   ADXL372_FIFO_CTL_SAMPLES_MODE(fifo_samples);
 
-	ret = regmap_write(st->regmap, ADXL372_FIFO_SAMPLES, fifo_samples);
+	ret = regmap_write(st->regmap,
+			   ADXL372_FIFO_SAMPLES, fifo_samples & 0xFF);
 	if (ret < 0)
 		return ret;
 


