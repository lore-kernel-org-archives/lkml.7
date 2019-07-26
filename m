Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03154C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB62421852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfGZLHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:07:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:42586 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfGZLHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:07:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 04:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="175562578"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.89.116]) ([10.251.89.116])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2019 04:07:37 -0700
Subject: Re: [RFC PATCH 27/40] soundwire: Add Intel resource management
 algorithm
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-28-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <869edbf2-1fdd-6b21-818f-20c39c013c11@intel.com>
Date:   Fri, 26 Jul 2019 13:07:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725234032.21152-28-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
> This algorithm computes bus parameters like clock frequency, frame
> shape and port transport parameters based on active stream(s) running
> on the bus.
> 
> This implementation is optimal for Intel platforms. Developers can
> also implement their own .compute_params() callback for specific
> resource management algorithm.
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. All hard-coded
> values were removed from the initial contribution to use BIOS
> information instead.
> 
> FIXME: remove checkpatch report
> WARNING: Reusing the krealloc arg is almost always a bug
> +			group->rates = krealloc(group->rates,
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Could you specify the requirements and limitations for this algorithm? 
Last year I written calc for Linux based on Windows (please don't burn 
me here) equivalent though said requirements/ limitiations might have 
changed and nothing is valid any longer.

I remember that some parts of specification overcomplicated the 
calculator and due to actual, realtime usecases it could be greatly 
simplified (that's why I mention that my work is probably no longer 
valid). However, these details would help me in reviewing your 
implementation and providing suggestions.

And yes, "Frame shape calculator" probably suits this better.
Though this might be just a preference thingy : )
