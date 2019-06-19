Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147C0C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D407A2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P2Rj2Yg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfFSCYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:24:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56852 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSCYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:24:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2OH0I059493;
        Wed, 19 Jun 2019 02:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wo5C4cIK+CFDK6ndeFNVNNiqCKM+8qE7NHBJGFfU5Sg=;
 b=P2Rj2Yg+ILLTttuRoKcPNGVKIdGkShEZTMF0MYywZKcyhSVS1RkLa4nNZDpyO9RXJVnQ
 q4U8VC4Q8bb5I375q/1ZSc2K+XeTATaiRTzRc6wFOzj8IEpsDqBp4Wwcm+GkLrFQSzTj
 l7o7D0Ibgao0iIDJucgPmqkmpNN4GCT+HOOZPyH82tituqDLjOQgPc+pB8Yn2Aa/pKTv
 odaGCVM0c5D8I8nrnlwC641rOTxTPlPM4xHxgHZNiC/axMqhbdkJ9wmBuEGNVgFlfXTq
 5rn5aeftiIOl+WP09DvglmuKZ8deuY7ubH7g5pGImrdE/18bsKFg+8wP5HPP8jEapQI0 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t78098nnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:24:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2MXTH050954;
        Wed, 19 Jun 2019 02:24:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t77ynjn77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:24:16 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J2OESH003350;
        Wed, 19 Jun 2019 02:24:14 GMT
Received: from [10.156.74.184] (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 19:24:13 -0700
Subject: Re: [RFC PATCH 10/16] xen/balloon: support ballooning in xenhost_t
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-11-ankur.a.arora@oracle.com>
 <c67f2fd9-c837-bc13-492f-f3bed7f01f05@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <aa050a5f-1897-64c0-d19d-d0f31b8d6c62@oracle.com>
Date:   Tue, 18 Jun 2019 19:24:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c67f2fd9-c837-bc13-492f-f3bed7f01f05@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/19 2:28 AM, Juergen Gross wrote:
> On 09.05.19 19:25, Ankur Arora wrote:
>> Xen ballooning uses hollow struct pages (with the underlying GFNs being
>> populated/unpopulated via hypercalls) which are used by the grant logic
>> to map grants from other domains.
>>
>> This patch allows the default xenhost to provide an alternate ballooning
>> allocation mechanism. This is expected to be useful for local xenhosts
>> (type xenhost_r0) because unlike Xen, where there is an external
>> hypervisor which can change the memory underneath a GFN, that is not
>> possible when the hypervisor is running in the same address space
>> as the entity doing the ballooning.
>>
>> Co-developed-by: Ankur Arora <ankur.a.arora@oracle.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   arch/x86/xen/enlighten_hvm.c       |  7 +++++++
>>   arch/x86/xen/enlighten_pv.c        |  8 ++++++++
>>   drivers/xen/balloon.c              | 19 ++++++++++++++++---
>>   drivers/xen/grant-table.c          |  4 ++--
>>   drivers/xen/privcmd.c              |  4 ++--
>>   drivers/xen/xen-selfballoon.c      |  2 ++
>>   drivers/xen/xenbus/xenbus_client.c |  6 +++---
>>   drivers/xen/xlate_mmu.c            |  4 ++--
>>   include/xen/balloon.h              |  4 ++--
>>   include/xen/xenhost.h              | 19 +++++++++++++++++++
>>   10 files changed, 63 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>> index 5ef4d6ad920d..08becf574743 100644
>> --- a/drivers/xen/balloon.c
>> +++ b/drivers/xen/balloon.c
>> @@ -63,6 +63,7 @@
>>   #include <asm/tlb.h>
>>   #include <xen/interface/xen.h>
>> +#include <xen/xenhost.h>
>>   #include <asm/xen/hypervisor.h>
>>   #include <asm/xen/hypercall.h>
>> @@ -583,12 +584,21 @@ static int add_ballooned_pages(int nr_pages)
>>    * @pages: pages returned
>>    * @return 0 on success, error otherwise
>>    */
>> -int alloc_xenballooned_pages(int nr_pages, struct page **pages)
>> +int alloc_xenballooned_pages(xenhost_t *xh, int nr_pages, struct page 
>> **pages)
>>   {
>>       int pgno = 0;
>>       struct page *page;
>>       int ret;
>> +    /*
>> +     * xenmem transactions for remote xenhost are disallowed.
>> +     */
>> +    if (xh->type == xenhost_r2)
>> +        return -EINVAL;
> 
> Why don't you set a dummy function returning -EINVAL into the xenhost_r2
> structure instead?
Will do. And, same for the two comments below.

Ankur

> 
>> +
>> +    if (xh->ops->alloc_ballooned_pages)
>> +        return xh->ops->alloc_ballooned_pages(xh, nr_pages, pages);
>> +
> 
> Please make alloc_xenballooned_pages() an inline wrapper and use the
> current implmentaion as the default. This avoids another if ().
> 
>>       mutex_lock(&balloon_mutex);
>>       balloon_stats.target_unpopulated += nr_pages;
>> @@ -620,7 +630,7 @@ int alloc_xenballooned_pages(int nr_pages, struct 
>> page **pages)
>>       return 0;
>>    out_undo:
>>       mutex_unlock(&balloon_mutex);
>> -    free_xenballooned_pages(pgno, pages);
>> +    free_xenballooned_pages(xh, pgno, pages);
>>       return ret;
>>   }
>>   EXPORT_SYMBOL(alloc_xenballooned_pages);
>> @@ -630,10 +640,13 @@ EXPORT_SYMBOL(alloc_xenballooned_pages);
>>    * @nr_pages: Number of pages
>>    * @pages: pages to return
>>    */
>> -void free_xenballooned_pages(int nr_pages, struct page **pages)
>> +void free_xenballooned_pages(xenhost_t *xh, int nr_pages, struct page 
>> **pages)
>>   {
>>       int i;
>> +    if (xh->ops->free_ballooned_pages)
>> +        return xh->ops->free_ballooned_pages(xh, nr_pages, pages);
>> +
> 
> Same again: please use an inline wrapper.
> 
> 
> Juergen
