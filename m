Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA68C31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CE920673
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XA8ComtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfFSDBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 23:01:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45038 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSDBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 23:01:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2xXmx070355;
        Wed, 19 Jun 2019 03:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=7tyT0YcMicDx0xhFBdh7+OaH2yc89XO8q+cebhQ9PlY=;
 b=XA8ComtPxAHsBCBAmlvOcy5PFm3bQ+bJxRwXbWIv1Jvmz6p60FLvq/JaykfI+i1vwAWK
 RXbMjJM5jGKXOlxyq5wBsQxh9U3fE76irqfWhQAhnlQR+u/n/Yxj8qdQSU5RxYXL1QB/
 wWg5LHmTFQqdPf07yCtLsJjCTpNJ1WWgvdiUddPDXClXYYYiriDzxIhYfcEgNNIUsVrc
 M9FGHAwQs3U1QwDbr6dH9PPj6O01XR2gpjLcHk3E0TDB/8jyPwXRIyB7QjCd5ttV55zG
 8kqt+4QemoViH7qXXMh8OZ8tLEZetsRnOtwHGb54nPTtmfY0UN4ecyPD+JrBlSR+JMFn JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t78098qwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:01:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J31Cmq051398;
        Wed, 19 Jun 2019 03:01:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t77yn2xe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:01:16 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J31GfN030593;
        Wed, 19 Jun 2019 03:01:16 GMT
Received: from [10.156.74.184] (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 20:01:15 -0700
Subject: Re: [RFC PATCH 16/16] xen/grant-table: host_addr fixup in mapping on
 xenhost_r0
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-17-ankur.a.arora@oracle.com>
 <a35ab9a8-4874-fbc8-0148-aa07543e8672@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <11b62ba8-8aa2-9b84-c6fb-259d0548d753@oracle.com>
Date:   Tue, 18 Jun 2019 20:02:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a35ab9a8-4874-fbc8-0148-aa07543e8672@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 3:55 AM, Juergen Gross wrote:
> On 09.05.19 19:25, Ankur Arora wrote:
>> Xenhost type xenhost_r0 does not support standard GNTTABOP_map_grant_ref
>> semantics (map a gref onto a specified host_addr). That's because
>> since the hypervisor is local (same address space as the caller of
>> GNTTABOP_map_grant_ref), there is no external entity that could
>> map an arbitrary page underneath an arbitrary address.
>>
>> To handle this, the GNTTABOP_map_grant_ref hypercall on xenhost_r0
>> treats the host_addr as an OUT parameter instead of IN and expects the
>> gnttab_map_refs() and similar to fixup any state that caches the
>> value of host_addr from before the hypercall.
>>
>> Accordingly gnttab_map_refs() now adds two parameters, a fixup function
>> and a pointer to cached maps to fixup:
>>   int gnttab_map_refs(xenhost_t *xh, struct gnttab_map_grant_ref 
>> *map_ops,
>>               struct gnttab_map_grant_ref *kmap_ops,
>> -            struct page **pages, unsigned int count)
>> +            struct page **pages, gnttab_map_fixup_t map_fixup_fn,
>> +            void **map_fixup[], unsigned int count)
>>
>> The reason we use a fixup function and not an additional mapping op
>> in the xenhost_t is because, depending on the caller, what we are fixing
>> might be different: blkback, netback for instance cache host_addr in
>> via a struct page *, while __xenbus_map_ring() caches a phys_addr.
>>
>> This patch fixes up xen-blkback and xen-gntdev drivers.
>>
>> TODO:
>>    - also rewrite gnttab_batch_map() and __xenbus_map_ring().
>>    - modify xen-netback, scsiback, pciback etc
>>
>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> 
> Without seeing the __xenbus_map_ring() modification it is impossible to
> do a proper review of this patch.
Will do in v2.

Ankur

> 
> 
> Juergen
