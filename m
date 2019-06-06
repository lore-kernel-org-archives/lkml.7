Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BDDC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C57D20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cpT4Ry8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFFH0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:26:13 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31672 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFH0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559805972; x=1591341972;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mwPg6ZnGSCRENnbKaTCqPwiVkjA1qtZzZjwWWCUaAyA=;
  b=cpT4Ry8uLZ4APaumzAGkHy/+sO2YsV41Yx0y19uXOD5VbCvAnbRMUstS
   g9ReMzJZHcEv+p6fVa07OKsjlKmyRkj+h2DxWemUsVbxHjd0SFGCnSBr+
   H1SLlwxKpMlYp4f9kwLP+ajJo1dnshuvE2ZEDQLqRiEM2ruION8Nltg1P
   U=;
X-IronPort-AV: E=Sophos;i="5.60,558,1549929600"; 
   d="scan'208";a="808901085"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 06 Jun 2019 07:26:10 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id EE7C9A2963;
        Thu,  6 Jun 2019 07:26:09 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 6 Jun 2019 07:26:09 +0000
Received: from [10.125.238.52] (10.43.162.225) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 6 Jun
 2019 07:26:00 +0000
Subject: Re: [PATCH v2 2/2] irqchip: al-fic: Introduce Amazon's Annapurna Labs
 Fabric Interrupt Controller Driver
To:     Marc Zyngier <marc.zyngier@arm.com>, <nicolas.ferre@microchip.com>,
        <jason@lakedaemon.net>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <robh+dt@kernel.org>,
        <davem@davemloft.net>, <shawn.lin@rock-chips.com>,
        <tglx@linutronix.de>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <jonnyc@amazon.com>, <hhhawa@amazon.com>, <ronenk@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>, <talel@amazon.com>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
 <1559731921-14023-3-git-send-email-talel@amazon.com>
 <fa6e5a95-d9dd-19f6-43e3-3046e0898bda@arm.com>
 <553d06a4-a6b6-816f-b110-6ef7f300dde4@amazon.com>
 <0915892c-0e53-8f53-e858-b1c3298a4d35@arm.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <88907fea-aee1-62c8-604a-726b603ec48a@amazon.com>
Date:   Thu, 6 Jun 2019 10:25:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0915892c-0e53-8f53-e858-b1c3298a4d35@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.162.225]
X-ClientProxiedBy: EX13D21UWA002.ant.amazon.com (10.43.160.246) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/5/2019 6:12 PM, Marc Zyngier wrote:
> On 05/06/2019 15:38, Shenhar, Talel wrote:
>>
>> FIC only support two sensing modes, rising-edge and level.
> Yes, I can tell. Yet, this code will let EDGE_BOTH pass through, even if
> it cannot handle it.
Will handle on v4
> Indeed we use interrupt specifier that has the level type in it
>> (dt-binding: "#interrupt-cells: must be 2.") which in turns causes to
>> this irq_set_type callback.
> Well, this isn't what the example in your DT binding shows.
Will update the example in v4


Thanks,

Talel.

