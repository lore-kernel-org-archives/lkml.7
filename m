Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA79C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0699D2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCZL7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:59:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35252 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCZL7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:59:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E70691596;
        Tue, 26 Mar 2019 04:59:18 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 025B73F59C;
        Tue, 26 Mar 2019 04:59:17 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: Fix leak in scmi_mailbox_check
To:     Mukesh Ojha <mojha@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20190325173722.49414-1-steven.price@arm.com>
 <dcf27d87-e72f-3892-f982-941c91f95102@codeaurora.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <5135e6df-4977-bd97-95d9-300c12c9e073@arm.com>
Date:   Tue, 26 Mar 2019 11:59:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <dcf27d87-e72f-3892-f982-941c91f95102@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 07:23, Mukesh Ojha wrote:
> 
> On 3/25/2019 11:07 PM, Steven Price wrote:
>> of_parse_phandle_with_args() requires the caller to call of_node_put() on
>> the returned args->np pointer. Otherwise the reference count will remain
>> incremented.
>>
>> However, in this case, since we don't actually use the returned pointer,
>> we can simply pass in NULL.
>>
>> Fixes: aa4f886f3893f ("firmware: arm_scmi: add basic driver
>> infrastructure for SCMI")
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>   drivers/firmware/arm_scmi/driver.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/driver.c
>> b/drivers/firmware/arm_scmi/driver.c
>> index 8f952f2f1a29..dd967d675c08 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -654,9 +654,7 @@ static int scmi_xfer_info_init(struct scmi_info
>> *sinfo)
>>     static int scmi_mailbox_check(struct device_node *np)
>>   {
>> -    struct of_phandle_args arg;
>> -
>> -    return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0,
>> &arg);
>> +    return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0,
>> NULL);
> 
> Although, it is not used but it is better to put arg->np instead of
> passing NULL.
> Here, you are making the driver not to fill arguement which is
> customised solution, that may change in future.

The function of_parse_phandle_with_args() is documented thus:

>  * of_parse_phandle_with_args() - Find a node pointed by phandle in a list
>  * @np:		pointer to a device tree node containing a list
>  * @list_name:	property name that contains a list
>  * @cells_name:	property name that specifies phandles' arguments count
>  * @index:	index of a phandle to parse out
>  * @out_args:	optional pointer to output arguments structure (will be filled)

So I'm going by the documentation (and implementation) which both
consider out_args to be optional. The alternative is of course:

> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 8f952f2f1a29..aa6c0728e676 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -655,8 +655,11 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>  static int scmi_mailbox_check(struct device_node *np)
>  {
>  	struct of_phandle_args arg;
> +	int ret;
>  
> -	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
> +	ret = of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, &arg);
> +	of_node_put(arg->np);
> +	return ret;
>  }
>  
>  static int scmi_mbox_free_channel(int id, void *p, void *data)

But personally that doesn't seem as good. Is there any reason to think
the interface of of_parse_phandle_with_args() will change?

Steve
