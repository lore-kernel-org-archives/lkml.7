Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217A0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8838206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbfIIJ0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:26:17 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:59721 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIIJ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:26:16 -0400
IronPort-SDR: NsSH+SvlG6j2k/h3NcPDr6vZrSNXKX09gqiUnCe9iTpEFKAjEOvd0jaJN1TRDmFF9XbJtcLusB
 hkJa8AtMkAi/Sg7bKfh2QxpZjq/nJI2rCmJg7T8Y0UgGL5dtq9UZXOMgUPZOe38Zf/EfCvHjbV
 CSGG7i9HEEBULULoN0SCZLuJhFzRiILA/tY9w8DMuDVLVRAEIBY+lBiCBGeVMIs6wLZTjEdiw8
 WPxBQ17HFkuMP+erYZrGEz1G0C0EyJyMZUIKpWFvV7E/pseOxsQqSfKPZlrR6yK0nh7sXL0xHJ
 AwI=
X-IronPort-AV: E=Sophos;i="5.64,484,1559509200"; 
   d="scan'208";a="231491365"
Subject: Re: [PATCH] nvmem: core: fix nvmem_cell_write inline function
To:     Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
References: <20190908121038.6877-1-sre@kernel.org>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <d5017670-5622-283e-1376-8161d6e39dcd@vaisala.com>
Date:   Mon, 9 Sep 2019 12:26:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190908121038.6877-1-sre@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2019 09:26:11.0244 (UTC) FILETIME=[9E5DF6C0:01D566F0]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/19 3:10 PM, Sebastian Reichel wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> nvmem_cell_write's buf argument uses different types based on
> the configuration of CONFIG_NVMEM. The function prototype for
> enabled NVMEM uses 'void *' type, but the static dummy function
> for disabled NVMEM uses 'const char *' instead. Fix the different
> behaviour by always expecting a 'void *' typed buf argument.
> 
> Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Han Nandor <nandor.han@vaisala.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   include/linux/nvmem-consumer.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 8f8be5b00060..5c17cb733224 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -118,7 +118,7 @@ static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
>   }
>   
>   static inline int nvmem_cell_write(struct nvmem_cell *cell,
> -				    const char *buf, size_t len)
> +				   void *buf, size_t len)

nitpick: alignment issue?

Review-By: Han Nandor <nandor.han@vaisala.com>

Nandor
