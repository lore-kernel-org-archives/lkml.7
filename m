Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EEEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9343520674
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfDPNLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:11:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbfDPNLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:11:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GCxKB1092673
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:11:30 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rwe6cma8j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:11:30 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 16 Apr 2019 14:11:29 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 14:11:26 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3GDBLlj29229146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 13:11:22 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD785BE056;
        Tue, 16 Apr 2019 13:11:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46D68BE053;
        Tue, 16 Apr 2019 13:11:20 +0000 (GMT)
Received: from [9.80.202.44] (unknown [9.80.202.44])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Apr 2019 13:11:20 +0000 (GMT)
Subject: Re: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource in
 use
To:     pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
 <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
 <c575e772-59e2-9fed-5ade-24701d4f2b49@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 16 Apr 2019 09:11:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c575e772-59e2-9fed-5ade-24701d4f2b49@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041613-8235-0000-0000-00000E80DA9C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010937; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189901; UDB=6.00623486; IPR=6.00970696;
 MB=3.00026467; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-16 13:11:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041613-8236-0000-0000-0000452B0D77
Message-Id: <8ee6f624-b698-bf83-2ae0-e292ad2512fc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 3:52 AM, Pierre Morel wrote:
> On 11/04/2019 23:03, Tony Krowiak wrote:
>> Introduces a new driver callback to prevent a root user from unbinding
>> an AP queue from its device driver if the queue is in use. This prevents
>> a root user from inadvertently taking a queue away from a guest and
>> giving it to the host, or vice versa. The callback will be invoked
>> whenever a change to the AP bus's apmask or aqmask sysfs interfaces may
>> result in one or more AP queues being removed from its driver. If the
>> callback responds in the affirmative for any driver queried, the change
>> to the apmask or aqmask will be rejected with a device in use error.
>>
>> For this patch, only non-default drivers will be queried. Currently,
>> there is only one non-default driver, the vfio_ap device driver. The
>> vfio_ap device driver manages AP queues passed through to one or more
>> guests and we don't want to unexpectedly take AP resources away from
>> guests which are most likely independently administered.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/ap_bus.c | 138 
>> +++++++++++++++++++++++++++++++++++++++++--
>>   drivers/s390/crypto/ap_bus.h |   3 +
>>   2 files changed, 135 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> index 1546389d71db..66a5a9d9fae6 100644
>> --- a/drivers/s390/crypto/ap_bus.c
>> +++ b/drivers/s390/crypto/ap_bus.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/ctype.h>
>> +#include <linux/module.h>
>>   #include "ap_bus.h"
>>   #include "ap_debug.h"
>> @@ -980,9 +981,11 @@ int ap_parse_mask_str(const char *str,
>>       newmap = kmalloc(size, GFP_KERNEL);
>>       if (!newmap)
>>           return -ENOMEM;
>> -    if (mutex_lock_interruptible(lock)) {
>> -        kfree(newmap);
>> -        return -ERESTARTSYS;
>> +    if (lock) {
>> +        if (mutex_lock_interruptible(lock)) {
>> +            kfree(newmap);
>> +            return -ERESTARTSYS;
>> +        }
>>       }
>>       if (*str == '+' || *str == '-') {
>> @@ -994,7 +997,10 @@ int ap_parse_mask_str(const char *str,
>>       }
>>       if (rc == 0)
>>           memcpy(bitmap, newmap, size);
>> -    mutex_unlock(lock);
>> +
>> +    if (lock)
>> +        mutex_unlock(lock);
>> +
>>       kfree(newmap);
>>       return rc;
>>   }
>> @@ -1181,12 +1187,72 @@ static ssize_t apmask_show(struct bus_type 
>> *bus, char *buf)
>>       return rc;
>>   }
>> +static int __verify_card_reservations(struct device_driver *drv, void 
>> *data)
>> +{
>> +    int rc = 0;
>> +    struct ap_driver *ap_drv = to_ap_drv(drv);
>> +    unsigned long *newapm = (unsigned long *)data;
>> +
>> +    /*
>> +     * If the reserved bits do not identify cards reserved for use by 
>> the
>> +     * non-default driver, there is no need to verify the driver is 
>> using
>> +     * the queues.
>> +     */
>> +    if (ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
>> +        return 0;
> 
> I prefer you suppress this asymmetry with the assumption that the 
> "default driver" will not register a "in_use" callback.

Based on comments by Connie, I plan on removing this patch from the
next version.

> 
> 
>> +
>> +    /* Pin the driver's module code */
>> +    if (!try_module_get(drv->owner))
>> +        return 0;
>> +
>> +    if (ap_drv->in_use)
>> +        if (ap_drv->in_use(newapm, ap_perms.aqm))
>> +            rc = -EADDRINUSE;
>> +
>> +    module_put(drv->owner);
>> +
>> +    return rc;
>> +}
>> +
> 

