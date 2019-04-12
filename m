Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3745CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0255320850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDLORh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:17:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:28720 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLORh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:17:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 07:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="336798971"
Received: from cseverns-mobl1.amr.corp.intel.com (HELO [10.254.178.136]) ([10.254.178.136])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2019 07:17:35 -0700
Subject: Re: [alsa-devel] [PATCH 0/2] soundwire: fix Kconfig select/depend
 issues
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <189ee558-766c-0e94-9570-3bf283681795@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <aaa3f184-bcd5-70fd-b8fa-e6e361253ede@linux.intel.com>
Date:   Fri, 12 Apr 2019 09:17:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <189ee558-766c-0e94-9570-3bf283681795@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/19 5:06 AM, Srinivas Kandagatla wrote:
> 
> 
> On 11/04/2019 20:28, Pierre-Louis Bossart wrote:
>> 0-day/Kbuild starts complaining about missed module dependencies and
>> compilation issues. Since codecs and soc drivers need to be compilable
>> independently, let's fix this using the following model:
>>
>> SOUNDWIRE_INTEL ---- select -----------
>>                                        |
>>                       v
>> REGMAP_SOUNDWIRE --- select ---> SOUNDWIRE_BUS
>>
> 
> Last time when I looked at this, Kconfig symbols SOUNDWIRE_BUS and 
> SOUNDWIRE looked totally redundant and bit over done.
> 
> Removing SOUNDWIRE_BUS Kconfig did clean it up and made it bit more 
> align with others

Good point, but no. This is intentional and follows the Kconfig pattern 
pattern described by Takashi at https://lkml.org/lkml/2017/11/17/47

yes, this SOUNDWIRE is overkill for now, but let's assume there is a 
second non-intel implementation (which I understand as very likely given 
all the threads on ARM64 support). In that case you'd really want a 
top-level selector option that has no actual compilation impact - not 
used in any Makefile or code - but enables the sub-options and let 
users/distros select the platforms they care about.

SOUNDWIRE_BUS is really the lowest-common denominator that will be used 
by all drivers at the end.

> regarding REGMAP_SOUNDWIRE, It should be selected by the codec/soundwire 
> slave drivers isn't it?

yes, that was the intent.
Thanks
-Pierre
