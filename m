Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0859AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2B92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfD3IAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:00:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbfD3IAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:00:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3U7rGWI090470
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 03:59:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s6hxvs64q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 03:59:59 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 30 Apr 2019 08:59:57 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Apr 2019 08:59:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3U7xqGl43516056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 07:59:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B3275205A;
        Tue, 30 Apr 2019 07:59:52 +0000 (GMT)
Received: from [9.152.222.31] (unknown [9.152.222.31])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4E4415204E;
        Tue, 30 Apr 2019 07:59:51 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v7 2/4] vfio: ap: register IOMMU VFIO notifier
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1556283688-556-1-git-send-email-pmorel@linux.ibm.com>
 <1556283688-556-3-git-send-email-pmorel@linux.ibm.com>
 <20190429180702.641c9110.pasic@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 30 Apr 2019 09:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429180702.641c9110.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19043007-0016-0000-0000-00000276C390
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19043007-0017-0000-0000-000032D34CF0
Message-Id: <b1577203-78c7-24f3-9357-42159feb08ae@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=904 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904300054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2019 18:07, Halil Pasic wrote:
> On Fri, 26 Apr 2019 15:01:26 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> @@ -858,7 +887,17 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>   		return ret;
>>   	}
>>   
>> -	return 0;
>> +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>> +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>> +				     &events, &matrix_mdev->iommu_notifier);
>> +	if (!ret)
>> +		return ret;
>> +
>> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +				 &matrix_mdev->group_notifier);
>> +	module_put(THIS_MODULE);
> 
> Can you please explain this module_put() here? I don't see anything in
> the cover letter.

May be you should have a look at the sources or the original patch 
series of Tony, there is a try_module_get() at the beginning of open to 
make sure that the module is not taken away while in use by the guest.

In the case we failed to open the mediated device we let fall the reference.

Regards,
Pierre


> 
> Regards,
> Halil
> 
>> +	return ret;
>>   }
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

