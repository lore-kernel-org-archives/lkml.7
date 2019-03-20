Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A132C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47692075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfCTMwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:52:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfCTMwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:52:33 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3714C3AE664F8A08E120;
        Wed, 20 Mar 2019 20:52:31 +0800 (CST)
Received: from SHA1000170415.huawei.com (100.106.92.139) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Mar 2019 20:52:22 +0800
From:   Wanglai Shi <shiwanglai@hisilicon.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <xuwei5@hisilicon.com>, <alexander.shishkin@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <leo.yan@linaro.org>, <suzhuangluan@hisilicon.com>
Subject: [PATCH v2 0/3] Support static funnel and CoreSight DT on Hikey960
Date:   Wed, 20 Mar 2019 20:38:07 +0800
Message-ID: <1553085490-42870-1-git-send-email-shiwanglai@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.106.92.139]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Since before there have no platforms use static funnel in mainline
kernel (though maybe some in-house SoC has used it but didn't upstream
for mainline kernel yet so we don't be aware for it), when enable
CoreSight DT binding for hikey960, we found the SoC uses the static
funnel in the link path and but it's not supported in CoreSight funnel
driver.

So patches 0001/0002 are two patches to support static funnel, this
first patch is to update DT documentation to support static funnel (we
call it as non-configurable funnel in documentation); the second patch
is to support the static funnel in the CoreSight funnel driver.

Credits to Suzuki shared code for CoreSight replicator refactoring,
patches 0001/0002 heavily follows up the same fashion in Suzuki's shared
code.

Patch 0003 is the DT binding for CoreSight enabling on Hikey960, and
it's the first consumer for use static funnel binding.

This patch set has been tested on Hikey960 with perf command for trace
data recording and decoding with below commands:

  # perf record -e cs_etm/@20010000.etf/ --per-thread ./main
  # perf report --tui


Leo Yan (2):
  dt-bindings: arm: coresight: Support non-configurable funnel
  coresight: funnel: Support static funnel

Wanglai Shi (1):
  arm64: dts: hi3660: Add CoreSight support

 .../devicetree/bindings/arm/coresight.txt     |  45 +-
 .../boot/dts/hisilicon/hi3660-coresight.dtsi  | 456 ++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |   2 +
 .../hwtracing/coresight/coresight-funnel.c    | 112 +++--
 4 files changed, 585 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi

-- 
2.17.1

