Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DF5C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A4020863
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOsvPiUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfIHKMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:12:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38122 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfIHKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:12:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so9550452ljn.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1FZWc1l7HaSC+LrTIXPB2a9G73blmWE/aBz0iAX4uUs=;
        b=WOsvPiUncXIZqvxIApQgpCdpHVQb6ExjjUfUELzyS23qTnBbvN/xlPPFg6YFqSjAQk
         3UOXIMKw+RrnSp0HOm4XQWwI+u0P7bQi+49+SbLTZD0ZSng1wCi5vDWUpKgJtuqaEKfN
         Ninav7/5GzTRQftW8Pdryq5edF5eiM1k+C5FdR6g6hFzA3Vpm6cHAk5Z90Hv7xZE9iXu
         qpE4pKoNwFJMPDyjJjX1Rd8coNL9GW2k1pI8pnTnfmbUKH5hkZb4FSyEf05EzNx1C9/n
         pYiNPo3fUO/RTXSxdXXX9PWtt+ZHIe0VvUTfFVwpEco2ZVSy2WbS9l+1hnY1q34MAWcP
         0F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1FZWc1l7HaSC+LrTIXPB2a9G73blmWE/aBz0iAX4uUs=;
        b=QfQw9SH4RkZxmkWwSHjA5QzM8Cp8ChCuoLAPLQrpuiL0IJCSLZH3hGlKC15CRBUCGs
         HzpYaFlwTU2R2bdK9SaYyUqtTSuY7LkH1lJqWWfyUxbe3AqQiCI0j2wcUMmvWZmp1TwT
         TZ3oUw+h/TUhuzCjrqU5+qgNCgktpD5GzITduGZALJMPZcc9gyd+FECCkegjhFc1UdsZ
         ydFevzn+JDk2NIonFCE5dvRfw5PWAPcmUpU+3q9VieCr9UsuLrGTkEYb6JxYMe1m4UOh
         sFVRfrYV66YIoKhUnzL3fXR/RSxYdBuiQaysn6Qsh4vz6Sfro7LktGmTi6VH4cVhKdCA
         dpMA==
X-Gm-Message-State: APjAAAWGakuypCjF13TSZvCHsXPA3ARnw3MyZYPCVVaRNWaiGCA4Kan5
        PWXcI14CTvQoJY+TuHVSGH/Nkw==
X-Google-Smtp-Source: APXvYqyPDM2h2WAHw6dtKXlkzKVCCzbGVcDt15Oo/IvNMUVlrwBFocCJhR6QMkOF+Ftr65RWCZ3Ygw==
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr12295924ljo.131.1567937561969;
        Sun, 08 Sep 2019 03:12:41 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:41 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] mmc: core: PM fixes/improvements for SDIO IRQs 
Date:   Sun,  8 Sep 2019 12:12:25 +0200
Message-Id: <20190908101236.2802-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
	- Added reviewed/tested-by tags.
	- Updated some changelogs.
	- Renamed sdio_irq_enabled() to sdio_irq_claimed().
	- Don't set sdio_irq_pending when resuming SDIO card, but just queue the
	work.

The power management support for SDIO cards have slowly been improved, but
there are still quite some serious problems, especially when dealing with the
so called SDIO IRQs during system suspend/resume.

This series makes some additional improvements to this code in the mmc core,
but also includes some needed adaptations for the sdhci, the dw_mmc and the
mtk-sd host drivers.

The series is also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git sdio_irq_suspend_next_v2

Kind regards
Uffe


Matthias Kaehlcke (1):
  mmc: core: Move code to get pending SDIO IRQs to a function

Ulf Hansson (10):
  mmc: core: Add helper function to indicate if SDIO IRQs is enabled
  mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
  mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
  mmc: core: Clarify sdio_irq_pending flag for
    MMC_CAP2_SDIO_IRQ_NOTHREAD
  mmc: core: Clarify that the ->ack_sdio_irq() callback is mandatory
  mmc: core: WARN if SDIO IRQs are enabled for non-powered card in
    suspend
  mmc: core: Fixup processing of SDIO IRQs during system suspend/resume
  mmc: sdhci: Drop redundant check in sdhci_ack_sdio_irq()
  mmc: sdhci: Drop redundant code for SDIO IRQs
  mmc: sdhci: Convert to use sdio_irq_claimed()

 drivers/mmc/core/sdio.c            |  4 ++-
 drivers/mmc/core/sdio_irq.c        | 57 +++++++++++++++++++-----------
 drivers/mmc/host/dw_mmc.c          |  4 +++
 drivers/mmc/host/mtk-sd.c          |  3 ++
 drivers/mmc/host/sdhci-esdhc-imx.c | 34 ++++++++----------
 drivers/mmc/host/sdhci.c           | 12 ++-----
 drivers/mmc/host/sdhci.h           |  6 ----
 include/linux/mmc/host.h           | 10 ++++++
 8 files changed, 75 insertions(+), 55 deletions(-)

-- 
2.17.1

