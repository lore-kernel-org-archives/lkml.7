Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE10C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B62921916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253748;
	bh=41TRVpiVFnxbv2ygo9WsDQT5PRbWlirCMdb/MvHvXFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dx0GEIWCGCiq20cIff3t22aLhaiKzM+srRC6XZetSEgGVQFec2ePHWoOH5/8cGfuw
	 Bkt40rGxkrGzxRS9Z9HyHddhIUNu1vLwBfwSCG3U51296dRf32iFNXU4NpvKWGJ16z
	 bKE1yIYN91VsAqxsn+c9ZFfLRHDz8AkTrpd/Qia0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfCVLW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbfCVLWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:22:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CD2218D4;
        Fri, 22 Mar 2019 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253742;
        bh=41TRVpiVFnxbv2ygo9WsDQT5PRbWlirCMdb/MvHvXFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzE2L1tCoqRt5m0+rENAmRx9PkbKQqj/Qw9TQDuc4xXM4QevvKNcQjYCH9+SBN8Xx
         rmSxZFOUjeOBAa8Be/h8bEt1deeuWHT9az/bSGkdpBFZmz0RbbS6/4WzEQptXkfFtt
         muHcqNM22pYBybiKblBqTEWY1TBX+YjDu1dpCj0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3.18 041/134] mmc: spi: Fix card detection during probe
Date:   Fri, 22 Mar 2019 12:14:14 +0100
Message-Id: <20190322111212.862771690@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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


