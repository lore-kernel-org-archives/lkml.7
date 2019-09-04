Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F405C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC0C2070C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613295;
	bh=xlj4YzSLybuhqRVuRFUgZO5wN1PoJ9k1JCxgoRxgs3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rvFk9e9u+hMyIAdty7q1ZsNMZign5cVPcOtwEuypMpRc2lh08xvRYMTJ2Rk76b2yc
	 HJoFPkKJYDzweDU1Q5/EfqG0J6u1Nfzr1owDt1Lt4CWq22BSOrA+1MB2GPQGy9kzMi
	 SZkWIF8RCoVnIF27rCOYfD8LH9HbRTkOROZHQXTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbfIDQBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733013AbfIDQBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:01:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 452D123404;
        Wed,  4 Sep 2019 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612890;
        bh=xlj4YzSLybuhqRVuRFUgZO5wN1PoJ9k1JCxgoRxgs3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fc3kEbTZYisRGg6oMrZM7phQPlEP69zlCX3QoCV9Y2pddX+mAXnT7wW0UfSnpAzcx
         thDHSb9hwp7rwy7o4/w/ouHUig6uXzp8quFmNZfSiZBd1MBvEj1eWXb9QytdZanKMs
         JNZ8sSjqX1U1HSaPrYiFYsNStwFhIzcaZCoc0c/g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Phil Reid <preid@electromag.com.au>,
        Moritz Fischer <mdf@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-fpga@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/36] fpga: altera-ps-spi: Fix getting of optional confd gpio
Date:   Wed,  4 Sep 2019 12:00:53 -0400
Message-Id: <20190904160122.4179-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160122.4179-1-sashal@kernel.org>
References: <20190904160122.4179-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

