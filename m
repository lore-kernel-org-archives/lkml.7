Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2A7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC3620879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfEVQlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:41:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:4136 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbfEVQlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:41:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 09:41:39 -0700
X-ExtLoop1: 1
Received: from sydneywa-mobl1.amr.corp.intel.com (HELO [10.252.132.240]) ([10.252.132.240])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2019 09:41:38 -0700
Subject: Re: [PATCH] soundwire: stream: fix bad unlock balance
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4744834c-36b1-dd8d-45fa-76c75eb3d5cb@linux.intel.com>
Date:   Wed, 22 May 2019 11:41:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/19 11:25 AM, Srinivas Kandagatla wrote:
> This patch fixes below warning due to unlocking without locking.
> 
>   =====================================
>   WARNING: bad unlock balance detected!
>   5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
>   -------------------------------------
>   aplay/2954 is trying to release lock (&bus->msg_lock) at:
>   do_bank_switch+0x21c/0x480
>   but there are no more locks to release!
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/stream.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 544925ff0b40..d16268f30e4f 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -814,7 +814,8 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>   			goto error;
>   		}
>   
> -		mutex_unlock(&bus->msg_lock);
> +		if (mutex_is_locked(&bus->msg_lock))
> +			utex_unlock(&bus->msg_lock);

Does this even compile? should be mutex_unlock, no?

We also may want to identify the issue in more details without pushing 
it under the rug. The locking mechanism is far from simple and it's 
likely there are a number of problems with it.

>   	}
>   
>   	return ret;
> 
