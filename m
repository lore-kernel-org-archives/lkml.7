Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B7C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEC326FDA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfFCQpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:45:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55358 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfFCQpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:45:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BBAE80D;
        Mon,  3 Jun 2019 09:45:30 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8127F3F5AF;
        Mon,  3 Jun 2019 09:45:29 -0700 (PDT)
Subject: Re: [RFC PATCH 39/57] drivers: mux: Use class_find_device_by_of_node
 helper
To:     peda@axentia.se, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-40-git-send-email-suzuki.poulose@arm.com>
 <bdfa93d6-a45f-cc26-bc95-42ef21c7e8c6@axentia.se>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <0c98e540-ae82-4cf8-0936-0d61ae04eac7@arm.com>
Date:   Mon, 3 Jun 2019 17:45:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bdfa93d6-a45f-cc26-bc95-42ef21c7e8c6@axentia.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for your comments, please see my response inline.

On 03/06/2019 17:22, Peter Rosin wrote:
> Hi!
> 
> This all sounds like nice changes. First a couple of nitpicks:
> 
>  From the cover letter, included here to spare most of the others...
> 
>> subsystems. This series is an attempt to consolidate the and cleanup
> 
> s/the and/and/

Thanks for spotting.

> 
> On 2019-06-03 17:50, Suzuki K Poulose wrote:
>> Use the generic helper to find a device matching the of_node.
>>
>> Cc: Peter Rosin <peda@axentia.se>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/mux/core.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>> index d1271c1..3591e40 100644
>> --- a/drivers/mux/core.c
>> +++ b/drivers/mux/core.c
>> @@ -405,18 +405,12 @@ int mux_control_deselect(struct mux_control *mux)
>>   }
>>   EXPORT_SYMBOL_GPL(mux_control_deselect);
>>   
>> -static int of_dev_node_match(struct device *dev, const void *data)
>> -{
>> -	return dev->of_node == data;
>> -}
>> -
>>   /* Note this function returns a reference to the mux_chip dev. */
>>   static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
>>   {
>>   	struct device *dev;
>>   
>> -	dev = class_find_device(&mux_class, NULL, np, of_dev_node_match);
>> -
> 
> Nitpick #2. Please leave the blank line where it belongs.

Agreed !

> 
> However, how can I review this if I do not get to see the patch that
> adds the class_find_device_by_of_node function? Please provide a
> little bit more context!

Sorry about that. The routine is a wrapper to class_find_device()
which uses a generic routine to match the of_node, instead of the
driver specific of_dev_node_match(). The series adds such wrappers for
{bus/drivers/class}_find_device(). Unfortunately I didn't add
individual driver maintainers to the patches, which add those wrappers.
For the moment, please find the link below for the patch :

https://lkml.kernel.org/r/1559577023-558-29-git-send-email-suzuki.poulose@arm.com


I will try to address it in the next revision.

Kind regards
Suzuki
