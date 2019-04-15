Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD1DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2961A20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reLoU8+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfDOOzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:55:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46911 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDOOzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so4405799lfj.13;
        Mon, 15 Apr 2019 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f5T8atUTvJOfOrgRbVO67MZvPmsCQ9fM6En3Qkk12gw=;
        b=reLoU8+J6CvGt5tVx71ZKa5svYrQlag86nDbeucNXt5eb33Tux1ofULLXSEDINjMSm
         pSvgVQVQp2Tz46Xb1NwZQG5/0fPzxpgbqc7ZFWS4Npd0RglFDuaY5Ap1vf1jV0lQGCWp
         dYLzp+DzYRJEj+bELItd/Gc1lUqMGZ3MwwAueUUPQavnVf01GWKAUCocFV0G455N7rdy
         0KUkjK/g02LFNyLMMlP3FR6xqfQbqx5z3DHkzYmTbWBPSTNxvcBI++Yu0mW5U7LJzYBk
         O+k3KVulJPq9YsjoEVOTOW9FDj7cv8d+h1cmrgloOuS1xtjN+Aoc221SlbAU623OA8FM
         hlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f5T8atUTvJOfOrgRbVO67MZvPmsCQ9fM6En3Qkk12gw=;
        b=rrNsGhICP5rJrd/jxp4CZm0zMWkEC8/3AQthD1VfyLL/j0ttkj+h7/ASOVezV4SeOE
         RSHj4AauRIUl+Ya692jMkg0FWoftnCyxW5KoSVLg1Ytz9xtm6OsBHvqGXkwHjVT3ok/a
         ZuoFI5WzWIxLYpsQ3GV5heLe3P2ub4EU47c6ZIG8vk3ltS+0t63yOmBqUyl6PS+7xZk+
         YNn5l7jC6qxPmtVe8SEpUvMuxPD3w5Uvk5Kg3dJa0TPIS3fIWkZlKsHdJ/eLu1IgTyBL
         iblVkiBXzxdIUd05JZNy/D6FlhRVUwiYP4Tq4uovWIE+MgCUpAhTmIq5soed7A5Jod8h
         QwXA==
X-Gm-Message-State: APjAAAVLscmT3HNAazq1OuRhSGK0Da7n5nnxQNZ2y8gsSGSuyOENsZ0m
        7ftRzkPrWykezINnPNYPg4VZK8oc
X-Google-Smtp-Source: APXvYqyypglaCMPVFONPc4c0X7lEj7S6RTZ7TzQ8utFiRuvelUVt4PZqm219CVy83KuOaZMYA24WHw==
X-Received: by 2002:a19:f60d:: with SMTP id x13mr4237018lfe.11.1555340134287;
        Mon, 15 Apr 2019 07:55:34 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 00/19] NVIDIA Tegra devfreq improvements and Tegra20/30 support
Date:   Mon, 15 Apr 2019 17:54:46 +0300
Message-Id: <20190415145505.18397-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to utilize the Tegra devfreq driver on Tegra30 and found out that
it doesn't work properly due to improper Hz<->kHz conversions made by the
driver. After fixing that problem and doing some more testing I noticed
that there are things that could be improved and in result here is this
patchset that fixes the problems, makes some improvements and adds support
for NVIDIA Tegra30 SoC's. This series was tested on Tegra30 and Tegra124
machines.

This series also adds support for the Tegra20 SoC's that do not have
the ACTMON hardware unit, but can use Memory Controller counters to make
decision about the required memory frequency. Please note that the patch
that instantiates a platform device for the driver isn't a part of this
series, I'll submit it later on because of interdependency with some other
ongoing patchset.

Please review, thanks.

Changelog:

v2: The patchset was quite heavily reworked since v1, few patches we
    dropped or squashed into the new ones and more patches we added.
    In a result more bugs and potential problems are fixed now, driver's
    code got more clean up.

    The Tegra20 driver-addition patch is now a part of this series, it has
    no changes since v1.

Dmitry Osipenko (19):
  PM / devfreq: tegra: Fix kHz to Hz conversion
  PM / devfreq: tegra: Replace readl-writel with relaxed versions
  PM / devfreq: tegra: Don't ignore clk errors
  PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
  PM / devfreq: tegra: Replace write memory barrier with the read
    barrier
  PM / devfreq: tegra: Fix missed error checking on devfreq
    initialization failure
  PM / devfreq: tegra: Register clk notifier in the end of driver's
    probe
  PM / devfreq: tegra: Remove OPP entries on driver removal
  PM / devfreq: tegra: Change interrupt request order
  PM / devfreq: tegra: Drop primary interrupt handler
  PM / devfreq: tegra: De-initialize properly on driver's probe error
  PM / devfreq: tegra: Avoid inconsistency of current frequency value
  PM / devfreq: tegra: Mark ACTMON's governor as immutable
  PM / devfreq: tegra: Move governor registration to driver's probe
  PM / devfreq: tegra: Synchronize IRQ after masking it in hardware
  PM / devfreq: tegra: Reconfigure hardware on governor's restart
  PM / devfreq: tegra: Support Tegra30
  PM / devfreq: tegra: Enable COMPILE_TEST for the driver
  PM / devfreq: Introduce driver for NVIDIA Tegra20

 MAINTAINERS                       |   8 +
 drivers/devfreq/Kconfig           |  15 +-
 drivers/devfreq/Makefile          |   1 +
 drivers/devfreq/tegra-devfreq.c   | 296 +++++++++++++-----------------
 drivers/devfreq/tegra20-devfreq.c | 177 ++++++++++++++++++
 5 files changed, 324 insertions(+), 173 deletions(-)
 create mode 100644 drivers/devfreq/tegra20-devfreq.c

-- 
2.21.0

