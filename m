Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECF7C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C68D21E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbfHGSRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:17:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:32943 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388612AbfHGSRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:17:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 11:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="165424309"
Received: from mwdryfus-mobl.amr.corp.intel.com (HELO [10.254.191.107]) ([10.254.191.107])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2019 11:17:20 -0700
Subject: Re: [alsa-devel] [PATCH] soundwire: fix regmap dependencies and align
 with other serial links
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        jank@cadence.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0g5Hk9JYLvRXfLk5-o=n_RVPKtWD=QONpiimCWyQOFELQ@mail.gmail.com>
 <52a2cb0c-92a6-59d5-72da-832edd6481f3@linux.intel.com>
 <20190807175646.GK4048@sirena.co.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5a7473a2-83c0-1a09-0cab-31fcc5b21302@linux.intel.com>
Date:   Wed, 7 Aug 2019 13:17:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807175646.GK4048@sirena.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> 
>> Vinod, Mark, any feedback?
> 
>> There will be a set of SoundWire codec drivers provided upstream soonish and
>> we'll get a number of kbuild errors without this patch.
> 
> I think I'm missing context here, I've basically been zoning out all the
> soundwire stuff - the patch series are huge and generate a bunch of
> discusion.  Is the patch below the full thing?  I don't see any obvious
> problems.

Here's a bit of context:

This patch is really independent from the 40-odd fixes I pushed about 10 
days ago. I provided an initial version back in April ('[PATCH v2 2/2] 
regmap: soundwire: fix Kconfig select/depend issue') during the first 
batch of updates. At the time, the suggested solution for the 
compilation issues was not agreed on, so the build errors remained - not 
a big deal they only show-up with codec drivers that were not upstreamed 
so far. It took me a while to come back to it but that was the first in 
my TODO list after my Summer break and now that we are almost ready to 
upstream those codec drivers it's a good time to revisit this issue.

Your initial feedback was:

"This now makes _SOUNDWIRE different to all the other bus types; if this
is a good change then surely the same thing should be done for all the
other bus types. "

and

"Alignment is a requirement.  If you want to optimize
this then it'd be better to optimize all the bus types rather than just
having the one weird bus type that does something different for no
documented reason."

I don't have the knowledge or means to test what I suggested initially 
for the other buses, and the optimization was minimal anyways, so this 
patch takes the path of least resistance and aligns with others.

if there are no objections it's probably easier to push this patch 
through the SoundWire tree, with the relevant Acks.
