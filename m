Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0301BC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1E82085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wA7QDUr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfFSCZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:25:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57326 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSCZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:25:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2Olgm059593;
        Wed, 19 Jun 2019 02:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=bKxrAYHwoH0/SIJITZmlVmnts64uX0JP+N6ODtWcKB8=;
 b=wA7QDUr/rs9c2cSLSyO3D8p8dT7zL6SsTSugm4VYGsoNuYN/3lkdljIIn5CADg3ofGhg
 i+wxm46yOJm/SqhB2dv+b+ZItBq6QeOtJtctRO+xEArsEL3aFRyy6DX/2rdWRL52LczV
 eKf7AbI7e1f4QADAEuR3hzhMUJ0DuAq9nhaCiiDVaCTXeumP6ZA5HvE6NfDFl2I61rQ+
 KpTreqC54vt7ULpeiI5PGSq4KuArcKDBR2tmuBI6XyOvuyc3wUSaeXhkv5H6ULcy3+NA
 w91UWFzOHmd2aNAGdSguZV/B6lVL22MeMf5Kf43SOLH8MU3JqSX8kUEN9xRYl7+4lLUT Kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t78098nrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:25:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2PE9F121124;
        Wed, 19 Jun 2019 02:25:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t77ymtnba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:25:14 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J2PCYi018386;
        Wed, 19 Jun 2019 02:25:12 GMT
Received: from [10.156.74.184] (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 19:25:12 -0700
Subject: Re: [RFC PATCH 11/16] xen/grant-table: make grant-table xenhost aware
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-12-ankur.a.arora@oracle.com>
 <71d3131a-cd14-6bf6-391a-6e4b0533fb23@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <3986345a-2f34-52cd-7d5f-3cd1d8b3267e@oracle.com>
Date:   Tue, 18 Jun 2019 19:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <71d3131a-cd14-6bf6-391a-6e4b0533fb23@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/19 2:36 AM, Juergen Gross wrote:
> On 09.05.19 19:25, Ankur Arora wrote:
>> Largely mechanical changes: the exported grant table symbols now take
>> xenhost_t * as a parameter. Also, move the grant table global state
>> inside xenhost_t.
>>
>> If there's more than one xenhost, then initialize both.
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   arch/x86/xen/grant-table.c |  71 +++--
>>   drivers/xen/grant-table.c  | 611 +++++++++++++++++++++----------------
>>   include/xen/grant_table.h  |  72 ++---
>>   include/xen/xenhost.h      |  11 +
>>   4 files changed, 443 insertions(+), 322 deletions(-)
>>
>> diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
>> index 9e08627a9e3e..acee0c7872b6 100644
>> --- a/include/xen/xenhost.h
>> +++ b/include/xen/xenhost.h
>> @@ -129,6 +129,17 @@ typedef struct {
>>           const struct evtchn_ops *evtchn_ops;
>>           int **evtchn_to_irq;
>>       };
>> +
>> +    /* grant table private state */
>> +    struct {
>> +        /* private to drivers/xen/grant-table.c */
>> +        void *gnttab_private;
>> +
>> +        /* x86/xen/grant-table.c */
>> +        void *gnttab_shared_vm_area;
>> +        void *gnttab_status_vm_area;
>> +        void *auto_xlat_grant_frames;
> 
> Please use proper types here instead of void *. This avoids lots of
> casts. It is okay to just add anonymous struct definitions and keep the
> real struct layout local to grant table code.
Will fix.

Ankur

> 
> 
> Juergen
