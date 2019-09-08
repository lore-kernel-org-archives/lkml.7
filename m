Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB67C4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 07:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5152082C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 07:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uWCkiMYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfIHH7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 03:59:15 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:9624 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfIHH7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 03:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567929552; x=1599465552;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=95z+TopiVfICeaKBblrEU+S5vNus3UEMlJ3VR16Kq1w=;
  b=uWCkiMYsQ4s2HcvvKVnhTl2NkQsfNSaRfHasGVPbgM0Vk7dnyuNg7Pwe
   1XIezwPddAcsaJg57tGIBk7qwNeBoYxxo3Dp6sKBkuPP5WeQJMImoH8Vo
   r87eYvHCM1DH68YdJJZ13ei+CAf76ARmVLuu6Xn9iauAhkPWzPPIfJbJg
   M=;
X-IronPort-AV: E=Sophos;i="5.64,479,1559520000"; 
   d="scan'208";a="701348721"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 08 Sep 2019 07:58:37 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 3815AA1E64;
        Sun,  8 Sep 2019 07:58:36 +0000 (UTC)
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 8 Sep 2019 07:58:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 8 Sep 2019 07:58:35 +0000
Received: from [10.107.3.19] (10.107.3.19) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Sun, 8 Sep 2019 07:58:33 +0000
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Subject: Re: [PATCH 1/1] edac: Add an API for edac device to report for
 multiple errors
To:     Robert Richter <rrichter@marvell.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
References: <20190905083745.6899-1-hhhawa@amazon.com>
 <20190905095642.ohqkcllm7wufx6sc@rric.localdomain>
Message-ID: <50f5bc27-98da-ee3e-59dd-7252c3ed7a0a@amazon.com>
Date:   Sun, 8 Sep 2019 10:58:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905095642.ohqkcllm7wufx6sc@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/2019 12:56 PM, Robert Richter wrote:
> Hi Hanna,
> 
> thanks for the update. See below.
> 
> On 05.09.19 09:37:45, Hanna Hawa wrote:
>> Add an API for edac device to report multiple errors with same type.
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
>> ---
>>   drivers/edac/edac_device.c | 66 +++++++++++++++++++++++++++++---------
>>   drivers/edac/edac_device.h | 31 ++++++++++++++++--
>>   2 files changed, 79 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
>> index 65cf2b9355c4..bf6a4fd9831b 100644
>> --- a/drivers/edac/edac_device.c
>> +++ b/drivers/edac/edac_device.c
>> @@ -555,12 +555,15 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
>>   	return edac_dev->panic_on_ue;
>>   }
>>   
>> -void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>> -			int inst_nr, int block_nr, const char *msg)
>> +static void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>> +			   u16 error_count, int inst_nr, int block_nr,
> 
> Just curious, why u16, some register mask size? Maybe just use unsigned int?

Wanted to be aligned with edac MC.
I can change it to be u32.

> 
> I think the variable can be shortened to 'count', the meaning should
> still be clear.

I think more clear to include 'error'.
maybe shorter name 'err_count'?

> 
>> +			   const char *msg)
>>   {
>>   	struct edac_device_instance *instance;
>>   	struct edac_device_block *block = NULL;
>>   
>> +	WARN_ON(!error_count);
> 
> Should return in this case.
> 
> Better use WARN_ON_ONCE() to avoid flooding.

In case of two drivers using this function with wrong error count, only 
the first WARN_ON_ONCE will catch in this case, and other will miss 
other wrong usage of other edac device drivers.

> 
> The check should be moved to edac_device_handle_ce_count().

I'll move it to edac_device_handle_ce_count.

> 
>> +
>>   	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
>>   		edac_device_printk(edac_dev, KERN_ERR,
>>   				"INTERNAL ERROR: 'instance' out of range "
>> @@ -582,27 +585,44 @@ void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>>   
>>   	if (instance->nr_blocks > 0) {
>>   		block = instance->blocks + block_nr;
>> -		block->counters.ce_count++;
>> +		block->counters.ce_count += error_count;
>>   	}
>>   
>>   	/* Propagate the count up the 'totals' tree */
>> -	instance->counters.ce_count++;
>> -	edac_dev->counters.ce_count++;
>> +	instance->counters.ce_count += error_count;
>> +	edac_dev->counters.ce_count += error_count;
>>   
>>   	if (edac_device_get_log_ce(edac_dev))
>>   		edac_device_printk(edac_dev, KERN_WARNING,
>> -				"CE: %s instance: %s block: %s '%s'\n",
>> +				"CE: %s instance: %s block: %s count: %d '%s'\n",
>>   				edac_dev->ctl_name, instance->name,
>> -				block ? block->name : "N/A", msg);
>> +				block ? block->name : "N/A", error_count, msg);
>> +}
>> +
>> +void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>> +			   int inst_nr, int block_nr, const char *msg)
>> +{
>> +	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
>>   }
>>   EXPORT_SYMBOL_GPL(edac_device_handle_ce);
> 
> We could just export the __*() version of those functions and make
> everything else inline in the header file? Though, better do this with
> two patches to avoid an ABI breakage in case someone wants to backport
> it. Let's see what others say here.

Waiting for other reviewers.

