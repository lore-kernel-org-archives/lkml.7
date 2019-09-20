Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C61C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DDE207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKXZf4pQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393140AbfITOxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:53:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52371 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388844AbfITOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:53:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id x2so2842018wmj.2;
        Fri, 20 Sep 2019 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aNWHbevRsk4KejISaDDKrrmCAj/+nQn5NQmc8QeRKVg=;
        b=pKXZf4pQjNJUXpkcv0Z4a7b2Ci7CW9Ur7JduJHnfCljgNSI+W++Gh5hz3zNTbaSeOI
         f7pDQr/2H00yjJcSa/7ip9sh0U9hyBuhf2fGEZo2fRBmczPBGg70PAdNbJ1Uzp+Xw4JV
         cVT4Qehl+RwORC8dQdYPbq1oR+/HA7rFu44zmVCCNzFFe1sB+jFYSj/hHKmft6GNrDes
         vT8KiDu0KgpoG+lMzBfeqt9LoFoU+QifZXCJl4lUVjGmxeEohAMKZhF/OmhvrjhAEPuG
         G3uh9zs7jmdaWA0Z8aryqgILO96LE9gsspgzTZ/FLshKcg6mtHaXrDpl1QEdkcf7ahdg
         zt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aNWHbevRsk4KejISaDDKrrmCAj/+nQn5NQmc8QeRKVg=;
        b=VuCvm1JpAGpP5rB9HXMisX8rAXIDVUYHV/WdyiN15GR2jkxvgZUAraIDIw8FO+z6Tj
         TEBa85zCC7sfFkzxe7g1RvzVIoryEP+fNPe+yy5d0e1tBHVb3fk/NU4Lv4Dnz1W412fm
         qUbhcVaqtuAwM1W2gV/nl1qNDcSw+TbN4vUWHx+EGA8dbhMQC08s7JV9T+yLCFB7hDqz
         hu81TxeWwD62U4QIZaNYXfiyBtsE/XoPo8FammxI4QzCt6KflJcddT5p9nZZhiMU6hea
         zdQNJWV/HBv2wtH8e+Y27ZRPwa3UO2TOLpaUFWPQfqDtuSOGTqxnoIVYwTiiBo234QKT
         ImGg==
X-Gm-Message-State: APjAAAUvtGBWPd7tZEMWxeZDCwne6doIpgguYVfMkKY2hfXnV/R8ASJR
        kbhAa8hw3gm9U3UznWiiNIE=
X-Google-Smtp-Source: APXvYqxfYzpMhQOZ1/a8pRXC8kewdTQ3J941Z36yvEs+Q7vvIiVaB9qPj3KHz+GJw0yyce5zJeu5Bg==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr4157233wmk.150.1568991200760;
        Fri, 20 Sep 2019 07:53:20 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id n2sm1538237wmc.1.2019.09.20.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 07:53:19 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        inux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mmc: tegra: Use proper DMA mask
Date:   Fri, 20 Sep 2019 16:53:15 +0200
Message-Id: <20190920145317.11972-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

this puts together the two patches from this thread:

	http://patchwork.ozlabs.org/patch/1146705/

there hasn't been any activity there for a couple of weeks, so I thought
I'd just throw them together and update the second patch to work on top
of the first one.

The goal here is to avoid the use of bounce buffers and fix IOVA space
issues when an IOMMU gets involved. The first patch introduces the
->set_dma_mask() host operation as proposed by Adrian and the second
patch is just a rebase of Nicolin's Tegra SDHCI patch that uses the new
host operation rather than doing it as part of ->enable_dma().

Thierry


Adrian Hunter (1):
  mmc: sdhci: Let drivers define their DMA mask

Nicolin Chen (1):
  mmc: tegra: Implement ->set_dma_mask()

 drivers/mmc/host/sdhci-tegra.c | 48 ++++++++++++++++++++--------------
 drivers/mmc/host/sdhci.c       | 12 +++------
 drivers/mmc/host/sdhci.h       |  1 +
 3 files changed, 33 insertions(+), 28 deletions(-)

-- 
2.23.0

