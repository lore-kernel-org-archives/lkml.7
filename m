Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BD2C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CBF20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dl5JgfjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfEGGKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:10:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39751 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEGGKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:10:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so201252plm.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=F2rlrgjaiJp1NZ6RM4VM9hD4Rmd/jUUVurwXpw2zOD0=;
        b=Dl5JgfjZLUNAedfPuQQEAtFakRXAUtWL3Qc7a0Ko7nRreVMr5QXRF9ELOhpMzYIXEF
         M+uqiTbjF/ZOFb9Sy+fVQzLBwvmpryBUYQ/+FdjbY6Hn5tU95O3/0by2Hv5r5CaTSk9U
         a9ISQUlkFaTyzuMtX1+uVWLFQZAsUKnaI5jGOPi1EbiB3yaPKy75oW0BPNMZMsdRBw2O
         +xUO/mmPVEm418F9q7Aclbkl5PTgkOdagQsrzNnQdQK3bbq5zfJrduth/X3I7ZpcKkXd
         tCRFsqKB1xW66ic0/V8jaC1kGEWwhP7tYUHaJVsMVtBAwISXMYtJ/YAdq2dTVyVrPtwg
         mafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F2rlrgjaiJp1NZ6RM4VM9hD4Rmd/jUUVurwXpw2zOD0=;
        b=FvFhVsQdHHDScgbg3/LGNhU5KUweWi64NKs6Cf/Qs1ZQ7yJeu0BwTpfrkQJvRdTJP4
         G8NGudqcro4UAjrJlmdstqvwTDBr5H6ctwu3mKIzrr8JArbPZx/tcV2DxqH3ZS7dpaHS
         GviIeZ/K/8e/xKrOxJ4R3NbxiZpzu3Bn9JneOoXTDO5wxjNcavKJgFJaQtkNJpbsLcd+
         sZSakjBP5yNOJQPOgMiKJVHbYWjUM+RGOdHoHtAoBAgKqvWNpiz5lW3dy7lRq0DCclXI
         lxlnM5iehEGW0Hj47yaSmSfPRnyTxBhUwYewYRecA+AlhDLatJCyh29qZCZV6Fz5/AC9
         INxA==
X-Gm-Message-State: APjAAAVY4XZfpywtoHH46nnvYpgK2a+yYroP+/l9fSRGOGZJH445I+NO
        cYpRN01IWq6gOiTzgAq1U8RF6g==
X-Google-Smtp-Source: APXvYqyFxErSKOJGlANeP4eMybnknfCs0uOocek9g5tx0HVX9gFqZV9fJIv0GNvM6WxbwVQ6k420WQ==
X-Received: by 2002:a17:902:9a0c:: with SMTP id v12mr38439694plp.184.1557209406749;
        Mon, 06 May 2019 23:10:06 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:06 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/8] Add matching device node validation in DMA engine core
Date:   Tue,  7 May 2019 14:09:37 +0800
Message-Id: <cover.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set adds a device node validation in DMA engine core, that will
help some drivers to remove the duplicate device node validation in each
driver.

Any comments are welcome. Thanks.

Baolin Wang (8):
  dmaengine: Add matching device node validation in
    __dma_request_channel()
  soc: tegra: fuse: Change to the correct __dma_request_channel()
    prototype
  dmaengine: imx-sdma: Let the core do the device node validation
  dmaengine: dma-jz4780: Let the core do the device node validation
  dmaengine: mmp_tdma: Let the core do the device node validation
  dmaengine: mxs-dma: Let the core do the device node validation
  dmaengine: sh: rcar-dmac: Let the core do the device node validation
  dmaengine: sh: usb-dmac: Let the core do the device node validation

 drivers/dma/dma-jz4780.c              |    7 ++-----
 drivers/dma/dmaengine.c               |   10 ++++++++--
 drivers/dma/imx-sdma.c                |    9 ++-------
 drivers/dma/mmp_tdma.c                |   10 ++--------
 drivers/dma/mxs-dma.c                 |    8 ++------
 drivers/dma/of-dma.c                  |    4 ++--
 drivers/dma/sh/rcar-dmac.c            |    6 +++---
 drivers/dma/sh/usb-dmac.c             |    6 ++----
 drivers/soc/tegra/fuse/fuse-tegra20.c |    2 +-
 include/linux/dmaengine.h             |   12 ++++++++----
 include/linux/platform_data/dma-imx.h |    1 -
 11 files changed, 32 insertions(+), 43 deletions(-)

-- 
1.7.9.5

