Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BC8C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4807321741
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfCLG6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:58:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727301AbfCLG6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:58:48 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 95CBFB869ED5BC48720E;
        Tue, 12 Mar 2019 14:58:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Mar 2019
 14:58:43 +0800
Subject: Re: [PATCH net] staging: rtl8188eu: use is_zero_ether_addr() instead
 of memcmp()
To:     Joe Perches <joe@perches.com>, <Larry.Finger@lwfinger.net>,
        <gregkh@linuxfoundation.org>, <straube.linux@gmail.com>,
        <jananis37@gmail.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <davem@davemloft.net>
References: <20190309032600.98732-1-maowenan@huawei.com>
 <951c83d2-fa0d-11ed-96a9-cee620c9c096@huawei.com>
 <e192c19b35ba5a07ed6bea571546800cc3235282.camel@perches.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <22e39cdc-6c66-f08a-f2b3-e2637e0b810b@huawei.com>
Date:   Tue, 12 Mar 2019 14:58:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <e192c19b35ba5a07ed6bea571546800cc3235282.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/12 14:35, Joe Perches wrote:
> On Tue, 2019-03-12 at 14:29 +0800, maowenan wrote:
>> ping...
>>
>> On 2019/3/9 11:26, Mao Wenan wrote:
>>> Using is_zero_ether_addr() instead of directly use
>>> memcmp() to determine if the ethernet address is all
>>> zeros.
> []
>>> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> []
>>> @@ -180,9 +180,8 @@ struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
>>>  {
>>>  	struct list_head *phead, *plist;
>>>  	struct wlan_network *pnetwork = NULL;
>>> -	u8 zero_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
>>>  
>>> -	if (!memcmp(zero_addr, addr, ETH_ALEN)) {
>>> +	if (is_zero_ether_addr(addr)) {
> 
> How did you verify that addr is __aligned(2)?

/**
 * is_zero_ether_addr - Determine if give Ethernet address is all zeros.
 * @addr: Pointer to a six-byte array containing the Ethernet address
 *
 * Return true if the address is all zeroes.
 */
I think they are completely equivalent functions, no need to check addr is __aligned(2),
because addr may be defined as unsigned char MacAddress[ETH_ALEN]; the length is 6.
> 
> 
> 
> .
> 

