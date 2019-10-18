Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2975CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E3E21D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMoXTlqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407941AbfJRKIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:08:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44832 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407747AbfJRKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:08:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so5586939ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=q1/kouGHNSHjsTnVr5JR5wPq5E3JDIov11IhxvB0x4M=;
        b=mMoXTlqjYb6Fj1JD+8Ey2QBWeRvXrJiTFv2PkD6Fj8C6KeZ0a8rKjZghzQLnd3tFwY
         A/QsrZ62UFp6pIfYprl27NE3EAUMsFQyjAnsehjXB0aZ5/xDqs412HGqUMfdvRCRZNRA
         r+KLfcnAdm/CnUqg0b9zoqf04V6HFn+HAl4t7CJHqpcT4M3JG7gWl5D0q9T54pDXHDzq
         JpcF/gr/pTBw9pO2OwNbQa39XZfziXzaNpVQRGAhTRgQUaCOeTLvndauZBWJk7chSkhm
         tI6umHGCYzj8PCWmYHZazd6KMEbZjMASB6IkaWfaRsTTrgA5qFHGWAA/I8vhaoQ9EWzb
         zsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q1/kouGHNSHjsTnVr5JR5wPq5E3JDIov11IhxvB0x4M=;
        b=GJrWmWnUAaM8bWIynEiiTZNpj3fUrsF+oyeLcWiTzx/uGoGjNwiMiHdV/LbAeIZcFl
         UfxIbWjI0J8BH7UcBRdUOxJjy5bNjLvM7CzMlQSZXDyd6PNvyjrT47eoCNAbQ52ywMXs
         hUJQPSAOmdRoCne0AeiUiLmvVmbLtzidzwLqFnoTeC6/b5ywDzoNYHDchccrTCaFZ5+K
         yUGLDHt0V0fV+Ljuu/gN9P2Y9DsgJPCvmBQWWkLHZHafZPHeYpjz3a0lSiqXCEjDUF29
         rdg/BjrDKjFSZwcgJJ/4M3TsaQbhNsm/cYMZhjjzxNdXMyVrY/+YQR5Ltc4LV5hyI5O5
         Jqiw==
X-Gm-Message-State: APjAAAUXW+vtFjYMiaoSI+hVqG492T3w4nnYRmI+6qf2jrRzcTRB5w8l
        UQkY5HaErmj/S5coPLyj20wIcz39ILA=
X-Google-Smtp-Source: APXvYqxrWp0IG5kCVWm+HwfH0r9h0mO2qpZtvHqhzG8i4ufKUpotm8r51l5/N1oUl+ODMVw39kAneg==
X-Received: by 2002:a2e:97ca:: with SMTP id m10mr5662027ljj.190.1571393296692;
        Fri, 18 Oct 2019 03:08:16 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id y3sm1974997lji.53.2019.10.18.03.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 03:08:15 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.4-rc4
Date:   Fri, 18 Oct 2019 12:08:14 +0200
Message-Id: <20191018100814.5265-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.4-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc1

for you to fetch changes up to 28c9fac09ab0147158db0baeec630407a5e9b892:

  memstick: jmb38x_ms: Fix an error handling path in 'jmb38x_ms_probe()' (2019-10-09 11:08:03 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-iproc: Prevent some spurious interrupts
 - renesas_sdhi/sh_mmcif: Avoid false warnings about IRQs not found

MEMSTICK host:
 - jmb38x_ms: Fix an error handling path at ->probe()

----------------------------------------------------------------
Christophe JAILLET (1):
      memstick: jmb38x_ms: Fix an error handling path in 'jmb38x_ms_probe()'

Geert Uytterhoeven (2):
      mmc: renesas_sdhi: Do not use platform_get_irq() to count interrupts
      mmc: sh_mmcif: Use platform_get_irq_optional() for optional interrupt

Nicolas Saenz Julienne (1):
      mmc: sdhci-iproc: fix spurious interrupts on Multiblock reads with bcm2711

 drivers/memstick/host/jmb38x_ms.c    |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c | 31 +++++++++++++++++++------------
 drivers/mmc/host/sdhci-iproc.c       |  1 +
 drivers/mmc/host/sh_mmcif.c          |  6 ++----
 4 files changed, 23 insertions(+), 17 deletions(-)
