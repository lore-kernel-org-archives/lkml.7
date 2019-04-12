Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EAC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8252171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDLO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:56:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:25073 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbfDLO4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:56:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 07:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="150354478"
Received: from tmlee1-mobl1.amr.corp.intel.com (HELO [10.252.202.40]) ([10.252.202.40])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2019 07:56:22 -0700
Subject: Re: [alsa-devel] [PATCH 0/2] soundwire: fix Kconfig select/depend
 issues
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
 <189ee558-766c-0e94-9570-3bf283681795@linaro.org>
 <aaa3f184-bcd5-70fd-b8fa-e6e361253ede@linux.intel.com>
 <20190412142748.GB6235@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0f6431b2-169e-4146-8f53-1ff2efac4d74@linux.intel.com>
Date:   Fri, 12 Apr 2019 09:56:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412142748.GB6235@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Removing SOUNDWIRE_BUS Kconfig did clean it up and made it bit more
>>> align with others
> 
>> Good point, but no. This is intentional and follows the Kconfig pattern
>> pattern described by Takashi at https://lkml.org/lkml/2017/11/17/47
> 
>> yes, this SOUNDWIRE is overkill for now, but let's assume there is a second
>> non-intel implementation (which I understand as very likely given all the
>> threads on ARM64 support). In that case you'd really want a top-level
>> selector option that has no actual compilation impact - not used in any
>> Makefile or code - but enables the sub-options and let users/distros select
>> the platforms they care about.
> 
> I don't understand what you're saying here - what is the intended
> difference between SOUNDWIRE and SOUNDWIRE_BUS?  Having the separate
> option for _INTEL for your controller makes sense but otherwise the
> normal pattern for a bus would be that you'd have the root config
> option for the bus (which would enable the core code for the bus) and
> then everything else is hidden behind that.

I was thinking of this pattern:

config SOUNDWIRE
	bool "SoundWire support"

if SOUNDWIRE

config SOUNDWIRE_INTEL
	tristate "SoundWire for Intel"
	select SOUNDWIRE_BUS

config SOUNDWIRE_XYZ_ARM64
	tristate "SoundWire for XYZ platform"
	select SOUNDWIRE_BUS

config SOUNDWIRE_BUS
	tristate

endif

One could argue that SOUNDWIRE could select SOUNDWIRE_BUS directly, or 
merge the two, but then you could have a configuration where the bus is 
included with no actual users. Not to mention that the intent of the 
top-level selector is typically to have no impact on compilation as 
recommended by Linus.
