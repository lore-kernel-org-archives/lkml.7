Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA80C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBBC253B4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfE3JTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:19:07 -0400
Received: from mx.socionext.com ([202.248.49.38]:34634 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfE3JTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:19:06 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 May 2019 18:19:04 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 47E99180D46;
        Thu, 30 May 2019 18:19:04 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 30 May 2019 18:19:04 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id DC0A24053B;
        Thu, 30 May 2019 18:19:03 +0900 (JST)
Received: from user-VB.e01.socionext.com (unknown [10.213.119.151])
        by yuzu.css.socionext.com (Postfix) with ESMTP id C1A00120C10;
        Thu, 30 May 2019 18:19:03 +0900 (JST)
From:   Takao Orito <orito.takao@socionext.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com,
        orito.takao@socionext.com
Subject: [PATCH v2 0/2] mmc: sdhci-milbeaut: add Milbeaut SD driver
Date:   Thu, 30 May 2019 18:20:52 +0900
Message-Id: <1559208052-385-1-git-send-email-orito.takao@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add driver for SD Host controller on
Socionext's Milbeaut M10V platforms.

SD Host controller on Milbeaut consists of two controller parts.
One is core controller F_SDH30, this is similar to sdhci-fujitsu
controller.
Another is bridge controller. This bridge controller is not compatible
with sdhci-fujitsu controller. This is special for Milbeaut series.

It has the several parts,
 - reset control
 - clock enable / select for SDR50/25/12
 - hold control of DATA/CMD line
 - select characteristics for WP/CD/LED line
 - Re-tuning control for mode3
 - Capability setting
   Timeout Clock / Base Clock / Timer Count for Re-Tuning /
   Debounce period
These requires special procedures at reset or clock enable/change or
 further tuning of clock.

Takao Orito (2):
  dt-bindings: mmc: add DT bindings for Milbeaut SD controller
  mmc: sdhci-milbeaut: add Milbeaut SD controller driver

 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     |  32 ++
 drivers/mmc/host/Kconfig                           |  11 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-milbeaut.c                  | 362 +++++++++++++++++++++
 drivers/mmc/host/sdhci_f_sdh30.c                   |  26 +-
 drivers/mmc/host/sdhci_f_sdh30.h                   |  32 ++
 6 files changed, 439 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
 create mode 100644 drivers/mmc/host/sdhci-milbeaut.c
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h

-- 
1.9.1


