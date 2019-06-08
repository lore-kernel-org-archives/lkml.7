Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B1BC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3580F21530
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559993995;
	bh=A8FqirUwTzG0BWwVtvrM/Y4DGGp6AkDG3NEkvc3yBe0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VDRREtWGk41T8nW4T5zA/4XZZk93CTwI/0B25+ZwHjGXbxWv41qdx/D9Pxwf94A8E
	 kelkI5m1SlHmlIOxYBklLIgSnEw9yM5uGTZf/lgn7B+pnsScVVGNVON2eE0eKlV7++
	 Zy5viUHa1Wfi21KRZ1T+SAw2K7JIGp6wGlxV5/Is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfFHLjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbfFHLjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:39:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FA8214AF;
        Sat,  8 Jun 2019 11:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559993992;
        bh=A8FqirUwTzG0BWwVtvrM/Y4DGGp6AkDG3NEkvc3yBe0=;
        h=From:To:Cc:Subject:Date:From;
        b=KtaqAeKsdCScsR+jNzG6DPIg2BksCjeh+AEBT1SNeRYGAgMxdJa6is46lK4+qAyLG
         XxlnTow0OkOl6tVKjQxr/iVDYlYRreXJL8HHyjgbQ1X00QygR4SqzmW5vRHIdMpcmJ
         uYYhC7Jsf+BtLE0isM7eP1BXjD+ql7XCKVOtmNw0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Dan Murphy <dmurphy@ti.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 01/70] iio: adc: ads124: avoid buffer overflow
Date:   Sat,  8 Jun 2019 07:38:40 -0400
Message-Id: <20190608113950.8033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Stehlé <vincent.stehle@laposte.net>

[ Upstream commit 0db8aa49a97e7f40852a64fd35abcc1292a7c365 ]

When initializing the priv->data array starting from index 1, there is one
less element to consider than when initializing the full array.

Fixes: e717f8c6dfec8f76 ("iio: adc: Add the TI ads124s08 ADC code")
Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Reviewed-by: Dan Murphy <dmurphy@ti.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ti-ads124s08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 53f17e4f2f23..552c2be8d87a 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -202,7 +202,7 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
 	};
 
 	priv->data[0] = ADS124S08_CMD_RDATA;
-	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data));
+	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data) - 1);
 
 	ret = spi_sync_transfer(priv->spi, t, ARRAY_SIZE(t));
 	if (ret < 0)
-- 
2.20.1

