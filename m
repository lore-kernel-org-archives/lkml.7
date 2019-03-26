Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D5EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC47220828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfCZE4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:56:07 -0400
Received: from mx.socionext.com ([202.248.49.38]:10149 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZE4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 00:56:07 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Mar 2019 13:56:06 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5CEF56117D;
        Tue, 26 Mar 2019 13:56:06 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 26 Mar 2019 13:56:06 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id CF4511A04E0;
        Tue, 26 Mar 2019 13:56:05 +0900 (JST)
Received: from user-VB.e01.socionext.com (unknown [10.213.119.151])
        by yuzu.css.socionext.com (Postfix) with ESMTP id B8531120487;
        Tue, 26 Mar 2019 13:56:05 +0900 (JST)
From:   Takao Orito <orito.takao@socionext.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com,
        orito.takao@socionext.com
Subject: [Milbeaut PATCH v0.4 0/2] mmc: sdhci_f_sdh30: Add support for Milbeaut
Date:   Tue, 26 Mar 2019 13:58:01 +0900
Message-Id: <1553576281-5813-1-git-send-email-orito.takao@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add driver support for SD Host controller on
Socionext's Milbeaut M10V platforms.

SD Host controller on Milbeaut is consist of two controller parts.
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
  dt-bindings: mmc: sdhci-fujitsu.txt: add miilbeaut driver
  mmc: sdhci_f_sdh30: Add support for Milbeaut M10V host controller

 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  22 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   | 324 +++++++++++++++++++--
 2 files changed, 315 insertions(+), 31 deletions(-)

-- 
1.9.1


