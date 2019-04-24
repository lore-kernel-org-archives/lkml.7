Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C72C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E031D206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126105;
	bh=0pH6giZBP5EWcjVy6UHsSs54vJYzgd7pl1/aNWcWw6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gXY6FSWrPReNtjPePARXc8c2YhlVZeOeZbp5o5RflLjf+O20pfp5Y7yX7oxhJjaej
	 9raB4jVXlfoFqr5PnVmb8Epu9T2uKAJSXCKeW+MoofdjoD9gjCsjhJr9nHrf4YS934
	 Bm6e6A0N4aujHJU5S8uMIU2Q2Ow3w3x9CMB87z30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbfDXRPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387432AbfDXRPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:15:00 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6575721900;
        Wed, 24 Apr 2019 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126099;
        bh=0pH6giZBP5EWcjVy6UHsSs54vJYzgd7pl1/aNWcWw6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqvrsEdCh6RYBAqmJk016+w6Lp0VAYy+Jd7VX/BfrG5ccnmk9PgiOl5rXty4Z9IkM
         Y20eF7wATwe+6KHrB9drkX4YwQAAF87fXdJMqeRkmAF9BuoT3Umeoxxbkf4qV+8xgT
         FL0GV3GwY1F87mTOd+BHW0+GSczfomEGznIl3Abc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3.18 095/104] iio: ad_sigma_delta: select channel when reading register
Date:   Wed, 24 Apr 2019 19:09:52 +0200
Message-Id: <20190424170909.856821568@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

commit fccfb9ce70ed4ea7a145f77b86de62e38178517f upstream.

The desired channel has to be selected in order to correctly fill the
buffer with the corresponding data.
The `ad_sd_write_reg()` already does this, but for the
`ad_sd_read_reg_raw()` this was omitted.

Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/ad_sigma_delta.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -121,6 +121,7 @@ static int ad_sd_read_reg_raw(struct ad_
 	if (sigma_delta->info->has_registers) {
 		data[0] = reg << sigma_delta->info->addr_shift;
 		data[0] |= sigma_delta->info->read_mask;
+		data[0] |= sigma_delta->comm;
 		spi_message_add_tail(&t[0], &m);
 	}
 	spi_message_add_tail(&t[1], &m);


