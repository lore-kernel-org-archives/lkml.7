Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AAAC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2508C20861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BOPS402W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfGILBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:01:15 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44219 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGILBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562670074; x=1594206074;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FMJEzTCAPWq9BYGA0wXEs1vocglVfN8Tlz/V4lS1OfE=;
  b=BOPS402WtIgEXuGGqPOpCG/uDfBrkqpnIRtWJTA/YdY7BfFvA/jQKndX
   NLYAm72XFn1HwlzrrwmAZReA6fYrFd+kSwF2gwoZ4/BYHERAC3OInzwei
   AOc+7ZuyYEMV0lqwFu3T1GXG7Jf4ME+JwOpFFjA+ytOzLYQ07U1Y9Mhgh
   k=;
X-IronPort-AV: E=Sophos;i="5.62,470,1554768000"; 
   d="scan'208";a="740972077"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Jul 2019 11:01:11 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 839CCA2066;
        Tue,  9 Jul 2019 11:01:10 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 9 Jul 2019 11:01:10 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 9 Jul 2019 11:01:10 +0000
Received: from [10.107.3.17] (10.107.3.17) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Tue, 9 Jul 2019 11:01:05 +0000
Subject: Re: [PATCH v2 2/4] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <paulmck@linux.ibm.com>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
References: <1562500658-14717-1-git-send-email-hhhawa@amazon.com>
 <1562500658-14717-3-git-send-email-hhhawa@amazon.com>
 <20190709173229.0000135f@huawei.com>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <45e9ac35-9ffc-8f5f-cbdb-f85453227363@amazon.com>
Date:   Tue, 9 Jul 2019 14:01:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709173229.0000135f@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2019 12:32 PM, Jonathan Cameron wrote:
>> Signed-off-by: Hanna Hawa<hhhawa@amazon.com>
> A quick drive by review as I was feeling curious.
> 
> Just a couple of trivial queries and observation on the fact it
> might be useful to add a few devm managed functions to cut down
> on edac driver boilerplate.
> 
> Thanks,
> 
> Jonathan
> 
>> +#define ARM_CA57_CPUMERRSR_VALID		GENMASK(31, 31)
> For a single bit it's common to use BIT(31) rather than GENMASK to make
> it explicit.

Will fix.

> 
> 
>> +	edac_dev->mod_name = dev_name(dev);
> I'd admit I'm not that familiar with edac, but seems odd that a
> module name field would have the dev_name.

Will fix when I got more inputs.

> 
>> +	edac_device_free_ctl_info(edac_dev);
> More a passing observation than a suggestion for this driver, but if there was
> ever a place where it looked like a couple of devm_ allocation functions would
> be useful, this is it;)
> 
> edac_dev = devm_device_alloc_ctrl_info(dev, ...)
> ...
> devm_edac_device_add_device(dev, ...)

I agree.
I can implement the devm_* functions in separate patches as this is not 
related to my patches (and not to delay this patches).

> 
> 
