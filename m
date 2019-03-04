Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B722C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F3520863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687854;
	bh=eAXHzcf/YUyrwT9QVSneBxRyhZSCq753zJWOJS3sbFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bilp+OT8yNBsPo/lf6d726K304pb6gpZR85ySVbe7bjrvKI4YfZz1bulDYKkmD4BO
	 RxquXVpt7GaPfdqdEXruD3vvzkp/DbBgQRpAtIutKOY7l2cfr2cXgT6RYUtkCPBWO9
	 XluECyZfSHPEeOVhbWzcXU5SGJyIR0K9PbG7P89s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfCDIYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:24:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfCDIYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:24:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D960620863;
        Mon,  4 Mar 2019 08:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687849;
        bh=eAXHzcf/YUyrwT9QVSneBxRyhZSCq753zJWOJS3sbFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qenffC8agNe3Yw6fsah4fR1B04uYJt9/7S2pGmBYOU61X9ZUn06aAjNMRYmq+0iNC
         b2de7RHrsE9gAgB67VVFjRgYauxdCnfhuKH8Zc+dlumk9ekhpcPqN0/bf+o5XGgvlV
         r9YjJKPQ+IkUcBACKbQQL2D9CuujsxpUWP0y/6oo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.9 30/32] mmc: spi: Fix card detection during probe
Date:   Mon,  4 Mar 2019 09:22:18 +0100
Message-Id: <20190304081604.527445692@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
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
@@ -1450,6 +1450,7 @@ static int mmc_spi_probe(struct spi_devi
 		mmc->caps &= ~MMC_CAP_NEEDS_POLL;
 		mmc_gpiod_request_cd_irq(mmc);
 	}
+	mmc_detect_change(mmc, 0);
 
 	if (host->pdata && host->pdata->flags & MMC_SPI_USE_RO_GPIO) {
 		has_ro = true;


