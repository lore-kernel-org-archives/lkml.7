Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A72AC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F05205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ClvcOZ8X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ClvcOZ8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfF0Nej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:34:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0Nei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:34:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2A5C602F0; Thu, 27 Jun 2019 13:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561642477;
        bh=MB9usvJmprZl2GlAzFSrJpDBXV4POKIqkpQjv7Ok8FA=;
        h=From:To:Cc:Subject:Date:From;
        b=ClvcOZ8XOS1re5S8K95vq+I1THOJcUTFfWfCycf7BFfRn/sSXmyvedjxX5oKU65om
         2MIGnY+mD6zQBSMmNA/5qZDgRw8R2CN7mbqSxz+56ahs+0BHwYs5yDbbG0m3ChEokw
         YL3iqJ70yKSOA1hgsncMNbANbVHrjbXk4YFlbmnM=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33DA9602F0;
        Thu, 27 Jun 2019 13:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561642477;
        bh=MB9usvJmprZl2GlAzFSrJpDBXV4POKIqkpQjv7Ok8FA=;
        h=From:To:Cc:Subject:Date:From;
        b=ClvcOZ8XOS1re5S8K95vq+I1THOJcUTFfWfCycf7BFfRn/sSXmyvedjxX5oKU65om
         2MIGnY+mD6zQBSMmNA/5qZDgRw8R2CN7mbqSxz+56ahs+0BHwYs5yDbbG0m3ChEokw
         YL3iqJ70yKSOA1hgsncMNbANbVHrjbXk4YFlbmnM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33DA9602F0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org
Cc:     agross@kernel.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        saravanak@google.com, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 0/4] DDR/L3 Scaling support on SDM845 SoCs
Date:   Thu, 27 Jun 2019 19:04:20 +0530
Message-Id: <20190627133424.4980-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC series aims to extend cpu based scaling support to L3/DDR on
SDM845 SoCs. The patch series depends on "Introduce OPP bandwidth bindings"
series (https://patchwork.kernel.org/cover/10912993/). A part of the
series will still be applicable if we decide to go ahead with the proposal
from Saravana as well so I decided to post this out.

v2:
* Incorporated Viresh's comments from:
[1]https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
[2]https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/


Sibi Sankar (4):
  OPP: Add and export helper to update voltage
  OPP: Add and export helper to set bandwidth
  cpufreq: qcom: Update the bandwidth levels on frequency change
  arm64: dts: qcom: sdm845: Add cpu OPP tables

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 343 +++++++++++++++++++++++++++
 drivers/cpufreq/qcom-cpufreq-hw.c    |  77 +++++-
 drivers/opp/core.c                   |  98 ++++++++
 include/linux/pm_opp.h               |  16 ++
 4 files changed, 532 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

