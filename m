Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A615CC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D617206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NrxzvsRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfFEOv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:51:26 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:26595 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfFEOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559746285; x=1591282285;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IZ8RZ0C0aRcyyn2nmwffWRB8xOsqFtkZCpJc5LHuhpo=;
  b=NrxzvsRDnExhY5qBth68RtXXkAbqc8gCLe1sIV3LwRM8qblLYLVCXgi3
   +EkOkS40O61q86DZ03lZ6vXrfNUIAFxo8PPxKaQthjGnYJtwntfmIHoeN
   ubYPs9lfIcg1bHCdxSMGDP0vzRpBil0Jfp4K5g/h2WdZZTgwRTLpDJ2FW
   w=;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="769112211"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Jun 2019 14:51:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 29AC7A1CF4;
        Wed,  5 Jun 2019 14:51:22 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 14:51:21 +0000
Received: from [10.125.238.52] (10.43.160.65) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 5 Jun
 2019 14:51:12 +0000
Subject: Re: [PATCH v2 2/2] irqchip: al-fic: Introduce Amazon's Annapurna Labs
 Fabric Interrupt Controller Driver
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <nicolas.ferre@microchip.com>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <robh+dt@kernel.org>,
        <davem@davemloft.net>, <shawn.lin@rock-chips.com>,
        <tglx@linutronix.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <jonnyc@amazon.com>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>, <talel@amazon.com>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
 <1559731921-14023-3-git-send-email-talel@amazon.com>
 <20190605125055.GA3184@kroah.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <fb3f5f4d-26f4-8729-7370-f206369ab2b7@amazon.com>
Date:   Wed, 5 Jun 2019 17:51:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605125055.GA3184@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D13UWA004.ant.amazon.com (10.43.160.251) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/5/2019 3:50 PM, Greg KH wrote:
> On Wed, Jun 05, 2019 at 01:52:01PM +0300, Talel Shenhar wrote:
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-al-fic.c
>> @@ -0,0 +1,289 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
> No need for kernel-doc format style here.
done
>
>> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> "or its affiliates"?  You know the answer to this, don't keep us in
> suspense.  Put the proper copyright holder here please, otherwise this
> is totally useless.
>
> Well, copyright notices are technically useless anyway, but lawyers like
> to cargo-cult with the best of them, so it should be correct at the
> least.

This is the format we were asked to use and have been using.

I am pinging them with your comment but I am likely not to get immediate 
response so I'm publishing v3 without changing the "affiliates" for now.

>
> thanks,
>
> greg k-h
