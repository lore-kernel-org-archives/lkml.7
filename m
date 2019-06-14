Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A96AC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FDB21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RRkaeU9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfFNHVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:21:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45318 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfFNHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:21:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5E7JgB6173884;
        Fri, 14 Jun 2019 07:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9I+ncWkor52T8oCqNraH/iCCFApD8a7mN8UnT5aGO8M=;
 b=RRkaeU9j0O98lbjPYTOH+b76Maf+K81uyZU0mEUY4asywOt34hhuN4tTIDJSbluz/Ogb
 /OHnWnoJcOjiDae81LQXmADxO03SQugEnn3OSu8jhy2x+admu/AOOwwfwtOwQRu+tL8x
 MIkijUVBtxGGLOFYLLU4UeQasNrSPcngxD+bkalmN0utbDJQiGYUAlCxqq5Rmr0bjQwC
 JKCQLz+lGQV6SMyJoZsg5i+0YpoSj5sd8UP8eTNwQVDABN0hjTWnuBloGOt+yPVvXOfi
 kx6Qlr3x+SLbL4IBYXRsmqsDL1be6KnIr9U7y0i8L7u2xcB/2x02ypYhqFbQBzSLr/6y VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t05nr5mrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 07:20:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5E7JejA190190;
        Fri, 14 Jun 2019 07:20:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t024vy053-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 07:20:33 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5E7KVaU023497;
        Fri, 14 Jun 2019 07:20:31 GMT
Received: from [10.159.225.204] (/10.159.225.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Jun 2019 00:20:30 -0700
Subject: Re: [Xen-devel] [RFC PATCH 04/16] x86/xen: hypercall support for
 xenhost_t
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, sstabellini@kernel.org, konrad.wilk@oracle.com,
        pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-5-ankur.a.arora@oracle.com>
 <11f8b620-11ac-7075-019a-30d6bad7583c@citrix.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <fbfc0a0c-3707-7f17-9f2a-6c9d2c7b05b1@oracle.com>
Date:   Fri, 14 Jun 2019 00:20:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <11f8b620-11ac-7075-019a-30d6bad7583c@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906140057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906140058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-12 2:15 p.m., Andrew Cooper wrote:
> On 09/05/2019 18:25, Ankur Arora wrote:
>> Allow for different hypercall implementations for different xenhost types.
>> Nested xenhost, which has two underlying xenhosts, can use both
>> simultaneously.
>>
>> The hypercall macros (HYPERVISOR_*) implicitly use the default xenhost.x
>> A new macro (hypervisor_*) takes xenhost_t * as a parameter and does the
>> right thing.
>>
>> TODO:
>>    - Multicalls for now assume the default xenhost
>>    - xen_hypercall_* symbols are only generated for the default xenhost.
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> 
> Again, what is the hypervisor nesting and/or guest layout here?
Two hypervisors, L0 and L1, and the guest is a child of the L1
hypervisor but could have PV devices attached to both L0 and L1
hypervisors.

> 
> I can't think of any case where a single piece of software can
> legitimately have two hypercall pages, because if it has one working
> one, it is by definition a guest, and therefore not privileged enough to
> use the outer one.
Depending on which hypercall page is used, the hypercall would
(eventually) land in the corresponding hypervisor.

Juergen elsewhere pointed out proxying hypercalls is a better approach,
so I'm not really considering this any more but, given this layout, and
assuming that the hypercall pages could be encoded differently would it
still not work?

Ankur

> 
> ~Andrew
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 

