Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0784C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED2F21582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 21:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgABVSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:18:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:28012 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgABVSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:18:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 13:18:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,388,1571727600"; 
   d="scan'208";a="224819862"
Received: from ybabin-mobl1.amr.corp.intel.com (HELO [10.252.139.105]) ([10.252.139.105])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2020 13:18:34 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: boards: Fix compile-testing
 RT1011/RT5682
To:     Arnd Bergmann <arnd@arndb.de>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200102135322.1841053-1-arnd@arndb.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <96bf1ce8-0f96-0c81-130b-970427b82fab@linux.intel.com>
Date:   Thu, 2 Jan 2020 12:50:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102135322.1841053-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/2/20 7:52 AM, Arnd Bergmann wrote:
> On non-x86, the new driver results in a build failure:
> 
> sound/soc/intel/boards/cml_rt1011_rt5682.c:14:10: fatal error: asm/cpu_device_id.h: No such file or directory
> 
> The asm/cpu_device_id.h header is not actually needed here,
> so don't include it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Indeed it's not needed, thanks for spotting this.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> I found this last week, but the patch still seems to be needed
> as I could not find a fix in mainline or -next.
> 
> Please ignore if there is already a fix in some other tree.
> 
> 
>   sound/soc/intel/boards/cml_rt1011_rt5682.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/cml_rt1011_rt5682.c b/sound/soc/intel/boards/cml_rt1011_rt5682.c
> index a22f97234201..5f1bf6d3800c 100644
> --- a/sound/soc/intel/boards/cml_rt1011_rt5682.c
> +++ b/sound/soc/intel/boards/cml_rt1011_rt5682.c
> @@ -11,7 +11,6 @@
>   #include <linux/clk.h>
>   #include <linux/dmi.h>
>   #include <linux/slab.h>
> -#include <asm/cpu_device_id.h>
>   #include <linux/acpi.h>
>   #include <sound/core.h>
>   #include <sound/jack.h>
> 
