Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B8621916
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126630;
	bh=vuYyfCnrgjJUfh1Jlk1Uhxya4XCye2XUW2FUapDS6m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uoLOYescdV7c76xVkqbUEK/Woe48YanfGoqQOAdM3F80QoJsWFrZByboBypdJsSYW
	 S5zi0Fd8/6qMO3zMbx9NUYWZeI9gZaaQnWRH8YTbsga7EenCk+EYqz9kjERffZ36i4
	 SG948VAW+pN4hqueqKB2dj0DRN054ollWoJ01RXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbfDXRXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389461AbfDXRXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:23:44 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A78920675;
        Wed, 24 Apr 2019 17:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126623;
        bh=vuYyfCnrgjJUfh1Jlk1Uhxya4XCye2XUW2FUapDS6m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcTZQIJ1E5GLqJ0U4hWV7Lkt2te7hHHmeFCbMjo4u9MFDxLVwzDCKR0nemPH3wkkN
         RNolPS/JVAka4OThXg7mV9kfokd6I00G2uN2FLTuCH2g0GY3s4qbz+35EWFM+fTRzM
         J3JvTOMvf7vLZm9tp+9p419lgI5n0j338VdWytWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.4 149/168] iio/gyro/bmg160: Use millidegrees for temperature scale
Date:   Wed, 24 Apr 2019 19:09:53 +0200
Message-Id: <20190424170932.015316407@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Looijmans <mike.looijmans@topic.nl>

commit 40a7198a4a01037003c7ca714f0d048a61e729ac upstream.

Standard unit for temperature is millidegrees Celcius, whereas this driver
was reporting in degrees. Fix the scale factor in the driver.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/gyro/bmg160_core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -519,11 +519,10 @@ static int bmg160_read_raw(struct iio_de
 		} else
 			return -EINVAL;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val2 = 500000;
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val = 500;
+			return IIO_VAL_INT;
 		case IIO_ANGL_VEL:
 		{
 			int i;
@@ -531,6 +530,7 @@ static int bmg160_read_raw(struct iio_de
 			for (i = 0; i < ARRAY_SIZE(bmg160_scale_table); ++i) {
 				if (bmg160_scale_table[i].dps_range ==
 							data->dps_range) {
+					*val = 0;
 					*val2 = bmg160_scale_table[i].scale;
 					return IIO_VAL_INT_PLUS_MICRO;
 				}


