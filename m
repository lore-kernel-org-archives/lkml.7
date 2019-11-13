Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0681FC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5FF2245C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eyAFFpQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfKMJq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:46:56 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59074 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfKMJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:46:55 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9jAoK083668;
        Wed, 13 Nov 2019 03:45:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573638310;
        bh=uqVnqEg7jfzzCNxKlUaeLRD250zrEeSg57M2s2f3wmI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eyAFFpQzIWXMss7edh7mGgf6r85grW1ciR5t+B3y0SIjacKUz++sBUtFJlxHJSfYu
         x6qrR8Vqgip05sTx6kuPhIYMdO5Fh2lFBiJ1C1bLIwbcX4hX5gRqvLcvCB6jvldE6R
         +1RcRmWseqaiO9ZWWOVBe4Xpfr5+R3OsFoDBW+NY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAD9jAJ8088897
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 03:45:10 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:44:51 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:44:51 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9j2KB078225;
        Wed, 13 Nov 2019 03:45:06 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <gregkh@linuxfoundation.org>, <linux@armlinux.org.uk>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <ldewangan@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <vkoul@kernel.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 1/3] tty: serial: amba-pl011: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:46:16 +0200
Message-ID: <20191113094618.1725-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113094618.1725-1-peter.ujfalusi@ti.com>
References: <20191113094618.1725-1-peter.ujfalusi@ti.com>
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
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index ae63266e181f..38e2d25f7e23 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -414,7 +414,7 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 	dma_cap_mask_t mask;
 
 	uap->dma_probed = true;
-	chan = dma_request_slave_channel_reason(dev, "tx");
+	chan = dma_request_chan(dev, "tx");
 	if (IS_ERR(chan)) {
 		if (PTR_ERR(chan) == -EPROBE_DEFER) {
 			uap->dma_probed = false;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

