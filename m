Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FA9C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72374206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfJIOeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:34:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730490AbfJIOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:34:13 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x99DwbGn165116
        for <linux-kernel@vger.kernel.org>; Wed, 9 Oct 2019 09:59:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vhf6s3y51-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:59:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Wed, 9 Oct 2019 14:56:38 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Oct 2019 14:56:33 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x99DuV6B14155898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 13:56:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6DE05205A;
        Wed,  9 Oct 2019 13:56:31 +0000 (GMT)
Received: from [9.152.212.144] (unknown [9.152.212.144])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 595365204F;
        Wed,  9 Oct 2019 13:56:31 +0000 (GMT)
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
To:     Qian Cai <cai@lca.pw>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Wed, 9 Oct 2019 15:56:32 +0200
MIME-Version: 1.0
In-Reply-To: <1570550917.5576.303.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100913-4275-0000-0000-000003708094
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100913-4276-0000-0000-000038838541
Message-Id: <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=86 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.2019 18:08, Qian Cai wrote:
> On Tue, 2019-10-08 at 14:56 +0200, Christian Borntraeger wrote:
>> Adding Peter Oberparleiter.
>> Peter, can you have a look?
>>
>> On 08.10.19 10:27, Michal Hocko wrote:
>>> On Tue 08-10-19 09:43:57, Petr Mladek wrote:
>>>> On Mon 2019-10-07 16:49:37, Michal Hocko wrote:
>>>>> [Cc s390 maintainers - the lockdep is http://lkml.kernel.org/r/1570228005-24979-1-git-send-email-cai@lca.pw
>>>>>  Petr has explained it is a false positive
>>>>>  http://lkml.kernel.org/r/20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz]
>>>>> On Mon 07-10-19 16:30:02, Petr Mladek wrote:
>>>>> [...]
>>>>>> I believe that it cannot really happen because:
>>>>>>
>>>>>> 	static int __init
>>>>>> 	sclp_console_init(void)
>>>>>> 	{
>>>>>> 	[...]
>>>>>> 		rc = sclp_rw_init();
>>>>>> 	[...]
>>>>>> 		register_console(&sclp_console);
>>>>>> 		return 0;
>>>>>> 	}
>>>>>>
>>>>>> sclp_rw_init() is called before register_console(). And
>>>>>> console_unlock() will never call sclp_console_write() before
>>>>>> the console is registered.
>>>>>>
>>>>>> AFAIK, lockdep only compares existing chain of locks. It does
>>>>>> not know about console registration that would make some
>>>>>> code paths mutually exclusive.
>>>>>>
>>>>>> I believe that it is a false positive. I do not know how to
>>>>>> avoid this lockdep report. I hope that it will disappear
>>>>>> by deferring all printk() calls rather soon.
>>>>>
>>>>> Thanks a lot for looking into this Petr. I have also checked the code
>>>>> and I really fail to see why the allocation has to be done under the
>>>>> lock in the first place. sclp_read_sccb and sclp_init_sccb are global
>>>>> variables but I strongly suspect that they need a synchronization during
>>>>> early init, callbacks are registered only later IIUC:
>>>>
>>>> Good idea. It would work when the init function is called only once.
>>>> But see below.
>>>>
>>>>> diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
>>>>> index d2ab3f07c008..4b1c033e3255 100644
>>>>> --- a/drivers/s390/char/sclp.c
>>>>> +++ b/drivers/s390/char/sclp.c
>>>>> @@ -1169,13 +1169,13 @@ sclp_init(void)
>>>>>  	unsigned long flags;
>>>>>  	int rc = 0;
>>>>>  
>>>>> +	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
>>>>> +	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
>>>>>  	spin_lock_irqsave(&sclp_lock, flags);
>>>>>  	/* Check for previous or running initialization */
>>>>>  	if (sclp_init_state != sclp_init_state_uninitialized)
>>>>>  		goto fail_unlock;
>>>>
>>>> It seems that sclp_init() could be called several times in parallel.
>>>> I see it called from sclp_register() and sclp_initcall().
>>>
>>> Interesting. Something for s390 people to answer I guess.
>>> Anyway, this should be quite trivial to workaround by a cmpxch or alike.
>>>
> 
> The above fix is simply insufficient,
> 
> 00: [    3.654307] WARNING: possible circular locking dependency detected       
> 00: [    3.654309] 5.4.0-rc1-next-20191004+ #4 Not tainted                      
> 00: [    3.654311] ------------------------------------------------------       
> 00: [    3.654313] swapper/0/1 is trying to acquire lock:                       
> 00: [    3.654314] 00000000553f3fb8 (sclp_lock){-.-.}, at: sclp_add_request+0x34
> 00: /0x308                                                                      
> 00: [    3.654320]                                                              
> 00: [    3.654322] but task is already holding lock:                            
> 00: [    3.654323] 00000000550c9fc0 (console_owner){....}, at: console_unlock+0x
> 00: 328/0xa30                                                                   
> 00: [    3.654329]                                                              
> 00: [    3.654331] which lock already depends on the new lock.                  

I can confirm that both this lockdep warning as well as the original one
are both false positives: lockdep warns that code in sclp_init could
trigger a deadlock via the chain

   sclp_lock --> &(&zone->lock)->rlock --> console_owner

but

  a) before sclp_init successfully completes, register_console is not
     called, so there is no connection between console_owner -> sclp_lock
  b) after sclp_init completed, it won't be called again, so any
     dependency that requires a call-chain including sclp_init is
     impossible to achieve

