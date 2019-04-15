Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86052C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7BB2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfDOMup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:50:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:3130 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOMup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:50:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 05:50:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,353,1549958400"; 
   d="scan'208";a="149551603"
Received: from ddimarco-mobl1.amr.corp.intel.com (HELO [10.252.206.7]) ([10.252.206.7])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2019 05:50:43 -0700
Subject: Re: [alsa-devel] [PATCH 0/2] soundwire: fix Kconfig select/depend
 issues
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <20190414101347.GJ28103@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7a2378b1-24d5-f60b-b32a-53e2d378d824@linux.intel.com>
Date:   Mon, 15 Apr 2019 07:50:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414101347.GJ28103@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/19 5:13 AM, Vinod Koul wrote:
> On 11-04-19, 14:28, Pierre-Louis Bossart wrote:
>> 0-day/Kbuild starts complaining about missed module dependencies and
>> compilation issues. Since codecs and soc drivers need to be compilable
>> independently, let's fix this using the following model:
> 
> I have not seen a build report on this one, is this some internal Intel
> report or on upstream tree?

0day/kbuild generated this on my work tree:

tree:   https://github.com/plbossart/sound fix/soundwire-dev
head:   d59242993bef53c301c0badda162c6bb3a5f15cb
commit: 24fe4a80b2435446c52197cb828f4475aa817c79 [22/25] skl change for sdw
config: x86_64-randconfig-l1-04110213 (attached as .config)
compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
reproduce:
         git checkout 24fe4a80b2435446c52197cb828f4475aa817c79
         # save the attached .config to linux build tree
         make ARCH=x86_64

All errors (new ones prefixed by >>):

    sound/soc/intel/skylake/skl-pcm.o: In function 
`skl_platform_pcm_prepare':
>> sound/soc/intel/skylake/skl-pcm.c:1364: undefined reference to `sdw_prepare_stream'
    sound/soc/intel/skylake/skl-pcm.o: In function 
`skl_platform_pcm_hw_free':
>> sound/soc/intel/skylake/skl-pcm.c:1339: undefined reference to `sdw_deprepare_stream'
    sound/soc/intel/skylake/skl-pcm.o: In function `skl_platform_shutdown':
>> sound/soc/intel/skylake/skl-pcm.c:1314: undefined reference to `sdw_release_stream'
    sound/soc/intel/skylake/skl-pcm.o: In function `skl_sdw_stream_trigger':
>> sound/soc/intel/skylake/skl-pcm.c:1266: undefined reference to `sdw_enable_stream'
>> sound/soc/intel/skylake/skl-pcm.c:1278: undefined reference to `sdw_disable_stream'
    sound/soc/intel/skylake/skl-pcm.o: In function `skl_platform_open':
>> sound/soc/intel/skylake/skl-pcm.c:1136: undefined reference to `sdw_alloc_stream'
    sound/soc/intel/skylake/skl-pcm.c:1163: undefined reference to 
`sdw_release_stream'
    sound/soc/intel/skylake/cnl-sst.o: In function `skl_sdw_init':
>> sound/soc/intel/skylake/cnl-sst.c:514: undefined reference to `sdw_intel_init'
