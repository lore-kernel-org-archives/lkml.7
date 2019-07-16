Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E14C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB2220665
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozODvfRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbfGPTAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:00:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40458 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfGPTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:00:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so9546281pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=La5gz3+AtRfpUH2XciZ9aSKb6yl6cJgz60szKVT/YX8=;
        b=ozODvfRC1f9Sl5vdvKpXE0U6s04L6lG8ZUMXvfwKAuaVZedPcyhNqWOXnhx2SQQWK4
         jE+D72JmHSV+8OcuA9bRc3/d+FKO2V56aAcIg1EmdTFQS7nejCu1L1LNdP3Qh39dG1v+
         V9M9b1kC83q0/zZqBSyBLaSDQJolmnweTXjllg/G7LXwqvZX30KLVQORxiwXUsbH04Wu
         1JGeqVk5rf8AaHGt8xvCkAzSEx13c4/v7GEuwVqOzQz9NPRySgKE5KUzOx64ZJdOjPND
         rgclpykxjjW22U3ZskJP01M9ov+J3zpnU7u8SQGImUYEt+qmvNU24h530hg0TtDPRzs0
         NKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=La5gz3+AtRfpUH2XciZ9aSKb6yl6cJgz60szKVT/YX8=;
        b=LJ/+7p9h0/aI3z80+3XH/UzaU4fhxUKZCkrGc9EYWsAMUzolHoH11MCP60vZRUkvay
         mmaLa5zVJXesOXvHrcFuHlZEeVyD8qyOFaTHz96HN1MhIuDLF9F8tUdKKySdQ/rTHI0E
         vzdTVC/+quInDZcyi3sZgX+9ppMoQH3SAVD0Hf4PzF+xCgJ4A4zLpoYU82hEKpggdE8w
         YrCBt/AAm56X4VJyMnBEut0OZujYXMy/CKEl/4akQ1K5z6wpvyDH/+sDVx7yx2ko+ps0
         X1seh9sYk+DQ9DIMl/+JeZk/9L5bo/iYSSTFwY9cl2xN0fvGoiUOuVCJAmroDRgBb6LV
         6RtA==
X-Gm-Message-State: APjAAAVsZUytfdGc2zi+pZebieluyWScB7WeB6efdRyI0Dksr4HSmRa/
        4jIFtWdsQsWzOctwd/RMJ2yoSQ==
X-Google-Smtp-Source: APXvYqzZncw8p1MU9FAK8cWlOPodS3hvcazMdYBofmnWJWczxl1JROF9sl3p9rY1LB/d4jGNZdq4MQ==
X-Received: by 2002:a17:90a:d791:: with SMTP id z17mr36806013pju.40.1563303610687;
        Tue, 16 Jul 2019 12:00:10 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 196sm23865267pfy.167.2019.07.16.12.00.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 12:00:10 -0700 (PDT)
Date:   Tue, 16 Jul 2019 12:01:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Clement Leger <cleger@kalray.eu>,
        Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [GIT PULL] remoteproc updates for v5.3
Message-ID: <20190716190129.GB8572@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rproc-v5.3

for you to fetch changes up to 93f1d3e4b59cf2e7ef31eaf1131480897b040e97:

  remoteproc: stm32: fix building without ARM SMCC (2019-07-08 07:05:50 -0700)

----------------------------------------------------------------
remoteproc updates for v5.3

This adds support for the STM32 remoteproc, additional i.MX platforms
with Cortex M4 remoteprocs and Qualcomm's QCS404 Compute DSP. Initial
support for vendor specific resource table entries and support for
unprocessed Qualcomm firmware files.

----------------------------------------------------------------
Arnd Bergmann (1):
      remoteproc: stm32: fix building without ARM SMCC

Bjorn Andersson (4):
      dt-bindings: remoteproc: Rename and amend Hexagon v56 binding
      remoteproc: qcom: qdsp6-adsp: Add support for QCS404 CDSP
      soc: qcom: mdt_loader: Support loading non-split images
      remoteproc: qcom: q6v5-mss: Support loading non-split images

Clement Leger (2):
      remoteproc: add vendor resources handling
      remoteproc: copy parent dma_pfn_offset for vdev

Fabien Dessenne (3):
      dt-bindings: stm32: add bindings for ML-AHB interconnect
      dt-bindings: remoteproc: add bindings for stm32 remote processor driver
      remoteproc: stm32: add an ST stm32_rproc driver

Fabio Estevam (2):
      remoteproc: imx: Broaden the Kconfig selection logic
      remoteproc: imx: Fix typo in "failed"

Gustavo A. R. Silva (1):
      remoteproc: Use struct_size() helper

Robert P. J. Day (1):
      remoteproc,rpmsg: add missing MAINTAINERS file entries

YueHaibing (1):
      remoteproc: qcom: q6v5-mss: Fix build error without QCOM_MDT_LOADER

 .../devicetree/bindings/arm/stm32/mlahb.txt        |  37 ++
 .../{qcom,adsp-pil.txt => qcom,hexagon-v56.txt}    |  35 +-
 .../devicetree/bindings/remoteproc/stm32-rproc.txt |  63 +++
 Documentation/remoteproc.txt                       |  14 +-
 MAINTAINERS                                        |   5 +
 drivers/remoteproc/Kconfig                         |  18 +-
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/imx_rproc.c                     |   8 +-
 drivers/remoteproc/qcom_q6v5_adsp.c                |  73 ++-
 drivers/remoteproc/qcom_q6v5_mss.c                 |  33 +-
 drivers/remoteproc/remoteproc_core.c               |  15 +
 drivers/remoteproc/remoteproc_elf_loader.c         |   3 +-
 drivers/remoteproc/remoteproc_internal.h           |  11 +
 drivers/remoteproc/stm32_rproc.c                   | 628 +++++++++++++++++++++
 drivers/soc/qcom/mdt_loader.c                      |  88 ++-
 include/linux/remoteproc.h                         |  32 +-
 include/linux/soc/qcom/mdt_loader.h                |   2 +
 17 files changed, 1009 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
 rename Documentation/devicetree/bindings/remoteproc/{qcom,adsp-pil.txt => qcom,hexagon-v56.txt} (74%)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
 create mode 100644 drivers/remoteproc/stm32_rproc.c
