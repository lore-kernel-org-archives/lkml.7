Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAA0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDC82077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rUHeRu8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfDOMvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:51:31 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34032 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDOMva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:51:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3FCpOIA040924;
        Mon, 15 Apr 2019 07:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555332685;
        bh=tRgr5wDUWCiJJJDJx+tHgakdyNUXop3FMfqYdDNWE4k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rUHeRu8VLcr88g9hL0UQhVlKvfERL2SdxjG8nn6YGprJTWMWWnxl1slZvt06jPNK1
         xystc89ID9glveic7g+iak6KSQWV2LaBjuCLPIlKKlReGw4CjzdPnVjFbjQsdZJl9i
         5hHT2s1oZ9QfOTJZaqenih4Edq5f8zUAP6QlaG04=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3FCpOq4085632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Apr 2019 07:51:24 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 15
 Apr 2019 07:51:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 15 Apr 2019 07:51:24 -0500
Received: from [158.218.117.39] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3FCpN8N062213;
        Mon, 15 Apr 2019 07:51:23 -0500
Subject: Re: [net-next PATCH 3/3] net: hsr: add tx stats for master interface
To:     David Miller <davem@davemloft.net>
CC:     <arvid.brodin@alten.se>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190412201325.29001-1-m-karicheri2@ti.com>
 <20190412201325.29001-4-m-karicheri2@ti.com>
 <20190412.171448.1969143158873595750.davem@davemloft.net>
From:   Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <f238a9d4-6e1a-db04-0ad2-5d9a20ab2e25@ti.com>
Date:   Mon, 15 Apr 2019 08:53:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190412.171448.1969143158873595750.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 04/12/2019 08:14 PM, David Miller wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> Date: Fri, 12 Apr 2019 16:13:25 -0400
> 
>> Add tx stats to hsr interface. Without this
>> ifconfig for hsr interface doesn't show tx packet stats.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> ---
>>   net/hsr/hsr_device.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
>> index 15c72065df79..f22902eac083 100644
>> --- a/net/hsr/hsr_device.c
>> +++ b/net/hsr/hsr_device.c
>> @@ -229,6 +229,8 @@ static int hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>>   	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
>>   	skb->dev = master->dev;
>>   	hsr_forward_skb(skb, master);
>> +	master->dev->stats.tx_packets++;
>> +	master->dev->stats.tx_bytes += skb->len;
>>   
> 
> This introduced a use after free of 'skb' as hsr_forward_skb() can free it.
You are right. I think I should move this to inside hsr_forward_skb().
> 
> Also, why are there so many changes in your "internal" tree and why are
> they not all upstream already?
> That is a good question. That was a management decision. Priority was 
prototyping of hsr and prp solution internally first using TI' ICSS PRU 
Ethernet for industrial applications and then once we have it working, 
push the changes upstream. We are starting this process already 
beginning with upstream of ICSS PRU driver. I have plan to send an RFC 
patch for PRP support soon.

Murali
