Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777ADC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF2220656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URK3N/1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbfETLcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:32:32 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:37827 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbfETLcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:32:32 -0400
Received: by mail-pg1-f179.google.com with SMTP id n27so4077427pgm.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2S9MAivwF7zxfimY+INJLOlqiV39ooQLNnYsMx0gRf8=;
        b=URK3N/1kJyHHrmd+w0Bx3YnOfa9G/JKqnZjMFsmCW22W5lxDFJUrmiKylqdW5OiP7c
         ZCxvYv4/7R2tcTo3I6DGZLRXFWNycsWZN/9J88ws7aMlzqo529IQ0Uu8QzwNVDDtmep4
         rRZOvw5qMETo0vhB+ZRq09iNTfSjza+IF4DjBHK7K0myRamsPRFiu8vDdP5kNz5FJDtO
         MDFlProPb/qyG34QmYYrKQcvc+OnM06MqNO0gB2M8ml0xVGeNrRe4UFBdiRB0XtK01Ng
         gP1+SdSm2Xa2e/Ao7G1sHkL56Heorsn+ssZqRfsHmTauEq1vDwgsbUmISsw2EDfUgNs1
         AfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2S9MAivwF7zxfimY+INJLOlqiV39ooQLNnYsMx0gRf8=;
        b=d/se2nKgBIaQ0YJns3J5PZXs2+V4Xlf0afpWBoLHSmgjBCJ54ykJBKYU43guoPRAA0
         oUnuuOwy+HB64qf3r0RzlKNSSYa4lnFkMJFrS6W/ZOmD1yfrd4hWFviYOn+VBX+91DS3
         Y6k9lZLA0Tsg+Jk5nORW5+rQm+e4g/faULUWH82p87o/Dycmzu8eKPOAFxI4UfSHgu4o
         bQWFXVPxjxRxOcjOJllFqfRumgOlqzfEbrOmWdauVv1JeJW48dxeFTQLqawLRPaNQKXx
         F/JVRaC6KFU/zoHR2XnpdUt96+PnPaLVd8YDBVBMaHOEd5uEqdB65+S7gnWDukpc7NGj
         ThKg==
X-Gm-Message-State: APjAAAXJlGv6gMT4x/XXMZ7jWYWmCK13IZf8SlAyYlxDAAffysX2QO/Z
        p53Nwke/EXmsqpw/TOqxc0UXZg==
X-Google-Smtp-Source: APXvYqxnQKIpFWVcVI13NBnHjPEFJoPccFai4k2DvNkDwrNTAcUlVFnQw/aT/Mj6kEAvFmc3w3SFDA==
X-Received: by 2002:a62:604:: with SMTP id 4mr80275260pfg.38.1558351951343;
        Mon, 20 May 2019 04:32:31 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.32.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:32:30 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/8] Add matching device node validation in DMA engine core
Date:   Mon, 20 May 2019 19:32:13 +0800
Message-Id: <cover.1558351667.git.baolin.wang@linaro.org>
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

Changes from v1:
 - Add test-by tag from Peter.
 - Use dma_request_channel instead of __dma_request_channel() for
 the fuse-tegra20.c driver to keep bisectable.

Baolin Wang (8):
  dmaengine: Add matching device node validation in
    __dma_request_channel()
  soc: tegra: fuse: Use dma_request_channel instead of
    __dma_request_channel()
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