> 
>>   
>> -void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>> -			int inst_nr, int block_nr, const char *msg)
>> +void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
>> +				 u16 error_count, int inst_nr, int block_nr,
>> +				 const char *msg)
>> +{
>> +	__edac_device_handle_ce(edac_dev, error_count, inst_nr, block_nr, msg);
>> +}
>> +EXPORT_SYMBOL_GPL(edac_device_handle_ce_count);
>> +
>> +static void __edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>> +			   u16 error_count, int inst_nr, int block_nr,
>> +			   const char *msg)
> 
> All the above applies for this function too.
> 
>>   {
>>   	struct edac_device_instance *instance;
>>   	struct edac_device_block *block = NULL;
>>   
>> +	WARN_ON(!error_count);
>> +
>>   	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
>>   		edac_device_printk(edac_dev, KERN_ERR,
>>   				"INTERNAL ERROR: 'instance' out of range "
>> @@ -624,22 +644,36 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>>   
>>   	if (instance->nr_blocks > 0) {
>>   		block = instance->blocks + block_nr;
>> -		block->counters.ue_count++;
>> +		block->counters.ue_count += error_count;
>>   	}
>>   
>>   	/* Propagate the count up the 'totals' tree */
>> -	instance->counters.ue_count++;
>> -	edac_dev->counters.ue_count++;
>> +	instance->counters.ue_count += error_count;
>> +	edac_dev->counters.ue_count += error_count;
>>   
>>   	if (edac_device_get_log_ue(edac_dev))
>>   		edac_device_printk(edac_dev, KERN_EMERG,
>> -				"UE: %s instance: %s block: %s '%s'\n",
>> +				"UE: %s instance: %s block: %s count: %d '%s'\n",
>>   				edac_dev->ctl_name, instance->name,
>> -				block ? block->name : "N/A", msg);
>> +				block ? block->name : "N/A", error_count, msg);
>>   
>>   	if (edac_device_get_panic_on_ue(edac_dev))
>> -		panic("EDAC %s: UE instance: %s block %s '%s'\n",
>> +		panic("EDAC %s: UE instance: %s block %s count: %d '%s'\n",
>>   			edac_dev->ctl_name, instance->name,
>> -			block ? block->name : "N/A", msg);
>> +			block ? block->name : "N/A", error_count, msg);
>> +}
>> +
>> +void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>> +			   int inst_nr, int block_nr, const char *msg)
>> +{
>> +	__edac_device_handle_ue(edac_dev, 1, inst_nr, block_nr, msg);
>>   }
>>   EXPORT_SYMBOL_GPL(edac_device_handle_ue);
>> +
>> +void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
>> +				 u16 error_count, int inst_nr, int block_nr,
>> +				 const char *msg)
>> +{
>> +	__edac_device_handle_ue(edac_dev, error_count, inst_nr, block_nr, msg);
>> +}
>> +EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
>> diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
>> index 1aaba74ae411..c8dc83eda64f 100644
>> --- a/drivers/edac/edac_device.h
>> +++ b/drivers/edac/edac_device.h
>> @@ -287,7 +287,7 @@ extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
>>   
>>   /**
>>    * edac_device_handle_ue():
>> - *	perform a common output and handling of an 'edac_dev' UE event
>> + *	perform a common output and handling of an 'edac_dev' single UE event
>>    *
>>    * @edac_dev: pointer to struct &edac_device_ctl_info
>>    * @inst_nr: number of the instance where the UE error happened
>> @@ -298,7 +298,7 @@ extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>>   				int inst_nr, int block_nr, const char *msg);
>>   /**
>>    * edac_device_handle_ce():
>> - *	perform a common output and handling of an 'edac_dev' CE event
>> + *	perform a common output and handling of an 'edac_dev' single CE event
>>    *
>>    * @edac_dev: pointer to struct &edac_device_ctl_info
>>    * @inst_nr: number of the instance where the CE error happened
>> @@ -308,6 +308,33 @@ extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>>   extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>>   				int inst_nr, int block_nr, const char *msg);
>>   
>> +/**
>> + * edac_device_handle_ue_count():
>> + *	perform a common output and handling of an 'edac_dev'
>> + *
>> + * @edac_dev: pointer to struct &edac_device_ctl_info
>> + * @error_count: number of errors of the same type
>> + * @inst_nr: number of the instance where the UE error happened
>> + * @block_nr: number of the block where the UE error happened
>> + * @msg: message to be printed
>> + */
>> +extern void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
>> +					u16 error_count, int inst_nr,
>> +					int block_nr, const char *msg);
>> +/**
>> + * edac_device_handle_ce_count():
>> + *	perform a common output and handling of an 'edac_dev'
>> + *
>> + * @edac_dev: pointer to struct &edac_device_ctl_info
>> + * @error_count: number of errors of the same type
>> + * @inst_nr: number of the instance where the CE error happened
>> + * @block_nr: number of the block where the CE error happened
>> + * @msg: message to be printed
>> + */
>> +extern void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
>> +					u16 error_count, int inst_nr,
>> +					int block_nr, const char *msg);
>> +
> 
> Looks otherwise good to me.

Thanks!

Thanks,
Hanna

> 
> Thanks,
> 
> -Robert
> 
>>   /**
>>    * edac_device_alloc_index: Allocate a unique device index number
>>    *
>> -- 
>> 2.17.1
>>
