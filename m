Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60304C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334A620663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCEHjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:39:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39105 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725909AbfCEHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:39:22 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544457600"; 
   d="scan'208";a="55938545"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Mar 2019 15:39:20 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 9BBF84C7F2C6;
        Tue,  5 Mar 2019 15:39:05 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 Mar 2019 15:39:20 +0800
Subject: Re: [PATCH] net: xfrm: Fix potential oops in xfrm_user_rcv_msg and
 array out of bounds
To:     Steffen Klassert <steffen.klassert@secunet.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1551671259-21311-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190305064920.gcpwvkp7yikq33cy@gondor.apana.org.au>
 <d401c74f-43cd-7abe-a02d-7397b09b1784@cn.fujitsu.com>
 <20190305073117.GD14737@gauss3.secunet.de>
From:   "Su Yanjun <suyj.fnst@cn.fujitsu.com>" <suyj.fnst@cn.fujitsu.com>
Message-ID: <be2976e7-f2c1-b936-af3b-6454451776b0@cn.fujitsu.com>
Date:   Tue, 5 Mar 2019 15:39:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190305073117.GD14737@gauss3.secunet.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: 9BBF84C7F2C6.AD0DD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/5 15:31, Steffen Klassert wrote:
> On Tue, Mar 05, 2019 at 03:08:49PM +0800, Su Yanjun <suyj.fnst@cn.fujitsu.com> wrote:
>> On 2019/3/5 14:49, Herbert Xu wrote:
>>
>>> On Sun, Mar 03, 2019 at 10:47:39PM -0500, Su Yanjun wrote:
>>>> When i review xfrm_user.c code, i found some potentical bug in it.
>>>>
>>>> In xfrm_user_rcvmsg if type parameter from user space is set to
>>>> XFRM_MSG_MAX or  XFRM_MSG_NEWSADINFO or XFRM_MSG_NEWSPDINFO. It will cause
>>>> xfrm_user_rcv_msg  referring to null entry in xfrm_dispatch array.
>>>>
>>>> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
>>>> ---
>>>>    net/xfrm/xfrm_user.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
>>>> index a131f9f..d832783 100644
>>>> --- a/net/xfrm/xfrm_user.c
>>>> +++ b/net/xfrm/xfrm_user.c
>>>> @@ -2630,11 +2630,13 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
>>>>    		return -EOPNOTSUPP;
>>>>    	type = nlh->nlmsg_type;
>>>> -	if (type > XFRM_MSG_MAX)
>>>> +	if (type >= XFRM_MSG_MAX)
>>>>    		return -EINVAL;
>>> Your patch is wrong.  Please check the definition of XFRM_MSG_MAX.
>> I see, thanks for your reply.
>>
>>   	type -= XFRM_MSG_BASE;
>>   	link = &xfrm_dispatch[type];
>> +	if (!link)
>> +		return -EOPNOTSUPP;
>>
>> Here **link** may refer to null entry for special types such as
>> XFRM_MSG_MAX or  XFRM_MSG_NEWSADINFO or XFRM_MSG_NEWSPDINFO
>> Am i miss something?
> 'link' is always a valid pointer into that array.

Thanks

Su



