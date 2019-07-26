Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30882C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0888B2189F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfGZRYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:24:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:42026 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbfGZRYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:24:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 10:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="369603426"
Received: from haiyuewa-mobl.ccr.corp.intel.com (HELO [10.255.31.18]) ([10.255.31.18])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2019 10:24:43 -0700
Subject: Re: [RFC PATCH 14/17] ipmi: kcs: Finish configuring ASPEED KCS device
 before enable
From:   "Wang, Haiyue" <haiyue.wang@linux.intel.com>
To:     Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corey Minyard <minyard@acm.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net
References: <20190726053959.2003-1-andrew@aj.id.au>
 <20190726053959.2003-15-andrew@aj.id.au>
 <29a2d999-23bd-8e95-a1b8-f00e25a11df5@linux.intel.com>
Message-ID: <b4d60d12-0a1f-906a-1f3a-da0cfdd06be3@linux.intel.com>
Date:   Sat, 27 Jul 2019 01:24:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <29a2d999-23bd-8e95-a1b8-f00e25a11df5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019-07-27 01:04, Wang, Haiyue 写道:
> 在 2019-07-26 13:39, Andrew Jeffery 写道:
>> The currently interrupts are configured after the channel was enabled.
>>
>> Cc: Haiyue Wang<haiyue.wang@linux.intel.com>
>> Cc: Corey Minyard<minyard@acm.org>
>> Cc: Arnd Bergmann<arnd@arndb.de>
>> Cc: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
>> Cc:openipmi-developer@lists.sourceforge.net
>> Signed-off-by: Andrew Jeffery<andrew@aj.id.au>
>> ---
>>   drivers/char/ipmi/kcs_bmc_aspeed.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c 
>> b/drivers/char/ipmi/kcs_bmc_aspeed.c
>> index 3c955946e647..e3dd09022589 100644
>> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
>> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
>> @@ -268,13 +268,14 @@ static int aspeed_kcs_probe(struct 
>> platform_device *pdev)
>>       kcs_bmc->io_inputb = aspeed_kcs_inb;
>>       kcs_bmc->io_outputb = aspeed_kcs_outb;
>>   +    rc = aspeed_kcs_config_irq(kcs_bmc, pdev);
>> +    if (rc)
>> +        return rc;
>> +
>>       dev_set_drvdata(dev, kcs_bmc);
>
>
> Thanks for catching this, for not miss the data.
>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
