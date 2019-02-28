Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA8AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C6D214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfB1Gs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:48:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725967AbfB1GsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:48:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AB4A2C4A50A5E2E0BA61;
        Thu, 28 Feb 2019 14:48:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Thu, 28 Feb 2019
 14:48:18 +0800
Subject: Re: [PATCH v2] xfrm: policy: Fix possible user after free in
 __xfrm_policy_unlink
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <20190228063801.27200-1-yuehaibing@huawei.com>
 <20190228064106.v4fe5b2ij3gbodxk@gondor.apana.org.au>
CC:     <steffen.klassert@secunet.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <49905b89-3164-76df-dce7-becca1796a95@huawei.com>
Date:   Thu, 28 Feb 2019 14:48:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190228064106.v4fe5b2ij3gbodxk@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/2/28 14:41, Herbert Xu wrote:
> On Thu, Feb 28, 2019 at 02:38:01PM +0800, Yue Haibing wrote:
>>
>> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
>> index a131f9f..aaa45c9 100644
>> --- a/net/xfrm/xfrm_user.c
>> +++ b/net/xfrm/xfrm_user.c
>> @@ -1424,7 +1424,8 @@ static int verify_newpolicy_info(struct xfrm_userpolicy_info *p)
>>  	ret = verify_policy_dir(p->dir);
>>  	if (ret)
>>  		return ret;
>> -	if (p->index && ((p->index & XFRM_POLICY_MAX) != p->dir))
>> +	if (p->index && (((p->index & XFRM_POLICY_MAX) != p->dir) ||
>> +			 (xfrm_policy_id2dir(p->index) >= XFRM_POLICY_MAX)))
> 
> Please just check 
> 
> 	xfrm_policy_id2dir(p->index) != p->dir


Oh, it indeed can be merged, Thanks!

> 
> Thanks,
> 

