Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1388AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE59217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfCONo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:44:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727248AbfCONo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:44:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2FDduaC055132
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:44:27 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r8ch0tjuh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:44:27 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 15 Mar 2019 13:44:25 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Mar 2019 13:44:21 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2FDiKli58523816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Mar 2019 13:44:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12FEBAE056;
        Fri, 15 Mar 2019 13:44:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E8F7AE045;
        Fri, 15 Mar 2019 13:44:19 +0000 (GMT)
Received: from [9.145.170.151] (unknown [9.145.170.151])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Mar 2019 13:44:19 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
 <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
 <20190315112032.13b259c2.cohuck@redhat.com>
 <a0aef0e8-03e3-2cb7-3127-61521eed0629@linux.ibm.com>
 <20190315144141.100f2be7.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 15 Mar 2019 14:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315144141.100f2be7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031513-0016-0000-0000-000002634D15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031513-0017-0000-0000-000032BE505F
Message-Id: <b95c3113-09f5-ba48-3d5b-5ef460335329@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903150098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2019 14:41, Cornelia Huck wrote:
> On Fri, 15 Mar 2019 14:26:34 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> Conclusion:  we must handle this in userland, it will have the benefit
>> to keep old behavior when there is no callback.
>> OLD QEMU will not see change as they will not set aqic facility
>> NEW QEMU will handle this correctly.
>>
>> In this case we also do not need to handle all other tests here but can
>> move it to the callback as Tony wanted.
>>
>> Would you agree with something simple like:
>>
>> static int handle_pqap(struct kvm_vcpu *vcpu)
>> {
>>           int ret = -EOPNOTSUPP;
>>
>>           /* Verify that the hook callback is registered and call it */
>>           if (pqap_hook)
>>                   if (try_module_get(pqap_hook->owner)) {
>>                           ret = pqap_hook->hook(vcpu);
>>                           module_put(pqap_hook->owner);
>>                   }
>>           return ret;
>> }
>>
>> All other tests in QEMU and in the callback.
> 
> With the hook checking for priv, fc, etc.? Yeah, might work.
> 
> But don't count on my feedback too much right now, better wait for
> others' comments :) I'll resume in April, if needed.
> 

OK, thanks

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

