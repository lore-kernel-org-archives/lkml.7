Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEEBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A116218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KBzh3jsx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UsgIOdxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCTUjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:39:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48370 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfCTUjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:39:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8C061607C3; Wed, 20 Mar 2019 20:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553114393;
        bh=41V6rGfP0Y9n1onKrGGSp5O80vwLf87ok8L0wus7bvE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KBzh3jsx9KRBESIco6nLjcfwsaMbsVCN+rXB8UatMoR2ZBNzVzeEmBaPu17jRE3db
         SVmg+SRzfhBanUL8VhSHahv/W1OshvQ3Wy/0Q2VghkoDhOu7lmI/7YnWxJT6BccJrZ
         5UEevaUX7ms0WsEOfWnd1LHN+zzRDZhLX6WDhYAU=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85B93607C6;
        Wed, 20 Mar 2019 20:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553114392;
        bh=41V6rGfP0Y9n1onKrGGSp5O80vwLf87ok8L0wus7bvE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UsgIOdxz439rIeCzDkAzsb+yCMPCVQcztwpu9U2nyR4WbwvI0WrgusvDhyVpt+PG9
         /xKRQH1qhbFyLRNG/ro4S0UCJkA3NhlxKJsYYgyN70NZL+kc35GNntqVxZ16gRrga5
         eZXQXlwIRLWC6IF8KiaWI25K8ySYpYQEX9I4NrsE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85B93607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] thunderbolt: Fix to check return value of
 ida_simple_get
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190320162446.30500-1-pakki001@umn.edu>
 <20190320162924.GA3622@lahna.fi.intel.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <78aa904a-6b98-9fb3-e2ca-b9994dc04869@codeaurora.org>
Date:   Thu, 21 Mar 2019 02:09:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320162924.GA3622@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 9:59 PM, Mika Westerberg wrote:
> On Wed, Mar 20, 2019 at 11:24:45AM -0500, Aditya Pakki wrote:
>> In enumerate_services, ida_simple_get on failure can return an error and
>> leaks memory during device_register failure. The patch ensures that
>> the dev_set_name is set on non failure cases, and releases memory in
>> case of failure.
>>
>> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>>
>> ---
>> v1: Missed cleanup of svc in case of allocation failure and
>> device_register failure.
>> ---
>>   drivers/thunderbolt/xdomain.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
>> index e27dd8beb94b..eb08275185bf 100644
>> --- a/drivers/thunderbolt/xdomain.c
>> +++ b/drivers/thunderbolt/xdomain.c
>> @@ -740,6 +740,7 @@ static void enumerate_services(struct tb_xdomain *xd)
>>   	struct tb_service *svc;
>>   	struct tb_property *p;
>>   	struct device *dev;
>> +	int id;
>>   
>>   	/*
>>   	 * First remove all services that are not available anymore in
>> @@ -768,7 +769,12 @@ static void enumerate_services(struct tb_xdomain *xd)
>>   			break;
>>   		}
>>   
>> -		svc->id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
>> +		id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
>> +		if (id < 0) {
>> +			kfree(svc);
>> +			break;
>> +		}
>> +		svc->id = id;
>>   		svc->dev.bus = &tb_bus_type;
>>   		svc->dev.type = &tb_service_type;
>>   		svc->dev.parent = &xd->dev;
>> @@ -776,6 +782,7 @@ static void enumerate_services(struct tb_xdomain *xd)
>>   
>>   		if (device_register(&svc->dev)) {
>>   			put_device(&svc->dev);
>> +			kfree(svc);
> You can't do this after device_register() is called. The put_device()
> above is sufficient.


If  device_register fails, how would svc gets freed? we need  to kfree 
svc here as well.

Thanks,
Mukesh

