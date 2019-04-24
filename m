Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E850DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB16A21905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127363;
	bh=0pH6giZBP5EWcjVy6UHsSs54vJYzgd7pl1/aNWcWw6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FWVebkCXR2leaUNydd7bhAQDb4wAW5wnXzrNkOKZADE/b7vpw7KgGux93JXm1PEWE
	 sDblyM+LMY7gYcTmlwysKWunumt6MAkBm/RzNgy+S5TU5SFZ4D492Nb03gi4p2Yag+
	 JtqUVR5deo06VnMDb8GBYSSbgRNm47XMoQuLRylk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392025AbfDXRgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391598AbfDXRf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:56 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF2920675;
        Wed, 24 Apr 2019 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127356;
        bh=0pH6giZBP5EWcjVy6UHsSs54vJYzgd7pl1/aNWcWw6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gURLzCv78GQ8hHQIftJMsHQLiau1qAmTc6wRw0O3dB3eENgsR2XU5h2Ok9YZKueeh
         U32Kiq2oubxeZHiNU4RmD6sTXGcHshYmBCFact9Kj1JCt4FA3/B5KZrhP9Vi+Tdnh8
         4a6dr3t/Ep+OpDNqxlycSXY4SxB5WPeuBf8aJMTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.0 059/115] iio: ad_sigma_delta: select channel when reading register
Date:   Wed, 24 Apr 2019 19:09:55 +0200
Message-Id: <20190424170928.628801733@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
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


