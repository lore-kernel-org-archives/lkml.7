Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F68C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A7E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfDXXNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:13:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:54700 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbfDXXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:13:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 16:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,391,1549958400"; 
   d="scan'208";a="145470908"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2019 16:13:30 -0700
Received: from pbossart-mac01.local (unknown [10.241.224.79])
        by linux.intel.com (Postfix) with ESMTP id 4E31B5803C2;
        Wed, 24 Apr 2019 16:13:30 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: bytcht_es8316: fix cast warning
To:     Anders Roxell <anders.roxell@linaro.org>,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190424114114.27073-1-anders.roxell@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <13969360-f863-e93e-9d48-d27c0034795a@linux.intel.com>
Date:   Wed, 24 Apr 2019 16:13:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424114114.27073-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 6:41 AM, Anders Roxell wrote:
> When building bytcht_es8316 the following warning shows up:
> 
> ../sound/soc/intel/boards/bytcht_es8316.c: In function ‘snd_byt_cht_es8316_mc_probe’:
> ../sound/soc/intel/boards/bytcht_es8316.c:508:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     quirk = (int)dmi_id->driver_data;
>             ^
> 
> Rework to use uintptr_t instead of int.
> 
> Fixes: a8d218f4fe81 ("ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I submitted an alternate fix last Friday to alsa-devel, along with 2 
additional patches to handle the quirk_override in the same way between 
machine drivers.
