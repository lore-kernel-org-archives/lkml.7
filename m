Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71A4C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F9A216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5lyywLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfK1QuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35799 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1QuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id q13so13386266pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EtE8iKMLU92GTDMRpW8v47ZiBzkWYQrI/Nlmh1qlqtI=;
        b=U5lyywLacpPKT3VSRWffB5xGzZlwvL7QfYD2llP5vXMTtclbt0nXxmMcA5ZI1/9IqM
         chS4Z4CZD8QFx4b6MXGL1v/hxEI4VCILZmT5WJopEXVqF2UcHqF7Nz6wN+RjY2Jxkn0+
         qTluI143uuBq1MQTyA5biPlZFRMQJQUWWKRp2BaMz1IRunAdCPsckYo7n/9Xau0awiKv
         jpHwOFpzbKGUqW5cOhHq35ek0/m4TcN3h0TuguyDPBTQn/o/Is9zO8njacIPrC+YtJFV
         Ayge8ThTWtiLeOSlIU2Z5UHWK9vGxF9uYYElaMFNt20oAnhO43uCbibm2SURbWQnh2ml
         Zc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EtE8iKMLU92GTDMRpW8v47ZiBzkWYQrI/Nlmh1qlqtI=;
        b=rsxdIXA6GCTiLPuPF5+pG5oNkgl8qxefTou9mXdkpkMrtKmK70ATKRw1FyO3Yf+WZX
         Bj5i3uxn+92I4yJ4bDs0eG4cYO2prUo5/xgjWN1DJb7uZs74ppNeBCH830b/WNTGyz/t
         MYKE9SQl2GEZxpqSH4yvDgXEez5uLFnL5/bGBLDnioJUJPCmbEVvPmiY5oTM9BAAes1k
         Lf7vmsHohRTViHgD/lVLhIy9lrjrHO6R6zzB6JaqxwvyirHkxc453TvaBmwJ9OjxgFbj
         SJWh8OR+RsKmVf2gRk+oQeKWgmLBt+5+Ef+tn/fYEtRd5XXLENHF375bTid5Z6skAOCz
         S9LA==
X-Gm-Message-State: APjAAAULv7qL4S8ecgnA4ArKKDtXsgsRL410fKWU70cSF7pdgXS7RU2U
        EjRXKwr+nRCo4vcCgMc38muhPw==
X-Google-Smtp-Source: APXvYqzFXuuCNpa2wOGk/uugNpRHYlw73qwmWN31RQc253nISwTs7bcJPSadlmNYCemZ4rYYyRvD0Q==
X-Received: by 2002:a63:1360:: with SMTP id 32mr11710857pgt.3.1574959804400;
        Thu, 28 Nov 2019 08:50:04 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:03 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 00/17] candidates for stable 4.19.y
Date:   Thu, 28 Nov 2019 09:49:45 -0700
Message-Id: <20191128165002.6234-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a retake of this set [1].  The patches are destined to 4.19.y and have
been applied and compiled to 4.19.86.  All the content in this set is already in
5.3.y.

Thanks,
Mathieu 

[1]. https://lkml.org/lkml/2019/11/15/1105

Alexandre Torgue (1):
  pinctrl: stm32: fix memory leak issue

Arnaud Pouliquen (1):
  mailbox: stm32_ipcc: add spinlock to fix channels concurrent access

Fabien Dessenne (1):
  mailbox: mailbox-test: fix null pointer if no mmio

Gabriel Fernandez (4):
  clk: stm32mp1: fix HSI divider flag
  clk: stm32mp1: fix mcu divider table
  clk: stm32mp1: add CLK_SET_RATE_NO_REPARENT to Kernel clocks
  clk: stm32mp1: parent clocks update

Hugues Fruchet (2):
  media: stm32-dcmi: fix DMA corruption when stopping streaming
  media: stm32-dcmi: fix check of pm_runtime_get_sync return value

Lionel Debieve (2):
  crypto: stm31/hash - Fix hmac issue more than 256 bytes
  hwrng: stm32 - fix unbalanced pm_runtime_enable

Loic Pallardy (1):
  remoteproc: fix rproc_da_to_va in case of unallocated carveout

Olivier Moysan (3):
  ASoC: stm32: i2s: fix dma configuration
  ASoC: stm32: i2s: fix 16 bit format support
  ASoC: stm32: i2s: fix IRQ clearing

Pierre-Yves MORDRET (1):
  dmaengine: stm32-dma: check whether length is aligned on FIFO
    threshold

Wen Yang (1):
  ASoC: stm32: sai: add missing put_device()

 drivers/char/hw_random/stm32-rng.c        |  8 +++++
 drivers/clk/clk-stm32mp1.c                | 28 +++++++++--------
 drivers/crypto/stm32/stm32-hash.c         |  2 +-
 drivers/dma/stm32-dma.c                   | 20 ++++--------
 drivers/mailbox/mailbox-test.c            | 14 +++++----
 drivers/mailbox/stm32-ipcc.c              | 37 +++++++++++++++++------
 drivers/media/platform/stm32/stm32-dcmi.c | 23 ++++++++++++--
 drivers/pinctrl/stm32/pinctrl-stm32.c     | 26 ++++++++++------
 drivers/remoteproc/remoteproc_core.c      |  4 +++
 sound/soc/stm/stm32_i2s.c                 | 29 +++++++++---------
 sound/soc/stm/stm32_sai.c                 | 11 +++++--
 11 files changed, 127 insertions(+), 75 deletions(-)

-- 
2.17.1

