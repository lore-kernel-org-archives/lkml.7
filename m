Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A77C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC5724CE2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188021;
	bh=gPq7/Es2MUJDAPUJFUxdqzEFrIWAU7SZEDLJAutsj6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z3OruJ8sxsUT5ITZBLyvZct3uYRjTmOUuf3+/SJmkBvuj9NuRmfOCkPNR8Ev5d+FX
	 4mcht8ATojNu3FogOexoOYcSPgSP3tn29an6Mwm++eMcWzMse2ESq1vqf0V5JwVFwO
	 /CQkmjngQ4i1OrxB2SzRNZQSb+gohYAKF8All668=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbfE3Dq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732261AbfE3DUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:20:36 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D73F2494A;
        Thu, 30 May 2019 03:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186435;
        bh=gPq7/Es2MUJDAPUJFUxdqzEFrIWAU7SZEDLJAutsj6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omM6IKw1jm/lZUXBVXtMfr7c+45wsVfPrRwZ1CXwIVJwfNU3SJGifC4pLjv54Bylk
         DHks3lcR6AjxUxn5bqrfS924aqZLIbIyoiCSvrrV+UomzejBxGZvN1H37xXkC3/Tbn
         C3W+0SGxum+Dn7mMFVHTur1ldDsMdGNwoZviNI7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 031/128] spi: pxa2xx: fix SCR (divisor) calculation
Date:   Wed, 29 May 2019 20:06:03 -0700
Message-Id: <20190530030440.229574563@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 29f2133717c527f492933b0622a4aafe0b3cbe9e ]

Calculate the divisor for the SCR (Serial Clock Rate), avoiding
that the SSP transmission rate can be greater than the device rate.

When the division between the SSP clock and the device rate generates
a reminder, we have to increment by one the divisor.
In this way the resulting SSP clock will never be greater than the
device SPI max frequency.

For example, with:

 - ssp_clk  = 50 MHz
 - dev freq = 15 MHz

without this patch the SSP clock will be greater than 15 MHz:

 - 25 MHz for PXA25x_SSP and CE4100_SSP
 - 16,56 MHz for the others

Instead, with this patch, we have in both case an SSP clock of 12.5MHz,
so the max rate of the SPI device clock is respected.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f2209ec4cb68d..8b618f0fa459f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -921,10 +921,14 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 
 	rate = min_t(int, ssp_clk, rate);
 
+	/*
+	 * Calculate the divisor for the SCR (Serial Clock Rate), avoiding
+	 * that the SSP transmission rate can be greater than the device rate
+	 */
 	if (ssp->type == PXA25x_SSP || ssp->type == CE4100_SSP)
-		return (ssp_clk / (2 * rate) - 1) & 0xff;
+		return (DIV_ROUND_UP(ssp_clk, 2 * rate) - 1) & 0xff;
 	else
-		return (ssp_clk / rate - 1) & 0xfff;
+		return (DIV_ROUND_UP(ssp_clk, rate) - 1)  & 0xfff;
 }
 
 static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
-- 
2.20.1



