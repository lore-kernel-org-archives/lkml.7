Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE643C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5852064A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfHUTXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:23:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:54254 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbfHUTXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:23:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 12:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="180148220"
Received: from dbarua-mobl.amr.corp.intel.com (HELO [10.252.198.189]) ([10.252.198.189])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2019 12:23:10 -0700
Subject: Re: [alsa-devel] [PATCH 0/6] soundwire: inits and PM additions for
 5.4
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <57e5dab5-2641-7c4b-a05a-fb4f0adccfc7@linux.intel.com>
Date:   Wed, 21 Aug 2019 14:23:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/13/19 4:32 PM, Pierre-Louis Bossart wrote:
> This is an update on the RFC, to be applied after the '[PATCH v2 0/3]
> soundwire: debugfs support for 5.4' and '[PATCH 00/17] soundwire:
> fixes for 5.4' series.
> 
> Total that makes 28 patches submitted for review, broken in 3 sets.

I double-checked that this patchset does apply on top of soundwire/next 
+ the 4 debugfs patches I just sent earlier.

I will now send the rather big changes needed for SOF integration as an 
RFC, assuming this set is applied.

> 
> Changes since RFC (Feedback from GregKH, Vinod, Cezary, Guennadi):
> Squashed init sequence fixes in one patch, which remains
> readable. Tested all return values and called update_config() as
> needed.
> Fixed hw-reset debugfs (removed -unsafe and noisy dev_info traces)
> Simplified enable_interrupt() with goto
> Fixed style, removed typos and FIXMES in pm_runtime code
> Clarified commit messages
> 
> Pierre-Louis Bossart (6):
>    soundwire: fix startup sequence for Intel/Cadence
>    soundwire: cadence_master: add hw_reset capability in debugfs
>    soundwire: intel: add helper for initialization
>    soundwire: intel: Add basic power management support
>    soundwire: cadence_master: make clock stop exit configurable on init
>    soundwire: intel: add pm_runtime support
> 
>   drivers/soundwire/cadence_master.c | 135 ++++++++++++++------
>   drivers/soundwire/cadence_master.h |   5 +-
>   drivers/soundwire/intel.c          | 194 +++++++++++++++++++++++++++--
>   3 files changed, 289 insertions(+), 45 deletions(-)
> 
