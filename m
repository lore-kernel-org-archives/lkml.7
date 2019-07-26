Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39CDC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79F622BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfGZPXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:23:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:4046 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfGZPXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:23:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 08:23:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322064852"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 08:23:01 -0700
Subject: Re: [alsa-devel] [RFC PATCH 00/40] soundwire: updates for 5.4
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <6d268dd6-5f1a-e1f4-b0be-c3b978f89cb1@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6db19ecc-3cb0-68f6-537f-be1df4bf2750@linux.intel.com>
Date:   Fri, 26 Jul 2019 10:23:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6d268dd6-5f1a-e1f4-b0be-c3b978f89cb1@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Comments and feedback welcome!
> 
> Hello Pierre,
> 
> This patchset is pretty large - I'd suggest dividing next RFC into 
> segments: debugfs, info, power-management, basic flow corrections and 
> frame shape calculator.

There was an intent to provide a logical progression...

First debugfs, since I believe it was reviewed before, and I wanted 
folks like Greg to double-check it without burrying it too deep.

Then all corrections, followed by the allocator.

And last all PM stuff, split by regular suspend/resume and pm_runtime.

The RFC state is precisely to gather feedback, if folks want a different 
order that's fine. I just wanted to be transparent and share what we have.

> Some commits have no messages and others lack additional info - tried to 
> provide feedback wherever I could, though, especially for the last one, 
> it would be vital to post additional info so in-depth feedback can be 
> provided.

The lack of commits is a miss, I went from 170 debug/integration patches 
to 40 yesterday and my brain was fried.

> Maybe nothing for calculator will come up, maybe something will. In 
> general I remember it being an essential part of SDW and one where many 
> bugs where found during the initial verification phase.

the frame allocation is a critical piece and it does need to be 
hardened. However we can do so in steps. The current setups we have 
support 1 Slave per link and a limited amount of bandwidth. The links 
themselves don't operate at the max frequency.
Also note that that the streams are 'statically' defined by the 
dailinks, and the allocation is not fully dynamic with random 
configurations being request. If you fail you fail fast.

Nevertheless I do plan to recheck the allocator with an additional 
scripting tool. It'd be very good to e.g. dump the current setup in a 
debugfs file and show to users what is happening (or not happening). I 
didn't recall you worked on SoundWire and I can use your practical 
knowledge to make the code and tools better :-)

> 
> Thanks for your contribution and have a good day!

Thanks for reviewing this long series and have a nice week-end.
-Pierre
