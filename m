Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC83FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B642077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfDZLCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:02:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725983AbfDZLB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:01:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QAnD4k059947
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:01:57 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s404jj2k5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:01:56 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 26 Apr 2019 12:01:54 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 12:01:53 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3QB1pwK48431332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 11:01:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71E37A4053;
        Fri, 26 Apr 2019 11:01:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2A90A4040;
        Fri, 26 Apr 2019 11:01:50 +0000 (GMT)
Received: from [9.145.15.72] (unknown [9.145.15.72])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Apr 2019 11:01:50 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH] KVM: s390: vsie: Do not shadow CRYCB when no AP and no
 keys
To:     Christian Borntraeger <borntraeger@de.ibm.com>, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <1556269010-22258-1-git-send-email-pmorel@linux.ibm.com>
 <9f97f69f-1f23-55b1-b14f-e050cbc48b7f@de.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 26 Apr 2019 13:01:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9f97f69f-1f23-55b1-b14f-e050cbc48b7f@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042611-0016-0000-0000-00000275761D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042611-0017-0000-0000-000032D1F30F
Message-Id: <7486060f-5d32-7926-bf5c-0869f4beb300@linux.ibm.com>
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

On 26/04/2019 11:08, Christian Borntraeger wrote:
> 
> 
> On 26.04.19 10:56, Pierre Morel wrote:
>> When the guest do not have AP instructions nor Key management
>> we should return without shadowing the CRYCB.
>>
>> We did not check correctly in the past.
>>
>> Fixes: b10bd9a256ae ("s390: vsie: Use effective CRYCBD.31 to check CRYCBD
>> validity")
>> Fixes: 6ee74098201b ("KVM: s390: vsie: allow CRYCB FORMAT-0")
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Thanks,
It gives a better feeling on this patch.

Pierre

> 
>> ---
>>   arch/s390/kvm/vsie.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index c6983d9..ac411e9 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -290,6 +290,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	u8 ecb3_flags;
>>   	u32 ecd_flags;
>>   	int apie_h;
>> +	int apie_s;
>>   	int key_msk = test_kvm_facility(vcpu->kvm, 76);
>>   	int fmt_o = crycbd_o & CRYCB_FORMAT_MASK;
>>   	int fmt_h = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
>> @@ -298,7 +299,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	scb_s->crycbd = 0;
>>   
>>   	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
>> -	if (!apie_h && (!key_msk || fmt_o == CRYCB_FORMAT0))
>> +	apie_s = apie_h & scb_o->eca;
>> +	if (!apie_s && (!key_msk || (fmt_o == CRYCB_FORMAT0)))
>>   		return 0;
>>   
>>   	if (!crycb_addr)
>> @@ -309,7 +311,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   		    ((crycb_addr + 128) & PAGE_MASK))
>>   			return set_validity_icpt(scb_s, 0x003CU);
>>   
>> -	if (apie_h && (scb_o->eca & ECA_APIE)) {
>> +	if (apie_s) {
>>   		ret = setup_apcb(vcpu, &vsie_page->crycb, crycb_addr,
>>   				 vcpu->kvm->arch.crypto.crycb,
>>   				 fmt_o, fmt_h);
>>


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

