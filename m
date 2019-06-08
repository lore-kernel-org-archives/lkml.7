Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AFAC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0C821537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994942;
	bh=GN9fj8h0Z1VPlEI5dkPyZ16IY3nf3XZ6iJ2EyzKJuC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ok8w60AwJxjA3pUKOwRDx6yQFB3edHxXVcdj2DIghcbpVUAxvE57qMnmxUgmxUD6J
	 eoHKJMr0BFRk0/h1NvAimAOst3QQ228qIe26gGb7MsUEdT1uQtD7VzMkIbgt9J1j+K
	 N3lgRV4GjjYC9Pro/asxNDRTyxsTbd3e+2k/Gaz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfFHLzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbfFHLj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:39:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559A6214DA;
        Sat,  8 Jun 2019 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559993996;
        bh=GN9fj8h0Z1VPlEI5dkPyZ16IY3nf3XZ6iJ2EyzKJuC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HO/4WG+8c5/caVRyGJtm5bYWKRzo+iwk/5JQ5xRfQhJifPYlLN+d6dQcAgSIvDmK2
         HdluHhM1pSYiOiQnc5NhVX2RzIN/UfzSoMB0MhLzJ+8PCfn6/jghLzSFZtheGnE6RA
         EE36Vs3zaw84C9j5Kh94WpoSqcXO/nV8hTYZDEx4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 04/70] iio: adc: ti-ads8688: fix timestamp is not updated in buffer
Date:   Sat,  8 Jun 2019 07:38:43 -0400
Message-Id: <20190608113950.8033-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Nyekjaer <sean@geanix.com>

[ Upstream commit e6d12298310fa1dc11f1d747e05b168016057fdd ]

When using the hrtimer iio trigger timestamp isn't updated.
If we use iio_get_time_ns it is updated correctly.

Fixes: 2a86487786b5c ("iio: adc: ti-ads8688: add trigger and buffer support")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ti-ads8688.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 8b4568edd5cb..7f16c77b99fb 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -397,7 +397,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-			pf->timestamp);
+			iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.20.1