Apparently lockdep cannot determine that sclp_init won't be called again.
I'm attaching a patch that moves sclp_init to __init so that lockdep has
a chance of knowing that the function will be gone after init.

This patch is intended for testing only though, to see if there are other
paths to similar possible deadlocks. I still need to decide if its worth
changing the code to remove false positives in lockdep.

A generic solution would be preferable from my point of view though,
because otherwise each console driver owner would need to ensure that any
lock taken in their console.write implementation is never held while
memory is allocated/released.

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index d2ab3f07c008..13219e43d488 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -140,7 +140,6 @@ static void sclp_request_timeout(bool force_restart);
 static void sclp_process_queue(void);
 static void __sclp_make_read_req(void);
 static int sclp_init_mask(int calculate);
-static int sclp_init(void);

 static void
 __sclp_queue_read_req(void)
@@ -670,7 +669,8 @@ __sclp_get_mask(sccb_mask_t *receive_mask, sccb_mask_t *send_mask)
 	}
 }

-/* Register event listener. Return 0 on success, non-zero otherwise. */
+/* Register event listener. Return 0 on success, non-zero otherwise. Early
+ * callers (<= arch_initcall) must call sclp_init() first. */
 int
 sclp_register(struct sclp_register *reg)
 {
@@ -679,9 +679,8 @@ sclp_register(struct sclp_register *reg)
 	sccb_mask_t send_mask;
 	int rc;

-	rc = sclp_init();
-	if (rc)
-		return rc;
+	if (sclp_init_state != sclp_init_state_initialized)
+		return -EINVAL;
 	spin_lock_irqsave(&sclp_lock, flags);
 	/* Check event mask for collisions */
 	__sclp_get_mask(&receive_mask, &send_mask);
@@ -1163,8 +1162,7 @@ static struct platform_device *sclp_pdev;

 /* Initialize SCLP driver. Return zero if driver is operational, non-zero
  * otherwise. */
-static int
-sclp_init(void)
+int __init sclp_init(void)
 {
 	unsigned long flags;
 	int rc = 0;
diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index 196333013e54..463660261379 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -296,6 +296,7 @@ struct sclp_register {
 };

 /* externals from sclp.c */
+int __init sclp_init(void);
 int sclp_add_request(struct sclp_req *req);
 void sclp_sync_wait(void);
 int sclp_register(struct sclp_register *reg);
diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index 8966a1c1b548..a08ef2c8379e 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -319,6 +319,9 @@ sclp_console_init(void)
 	/* SCLP consoles are handled together */
 	if (!(CONSOLE_IS_SCLP || CONSOLE_IS_VT220))
 		return 0;
+	rc = sclp_init();
+	if (rc)
+		return rc;
 	rc = sclp_rw_init();
 	if (rc)
 		return rc;
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 3f9a6ef650fa..28b23e22248b 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -694,6 +694,11 @@ static int __init __sclp_vt220_init(int num_pages)
 	sclp_vt220_init_count++;
 	if (sclp_vt220_init_count != 1)
 		return 0;
+	rc = sclp_init();
+	if (rc) {
+		sclp_vt220_init_count--;
+		return rc;
+	}
 	spin_lock_init(&sclp_vt220_lock);
 	INIT_LIST_HEAD(&sclp_vt220_empty);
 	INIT_LIST_HEAD(&sclp_vt220_outqueue);
-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

