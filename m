Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A72C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2C020879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfEVQhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:37:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:1819 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbfEVQhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:37:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 09:37:02 -0700
X-ExtLoop1: 1
Received: from avcaesar-mobl.amr.corp.intel.com (HELO [10.252.140.52]) ([10.252.140.52])
  by FMSMGA003.fm.intel.com with ESMTP; 22 May 2019 09:37:01 -0700
Subject: Re: [PATCH] soundwire: stream: fix out of boundary access on port
 properties
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190522162443.5780-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <19ad7a42-9625-f547-eab3-66d3aeded6c0@linux.intel.com>
Date:   Wed, 22 May 2019 11:37:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522162443.5780-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/19 11:24 AM, Srinivas Kandagatla wrote:
> Assigning local iterator to array element and using it again for
> indexing would cross the array boundary.
> Fix this by directly referring array element without using the local
> variable.

The change is valid and indeed the code could never work as is. I 
vaguely recall providing this feedback as well in an earlier version.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/stream.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index d01060dbee96..544925ff0b40 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1406,9 +1406,7 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
>   	}
>   
>   	for (i = 0; i < num_ports; i++) {
> -		dpn_prop = &dpn_prop[i];
> -
> -		if (dpn_prop->num == port_num)
> +		if (dpn_prop[i].num == port_num)
>   			return &dpn_prop[i];
>   	}
>   
> 
