Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FFDC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A0721773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfDQCWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:22:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46428 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbfDQCWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:22:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9973C9C69598820E8015;
        Wed, 17 Apr 2019 10:22:33 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Wed, 17 Apr 2019
 10:22:27 +0800
Subject: Re: some trouble when using vrf
To:     David Ahern <dsa@cumulusnetworks.com>, <shrijeet@gmail.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
References: <15adf635-a74b-e9e3-5dad-b35890f0a746@huawei.com>
 <e4aa6621-8d9b-8d69-0562-610bae347ad3@cumulusnetworks.com>
From:   linmiaohe <linmiaohe@huawei.com>
Message-ID: <f106ad99-c0a3-346c-f01f-d6e48ab4b628@huawei.com>
Date:   Wed, 17 Apr 2019 10:22:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e4aa6621-8d9b-8d69-0562-610bae347ad3@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/16 23:20, David Ahern wrote:
> On 4/16/19 5:26 AM, linmiaohe wrote:
>>     ...
>>     bind(sock_fd, (struct sockaddr *)&addr_serv, sizeof(addr_serv));
>>     ...
>>     ret = setsockopt(sock_fd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, strlen(bind_dev)+1);
>>     ...
>>     This code snipet doesn't work if the ip address of addr_serv is not in default vrf. And
>> "Cannot assign requested address" will occurs.
> 
> Applications must bind to the device first and then bind to the local
> address. As I recall this applies regardless of whether it is a VRF or
> other.
> 
> 
It should be, but unfortunately some applications break this.

>>
>>     2.When I run a udp server in default vrf and set net.ipv4.udp_l3mdev_accept=1,
>> it's supposed to work accorss VRFs.
> 
> UDP applications can use cmsg with IP_PKTINFO to send the reply out the
> same device as the request was received. An app can also track the
> relationship of the enslaved device to a VRF to use a VRF based lookup
> to send a response. Choices.
> 
> 

UDP applications using cmsg with IP_PKTINFO is really a good idea.

>>
>> Thanks a lot if you can help me fix these. Have a nice day.
>>
> .
> 

Thanks a lot for your advice.

