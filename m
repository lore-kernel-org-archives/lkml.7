Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAE8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7490220674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497717;
	bh=3vG4EWMklZ0ESCIkXmbbYhT1dEFxQiPHgFy+ESs2VdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ufucY/16Gj21JOWv3IdtBaqjp/ALoSPvcnm3l8ujrLrI3yMg+kj3t3z3bD7VpAuxe
	 bCnqr2La1MnoCe2yuL5dtyauTYb27tSNDZcz8Rk1bAyM1cynQwqcjYctdShCrTOiJA
	 xkv65aW34/6kt54Eri5u+pj7e8EQiEDKx84pJsoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfKKSl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:41:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbfKKSlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:41:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F108214E0;
        Mon, 11 Nov 2019 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497713;
        bh=3vG4EWMklZ0ESCIkXmbbYhT1dEFxQiPHgFy+ESs2VdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2SmjJHETeK1pMkG0OM9tiw4ddMJTa8Q/a+J7MKAD2Z4MUFIqBgRHVZ1WTtrZEz0mV
         GRd5bSXuUKJU9sy5bxRDLAzXa4cNRiiooKVoHWGQgqmBoeKePyG+hDFadIi8Wi79qD
         IxBKXoHN4XLw5nFchlpmOnKoQIkouzEZ2HpIBc4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 034/125] iio: imu: adis16480: make sure provided frequency is positive
Date:   Mon, 11 Nov 2019 19:27:53 +0100
Message-Id: <20191111181445.151155830@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

commit 24e1eb5c0d78cfb9750b690bbe997d4d59170258 upstream.

It could happen that either `val` or `val2` [provided from userspace] is
negative. In that case the computed frequency could get a weird value.

Fix this by checking that neither of the 2 variables is negative, and check
that the computed result is not-zero.

Fixes: e4f959390178 ("iio: imu: adis16480 switch sampling frequency attr to core support")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/imu/adis16480.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -270,8 +270,11 @@ static int adis16480_set_freq(struct iio
 	struct adis16480 *st = iio_priv(indio_dev);
 	unsigned int t;
 
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
 	t =  val * 1000 + val2 / 1000;
-	if (t <= 0)
+	if (t == 0)
 		return -EINVAL;
 
 	t = 2460000 / t;


