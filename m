Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62933C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAED206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfC1P0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:26:10 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:55429 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfC1P0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:26:09 -0400
Received: from [IPv6:2001:420:44c1:2579:7126:11db:5076:31b1] ([IPv6:2001:420:44c1:2579:7126:11db:5076:31b1])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 9Wuph7LWJNG8z9Wuthprsh; Thu, 28 Mar 2019 16:26:07 +0100
Subject: Re: [PATCH] media: rcar-vin: fix a potential NULL pointer dereference
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190309070527.2657-1-kjlu@umn.edu>
 <20190309110217.GA5281@bigcity.dyn.berto.se>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c16cbf21-562a-ba00-020e-6232fc27e9f9@xs4all.nl>
Date:   Thu, 28 Mar 2019 16:26:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190309110217.GA5281@bigcity.dyn.berto.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBEB/0puJGDittCRzgcErJ5iT0vB8q+I3QeuojGpSk72r7Zeew5ze69IljW770giFQZcGW78sr3t9dPyasq2QAUYMNfIwkJUVRtN+TRmnyHHFJaBaR9g
 X8crBnLbS1u8Gx0/f7FP8U0MkNiaeWF9w7ASsmAbDxqK8YCCRgNQ5v/86ULIHKVqWWyzXpU5Ko+rrX5FgrETx2VOo2E5ialSnQ438ctbLVAUDd1hYL2ERJVo
 nBQxv2PgsG5JjDM0CBgtwGzbcyN9qo4RnlImJKZRiXOmgoH5Enhia5rt4PkosjuiMQqfgYjONqDKNrEYkBEbXxdPbi/EvMsrFGgogh5wBsddS1sKIvgesiB5
 DRGBnvnZk9UUdo1ej7rNGe9qFhpK8ioRbTIPr7937DpmkR+mx4cAm7KV+cyB4ouDQpjBWjwj3oBy5HlywmGZYfKWoA/wLRIaRHMnMdedqFK39eFw1RXI7Gel
 b497XBQayYXlbk5uG00jKveC/aoO1x4KdYRPUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/19 12:02 PM, Niklas Söderlund wrote:
> Hi Kangjie,
> 
> Thanks for your patch.
> 
> On 2019-03-09 01:05:27 -0600, Kangjie Lu wrote:
>> In case of_match_node cannot find a match, the fix returns
>> -EINVAL to avoid NULL pointer dereference.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>>  drivers/media/platform/rcar-vin/rcar-core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
>> index f0719ce24b97..a058e2023ca8 100644
>> --- a/drivers/media/platform/rcar-vin/rcar-core.c
>> +++ b/drivers/media/platform/rcar-vin/rcar-core.c
>> @@ -266,6 +266,8 @@ static int rvin_group_init(struct rvin_group *group, struct rvin_dev *vin)
>>  
>>  	match = of_match_node(vin->dev->driver->of_match_table,
>>  			      vin->dev->of_node);
>> +	if (unlikely(!match))
>> +		return -EINVAL;
> 
> I don't think this is needed. The driver depends on selects OF and if we 
> get this far we it is because we had a match already. The reason to call 
> of_match_node() here is simply to retrieve which of the possible 
> compatible strings was matched.
> 
> Am I missing something? What scenario do you see where this can fail?

And even if it can fail, then please drop the 'unlikely'.

Regards,

	Hans

> 
>>  
>>  	strscpy(mdev->driver_name, KBUILD_MODNAME, sizeof(mdev->driver_name));
>>  	strscpy(mdev->model, match->compatible, sizeof(mdev->model));
>> -- 
>> 2.17.1
>>
> 

