Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B2FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B3F21903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127044;
	bh=XL+NTDVkUHk0deZSJSKYKtEdcHz6bmfVzP3Azt4Glc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VG5Y90QGoV2RSzXpGfRy3gl1ULFiAxS6VZKXvYS9pmUjMPvPGyKRyoD0CAf4JwSrk
	 XwOBg1XjZJcaexZDS00vU22J8RRDHN3UXLQwx4ayanY7A5wv65ACqt7pSPJO+Sig7k
	 0Yo0wBIF2uRxoVcEQVjqhDl6y3CZsl3kd79XMjco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391040AbfDXRan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391025AbfDXRaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:39 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E01F218B0;
        Wed, 24 Apr 2019 17:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127038;
        bh=XL+NTDVkUHk0deZSJSKYKtEdcHz6bmfVzP3Azt4Glc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEcJBGtbX746dQDtdS4xP/YSn3dFIM8ZeCNKGD+QFeNyNQh5Chlkc+bUId4cnizxF
         ugThceSdJvNl3HpaL3U9KEvoDCMgQiPyBARCGC7/dh1+muidNhvDHiZlNC747sc/6t
         x8+OGGHSxhRSpfQLAKA5uP7J4Wq2c/WQ5qKVS77o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 37/96] iio/gyro/bmg160: Use millidegrees for temperature scale
Date:   Wed, 24 Apr 2019 19:09:42 +0200
Message-Id: <20190424170922.410929935@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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
@@ -582,11 +582,10 @@ static int bmg160_read_raw(struct iio_de
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		return bmg160_get_filter(data, val);
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
@@ -594,6 +593,7 @@ static int bmg160_read_raw(struct iio_de
 			for (i = 0; i < ARRAY_SIZE(bmg160_scale_table); ++i) {
 				if (bmg160_scale_table[i].dps_range ==
 							data->dps_range) {
+					*val = 0;
 					*val2 = bmg160_scale_table[i].scale;
 					return IIO_VAL_INT_PLUS_MICRO;
 				}


