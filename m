Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F43FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A5D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128137;
	bh=0pH6giZBP5EWcjVy6UHsSs54vJYzgd7pl1/aNWcWw6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K4g+62RN/BqxPb4PF8uubIqDEc1N8aO0xNedqM4quU6oehZb1ykU/aWa10v3xzN9R
	 DCer/U0PuR9zz4iAdw8Fpux2OabEFfdNkkuq/eLuUp0FnKfIQdGH6waUGmnuDsUMXe
	 mXSxdlg22+/MP9r9+HjEipZf2/iOOjwIOQv41gdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391854AbfDXRs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391046AbfDXRaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:52 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE6A2054F;
        Wed, 24 Apr 2019 17:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127052;
        bh=0pH6giZBP5EWcjVy6UHsSs54vJYzgd7pl1/aNWcWw6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=poLNs6QfKrmcn5GJqjX8HX5xj+8KC0EiEgMmwwQz5+0+r2cn7OBj/5LOYo0TpeUJN
         ISz8AYEr5otynsP1L6E2sC8iMbRLkhtY2iZu1tnfjvkfFZ3scJ0wI0Kc2/GskCIDui
         sycmMv9OTPp3xF8obM+k/vL9KXFL6NZC0eAwNUPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 41/96] iio: ad_sigma_delta: select channel when reading register
Date:   Wed, 24 Apr 2019 19:09:46 +0200
Message-Id: <20190424170922.667025843@linuxfoundation.org>
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


