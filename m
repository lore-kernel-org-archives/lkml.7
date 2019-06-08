Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8B5C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54250208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 05:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BmUtVTTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfFHFvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 01:51:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52754 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfFHFvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 01:51:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x585muaV080604;
        Sat, 8 Jun 2019 05:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=eCGn2HgXow8RyOmSGWkBzbytLgwPE+mSpcit9XmqcJg=;
 b=BmUtVTTuGNNgNik7clvsfwJD2ob1DR+D3dt7g1RItTXOp/uLh9UDuVXORqfYGT/Mb+8m
 wVf3YV7wiSU91qLd+KdAZcTCnHm/NmxswWBOKz6lGa9gmTwrmlBojEuOLfzxEqt6JkgT
 o7HZDhbuA0AtdzUQtaCer/p3z1iqTyWBoMyaZdFJ4xCA5s+nuY1l51BuFbWLrDXHvvez
 qOxS4Qj4RmNLVN25ROOynKSXMsoaI98amoUmbtmoYd9uYucDX/dBv4EZ1EemIwUe+ge8
 8cPzp2NI/uXS3MNmJnpn86ezY8tHL9+sdriZ/CBNEV1UdwJaj1ZfvX0EoX+q9lu+Jtwq 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t04et88eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jun 2019 05:50:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x585o5db021097;
        Sat, 8 Jun 2019 05:50:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t04u21jxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jun 2019 05:50:44 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x585oh9P031110;
        Sat, 8 Jun 2019 05:50:43 GMT
Received: from [192.168.0.110] (/70.36.60.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 22:50:43 -0700
Subject: Re: [Xen-devel] [RFC PATCH 00/16] xenhost support
To:     Juergen Gross <jgross@suse.com>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     sstabellini@kernel.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <5649cfd1-24df-2196-2888-b00fc3ace7ad@suse.com>
 <ede6db03-121c-9ec6-f8eb-dbcc605977b4@oracle.com>
 <c73a6ec5-687e-d3ef-e5d7-5700d240b4ec@suse.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <29e94cec-66ae-baf0-d189-f9487ce162a7@oracle.com>
Date:   Fri, 7 Jun 2019 22:50:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c73a6ec5-687e-d3ef-e5d7-5700d240b4ec@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906080044
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906080045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-07 9:21 a.m., Juergen Gross wrote:
> On 07.06.19 17:22, Joao Martins wrote:
>> On 6/7/19 3:51 PM, Juergen Gross wrote:
>>> On 09.05.19 19:25, Ankur Arora wrote:
>>>> Hi all,
>>>>
>>>> This is an RFC for xenhost support, outlined here by Juergen here:
>>>> https://lkml.org/lkml/2019/4/8/67.
>>>
>>> First: thanks for all the effort you've put into this series!
>>>
>>>> The high level idea is to provide an abstraction of the Xen
>>>> communication interface, as a xenhost_t.
>>>>
>>>> xenhost_t expose ops for communication between the guest and Xen
>>>> (hypercall, cpuid, shared_info/vcpu_info, evtchn, grant-table and on 
>>>> top
>>>> of those, xenbus, ballooning), and these can differ based on the kind
>>>> of underlying Xen: regular, local, and nested.
>>>
>>> I'm not sure we need to abstract away hypercalls and cpuid. I believe in
>>> case of nested Xen all contacts to the L0 hypervisor should be done via
>>> the L1 hypervisor. So we might need to issue some kind of passthrough
>>> hypercall when e.g. granting a page to L0 dom0, but this should be
>>> handled via the grant abstraction (events should be similar).
>>>
>> Just to be clear: By "kind of passthrough hypercall" you mean (e.g. 
>> for every
>> access/modify of grant table frames) you would proxy hypercall to L0 
>> Xen via L1 Xen?
> 
> It might be possible to spare some hypercalls by directly writing to
> grant frames mapped into L1 dom0, but in general you are right.
Wouldn't we still need map/unmap_grant_ref?
AFAICS, both the xenhost_direct and the xenhost_indirect cases should be
very similar (apart from the need to proxy in the indirect case.)

Ankur

> 
> 
> Juergen
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel

