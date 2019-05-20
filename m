Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B60BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D378C206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XC8PRwo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbfETKMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:12:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36048 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbfETKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:12:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so6514370plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nj86Nyw3KJK7Z3FsC5eQxrUvkQQ/Oi+NDG8wLjmFGQU=;
        b=XC8PRwo84WSBd/TUs7O4kUryHVFjZ0XnohBkePvQGh3CobFgptIyYyK9QPrxq+moTw
         qheK3uDYfkxqc+38JpOr+MuQx3M+slPhb4hsHvX/1FdLomKsDGaJBTXctgbRuPwhMo6I
         +ItbFYvP1KMvoATv/mJdHRFf42AEBmhCLxJ14QY8cCi6i5VRzHv6VW72gfwzM8yUvUm7
         H+nNdj2feSOkTDc1EC8y6kKnXffkzwVY6UGQ1UscoSQKq+jiqwPU+ZbHj6fmu/jr3bKY
         ytyKTtebsLfAXv25ZfqOOLmPcisMLpAYSSglfz3JVyN8wMm6N+4iV+lpY3eGVvGcgFev
         ee/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nj86Nyw3KJK7Z3FsC5eQxrUvkQQ/Oi+NDG8wLjmFGQU=;
        b=W8DUpig9bU2g9spOqVMNVBZ/lzUzm//lH2AmNf4k/DcOD3xjNxgr2h5nUhXkdr054G
         rQJTNQaVb0wfAHy30rvI1ukugmlOWz2FY+p3UJYc/4h66gpJmXUBZRPRqSZDLL3TSMMD
         RN5N4SwqO4ofLEAbexaAXlVGUzk4sUbXz65iO+b0zxoVezWWkR9ZQDyDSMQJSrKyngj3
         NlbakABKtchNfzovLexo/kczU7up1lj6RcU3JedpCqPiFIeSWXaPdh72NnqmDXfqWyCM
         YF8+uRs+QQnBstvRJEeWfL/nITTW/cNBtdZR8DVdvKVOjrpTe0LAoY1PN6sLgxL/PbQB
         MlwA==
X-Gm-Message-State: APjAAAVq1mm+gq2uWoZDKVo1Yb2QxlqtkiJuUlRFwARxvGzupS3IjkxK
        FIqZxoJ1D08eH4y3V63qa1Nwxw==
X-Google-Smtp-Source: APXvYqxs+7628IuHBHqhbphPC8vlchUw/ugXo/fGIy1jfQpK4ADRQzLXXHQQSf8RfDbtwEP9NVZqPQ==
X-Received: by 2002:a17:902:860c:: with SMTP id f12mr76409294plo.127.1558347142768;
        Mon, 20 May 2019 03:12:22 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:12:22 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/9] Add SD host controller support for SC9860 platform
Date:   Mon, 20 May 2019 18:11:53 +0800
Message-Id: <cover.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds optional clock support, HS400 enhanced strobe mode support,
PHY DLL configuration and other optimization to make the SD host controller
can work well on the Spreadtrum SC9860 platform.

Baolin Wang (9):
  mmc: sdhci-sprd: Check the enable clock's return value correctly
  dt-bindings: mmc: sprd: Add another optional clock documentation
  mmc: sdhci-sprd: Add optional gate clock support
  mmc: sdhci-sprd: Implement the get_max_timeout_count() interface
  mmc: sdhci-sprd: Add HS400 enhanced strobe mode
  mmc: sdhci-sprd: Enable PHY DLL to make clock stable
  dt-bindings: mmc: sprd: Add PHY DLL delay documentation
  mmc: sdhci-sprd: Add PHY DLL delay configuration
  arm64: dts: sprd: Add Spreadtrum SD host controller support

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |   19 +++
 arch/arm64/boot/dts/sprd/whale2.dtsi               |   35 ++++
 drivers/mmc/host/sdhci-sprd.c                      |  171 +++++++++++++++++++-
 3 files changed, 217 insertions(+), 8 deletions(-)

-- 
1.7.9.5

