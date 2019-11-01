Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA7DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9769B20656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfKALzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:55:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbfKALzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:55:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 201F2492D232B3534227;
        Fri,  1 Nov 2019 19:55:46 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 19:55:43 +0800
Message-ID: <5DBC1D3E.8080705@huawei.com>
Date:   Fri, 1 Nov 2019 19:55:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Maxime Ripard <mripard@kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: sun4i: Use PTR_ERR_OR_ZERO to simplify the code
References: <1572530979-27595-1-git-send-email-zhongjiang@huawei.com> <20191101091355.ibbet6a2zb23bpjn@hendrix>
In-Reply-To: <20191101091355.ibbet6a2zb23bpjn@hendrix>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/1 17:13, Maxime Ripard wrote:
> On Thu, Oct 31, 2019 at 10:09:39PM +0800, zhong jiang wrote:
>> It is better to use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  sound/soc/sunxi/sun4i-i2s.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>> index d0a8d58..72012a6 100644
>> --- a/sound/soc/sunxi/sun4i-i2s.c
>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>> @@ -1174,10 +1174,8 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
>>  	i2s->field_fmt_sr =
>>  			devm_regmap_field_alloc(dev, i2s->regmap,
>>  						i2s->variant->field_fmt_sr);
>> -	if (IS_ERR(i2s->field_fmt_sr))
>> -		return PTR_ERR(i2s->field_fmt_sr);
>>
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);
> I don't find it "better". This couples the error handling and the
> success case, and it makes it harder to extend in the future.
PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR. It is 
feasible to replace it and more readable at least now. 

As you said,  PTR_ERR_OR_ZERO should be removed ? :-( 

Thanks,
zhong jiang


> Maxime


