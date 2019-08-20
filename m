Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B612C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBC422DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308550;
	bh=0dwwIdgtH7PjozajHkNaCBqCl7gFLOz9X/wet3Fyk8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r7Nt+V1zJRPHxE4M8X5yAp7JSU2CfzpJCyPPnqjstaUM5GkKVeUVY31UbHgAwWhkz
	 6TYqx7Au8cCfIfF2MlidPF+hiM/G9diUJLNE7wasHSSCUxgnq7UTAh4KYbhLWHhE70
	 SvETzpbN5iNPbjNNjeqDTQ8UbkoeNZYkyVXNVAa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfHTNm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730212AbfHTNm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:42:28 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5ED42339F;
        Tue, 20 Aug 2019 13:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308547;
        bh=0dwwIdgtH7PjozajHkNaCBqCl7gFLOz9X/wet3Fyk8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7/2Mj50JkiALmkRY+X4KLo/gIKjau8tq/bPk8OSR95Z8+VaEJBiB9ZFLFIAO45/W
         OLlowelJFS+9nqOfzu7RmrPL9LQM+3XtPTkLaAxrtflMJaYnYqWLs57ZSYwtZWEwJm
         z/8G83UNdvlR30R9FEjO7o2X2DQi9Cy870CJlDKk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/27] iio: adc: max9611: Fix temperature reading in probe
Date:   Tue, 20 Aug 2019 09:41:59 -0400
Message-Id: <20190820134213.11279-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134213.11279-1-sashal@kernel.org>
References: <20190820134213.11279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

[ Upstream commit b9ddd5091160793ee9fac10da765cf3f53d2aaf0 ]

The max9611 driver reads the die temperature at probe time to validate
the communication channel. Use the actual read value to perform the test
instead of the read function return value, which was mistakenly used so
far.

The temperature reading test was only successful because the 0 return
value is in the range of supported temperatures.

Fixes: 69780a3bbc0b ("iio: adc: Add Maxim max9611 ADC driver")
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/max9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index ce9af43fa2de7..49c1956e6a674 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -483,7 +483,7 @@ static int max9611_init(struct max9611_dev *max9611)
 	if (ret)
 		return ret;
 
-	regval = ret & MAX9611_TEMP_MASK;
+	regval &= MAX9611_TEMP_MASK;
 
 	if ((regval > MAX9611_TEMP_MAX_POS &&
 	     regval < MAX9611_TEMP_MIN_NEG) ||
-- 
2.20.1

