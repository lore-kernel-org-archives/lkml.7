Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94197C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E56205ED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfECOdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:33:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:8535 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfECOdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:33:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 07:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,426,1549958400"; 
   d="scan'208";a="145734214"
Received: from nzussbla-mobl.amr.corp.intel.com (HELO [10.254.111.239]) ([10.254.111.239])
  by fmsmga008.fm.intel.com with ESMTP; 03 May 2019 07:32:53 -0700
Subject: Re: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
 <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
 <20190503043957.GA14916@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <535dfeac-77d8-1307-0329-33b8f2675bbd@linux.intel.com>
Date:   Fri, 3 May 2019 09:32:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503043957.GA14916@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/19 11:39 PM, Mark Brown wrote:
> On Fri, Apr 19, 2019 at 02:46:49PM -0500, Pierre-Louis Bossart wrote:
> 
>>   config REGMAP_SOUNDWIRE
>>   	tristate
>> -	depends on SOUNDWIRE_BUS
>> +	select SOUNDWIRE_BUS
> 
> This now makes _SOUNDWIRE different to all the other bus types; if this
> is a good change then surely the same thing should be done for all the
> other bus types.  It's also not clear to me that this actually does
> anything, do selects from symbols that are themselves selected actually
> do anything?

yes, this works, but if you prefer alignment I can follow the SLIMBUS model

config SND_SOC_WCD9335
	tristate "WCD9335 Codec"
	depends on SLIMBUS
	select REGMAP_SLIMBUS
	select REGMAP_IRQ

config REGMAP_SLIMBUS
	tristate
	depends on SLIMBUS

menuconfig SLIMBUS
	tristate "SLIMbus support"
	
if SLIMBUS

# SLIMbus controllers
config SLIM_QCOM_CTRL
...

As I mentioned it'll compile the bus even if there is no user for it, 
but it's your call: alignment or optimization.
