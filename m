Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D132C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B19D2238E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfGWFVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:21:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:49136 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfGWFVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:21:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 22:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,297,1559545200"; 
   d="scan'208";a="163388576"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga008.jf.intel.com with ESMTP; 22 Jul 2019 22:21:32 -0700
Subject: Re: Issue with sequence to switch to HS400
To:     Alan Cooper <alcooperx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <CAOGqxeVeEq803rrtGrnubRA8cP3dRCXsU15ss3pS1q6ik+k8Bw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7610bbc9-83d8-ee98-1425-07bb65448541@intel.com>
Date:   Tue, 23 Jul 2019 08:20:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOGqxeVeEq803rrtGrnubRA8cP3dRCXsU15ss3pS1q6ik+k8Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/19 1:31 AM, Alan Cooper wrote:
> I'm having a problem with a new SD/MMC controller and PHY in our
> latest SoC's. The issue I'm seeing is that I can't switch into HS400
> mode. This looks like something the driver is doing that doesn't meet
> the JEDEC spec. In the "HS400 timing mode selection" section of the
> JEDEC spec , in step 7 it states:
> 
> 7) Set the “Timing Interface” parameter in the HS_TIMING [185] field
> of the Extended CSD register to 0x1 to switch to High Speed mode and
> then set the clock frequency to a value not greater than 52 MHz.
> 
> In the function mmc_select_hs400() in mmc.c, I see that a switch
> command is done to set the eMMC device to HS mode and then
> mmc_set_timing(card->host, MMC_TIMING_MMC_HS) is used to change the
> controller to HS mode. The problem is that the "SD Host Controller
> Standard Specification" states that "UHS Mode Select" field of the
> "Host Control 2 Register" controls the mode when the "1.8V Signaling
> Enable" bit in the same register is set, so mmc_set_timing() is
> actually leaving the controller in SDR12 mode and mmc_select_hs400()
> will then set the clock to 52MHz. This causes our PHY to detect an
> illegal combination and return an error.
> 
> I think the easiest fix would be to change mmc_set_timing(card->host,
> MMC_TIMING_MMC_HS) to mmc_set_timing(card->host,
> MMC_TIMING_UHS_SDR25). The other possibility would be to change
> mmc_set_timing to handle the "1.8V Signaling Enable" bit properly.
> I'll submit a patch based on the feedback I get.

eMMC is governed by JEDEC specs not SD specs.

Please consider making a change in your driver instead.  For example, hook
->set_ios() and if 1.8V is enabled and timing is set to MMC_TIMING_MMC_HS
then change it to MMC_TIMING_UHS_SDR25.
