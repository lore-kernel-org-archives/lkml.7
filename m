Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2B3C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1A1214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uJ1keCPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfILGv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 02:51:27 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:49346 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbfILGv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 02:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568271086; x=1599807086;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=v/pX95VG0dk6qWY6B2d9zRKQJS6kq+3rjfgFHXmjK3k=;
  b=uJ1keCPWpZraDikDMGwDTZUm6pvR/c5WBIa8mJj588WrSGPnVVUrsram
   mTVL1FrsggrLzNprA08vPxx6y139+HCfolb2BFf/BbrPU+y/xYP9PkJlX
   XfCUG0wSsyK+wX5JnoYhfWGuSi6cDaU9Y7n0eRVsqfgUN3eboO/iDpqKP
   g=;
X-IronPort-AV: E=Sophos;i="5.64,495,1559520000"; 
   d="scan'208";a="750339449"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 12 Sep 2019 06:51:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 74E36A0491;
        Thu, 12 Sep 2019 06:51:21 +0000 (UTC)
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 06:51:20 +0000
Received: from [10.125.238.52] (10.43.162.242) by EX13D01EUB002.ant.amazon.com
 (10.43.166.113) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 12 Sep
 2019 06:51:14 +0000
Subject: Re: [UNVERIFIED SENDER] Re: [PATCH v2 3/3] soc: amazon: al-pos: cast
 to u64 before left shifting
To:     Marc Zyngier <maz@kernel.org>
CC:     <robh+dt@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <mchehab+samsung@kernel.org>, <shawn.lin@rock-chips.com>,
        <gregkh@linuxfoundation.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1568142310-17622-1-git-send-email-talel@amazon.com>
 <1568142310-17622-4-git-send-email-talel@amazon.com>
 <86blvqsyq0.wl-maz@kernel.org>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <57d36339-d1e6-ac60-1ec2-4fb6bebf6d2f@amazon.com>
Date:   Thu, 12 Sep 2019 09:51:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <86blvqsyq0.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.162.242]
X-ClientProxiedBy: EX13D08UWC003.ant.amazon.com (10.43.162.21) To
 EX13D01EUB002.ant.amazon.com (10.43.166.113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/11/2019 5:18 PM, Marc Zyngier wrote:
> On Tue, 10 Sep 2019 20:05:10 +0100,
> Talel Shenhar <talel@amazon.com> wrote:
>> Fix wrap around for pos errors on addresses above 32 bit.
>>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> ---
>>   drivers/soc/amazon/al_pos.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/amazon/al_pos.c b/drivers/soc/amazon/al_pos.c
>> index a865111..e95e1fc 100644
>> --- a/drivers/soc/amazon/al_pos.c
>> +++ b/drivers/soc/amazon/al_pos.c
>> @@ -49,7 +49,7 @@ static irqreturn_t al_pos_irq_handler(int irq, void *info)
>>   	writel(0, pos->mmio_base + AL_POS_ERROR_LOG_1);
>>   
>>   	addr = FIELD_GET(AL_POS_ERROR_LOG_0_ADDR_LOW, log0);
>> -	addr |= (FIELD_GET(AL_POS_ERROR_LOG_1_ADDR_HIGH, log1) << 32);
>> +	addr |= (((u64)FIELD_GET(AL_POS_ERROR_LOG_1_ADDR_HIGH, log1)) << 32);
>>   	request_id = FIELD_GET(AL_POS_ERROR_LOG_1_REQUEST_ID, log1);
>>   	bresp = FIELD_GET(AL_POS_ERROR_LOG_1_BRESP, log1);
>>   
>> -- 
>> 2.7.4
>>
> This fix should be squashed into the previous patch.
Sure, Shall be part of v3.
>
> Thanks,
>
> 	M.
>
