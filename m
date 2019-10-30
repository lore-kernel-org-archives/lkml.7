Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A05CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BD120656
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 13:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E5Mmu3AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfJ3NCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:02:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfJ3NCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:02:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UCwxfq094994;
        Wed, 30 Oct 2019 13:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=2c8khfOqHioML8RrU2Q31a0tXKbcM3O9sIsWiv7yYNA=;
 b=E5Mmu3AUXMs2oE3rabZUbbliZM0GiFYeUe1aUrkLW/BIajwmnFglW414YBou/FkWWcWm
 lCbna/cemV7pMRcMbSguFafzUWHLUpi2Mymc/N64OsOp3KY+mXBO1hclB8v0iQgcEcl3
 4vkP9s4yoiuPHB2XtZjRh1OXQ7a5sQOLREDAIORLHjDKFux19M9vWWyQQhftkrhdXMEN
 PPlhG/SSMST02U7K9ckm4kffi9+K1hv8Ln5IPQcaiU7jw1Rn594QjsIKAIjlt4MHHNuJ
 nn5kG66EDAKELZjIk9JZvI+YV3g8Iq5NHzen09IzAmsM4eNs4H1EmgIBZQ+YR3UBpOYz Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vxwhfm0s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 13:01:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UCs3cX151893;
        Wed, 30 Oct 2019 13:01:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vxwj98e1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 13:01:53 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9UD1qtJ002674;
        Wed, 30 Oct 2019 13:01:52 GMT
Received: from [192.168.1.140] (/47.220.71.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 06:01:52 -0700
Subject: Re: [PATCH v3 ] iommu/vt-d: Fix panic after kexec -p for kdump
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
References: <f856dfd6-0483-fb97-033c-1cda83ead79f@Oracle.com>
 <20191030093313.GA7254@8bytes.org>
From:   John Donnelly <John.P.Donnelly@Oracle.com>
Message-ID: <98a3f2c3-e3a6-ffe2-6972-f6f901635e50@Oracle.com>
Date:   Wed, 30 Oct 2019 08:01:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030093313.GA7254@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=980
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/19 4:33 AM, Joerg Roedel wrote:
> Hi John,
> 
> On Mon, Oct 21, 2019 at 09:48:10PM -0500, John Donnelly wrote:
>> Fixes: 8af46c784ecfe ("iommu/vt-d: Implement is_attach_deferred iommu ops
>> entry")
>> Cc: stable@vger.kernel.org # v5.3+
>>
>> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>>
>>
>> ---
>>   drivers/iommu/intel-iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index c4e0e4a9ee9e..f83a9a302f8e 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2783,7 +2783,7 @@ static int identity_mapping(struct device *dev)
>>   	struct device_domain_info *info;
>>
>>   	info = dev->archdata.iommu;
>> -	if (info && info != DUMMY_DEVICE_DOMAIN_INFO)
>> +	if (info && info != DUMMY_DEVICE_DOMAIN_INFO && info !=
>> DEFER_DEVICE_DOMAIN_INFO)
>>   		return (info->domain == si_domain);
>>
>>   	return 0;
> 
> I applied your patch for v5.4, but it needed manual fixup because your
> mailer screwed up the patch format by inserting line-breaks and
> converting tabs to spaces.
> 
> Please consider to setup and use 'git send-email' for your next patches.
> This will get it all right and makes life easier for maintainers that
> want to apply your patches.
> 
> Thanks,
> 
> 	Joerg
> 
Thank you .

I tried using the git mailer from my development server but 
vger.kernel.org mailer rejected it because the generated email did not 
match the subscription email and was rejected.





-- 
Thank You,
John
