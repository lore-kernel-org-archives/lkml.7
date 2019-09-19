Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA9C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD31420678
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931377;
	bh=xlj4YzSLybuhqRVuRFUgZO5wN1PoJ9k1JCxgoRxgs3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=usCWyN5uWZIlT3UOznaR2lQ3h+VJf5eUlXbQAlirO+WcTiKV4fYZ9eNsckFAp1rr7
	 XvEfSa4Qa5tvePa7xfFwnZTeKCK6yg+A8YhL30ycaUIdnwhB1xdisfbmQGkiF7n5bQ
	 55Qyq/zYNR9stlf4S1D5kmPZ64IJ3j8zv0OVAHkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406294AbfISWQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406266AbfISWQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:16:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 153C0218AF;
        Thu, 19 Sep 2019 22:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931367;
        bh=xlj4YzSLybuhqRVuRFUgZO5wN1PoJ9k1JCxgoRxgs3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAkKYE5nmg1u8Z87SMsqCzyIGy8AIJYDJzVJvK+cK0F4oiTX5HOE6lpaWmlehVKch
         6HuRDun1YQsnXTPjcLPYjN8Sf6ol9FWXTOriKGyaKV6YQ8qDEiLD7qHoVHHB43ZZEu
         Xg7B/HEX5wXJnMhBQvNd+ZYq8K13r2PCQ7yBs2rI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Reid <preid@electromag.com.au>,
        Moritz Fischer <mdf@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 20/59] fpga: altera-ps-spi: Fix getting of optional confd gpio
Date:   Fri, 20 Sep 2019 00:03:35 +0200
Message-Id: <20190919214801.744973272@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Reid <preid@electromag.com.au>

[ Upstream commit dec43da46f63eb71f519d963ba6832838e4262a3 ]

Currently the driver does not handle EPROBE_DEFER for the confd gpio.
Use devm_gpiod_get_optional() instead of devm_gpiod_get() and return
error codes from altera_ps_probe().

Fixes: 5692fae0742d ("fpga manager: Add altera-ps-spi driver for Altera FPGAs")
Signed-off-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/altera-ps-spi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 06d212a3d49dd..19b1cf8a82528 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -207,7 +207,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
 		return -EIO;
 	}
 
-	if (!IS_ERR(conf->confd)) {
+	if (conf->confd) {
 		if (!gpiod_get_raw_value_cansleep(conf->confd)) {
 			dev_err(&mgr->dev, "CONF_DONE is inactive!\n");
 			return -EIO;
@@ -263,10 +263,13 @@ static int altera_ps_probe(struct spi_device *spi)
 		return PTR_ERR(conf->status);
 	}
 
-	conf->confd = devm_gpiod_get(&spi->dev, "confd", GPIOD_IN);
+	conf->confd = devm_gpiod_get_optional(&spi->dev, "confd", GPIOD_IN);
 	if (IS_ERR(conf->confd)) {
-		dev_warn(&spi->dev, "Not using confd gpio: %ld\n",
-			 PTR_ERR(conf->confd));
+		dev_err(&spi->dev, "Failed to get confd gpio: %ld\n",
+			PTR_ERR(conf->confd));
+		return PTR_ERR(conf->confd);
+	} else if (!conf->confd) {
+		dev_warn(&spi->dev, "Not using confd gpio");
 	}
 
 	/* Register manager with unique name */
-- 
2.20.1



