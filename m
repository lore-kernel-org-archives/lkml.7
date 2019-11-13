Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A7CC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC032067B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KLWj7D24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKMJYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:24:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45808 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfKMJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:24:03 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Ni1Y116403;
        Wed, 13 Nov 2019 03:23:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573637024;
        bh=Pd7tbII3LTzmwqzjX5nu8oaCrrcLyiWtQxt68IJs78c=;
        h=From:To:CC:Subject:Date;
        b=KLWj7D24kAV3aWTlGgcNMSxrOwHUtQLeIfmUwQLKlsAlpTmLNtKhcjIu3LpKrDaK7
         Ft9W+z605lT6o0X7uWlNIcsA7/IjSoXt/dEm2aV5QrDPgGlPOkfJCA87C+DBGZuYBG
         8ndM8luWeZ8IFCjEvfgAViiOY3rXC5Yiw4TlKmEA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAD9Nhdq051974
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 03:23:44 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:23:22 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:23:22 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Nbnb065233;
        Wed, 13 Nov 2019 03:23:38 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <jic23@kernel.org>
CC:     <vkoul@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pmeerw@pmeerw.net>
Subject: [PATCH] iio: buffer-dmaengine: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:24:53 +0200
Message-ID: <20191113092453.30838-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index bea4a75e92f1..b7b5a934e9b2 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -150,7 +150,7 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	if (!dmaengine_buffer)
 		return ERR_PTR(-ENOMEM);
 
-	chan = dma_request_slave_channel_reason(dev, channel);
+	chan = dma_request_chan(dev, channel);
 	if (IS_ERR(chan)) {
 		ret = PTR_ERR(chan);
 		goto err_free;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

