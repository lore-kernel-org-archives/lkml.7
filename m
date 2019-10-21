Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12328CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70B920656
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfJUOgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:36:32 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:39608 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726987AbfJUOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:36:31 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Oct 2019 10:36:29 EDT
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Oct 2019 20:00:20 +0530
IronPort-SDR: vT5ilpa8nvRDneSXUcHtGXGZXqG/FfTAThMd4qBEG39zlVw4x7bYT9vjYSvmaC1H6w+sztqiCP
 uJv3N4yfZ8W1Vh+79fOOcqX214B5QrVNtUt/1s/F4uIRlNT4bHiiNUMkfPEufen95ayoI41ZgQ
 OYmw+QfW0QflvLSpFhKDjoEuUhBE5rWc6FGVBShd1Dqt6fMkbwxmZXl8Za6m9n4gVh6HcHKo21
 29O0Hc37EupITRjWwekG3Ra39GBahQz5YTf1kFUpT7ddoqrH1f2e+q288berFOUO3AH38FzPND
 aygV6/ah1QN/XVoPp+M5sfpV
Received: from rampraka-linux.qualcomm.com ([10.206.25.221])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Oct 2019 19:59:58 +0530
Received: by rampraka-linux.qualcomm.com (Postfix, from userid 2305851)
        id 32E2D329D; Mon, 21 Oct 2019 19:59:57 +0530 (IST)
From:   Ram Prakash Gupta <rampraka@codeaurora.org>
To:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, rampraka@codeaurora.org,
        vbadigan@codeaurora.org, cang@codeaurora.org, ppvk@codeaurora.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC 0/6] mmc: Add clock scaling support for mmc driver
Date:   Mon, 21 Oct 2019 19:59:31 +0530
Message-Id: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the use of devfreq based clock scaling to MMC.
This applicable for eMMC and SDCard.
For some workloads, such as video playback, it isn't necessary
for these cards to run at high speed. Running at lower
frequency, in such cases can still meet the deadlines for data
transfers.

Scaling down the clock frequency dynamically has power savings
not only because the bus is running at lower frequency but also
has an advantage of scaling down the system core voltage, if
supported. Provide an ondemand clock scaling support similar
to the cpufreq ondemand governor having two thresholds,
up_threshold and down_threshold to decide whether to increase
the frequency or scale it down respectively as per load.


Ram Prakash Gupta (6):
  mmc: core: Parse clk scaling dt entries
  mmc: core: Add core scaling support in driver
  mmc: core: Initialize clk scaling for mmc and SDCard
  mmc: core: Add debugfs entries for scaling support
  mmc: sdhci-msm: Add capability in platfrom host
  dt-bindings: mmc: sdhci-msm: Add clk scaling dt parameters

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  19 +
 drivers/mmc/core/block.c                           |  19 +-
 drivers/mmc/core/core.c                            | 777 +++++++++++++++++++++
 drivers/mmc/core/core.h                            |  17 +
 drivers/mmc/core/debugfs.c                         |  90 +++
 drivers/mmc/core/host.c                            | 226 ++++++
 drivers/mmc/core/mmc.c                             | 246 ++++++-
 drivers/mmc/core/queue.c                           |   2 +
 drivers/mmc/core/sd.c                              |  84 ++-
 drivers/mmc/host/sdhci-msm.c                       |   2 +
 include/linux/mmc/card.h                           |   7 +
 include/linux/mmc/host.h                           |  66 ++
 12 files changed, 1550 insertions(+), 5 deletions(-)

-- 
1.9.1

