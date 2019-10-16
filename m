Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05403FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C746320872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263491;
	bh=y7sgHoGnXAsezDdMfpycMHUY/pshOqLcSCc0e5fWPhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yp3Ntr0P9UOfSKb8tKOfksg8/nOXIHEeHH+aWQAFc7hNOHvQtt2xaejV9M065uFLK
	 57Dbp+FLeieYzOScfVRFgbM9ox0rco+5KQ8wy3xCeKWR4cajHS3FtUF1/Jb4CpQyIl
	 xw0n8zr8MlGrPIzsaLYZUoXjxnNXH7GUd0KiiHZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406882AbfJPWEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438344AbfJPV66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:58 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E2821925;
        Wed, 16 Oct 2019 21:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263138;
        bh=y7sgHoGnXAsezDdMfpycMHUY/pshOqLcSCc0e5fWPhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqKaL00wTSY1xsmYWqKFVqeNIa1lzcFXyaF3t4jknZEqi94wG5CgcuoGsjgq3pD0f
         ER/gtGCW+9If+ZppLhSybvcc9hoIEcicmWYDOjvoek2+aDhOTQI1Rj7MYQN+B1P2xp
         OqKsg0hft5swCOsLCHnFDdFEy0gcYvYxBnCAd6wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.3 061/112] iio: accel: adxl372: Perform a reset at start up
Date:   Wed, 16 Oct 2019 14:50:53 -0700
Message-Id: <20191016214900.706636626@linuxfoundation.org>
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

commit d9a997bd4d762d5bd8cc548d762902f58b5e0a74 upstream.

We need to perform a reset a start up to make sure that the chip is in a
consistent state. This reset also disables all the interrupts which
should only be enabled together with the iio buffer. Not doing this, was
sometimes causing unwanted interrupts to trigger.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Fixes: f4f55ce38e5f ("iio:adxl372: Add FIFO and interrupts support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/adxl372.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -575,6 +575,14 @@ static int adxl372_setup(struct adxl372_
 		return -ENODEV;
 	}
 
+	/*
+	 * Perform a software reset to make sure the device is in a consistent
+	 * state after start up.
+	 */
+	ret = regmap_write(st->regmap, ADXL372_RESET, ADXL372_RESET_CODE);
+	if (ret < 0)
+		return ret;
+
 	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
 	if (ret < 0)
 		return ret;


