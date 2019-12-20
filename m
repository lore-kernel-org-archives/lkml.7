Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A25C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D2921D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLTPtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:49:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:27460 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfLTPtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:49:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 07:49:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; 
   d="scan'208";a="267551905"
Received: from pkriegsm-mobl.amr.corp.intel.com (HELO [10.252.132.172]) ([10.252.132.172])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2019 07:49:34 -0800
Subject: Re: [alsa-devel] [PATCH v6 02/11] mfd: wcd934x: add support to
 wcd9340/wcd9341 codec
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        devicetree@vger.kernel.org, spapothi@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20191219103153.14875-1-srinivas.kandagatla@linaro.org>
 <20191219103153.14875-3-srinivas.kandagatla@linaro.org>
 <af48cd71-fa1a-dbc5-0e88-e315ea13c28c@linux.intel.com>
 <db36d6d7-40a2-bbd2-f299-838abf4d92cc@linaro.org>
 <4492b71e-9923-365c-f22c-3766e2d5bae2@linux.intel.com>
 <3fa4997f-4409-97f6-ba10-a87013383eb7@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <df1c8ef8-2619-99b7-317c-1970c9413d00@linux.intel.com>
Date:   Fri, 20 Dec 2019 09:22:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3fa4997f-4409-97f6-ba10-a87013383eb7@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>> Note these are the child devices of the MFD SLIMBus device.
>>
>> Ah ok. I guess the creation of those child devices when the parent 
>> SLIMbus device reports PRESENT initially if fine, it's the part where 
>> you remove them if the device loses sync or gets powered off which is 
>> odd. And I guess technically you could still have race conditions 
>> where a child device starts a transaction just as the parent is no 
>> longer attached to the bus.
> 
> Losing power to SLIMBus device is very odd usecase and if it happens 
> suggests that threre are bigger issues on the board design itself. This 
> case should never happen. Even if it happens we would get timeout errors 
> on every SLIMbus transactions.
> 
>>
>>>> I would however not remove the devices when the status is down but 
>>>> only on an explicit .remove.
>>>
>>> Am open for suggestions but I would not like the child devices to 
>>> talk on the bus once the SLIMbus device is down! Only way to ensure 
>>> or make it silent is to remove.
>>
>> it's as if you are missing a mechanism to forward the parent status to 
>> the children so use remove() for lack of a better solution?
> That is true. This gives bit more control on the slave device lifecycle.
> Current solution works fine for now with less complexities across 
> multiple drivers. I also agree that there is scope of improvement in 
> future for this.

ok, makes sense, thanks for the answers. No further questions, so

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
