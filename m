Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A129C31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1F820673
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pmi20vm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfFSC6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:58:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43154 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFSC6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:58:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2nJj5064244;
        Wed, 19 Jun 2019 02:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=jowh4Q4xUHQyWNPimAhffMpXX6KZ+2w3g3sh8AxxwsY=;
 b=Pmi20vm4sK9eiMf5uhJceBaQ4Y1ZODgWavxSLVk4GF4GC0ls8cALPJ9JZMccAIQzJmQY
 sa6qSQELNDc86Ohi8ifXjwETuCdRl81AtVDE+doTgL53HDCeAVrvgLazXjqpAL0OX6h3
 dDX6xU+tLNOCY7yMZX9oUZcUG7/bfDoVZxWKu5EG+tjHNrTRXgzjp1TJePfIDJcBmokJ
 ikHePLDKgP5sj+tBMMeztwvvoOu578sH0RNALB6boHSPtTlRC5Wf3sRZ7ehvBdWNfD3c
 TAOwTwWjUSmxXBZHVdYku53tF2EORDBQnezjpABr0IZ0dFAKNM+rc8R7AF2J4rTVDjn7 kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t78098qmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:57:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2raEA106635;
        Wed, 19 Jun 2019 02:55:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t77ymtvjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:55:14 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J2tD25016091;
        Wed, 19 Jun 2019 02:55:13 GMT
Received: from [10.156.74.184] (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 19:55:13 -0700
Subject: Re: [RFC PATCH 13/16] drivers/xen: gnttab, evtchn, xenbus API changes
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-14-ankur.a.arora@oracle.com>
 <2c025112-aaeb-0918-ff01-10842d285314@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <dc57c816-bceb-d4bb-af83-579bae58529f@oracle.com>
Date:   Tue, 18 Jun 2019 19:55:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2c025112-aaeb-0918-ff01-10842d285314@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 3:07 AM, Juergen Gross wrote:
> On 09.05.19 19:25, Ankur Arora wrote:
>> Mechanical changes, now most of these calls take xenhost_t *
>> as parameter.
>>
>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   drivers/xen/cpu_hotplug.c     | 14 ++++++-------
>>   drivers/xen/gntalloc.c        | 13 ++++++++----
>>   drivers/xen/gntdev.c          | 16 +++++++++++----
>>   drivers/xen/manage.c          | 37 ++++++++++++++++++-----------------
>>   drivers/xen/platform-pci.c    | 12 +++++++-----
>>   drivers/xen/sys-hypervisor.c  | 12 ++++++++----
>>   drivers/xen/xen-balloon.c     | 10 +++++++---
>>   drivers/xen/xenfs/xenstored.c |  7 ++++---
>>   8 files changed, 73 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
>> index afeb94446d34..4a05bc028956 100644
>> --- a/drivers/xen/cpu_hotplug.c
>> +++ b/drivers/xen/cpu_hotplug.c
>> @@ -31,13 +31,13 @@ static void disable_hotplug_cpu(int cpu)
>>       unlock_device_hotplug();
>>   }
>> -static int vcpu_online(unsigned int cpu)
>> +static int vcpu_online(xenhost_t *xh, unsigned int cpu)
> 
> Do we really need xenhost for cpu on/offlinig?
I was in two minds about this. We only need it for the xenbus
interfaces which could very well have been just xh_default.

However, the xenhost is part of the xenbus_watch state, so
I thought it is easier to percolate that down instead of
adding xh_default all over the place.

> 
>> diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
>> index 9a69d955dd5c..1655d0a039fd 100644
>> --- a/drivers/xen/manage.c
>> +++ b/drivers/xen/manage.c
>> @@ -227,14 +227,14 @@ static void shutdown_handler(struct xenbus_watch 
>> *watch,
>>           return;
>>    again:
>> -    err = xenbus_transaction_start(xh_default, &xbt);
>> +    err = xenbus_transaction_start(watch->xh, &xbt);
>>       if (err)
>>           return;
>> -    str = (char *)xenbus_read(xh_default, xbt, "control", "shutdown", 
>> NULL);
>> +    str = (char *)xenbus_read(watch->xh, xbt, "control", "shutdown", 
>> NULL);
>>       /* Ignore read errors and empty reads. */
>>       if (XENBUS_IS_ERR_READ(str)) {
>> -        xenbus_transaction_end(xh_default, xbt, 1);
>> +        xenbus_transaction_end(watch->xh, xbt, 1);
>>           return;
>>       }
>> @@ -245,9 +245,9 @@ static void shutdown_handler(struct xenbus_watch 
>> *watch,
>>       /* Only acknowledge commands which we are prepared to handle. */
>>       if (idx < ARRAY_SIZE(shutdown_handlers))
>> -        xenbus_write(xh_default, xbt, "control", "shutdown", "");
>> +        xenbus_write(watch->xh, xbt, "control", "shutdown", "");
>> -    err = xenbus_transaction_end(xh_default, xbt, 0);
>> +    err = xenbus_transaction_end(watch->xh, xbt, 0);
>>       if (err == -EAGAIN) {
>>           kfree(str);
>>           goto again;
>> @@ -272,10 +272,10 @@ static void sysrq_handler(struct xenbus_watch 
>> *watch, const char *path,
>>       int err;
>>    again:
>> -    err = xenbus_transaction_start(xh_default, &xbt);
>> +    err = xenbus_transaction_start(watch->xh, &xbt);
>>       if (err)
>>           return;
>> -    err = xenbus_scanf(xh_default, xbt, "control", "sysrq", "%c", 
>> &sysrq_key);
>> +    err = xenbus_scanf(watch->xh, xbt, "control", "sysrq", "%c", 
>> &sysrq_key);
>>       if (err < 0) {
>>           /*
>>            * The Xenstore watch fires directly after registering it and
>> @@ -287,21 +287,21 @@ static void sysrq_handler(struct xenbus_watch 
>> *watch, const char *path,
>>           if (err != -ENOENT && err != -ERANGE)
>>               pr_err("Error %d reading sysrq code in control/sysrq\n",
>>                      err);
>> -        xenbus_transaction_end(xh_default, xbt, 1);
>> +        xenbus_transaction_end(watch->xh, xbt, 1);
>>           return;
>>       }
>>       if (sysrq_key != '\0') {
>> -        err = xenbus_printf(xh_default, xbt, "control", "sysrq", 
>> "%c", '\0');
>> +        err = xenbus_printf(watch->xh, xbt, "control", "sysrq", "%c", 
>> '\0');
>>           if (err) {
>>               pr_err("%s: Error %d writing sysrq in control/sysrq\n",
>>                      __func__, err);
>> -            xenbus_transaction_end(xh_default, xbt, 1);
>> +            xenbus_transaction_end(watch->xh, xbt, 1);
>>               return;
>>           }
>>       }
>> -    err = xenbus_transaction_end(xh_default, xbt, 0);
>> +    err = xenbus_transaction_end(watch->xh, xbt, 0);
>>       if (err == -EAGAIN)
>>           goto again;
>> @@ -324,14 +324,14 @@ static struct notifier_block xen_reboot_nb = {
>>       .notifier_call = poweroff_nb,
>>   };
>> -static int setup_shutdown_watcher(void)
>> +static int setup_shutdown_watcher(xenhost_t *xh)
> 
> I think shutdown is purely local, too.
Yes, I introduced xenhost for the same reason as above.

I agree that either of these cases (and similar others) have no use
for the concept of xenhost. Do you think it makes sense for these
to pass NULL instead and the underlying interface would just assume
xh_default.

Ankur

> 
> 
> Juergen
