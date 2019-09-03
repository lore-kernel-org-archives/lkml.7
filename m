Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1398AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD1B2341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOUvGuZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfICOWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:22:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41975 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfICOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:22:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id j4so13036519lfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jxeGFOcZojq09mDU5ChwaMdlo1ENQtr/dK8PzPkIcNw=;
        b=kOUvGuZPDWhYmoFZ35uZfgKof779e/mNRWaIlCuKoDc0z3PMHRNxbDGTHBXqZz/2iX
         OSKysAxrn1xT+ofGb+IXLEQgvcNF0k9/Tn7YqJc2ZYwjSaGQl4RkDUQjiBAfnJMNUOV4
         iE1GyRugTEu3VYfJInaXRoeFiej1bLSQBZ7NBwz3WnFC25vDBmuusqNYItGjFwbLtlDX
         aqgKGQ0I/2WguqVVqp2ALpPELYXObaA8Vz/6M+j1xt6Vy0ulakacsE45tKyvIQQhOpjE
         zhMsdp7RQhJE4lJaf1MYw3tzhQumhHZbkTP21KOW3EmBVEAwibHTnZ+dhArKcBLzP8Tg
         nQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jxeGFOcZojq09mDU5ChwaMdlo1ENQtr/dK8PzPkIcNw=;
        b=kJ4o5ki87yfq/CPIRFZCmdYtT3liT5rT7XBOQDdpjkI89wm0iZfFCqId2FeJ2HcoTW
         YYg4k5Ziq/F0xRaRarQikqND78wy+pTGaRdeXPH8tRkTdgNiExwZv3aso4O91BTxwZAh
         UFH7mmJZhLyIDqxN+77PRtyEHvdCxkBtF9coKfcN7kifuiGxn6A/axHWT8uZ6ssiYPo5
         67gmKIJk7ruqmg2uMJXcpt30TjgY7fP5QbhcX8qW2QstPn6LKdDni/MWMz8S4P8IgGHN
         BQE05bLmKZt+MRe0vd4rmt+HyaWQFU26J2RATTR93d07xrZKhCdn+tAFhYBwH3yll1e8
         ZKQw==
X-Gm-Message-State: APjAAAUzubcSCDk21CkURHRNg72f4TMNBZR2CkXBClBhey483q0BLUvi
        QGRyRYAZg+Bj0KyeK015Xpa8Aw==
X-Google-Smtp-Source: APXvYqw8xc5Srvx7uVIgZ6CAWg48jVMdxECIPClJ1jocPjMMn6ha3+WY+sH6SwYYQ8AJcdr0Js7Fsg==
X-Received: by 2002:ac2:5dfa:: with SMTP id z26mr13175013lfq.37.1567520553527;
        Tue, 03 Sep 2019 07:22:33 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:32 -0700 (PDT)
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
Subject: [PATCH 00/11] mmc: core: PM fixes/improvements for SDIO IRQs 
Date:   Tue,  3 Sep 2019 16:21:56 +0200
Message-Id: <20190903142207.5825-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power management support for SDIO cards have slowly been improved, but
there are still quite some serious problems, especially when dealing with the
so called SDIO IRQs during system suspend/resume.

This series makes some additional improvements to this code in the mmc core,
but also includes some needed adaptations for the sdhci, the dw_mmc and the
mtk-sd host drivers.

So far the series has only been compile tested, so definitely need some help in
testing this on HW, which of course would be greatly appreciated.

The series is also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git sdio_irq_suspend_next

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
  mmc: sdhci: Convert to use sdio_irq_enabled()

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

