Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A0CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3595E21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254170;
	bh=QeuM0FT3HlRjvSYyoje91/XHnysmpg2kj6kXeruHXGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XDuMZnnsLiBnb33VHccN+oCRLiFB74mNNvWQK+gXkmIk+b3Fgz4YHuQPmqMnbf7qv
	 f8ilQCEWmSVHNgaYOXhZLOQ5Dnnyp97aLEILQ6WZcmV3dVf2fs+mDPiqTCxnkEIfqL
	 KftczJQjOGvaJzZot2n8+jx/qjN0hPY3lvxtXbac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfCVL32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbfCVL3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:29:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8242B218B0;
        Fri, 22 Mar 2019 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254165;
        bh=QeuM0FT3HlRjvSYyoje91/XHnysmpg2kj6kXeruHXGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e65RV4E7dXj64kWP4OdZA2/T/FL8jz4eywT0U1o5vfrZS04Om/L7l7G9xbUbZkDYp
         OSb70xdFP1HwaKn901oW+vUEirRkQi6SID7niH8FL8cFYH/jF07v/YDOtdy+MHdJ/R
         x+VOtKXrkIakEzzswT8I0Vy0kL+Dya5iInl8nl7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.4 052/230] mmc: spi: Fix card detection during probe
Date:   Fri, 22 Mar 2019 12:13:10 +0100
Message-Id: <20190322111240.353474504@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

commit c9bd505dbd9d3dc80c496f88eafe70affdcf1ba6 upstream.

When using the mmc_spi driver with a card-detect pin, I noticed that the
card was not detected immediately after probe, but only after it was
unplugged and plugged back in (and the CD IRQ fired).

The call tree looks something like this:

mmc_spi_probe
  mmc_add_host
    mmc_start_host
      _mmc_detect_change
        mmc_schedule_delayed_work(&host->detect, 0)
          mmc_rescan
            host->bus_ops->detect(host)
              mmc_detect
                _mmc_detect_card_removed
                  host->ops->get_cd(host)
                    mmc_gpio_get_cd -> -ENOSYS (ctx->cd_gpio not set)
  mmc_gpiod_request_cd
    ctx->cd_gpio = desc

To fix this issue, call mmc_detect_change after the card-detect GPIO/IRQ
is registered.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/mmc_spi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1451,6 +1451,7 @@ static int mmc_spi_probe(struct spi_devi
 		if (status != 0)
 			goto fail_add_host;
 	}
+	mmc_detect_change(mmc, 0);
 
 	dev_info(&spi->dev, "SD/MMC host %s%s%s%s%s\n",
 			dev_name(&mmc->class_dev),


