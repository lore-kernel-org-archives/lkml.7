Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E021EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94CE2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfDZKyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:54:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbfDZKyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:54:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QAnK3C063637
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 06:54:13 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s3y20mqk7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 06:54:13 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 26 Apr 2019 11:54:11 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 11:54:08 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3QAs7Bd62259300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 10:54:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4344DA4055;
        Fri, 26 Apr 2019 10:54:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF611A404D;
        Fri, 26 Apr 2019 10:54:06 +0000 (GMT)
Received: from [9.145.15.72] (unknown [9.145.15.72])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Apr 2019 10:54:06 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH] KVM: s390: vsie: Return correct values for Invalid CRYCB
 format
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <1556269201-22918-1-git-send-email-pmorel@linux.ibm.com>
 <0fa39d6a-f74e-e0b7-ded9-948d1576a2b9@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 26 Apr 2019 12:54:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0fa39d6a-f74e-e0b7-ded9-948d1576a2b9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042610-0008-0000-0000-000002E07270
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042610-0009-0000-0000-0000224CCF9C
Message-Id: <024bb479-a731-5372-2832-108e0670950d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2019 11:07, David Hildenbrand wrote:
> On 26.04.19 11:00, Pierre Morel wrote:
>> Let's use the correct validity number.
>>
>> Fixes: 55ded154b43 "KVM: s390: vsie: Allow CRYCB FORMAT-2"
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/kvm/vsie.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index ac411e9..076090f 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -344,7 +344,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   end:
>>   	switch (ret) {
>>   	case -EINVAL:
>> -		return set_validity_icpt(scb_s, 0x0020U);
>> +		return set_validity_icpt(scb_s, 0x0022U);
>>   	case -EFAULT:
>>   		return set_validity_icpt(scb_s, 0x0035U);
>>   	case -EACCES:
>>
> 
> Can't verify
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks.

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

