Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCF3CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2261221852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LxXhWjj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407144AbfJRArf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:47:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45682 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfJRAre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:47:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I0iDGT068362;
        Fri, 18 Oct 2019 00:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=xOteuv/hucrhRyVuvpzt4Om0EvOQwTqguA72Fbv6uHE=;
 b=LxXhWjj4U4EHNr7wkcLHjUiyUGyurRvALfeYKnbhVJ5hiYxnTFbni0yCIPtWTiQWin/g
 RM0DdPCpN16jg3DvNMA+oZbshCf0XBqA9hmdhHHz5aMbHcYRbmafqhOhMCITgJVqALY3
 jx/K/9Afuw7b+M54rZZ8bq1dPWXEyJmVTTfga222wZLx+S0MydUaYPRQ7z+Giv0Pc9rd
 PCSfOJmtyfRgGWTkfX3PUi5tllMg1CBNyBpjCcWZgThdUov2R2LgX/12Cd9tf94CyUvz
 7TxltS3w79s6KL1y357qex3gH+0cqg1HbKo44T7U2ZLqGVjNJiGL2EDISTpYG2TZBICw Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vq0q48g0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 00:47:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I0h9Ko018419;
        Fri, 18 Oct 2019 00:47:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vq0dw8rwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 00:47:15 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9I0lAB7013883;
        Fri, 18 Oct 2019 00:47:10 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 00:47:10 +0000
Subject: Re: [PATCH] hugetlbfs: fix error handling in init_hugetlbfs_fs()
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Chengguang Xu <cgxu519@mykernel.net>,
        David Howells <dhowells@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20191017103822.8610-1-cgxu519@mykernel.net>
 <ccfddf19-630f-ad38-68b3-16003e740113@oracle.com>
Message-ID: <49ec37c4-bb74-d0d2-1dee-00778e08b8cb@oracle.com>
Date:   Thu, 17 Oct 2019 17:47:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <ccfddf19-630f-ad38-68b3-16003e740113@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for noise, left off David

On 10/17/19 5:08 PM, Mike Kravetz wrote:
> Cc: David
> On 10/17/19 3:38 AM, Chengguang Xu wrote:
>> In order to avoid using incorrect mnt, we should set
>> mnt to NULL when we get error from mount_one_hugetlbfs().
>>
>> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>> ---
>>  fs/hugetlbfs/inode.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index a478df035651..427d845e7706 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -1470,9 +1470,12 @@ static int __init init_hugetlbfs_fs(void)
>>  	i = 0;
>>  	for_each_hstate(h) {
>>  		mnt = mount_one_hugetlbfs(h);
>> -		if (IS_ERR(mnt) && i == 0) {
>> -			error = PTR_ERR(mnt);
>> -			goto out;
>> +		if (IS_ERR(mnt)) {
>> +			if (i == 0) {
>> +				error = PTR_ERR(mnt);
>> +				goto out;
>> +			}
>> +			mnt = NULL;
>>  		}
>>  		hugetlbfs_vfsmount[i] = mnt;
>>  		i++;
> 
> Thanks!
> 
> That should be fixed.  It was introduced with commit 32021982a324 ("hugetlbfs:
> Convert to fs_context").  
> 
> That commit also changed the condition for which init_hugetlbfs_fs() would
> 'error' and remove the inode cache.  Previously, it would do that if there
> was an error creating a mount for the default_hstate_idx hstate.  It now does
> that for the '0' hstate, and 0 is not always equal to default_hstate_idx.
> 
> David was that intentional or an oversight?  I can fix up, just wanted to
> make sure there was not some reason for the change.
> 


-- 
Mike Kravetz
