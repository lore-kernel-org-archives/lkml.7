Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96598C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E3920825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfEGU0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:26:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:4910 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfEGU0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:26:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 13:26:47 -0700
X-ExtLoop1: 1
Received: from rashavex-mobl.amr.corp.intel.com (HELO [10.252.204.102]) ([10.252.204.102])
  by fmsmga006.fm.intel.com with ESMTP; 07 May 2019 13:26:45 -0700
Subject: Re: [alsa-devel] [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
To:     "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>,
        Evan Green <evgreen@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rajat Jain <rajatja@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Zhang <benzh@chromium.org>,
        "M, Naveen" <naveen.m@intel.com>
References: <20190506225321.74100-1-evgreen@chromium.org>
 <20190506225321.74100-2-evgreen@chromium.org>
 <74e8cfcd-b99f-7f66-48ce-44d60eb2bbca@linux.intel.com>
 <64FD1F8348A3A14CA3CB4D4C9EB1D15F30A7C756@BGSMSX107.gar.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5c42b741-5e5c-ce00-8321-59df1df115f1@linux.intel.com>
Date:   Tue, 7 May 2019 15:26:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <64FD1F8348A3A14CA3CB4D4C9EB1D15F30A7C756@BGSMSX107.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 5/6/19 5:53 PM, Evan Green wrote:
>>> Add support for Intel Comet Lake platforms by adding a new Kconfig for
>>> CometLake and the appropriate PCI ID.
> 
>> This is odd. I checked internally a few weeks back and the CML PCI ID was 9dc8, same as WHL and CNL, so we did not add a PCI ID on purpose. To the best of my knowledge SOF probes fine on CML and the known issues can be found on the SOF github [1].
> 
> The PCI ID change is seen on later production Si versions. The PCI ID is 02c8.

As I suspected, we are talking about different skews and generations of 
the chipset and a board-level change, not silicon change.

The CNL PCH-LP PCI ID is 0x9DC8, the CNL PCH-H PCI ID is 0xA348 (used 
for CoffeeLake). Both are supported by SOF.

What we are missing are the PCI IDs for CML PCH-LP (0x02C8) and CML 
PCH-H (0x06C8).

Can we respin this patchset to add support for those last two instead of 
just the -LP case?

I'll send a patch to add those IDs for the HDaudio legacy driver for 
consistency.

Thanks!
-Pierre
