Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743BAC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A6E20740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfKOOzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:55:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:15041 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfKOOza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:55:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 06:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="214789942"
Received: from jdstodda-mobl.amr.corp.intel.com (HELO [10.254.177.96]) ([10.254.177.96])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2019 06:55:28 -0800
Subject: Re: [alsa-devel] [RFC PATCH 0/3] ALSA: compress: Add support for FLAC
To:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20191115102705.649976-1-vkoul@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <19c70dac-aa3e-f0ea-d729-26df4f193eb0@linux.intel.com>
Date:   Fri, 15 Nov 2019 08:55:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191115102705.649976-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/19 4:27 AM, Vinod Koul wrote:
> The current design of sending codec parameters assumes that decoders
> will have parsers so they can parse the encoded stream for parameters
> and configure the decoder.

that's not quite correct. It's rather than there was no need so far for 
existing implementations to have parameters on decode, this was never a 
limitation of the design, see e.g. the comments below:

/* AAC modes are required for encoders and decoders */

/*
  * IEC modes are mandatory for decoders. Format autodetection
  * will only happen on the DSP side with mode 0. The PCM mode should
  * not be used, the PCM codec should be used instead.
  */
