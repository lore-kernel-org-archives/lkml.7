Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8FF2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3DH5gs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfFTLQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:16:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41450 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfFTLQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:16:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so2136687lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c6iQkmmugLgkKQH3tZ6ZgGxpxMt5nwzcVaiLxHlgP6Y=;
        b=W3DH5gs7gzWVHxwNMOoq96D4jERRJfA72DAS1CaIDm4AZ6F5CnkkMIFPIY+l12J1Q1
         kZPsQkSSoz151c0chEwDJCQIUpZFInUGQILOk8IxKlh+iCvtw6QsrUVM87CGm/pRhREq
         UqSYdUMSWwWGIwCWXUNs5xoxpg61V18wH4rMnRj3Em2EcPfl9iX7lGggVAG8pCI9hppZ
         jGPhDK5e8DU7TaztMysdH5lcGNrGLoRJzHW2RkYl7gNrY81CJY0Jm7Ya4jL2Z8ixzcNq
         8bS7XoErntFk1chDcZutxVpx2SXYvY89CwuS0iMsxiGoUYyIiAPkqbKMwChrERe3VktX
         /UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c6iQkmmugLgkKQH3tZ6ZgGxpxMt5nwzcVaiLxHlgP6Y=;
        b=W4poIJIQzJvRKLoHLU18DlItcEbF6L40HqCyhNaB6bjP8UCZL4hsKVk94SsNMNit0L
         aGQynJzsjCQsoW3OlXgpQ0c4iTJ6GB2wgP09mTXKlpKBBHz+P47jj1k4ZOJAQk/pb758
         AmbE67+uCRCKxyH740gla52Z8ijOibWqnIu82cZhlgoliZXDlszn8KxCZO3+f0/hrXrh
         2FVmV91/HruGBW8cvQ9NXDkVclxo6K498Sjq+RELCe3B79v6IKZwMjQ2xxhtYS729fbd
         cN6r79FtLG4v3aNgvrKHGiDmMhbEsEXR73CCWa0GJM/JForKZrefWEPzAJ104OAgPcz5
         GVjg==
X-Gm-Message-State: APjAAAXzNUbwiEWTxcWgNHh8iNP3Yz4509lQbOpQipewOLSVos6AsLjv
        TP2J/sJHf9VhHeDtlFppCRBeWA==
X-Google-Smtp-Source: APXvYqxDPgRTsCyMwsJ3hroh4cJ/q57m0sncv+riRbKKWMBweWRucrVlRODHzOmTdwtuvJnlCe8/bA==
X-Received: by 2002:ac2:50cd:: with SMTP id h13mr28508702lfm.36.1561029364872;
        Thu, 20 Jun 2019 04:16:04 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id s20sm3055858lfb.95.2019.06.20.04.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 04:16:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [GIT PULL] MMC fixes for v5.2-rc6
Date:   Thu, 20 Jun 2019 13:16:02 +0200
Message-Id: <20190620111602.17958-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with quite a few MMC fixes intended for v5.2-rc6. This time the PR
also contains fixes for a WiFi driver, which device is attached to the SDIO
interface. Patches for the WiFi driver have been acked by the corresponding
maintainers. More details about the highlights are as usual found in the signed
tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-rc4

for you to fetch changes up to 83293386bc95cf5e9f0c0175794455835bd1cb4a:

  mmc: core: Prevent processing SDIO IRQs when the card is suspended (2019-06-18 14:06:32 +0200)

----------------------------------------------------------------
MMC core:
 - Make switch to eMMC HS400 more robust for some controllers
 - Add two SDIO func API to manage re-tuning constraints
 - Prevent processing SDIO IRQs when the card is suspended

MMC host:
 - sdhi: Disallow broken HS400 for M3-W ES1.2, RZ/G2M and V3H
 - mtk-sd: Fixup support for SDIO IRQs
 - sdhci-pci-o2micro: Fixup support for tuning

Wireless BRCMFMAC (SDIO):
 - Deal with expected transmission errors related to the idle states
   (handled by the Always-On-Subsystem or AOS) on the SDIO-based WiFi on
   rk3288-veyron-minnie, rk3288-veyron-speedy and rk3288-veyron-mickey.

----------------------------------------------------------------
Douglas Anderson (5):
      Revert "brcmfmac: disable command decode in sdio_aos"
      mmc: core: API to temporarily disable retuning for SDIO CRC errors
      brcmfmac: sdio: Disable auto-tuning around commands expected to fail
      mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
      brcmfmac: sdio: Don't tune while the card is off

Raul E Rangel (1):
      mmc: sdhci: sdhci-pci-o2micro: Correctly set bus width when tuning

Ulf Hansson (1):
      mmc: core: Prevent processing SDIO IRQs when the card is suspended

Wolfram Sang (2):
      mmc: sdhi: disallow HS400 for M3-W ES1.2, RZ/G2M, and V3H
      mmc: core: complete HS400 before checking status

jjian zhou (2):
      mmc: mediatek: fix SDIO IRQ interrupt handle flow
      mmc: mediatek: fix SDIO IRQ detection issue

 drivers/mmc/core/core.c                            |  5 +-
 drivers/mmc/core/mmc.c                             |  6 +-
 drivers/mmc/core/sdio.c                            | 13 +++-
 drivers/mmc/core/sdio_io.c                         | 77 ++++++++++++++++++++++
 drivers/mmc/core/sdio_irq.c                        |  4 ++
 drivers/mmc/host/mtk-sd.c                          | 39 ++++++-----
 drivers/mmc/host/renesas_sdhi_core.c               |  9 ++-
 drivers/mmc/host/sdhci-pci-o2micro.c               |  5 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 17 +++--
 include/linux/mmc/host.h                           |  1 +
 include/linux/mmc/sdio_func.h                      |  6 ++
 11 files changed, 151 insertions(+), 31 deletions(-)
