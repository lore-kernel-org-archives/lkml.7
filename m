Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDD2C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A22218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404559AbfIIMAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:00:14 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:22527 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404502AbfIIMAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:00:14 -0400
IronPort-SDR: XxhML/fkEbWh+Fdt5FqQN2xKL620r4U1w0nPZIzAxhs4OVQXX7BAimlpwRZqPsMKlj0kAakBOL
 XlgoZ32Wbz6kF8D583rYmDWtrW0PKwnUye7w6AW61Hu1oZXxDNbbQsBd9Zv2YAV9ZT0qLj9vZS
 HvcgEP56Bf6RqsRt8NoljuLtaEcWoeXypWDmYXPwi02X9Gu8oZlFXTkkkAb/S1gwJvM7jgCOGI
 K4SuVOzvaC2pjTBkUiUr2arzr86kF+4XftmRqLXf+gcyN/NPxJGYKix/5G6pK8mfVPKHIgv4pf
 9kc=
X-IronPort-AV: E=Sophos;i="5.64,484,1559509200"; 
   d="scan'208";a="231521946"
Subject: Re: [PATCH] nvmem: core: fix nvmem_cell_write inline function
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
References: <20190908121038.6877-1-sre@kernel.org>
 <d5017670-5622-283e-1376-8161d6e39dcd@vaisala.com>
 <20190909101810.gtqouke7vyu63r7e@earth.universe>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <84877749-c335-5a66-51b8-6071353f2151@vaisala.com>
Date:   Mon, 9 Sep 2019 15:00:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190909101810.gtqouke7vyu63r7e@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2019 12:00:09.0475 (UTC) FILETIME=[20C82530:01D56706]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/19 1:18 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Sep 09, 2019 at 12:26:06PM +0300, Nandor Han wrote:
>> On 9/8/19 3:10 PM, Sebastian Reichel wrote:
>>> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>
>>> nvmem_cell_write's buf argument uses different types based on
>>> the configuration of CONFIG_NVMEM. The function prototype for
>>> enabled NVMEM uses 'void *' type, but the static dummy function
>>> for disabled NVMEM uses 'const char *' instead. Fix the different
>>> behaviour by always expecting a 'void *' typed buf argument.
>>>
>>> Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>> Cc: Han Nandor <nandor.han@vaisala.com>
>>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>>    include/linux/nvmem-consumer.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
>>> index 8f8be5b00060..5c17cb733224 100644
>>> --- a/include/linux/nvmem-consumer.h
>>> +++ b/include/linux/nvmem-consumer.h
>>> @@ -118,7 +118,7 @@ static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
>>>    }
>>>    static inline int nvmem_cell_write(struct nvmem_cell *cell,
>>> -				    const char *buf, size_t len)
>>> +				   void *buf, size_t len)
>>
>> nitpick: alignment issue?
> 
> This actually fixes the alignment issue as a side-effect.
> I guess I should have mentioned it in the changelog.
> 
>> Review-By: Han Nandor <nandor.han@vaisala.com>
> 
> I suppose you meant to write "Reviewed-by" instead of inventing your
> own tag?
> 

Yes :)

Nandor


