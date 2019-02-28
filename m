Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3948C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF54A2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbfB1NKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:10:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727717AbfB1NKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:10:42 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SD1Tuo127060
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:10:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qxfhktdh3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:10:40 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Feb 2019 13:10:38 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 13:10:34 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1SDAXgk17891404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 13:10:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F185A4057;
        Thu, 28 Feb 2019 13:10:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2356A4055;
        Thu, 28 Feb 2019 13:10:32 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Feb 2019 13:10:32 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
 <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
 <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
 <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
 <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
 <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
 <6058a017-6404-af3c-62ef-2452214ac97c@de.ibm.com>
 <2391adc2-6611-034c-61c5-feb46e2a751b@de.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 28 Feb 2019 14:10:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2391adc2-6611-034c-61c5-feb46e2a751b@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022813-0016-0000-0000-0000025C07A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022813-0017-0000-0000-000032B67534
Message-Id: <dc483b20-8ade-2d5f-6a76-a2c5d2e72c57@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=866 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 12:03, Christian Borntraeger wrote:
> 
> 
> On 28.02.2019 10:42, Christian Borntraeger wrote:
> [...]
>>> Okay, let's go back to the genesis of this discussion; namely, my
>>> suggestion about moving the fc == 0x03 check into the hook code. If
>>> the vfio_ap module is not loaded, there will be no hook code. In that
>>> case, the check for the hook will fail and ultimately response code
>>> 0x01 will be set in the status word (which may not be the right thing
>>> to do?). You have not stated a single good reason for keeping this
>>> check, but I'm done with this silly argument. It certainly doesn't
>>> hurt anything.
>>
>> The instruction handler must handle the basic checks for the
>> instruction itself as outlined above.
>>
>> Do we want to allow QEMU to fully emulate everything (the  ECA_APIE case being off)?
>> The we should pass along everything to QEMU, but this is already done with the
>> ECA_APIE check, correct?
>>
>> Do we agree that when we are beyond the ECA_APIE check, that we do not emulate
>> in QEMU and we have enabled the AP instructions interpretion?
>> If yes then this has some implication:
>>
>> 1. ECA is on and we should only get PQAP interception for specific FC (namely 3).
>> 2. What we certainly should check is the facility bit of the guest (65) and reject fc==3
>> right away with a specification exception. I do not want the hook to mess with
>> the kvm cpu model. @Pierre would be good to actually check test_kvm_facility(vcpu->kvm, 65))
>> 3. What shall we do when fc == 0x3? We can certainly do the check here OR in the
>> hook. As long as we have only fc==3 this does not matter.
>>
>> Correct?
> 
> Thinking more about that, I think we should inject a specification exception for all
> unknown FCc != 0x3. That would also qualify for keeping it in the instruction handler.
> 

May be return a privileged operation exception if issued from guest's 
program state, but generally I agree with the idea of handling all PQAP 
functions here.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

