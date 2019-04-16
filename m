Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6973FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC3F20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfDPNCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:02:04 -0400
Received: from foss.arm.com ([217.140.101.70]:54588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfDPNCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:02:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 907E1EBD;
        Tue, 16 Apr 2019 06:02:03 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F8C73F706;
        Tue, 16 Apr 2019 06:02:02 -0700 (PDT)
Subject: Re: [PATCH 01/12] arm-cci: add missing of_node_put after
 of_device_is_available
To:     Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>, linux@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1550928043-14889-2-git-send-email-Julia.Lawall@lip6.fr>
 <2c56bdcb-9354-c719-13df-38b5f1974f10@web.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b50cffe8-5fe4-eb44-adf4-48bf8604943a@arm.com>
Date:   Tue, 16 Apr 2019 14:02:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2c56bdcb-9354-c719-13df-38b5f1974f10@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2019 15:45, Markus Elfring wrote:
>> @@ -538,8 +538,10 @@  static int cci_probe(void)
>>   	struct resource res;
>>
>>   	np = of_find_matching_node(NULL, arm_cci_matches);
>> -	if (!of_device_is_available(np))
>> +	if (!of_device_is_available(np)) {
>> +		of_node_put(np);
>>   		return -ENODEV;
>> +	}
>>
>>   	ret = of_address_to_resource(np, 0, &res);
>>   	if (!ret) {
> 
> How do you think about to move this function call to an additional jump target
> for the desired exception handling?

TBH it looks like the whole thing could do with a bit of refactoring - 
strictly we should probably be dropping the node reference in all the 
other failure paths too.

Robin.
