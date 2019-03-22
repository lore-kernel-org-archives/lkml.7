Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D637921925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254933;
	bh=2XgAvsMbM6/Uztk4wzbNQHJGRo1fvJMeivVvIPWoLMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2m1WgGxMc1DtIZdQQYJwGf74+OR1Jm+F0qI6rbVAO+HGn0vwZiy7G97SPNYX0Q4/M
	 t45EKbmFSq5GLdiTFO7kOga2N94Ns/uiEX601tpZImt2yZolxvEBFoLNeMv4Xud4bY
	 rkge6bf6eWv1MrBnhrX621h1cShcEDUhSm31cUaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfCVLmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbfCVLmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:42:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A3F2082C;
        Fri, 22 Mar 2019 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254929;
        bh=2XgAvsMbM6/Uztk4wzbNQHJGRo1fvJMeivVvIPWoLMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYS+CPqMxzmMABVunyBf9P6ByWI2vJXhhqwcVzSUAvYv/a6+DUD82zfZb0Cg0M1J/
         QayY93Z1qH8IG/ZBWJoahHCjA34+NBHm4rCoQFkNCjahgLGohB92usZHj3tNNMVvO0
         r9W29nYTwMxV89U6clnBeyKzOVCiUQmXVXEB12Ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 054/118] spi: pxa2xx: Setup maximum supported DMA transfer length
Date:   Fri, 22 Mar 2019 12:15:26 +0100
Message-Id: <20190322111220.289891574@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit ef070b4e4aa25bb5f8632ad196644026c11903bf upstream.

When the commit b6ced294fb61

   ("spi: pxa2xx: Switch to SPI core DMA mapping functionality")

switches to SPI core provided DMA helpers, it missed to setup maximum
supported DMA transfer length for the controller and thus users
mistakenly try to send more data than supported with the following
warning:

  ili9341 spi-PRP0001:01: DMA disabled for transfer length 153600 greater than 65536

Setup maximum supported DMA transfer length in order to make users know
the limit.

Fixes: b6ced294fb61 ("spi: pxa2xx: Switch to SPI core DMA mapping functionality")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-pxa2xx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1668,6 +1668,7 @@ static int pxa2xx_spi_probe(struct platf
 			platform_info->enable_dma = false;
 		} else {
 			master->can_dma = pxa2xx_spi_can_dma;
+			master->max_dma_len = MAX_DMA_LEN;
 		}
 	}
 


