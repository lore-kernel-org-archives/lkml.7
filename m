Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C54208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688255;
	bh=nD5LMdzBOoX/D/CD8WkvTCfb7oz49uRwtzQwVfBk6Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JAXp9nsMfCycwFuVPncSo6k2HLOSqPjPKHvvfSxanrFQrWHjN+90UFczWOvgsxDRV
	 wA2px2t+WR3YpgaWDP65qtmJRyt+Tw0awiN3naLLvqG6LoltbEV8w65UHZPojKgdT4
	 1KgIa5o5/3CiylBrMxMwdJD1vyBZ1wQANVbQn4ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfCDIax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbfCDIau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B0120836;
        Mon,  4 Mar 2019 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688250;
        bh=nD5LMdzBOoX/D/CD8WkvTCfb7oz49uRwtzQwVfBk6Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VY6SE6623qF0UGW6oo5FvnhhsKZ1IFHgVGLjvpUyoL6wQ5+EhNJWfjpeELWbCSmzs
         XAeA54wmPCt6KAuyEdCXNXA9NfkJSehIKnPRobGON8/ePa+BWyJHONviI4XgshFtnn
         r6vn3vltljapVoIBfFL+ys5Yw/IoC+sGglZ1OcHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 65/78] mmc: spi: Fix card detection during probe
Date:   Mon,  4 Mar 2019 09:22:48 +0100
Message-Id: <20190304081628.469946570@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1447,6 +1447,7 @@ static int mmc_spi_probe(struct spi_devi
 		mmc->caps &= ~MMC_CAP_NEEDS_POLL;
 		mmc_gpiod_request_cd_irq(mmc);
 	}
+	mmc_detect_change(mmc, 0);
 
 	if (host->pdata && host->pdata->flags & MMC_SPI_USE_RO_GPIO) {
 		has_ro = true;


