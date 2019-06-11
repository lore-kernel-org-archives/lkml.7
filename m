Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D11C31E46
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B37720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W5fommkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406952AbfFKVLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:11:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43584 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406681AbfFKVLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:11:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BL8nZQ041453;
        Tue, 11 Jun 2019 21:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=r4oU8QezePFqpSYiESryQs3UL8DYpfD9CLF3sY86YKg=;
 b=W5fommkpxEPMSUSkVfY8pwZefZojBn0xB2CG8mlaX+Xw8Hgm05RcUbft179SKF6cYNWm
 0pxi29x0S8RghwTRE5muCQO1CYvZ+Nw8mYq1yR7wj2gj2ta+Vo7EoHat4vmSwwwi6tiS
 XO95cemCe4QcK4yj0sga3quvQOIEghDLIkT7vKYBl9PL9C6Fdpwm+piz1xSXkEZ7yvYu
 1VHxxYrO5xwWLpsCNzy6MihKOgV0fMtsvHSCfgZs0x19Y+CPtpKS1kuaOeT0STLJhnnl
 jN4nnfQwcVFwy6Hxcrsm8bw9t7gAhpgYG3gxGAPf1jlDSlhaYauB36vDAQyly87SK4YZ Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t05nqqmr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 21:10:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BLApJI032408;
        Tue, 11 Jun 2019 21:10:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t1jphntch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 21:10:53 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BLAoEe011760;
        Tue, 11 Jun 2019 21:10:50 GMT
Received: from [10.209.243.59] (/10.209.243.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 14:10:50 -0700
Subject: Re: [PATCH] knav_qmss_queue: fix a missing-check bug in
 knav_pool_create()
To:     Gen Zhang <blackgod016574@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     ssantosh@kernel.org, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190530033949.GA8895@zhanggen-UX430UQ>
 <20190611093744.GA9783@ubuntu> <56a08bd2-6b94-457f-99f7-91ef3fca8804@arm.com>
 <20190611100819.GA10185@ubuntu>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <b1e3623f-b908-363c-041c-0b9fb96412d8@oracle.com>
Date:   Tue, 11 Jun 2019 14:10:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190611100819.GA10185@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/19 3:08 AM, Gen Zhang wrote:
> On Tue, Jun 11, 2019 at 10:54:15AM +0100, Marc Zyngier wrote:
>> Hi Gen,
>>
>> No idea why I'm being cc'd on this but hey... ;-)
> I copied email address ftom thid commit:-)
> https://github.com/torvalds/linux/commit/832ad0e3da4510fd17f98804abe512ea9a747035#diff-f2a24befc247191f4b81af93e9336785
>>
>> On 11/06/2019 10:37, Gen Zhang wrote:
>>> On Thu, May 30, 2019 at 11:39:49AM +0800, Gen Zhang wrote:
>>>> In knav_pool_create(), 'pool->name' is allocated by kstrndup(). It
>>>> returns NULL when fails. So 'pool->name' should be checked. And free
>>>> 'pool' when error.
>>>>
>>>> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
>>>> ---
>>>> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
>>>> index 8b41837..0f8cb28 100644
>>>> --- a/drivers/soc/ti/knav_qmss_queue.c
>>>> +++ b/drivers/soc/ti/knav_qmss_queue.c
>>>> @@ -814,6 +814,12 @@ void *knav_pool_create(const char *name,
>>>>   	}
>>>>   
>>>>   	pool->name = kstrndup(name, KNAV_NAME_SIZE - 1, GFP_KERNEL);
>>>> +	if (!pool->name) {
>>>> +		dev_err(kdev->dev, "failed to duplicate for pool(%s)\n",
>>>> +			name);
>>
>> There is no need to output anything, the kernel will be loud enough if
>> you run out of memory.
> Thanks for your comments.
>>
>>>> +		ret = -ENOMEM;
>>>> +		goto err_name;
>>>> +	}
>>>>   	pool->kdev = kdev;
>>>>   	pool->dev = kdev->dev;
>>>>   
>>>> @@ -864,6 +870,7 @@ void *knav_pool_create(const char *name,
>>>>   	mutex_unlock(&knav_dev_lock);
>>>>   err:
>>>>   	kfree(pool->name);
>>>> +err_name:
>>
>> kfree(NULL) is perfectly valid, there is no need to create a second
>> label. Just branch to the existing error label.
> Sure, better not to add redundant codes.
>>
>>>>   	devm_kfree(kdev->dev, pool);
>>>>   	return ERR_PTR(ret);
>>>>   }
>>> Can anyone look into this patch?
>>>
>>> Thanks
>>> Gen
>>>
>>
>> The real question is whether this is actually an error at all.
>> pool->name doesn't seem to be used for anything but debug information,
>> and the printing code can perfectly accommodate a NULL pointer.
> That sounds reasonable. This patch just fixes a *theoretical* bug.
> 
Not even theoretical bug.
