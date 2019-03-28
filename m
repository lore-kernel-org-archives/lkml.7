Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C30C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6BB2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iVveKalM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lyX0fYTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfC1P2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:28:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51076 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfC1P2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:28:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9187061576; Thu, 28 Mar 2019 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786919;
        bh=xum6ieznDZfBH+hlbErd+IO7fVPsgbzZh+x2tFodxH0=;
        h=From:To:Cc:Subject:Date:From;
        b=iVveKalMHXfEclY7JPh/1/xXuonGMA6XW+3qpqe0UfB9iR8CC9q0dWniw8X6qJsW1
         tT3Zjs9TD/QGHq7G0PciLWtEIa/Jcr8VCrk+fgE47TAhRfSlCj+fwP3gS2tVciWeHr
         jfm32N+i24Uc8e/s8ZQeUysmcY9PFhvEI7jJlpHE=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77278612F1;
        Thu, 28 Mar 2019 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786917;
        bh=xum6ieznDZfBH+hlbErd+IO7fVPsgbzZh+x2tFodxH0=;
        h=From:To:Cc:Subject:Date:From;
        b=lyX0fYTNqvQIyLTR+wNm4EWpGfF4SnagAXdZEgdUyaNoYCSrpiT629nuwNatYqne4
         RyXluRZqoYd2A/500lS7UKFTpcqGIHuO0e631XU7tfng+0++SidR5z+/irhrOGWCZF
         zD0JMPjC+zKPv0sLatuaQel5R+Lo+o5EAVavLBes=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77278612F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 0/9] Add CPU based scaling support to Passive governor
Date:   Thu, 28 Mar 2019 20:58:13 +0530
Message-Id: <20190328152822.532-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC series aims to add cpu based scaling support to the passive
governor and scale DDR with a generic interconnect bandwidth based
devfreq driver on SDM845 SoC. This series achieves similar functionality
to Georgi's Patch series (https://patchwork.kernel.org/cover/10850817/)
and can be used with MSM8916/MSM8996/QCS404 SoCs.

[patches 1,6 - Add and export export helpers to get avg/peak bandwidth and
 update voltage of an disabled opp respectively]

[patch 3 - Adds cpu based scaling support to passive governor]
To achieve this, it listens to CPU frequency transition notifiers
to keep itself up to date on the current CPU frequency.
To decide the frequency of the device, the governor depends one of
the following:
* Constructs a CPU frequency to device frequency mapping table from
  required-opps property of the devfreq device's opp_table
* Scales the device frequency in proportion to the CPU frequency by
  performing interpolation.

[patch 7 - Parses and updates opps from the frequency/voltage read from
 the look up tables]

The patch series depends on opp-bw-MBs bindings introduced in:
https://patchwork.kernel.org/cover/10850817/

Saravana Kannan (2):
  PM / devfreq: Add cpu based scaling support to passive_governor
  PM / devfreq: Add devfreq driver for interconnect bandwidth voting

Sibi Sankar (7):
  OPP: Add and export helpers to get avg/peak bw
  OPP: Export a number of helpers to prevent code duplication
  dt-bindings: devfreq: Add bindings for devfreq dev-icbw driver
  OPP: Add and export helper to update voltage
  cpufreq: qcom: Add support to update cpu node's OPP tables
  arm64: dts: qcom: sdm845: Add cpu OPP tables
  arm64: dts: qcom: sdm845: Add nodes for icbw driver and opp tables

 .../devicetree/bindings/devfreq/icbw.txt      | 146 +++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 262 +++++++++++++++++
 drivers/cpufreq/qcom-cpufreq-hw.c             |  29 +-
 drivers/devfreq/Kconfig                       |  19 ++
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/devfreq_icbw.c                | 132 +++++++++
 drivers/devfreq/governor_passive.c            | 276 +++++++++++++++++-
 drivers/opp/core.c                            | 100 +++++++
 drivers/opp/of.c                              |  13 +-
 include/linux/devfreq.h                       |  43 ++-
 include/linux/pm_opp.h                        |  35 +++
 11 files changed, 1044 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt
 create mode 100644 drivers/devfreq/devfreq_icbw.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

