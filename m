Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E7BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0CB20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDIBfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:35:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbfDIBfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:35:47 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8BD55FF73F9E16D1671;
        Tue,  9 Apr 2019 09:35:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
 09:35:44 +0800
Subject: Re: [PATCH -next] pinctrl: artpec6: Make two functions static
To:     Nathan Chancellor <natechancellor@gmail.com>
References: <20190321150909.3576-1-yuehaibing@huawei.com>
 <20190408180110.GA15199@archlinux-ryzen>
CC:     <jesper.nilsson@axis.com>, <lars.persson@axis.com>,
        <linus.walleij@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-arm-kernel@axis.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <11f6a1e6-6c8b-8490-57bb-f15f5050e80c@huawei.com>
Date:   Tue, 9 Apr 2019 09:35:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190408180110.GA15199@archlinux-ryzen>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/9 2:01, Nathan Chancellor wrote:
> On Thu, Mar 21, 2019 at 11:09:09PM +0800, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fix sparse warnings:
>>
>> drivers/pinctrl/pinctrl-artpec6.c:691:5: warning:
>>  symbol 'artpec6_pmx_enable' was not declared. Should it be static?
>> drivers/pinctrl/pinctrl-artpec6.c:705:6: warning:
>>  symbol 'artpec6_pmx_disable' was not declared. Should it be static?
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/pinctrl/pinctrl-artpec6.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-artpec6.c b/drivers/pinctrl/pinctrl-artpec6.c
>> index d89dc43..e836850 100644
>> --- a/drivers/pinctrl/pinctrl-artpec6.c
>> +++ b/drivers/pinctrl/pinctrl-artpec6.c
>> @@ -688,8 +688,9 @@ static void artpec6_pmx_select_func(struct pinctrl_dev *pctldev,
>>  	}
>>  }
>>  
>> -int artpec6_pmx_enable(struct pinctrl_dev *pctldev, unsigned int function,
>> -		       unsigned int group)
>> +static int artpec6_pmx_enable(struct pinctrl_dev *pctldev,
>> +			      unsigned int function,
>> +			      unsigned int group)
>>  {
>>  	struct artpec6_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
>>  
>> @@ -702,8 +703,9 @@ int artpec6_pmx_enable(struct pinctrl_dev *pctldev, unsigned int function,
>>  	return 0;
>>  }
>>  
>> -void artpec6_pmx_disable(struct pinctrl_dev *pctldev, unsigned int function,
>> -			 unsigned int group)
>> +static void artpec6_pmx_disable(struct pinctrl_dev *pctldev,
>> +				unsigned int function,
>> +				unsigned int group)
> 
> On arm32 allyesconfig:
> 
> drivers/pinctrl/pinctrl-artpec6.c:706:13: error: unused function
> 'artpec6_pmx_disable' [-Werror,-Wunused-function]
> 
> This is the second time you've introduced an unused function warning by
> making a function static[1], could you please be a little more vigilant
> in your clean ups in the future?

Sorry for this.

> 
> [1]: https://lore.kernel.org/lkml/20190327050126.12064-1-natechancellor@gmail.com/
> 
> Linus/Jesper/Lars, should this function just be deleted? I'd be happy to
> send a patch doing so if that's the right course of action.
> 
> Thanks,
> Nathan
> 
>>  {
>>  	struct artpec6_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
>>  
>> -- 
>> 2.7.0
>>
>>
> 
> .
> 

