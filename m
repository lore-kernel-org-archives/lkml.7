Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCF3C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3827721872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDLOHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:07:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:22225 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLOHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:07:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 07:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="160808890"
Received: from dsholman-mobl.amr.corp.intel.com (HELO [10.254.109.63]) ([10.254.109.63])
  by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2019 07:07:41 -0700
Subject: Re: [alsa-devel] [PATCH 1/2] regmap: soundwire: fix Kconfig
 select/depend issue
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <20190411192814.10663-2-pierre-louis.bossart@linux.intel.com>
 <s5ho95bpqis.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bd9a5c75-8519-b6ac-ca16-7fa93c706ead@linux.intel.com>
Date:   Fri, 12 Apr 2019 09:07:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <s5ho95bpqis.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reviews

>> The mechanism should be
>>
>> config CODEC_XYX_SDW
>>         depends on SOUNDWIRE
>>         select REGMAP_SOUNDWIRE
>>
>> config REGMAP_SOUNDWIRE
>>         depends on SOUNDWIRE
>>         select SOUNDWIRE_BUS
> 
> To be noted, in general you can't do put both depends-on and select.
> The select always wins.  So the depends-on in REGMAP_SOUNDWIRE is more
> or less moot.


ok. To double-check, the example below would be legit, yes?

  config CODEC_XYX_SDW
	 tristate "XYZ SDW Codec"
          depends on SOUNDWIRE
          select REGMAP_SOUNDWIRE

  config REGMAP_SOUNDWIRE
          select SOUNDWIRE_BUS

it'd follow the typical pattern seen in sound/soc/codecs/Kconfig:

config SND_SOC_CS4265
	tristate "Cirrus Logic CS4265 CODEC"
	depends on I2C
	select REGMAP_I2C

Thanks
-Pierre
