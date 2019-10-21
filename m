Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1F3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A691206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfJULIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:08:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:63298 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbfJULID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:08:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 04:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="187507860"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2019 04:08:02 -0700
Received: from atirumal-mobl1.amr.corp.intel.com (unknown [10.251.26.228])
        by linux.intel.com (Postfix) with ESMTP id 5A59058029D;
        Mon, 21 Oct 2019 04:08:01 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: bdw-rt5677: enable runtime channel
 merge
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Zavras, Alexios" <alexios.zavras@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1570007072-23049-1-git-send-email-brent.lu@intel.com>
 <CF33C36214C39B4496568E5578BE70C74031B9FD@PGSMSX108.gar.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <63da3995-b807-f9e6-6f09-a90e6b8e8e53@linux.intel.com>
Date:   Mon, 21 Oct 2019 05:41:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CF33C36214C39B4496568E5578BE70C74031B9FD@PGSMSX108.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> In the DAI link "Capture PCM", the FE DAI "Capture Pin" supports 4-channel
>> capture but the BE DAI supports only 2-channel capture. To fix the channel
>> mismatch, we need to enable the runtime channel merge for this DAI link.
>>
> 
> Hi Pierre,
> 
> This patch is for the same issue discussed in the following thread:
> https://patchwork.kernel.org/patch/11134167/
> 
> We enable the runtime channel merge for the DMIC DAI instead of adding a
> machine driver constraint. It's working good on chrome's 3.14 branch (which
> requires some backport for the runtime channel merge feature). Please let
> me know if this implementation is correct for the FE/BE mismatch problem.

Sorry, I don't fully understand your points, and it's the first time I 
see anyone use this .dpcm_merged_chan field for an Intel platform.

If I look at the code I see that the core would limit the number of 
channels to two. But that code needs the CPU_DAI to use 2 channels, 
which I don't see. So is this patch self-contained or do we need an 
additional constraint on the FE?

Thanks
-Pierre

