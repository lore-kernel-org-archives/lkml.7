Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77439C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E29206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfJJTVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:21:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:35377 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfJJTVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:21:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 12:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; 
   d="scan'208";a="206203510"
Received: from pchamber-mobl1.amr.corp.intel.com (HELO [10.252.139.48]) ([10.252.139.48])
  by orsmga002.jf.intel.com with ESMTP; 10 Oct 2019 12:21:37 -0700
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        spapothi@codeaurora.org
References: <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
 <99d35a9d-cbd8-f0da-4701-92ef650afe5a@linux.intel.com>
 <5e08f822-3507-6c69-5d83-4ce2a9f5c04f@linaro.org>
 <53bb3105-8e85-a972-fce8-a7911ae4d461@linux.intel.com>
 <95870089-25da-11ea-19fd-0504daa98994@linaro.org>
 <2326a155-332e-fda0-b7a2-b48f348e1911@linux.intel.com>
 <34e4cde8-f2e5-0943-115a-651d86f87c1a@linaro.org>
 <20191010120337.GB31391@ediswmail.ad.cirrus.com>
 <22eff3aa-dfd6-1ee5-8f22-2af492286053@linux.intel.com>
 <e671930b-645a-7ee3-6926-eea39626c0a3@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c9203f7f-f360-0ede-d351-cfdbec03299c@linux.intel.com>
Date:   Thu, 10 Oct 2019 10:49:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e671930b-645a-7ee3-6926-eea39626c0a3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> I still need to figure out prefixing multiple instances of this 
> Amplifier controls with "Left" and "Right"

FWIW we use the "snd_codec_conf" stuff to add a prefix for each 
amplifier, so that the controls are not mixed up between instances of 
the same amp, see e.g.

	
static struct snd_soc_codec_conf codec_conf[] = {
	{
		.dev_name = "sdw:0:25d:711:0:1",
		.name_prefix = "rt711",
	},
	{
		.dev_name = "sdw:1:25d:1308:0:0",
		.name_prefix = "rt1308-1",
	},
	{
		.dev_name = "sdw:2:25d:1308:0:2",
		.name_prefix = "rt1308-2",
	},
	{
		.dev_name = "sdw:3:25d:715:0:1",
		.name_prefix = "rt715",
	},
};


https://github.com/thesofproject/linux/pull/1142/commits/9ff9cf9d8994333df2250641c95431261bc66d69#diff-892560f80d603420baec7395e0b45d81R212
