Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43415C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103502082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aEz1nRuC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kyVLSuxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDKHCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:02:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59414 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:02:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6F4376110F; Thu, 11 Apr 2019 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554966121;
        bh=/Un6fMbkDWIZPwYPcbQuRjolfFDpeYx8BZ0NS69Q15s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aEz1nRuCMGFbxPelCLYA1nICGRtiFmbkSMy4iP9yrCCQHlTg8YIzkkHjFe4J1NJIi
         OWMZFZ5Wceyw4yldZBdVqDKAE9b6eJmlIW2vQCw5QEz+XCwL0R/zNUoI2sfkwyeejo
         8dSPA+voCWjkXg5IRCScrstBQGCgd5SoSR8w5xyQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1E8CC6086B;
        Thu, 11 Apr 2019 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554966120;
        bh=/Un6fMbkDWIZPwYPcbQuRjolfFDpeYx8BZ0NS69Q15s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kyVLSuxr4KGA98YlfdxhoykQRFaTBVKiCBqePs3Fw+N/JDsYFF6aLINCIXcAox/q9
         mPZbUeJB/R6oiYz9IjfsB0R3VSOaBQWBzYWRhIa2E+oTVvdnCPe7EE1+dswKpvVj5j
         VqmqDvVcogE931xZjmdavgc5VtsBmYyg3xGBvWaY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 11 Apr 2019 12:32:00 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, dianders@chromium.org
Subject: Re: [PATCH RFC 0/9] Add CPU based scaling support to Passive governor
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
Message-ID: <08c3cff8c39e3d82e044db93e992da72@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-28 20:58, Sibi Sankar wrote:
> This RFC series aims to add cpu based scaling support to the passive
> governor and scale DDR with a generic interconnect bandwidth based
> devfreq driver on SDM845 SoC. This series achieves similar 
> functionality
> to Georgi's Patch series (https://patchwork.kernel.org/cover/10850817/)
> and can be used with MSM8916/MSM8996/QCS404 SoCs.
> 
> [patches 1,6 - Add and export export helpers to get avg/peak bandwidth 
> and
>  update voltage of an disabled opp respectively]
> 
> [patch 3 - Adds cpu based scaling support to passive governor]
> To achieve this, it listens to CPU frequency transition notifiers
> to keep itself up to date on the current CPU frequency.
> To decide the frequency of the device, the governor depends one of
> the following:
> * Constructs a CPU frequency to device frequency mapping table from
>   required-opps property of the devfreq device's opp_table
> * Scales the device frequency in proportion to the CPU frequency by
>   performing interpolation.

Had a discussion with Viresh and Georgi,
Viresh pointed out cpu based scaling can
be done in a better way by placing the
required-opps in the cpu opp table and
with some changes in the core so dropping
the idea of cpufreq integration into passive
governor for now.

> 
> [patch 7 - Parses and updates opps from the frequency/voltage read from
>  the look up tables]
> 
> The patch series depends on opp-bw-MBs bindings introduced in:
> https://patchwork.kernel.org/cover/10850817/
> 
> Saravana Kannan (2):
>   PM / devfreq: Add cpu based scaling support to passive_governor
>   PM / devfreq: Add devfreq driver for interconnect bandwidth voting
> 
> Sibi Sankar (7):
>   OPP: Add and export helpers to get avg/peak bw
>   OPP: Export a number of helpers to prevent code duplication
>   dt-bindings: devfreq: Add bindings for devfreq dev-icbw driver
>   OPP: Add and export helper to update voltage
>   cpufreq: qcom: Add support to update cpu node's OPP tables
>   arm64: dts: qcom: sdm845: Add cpu OPP tables
>   arm64: dts: qcom: sdm845: Add nodes for icbw driver and opp tables
> 
>  .../devicetree/bindings/devfreq/icbw.txt      | 146 +++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 262 +++++++++++++++++
>  drivers/cpufreq/qcom-cpufreq-hw.c             |  29 +-
>  drivers/devfreq/Kconfig                       |  19 ++
>  drivers/devfreq/Makefile                      |   1 +
>  drivers/devfreq/devfreq_icbw.c                | 132 +++++++++
>  drivers/devfreq/governor_passive.c            | 276 +++++++++++++++++-
>  drivers/opp/core.c                            | 100 +++++++
>  drivers/opp/of.c                              |  13 +-
>  include/linux/devfreq.h                       |  43 ++-
>  include/linux/pm_opp.h                        |  35 +++
>  11 files changed, 1044 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt
>  create mode 100644 drivers/devfreq/devfreq_icbw.c

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
