Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4FCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB63B218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvlkNMnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfCVKPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:15:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39609 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbfCVKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:15:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so1544787ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+MWNg/TIzQLchIyvjMoRw66T+9UU3zL0Rs++7dyqToY=;
        b=XvlkNMnwvdupNttNeDuV4/rrOyu/7qeGcoNHlizVNz+v1FhLLd6MtV5YTvZJoXQYjZ
         W5+1mdIrsNymSua7cKQK3IAI1/sQ+n/y72IgQTQCDFVzzcmgTgEjtckF6gka3yLNgmtW
         dgNioKpnbd0ZY2T8MchI8gVUB1s2c2q4zk6FcpIImX4tmlMvspJtBG8SDLpVdHR2iNVD
         ptPCak1PfrhbkileJMiTnrueeqFXCyD1uu+6tfz2qrPylP/+IxtJW3DShu53S7LWFSpy
         BRJz1FgeE6f624tDvR/VZlA1j9bkmqoflbJbnRsUROtYw4nSTPsQfOc6liMcnZsroRwe
         KAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+MWNg/TIzQLchIyvjMoRw66T+9UU3zL0Rs++7dyqToY=;
        b=J9boXj/kaVBZBVzEKz4x7gswwhxrJ5Ehi5BgrXMIXRQA7Mbx8wVDjd9VvAlMLfYaM8
         Lzuxh3yYeLpa8jZf+BLaTmiOiJQJS0pjVhH/1HcFxoj+57MbcfJbe6T+d0agT46HPNPR
         WLh6cKSaejH9HzwvaoRANOEXwyP6kVSSyqiH/BA00ZOXnObWvyB5zz12mbYL2EvCuoho
         NGzh9R17AGmKNxv90Sl2Aygi0wHYdss9ne49kW7xWBSaHaRpekKLMXAIw55oxcCD3d8D
         Sncf4cCFbHP2NACxqQ97cj0+/nk/v+4YD89Rk4IZRB3/YfeSZJYVfgX8lEDY99u354FT
         xZdg==
X-Gm-Message-State: APjAAAUw+G0mVR7AdRB/WXeluUnQgiBzdQ50O7OtpEBqFghbhw5IBhip
        /n2pH8ZQLDDpIZDKcftsX5cXgA==
X-Google-Smtp-Source: APXvYqxbo+uFcOvXDuN6W9k1Q+R+pdFNNpNUt3XKuokXJbzXTh1PRDfJEOf90V0gn6jbzwLkQ01JiQ==
X-Received: by 2002:a2e:9098:: with SMTP id l24mr4039002ljg.55.1553249740681;
        Fri, 22 Mar 2019 03:15:40 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id m1sm1703161lfh.36.2019.03.22.03.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 03:15:40 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.1-rc2
Date:   Fri, 22 Mar 2019 11:15:36 +0100
Message-Id: <20190322101536.25315-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.1-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1-rc1

for you to fetch changes up to c9a9497ccef205ed4ed2e247011382627876d831:

  mmc: renesas_sdhi: limit block count to 16 bit for old revisions (2019-03-21 11:41:46 +0100)

----------------------------------------------------------------
MMC host:
 - alcor: Fix DMA reads
 - renesas_sdhi: Limit block count to 16-bit for old revisions
 - sdhci-omap: Fixup support for read-only pins
 - mxcmmc: Revert support for highmem pages
 - davinci/pxamci: Fix clang build warnings

----------------------------------------------------------------
Alexander Shiyan (1):
      mmc: mxcmmc: "Revert mmc: mxcmmc: handle highmem pages"

Arnd Bergmann (2):
      mmc: pxamci: fix enum type confusion
      mmc: davinci: remove extraneous __init annotation

Daniel Drake (1):
      mmc: alcor: fix DMA reads

Kishon Vijay Abraham I (1):
      mmc: sdhci-omap: Set caps2 to indicate no physical write protect pin

Wolfram Sang (1):
      mmc: renesas_sdhi: limit block count to 16 bit for old revisions

 drivers/mmc/host/alcor.c             | 25 +++++++++++++++++++------
 drivers/mmc/host/davinci_mmc.c       |  2 +-
 drivers/mmc/host/mxcmmc.c            | 16 ++++------------
 drivers/mmc/host/pxamci.c            |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c |  8 +++++++-
 drivers/mmc/host/sdhci-omap.c        |  3 +++
 6 files changed, 35 insertions(+), 21 deletions(-)
